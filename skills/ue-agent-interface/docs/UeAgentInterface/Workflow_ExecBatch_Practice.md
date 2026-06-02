# UeAgentInterface 批量执行实践

本文档说明当前推荐的批量调用方式，目标是：

- 减少重复输入
- 明确失败点
- 让结果可复现、可回放

## 1. 当前推荐入口

优先顺序：

1. `UeAgentInterfaceCMD/dist/uai-cli.exe doctor`
2. `UeAgentInterfaceCMD/dist/uai-cli.exe run --plan ... --vars ...`
3. `UeAgentInterfaceCMD/dist/uai-cli.exe batch --file ...`

不推荐：

- 手写 HTTP 作为日常工作流
- 在命令行内联长 JSON

## 2. 什么时候用 `run`

适合：

- 有固定任务模板
- 同一类任务需要多次执行
- 只变资产路径 / 命名 / 位置 / 少量参数

输入拆分为两个文件：

- `plan.json`：步骤模板
- `vars.json`：本次变量

优点：

- 复用性高
- 变量替换清晰
- 适合复杂任务分阶段执行

## 3. 什么时候用 `batch`

适合：

- 一次性任务
- 临时验证
- 已经明确所有步骤，不需要模板抽象

输入是一个完整批处理文件：

- `batch.json`

优点：

- 直接
- 易于快速调试

## 4. JSON 组织建议

推荐把任务拆成三类文件：

- `plans/`：可复用 plan 模板
- `vars/`：可复用变量样例
- `tmp/`：本次临时输入
- 报告与日志：
  - 打包版（`dist/uai-cli.exe`）：`dist/reports/`、`dist/logs/`
  - 开发态（`python run_uai_cli.py`）：`reports/`、`logs/`

对复杂任务建议按阶段拆批次：

1. 创建 / 删除 / 清理
2. 连接 / 属性写入 / 结构调整
3. 编译 / 保存 / 验收

## 5. `exec_batch` 基本结构

服务端底层仍是 `POST /api/exec`，批处理统一用 `command=exec_batch`：

```json
{
  "request_id": "req-batch-001",
  "command": "exec_batch",
  "params": {
    "stop_on_error": true,
    "commands": [
      { "request_id": "step-1", "command": "list_actors", "params": { "limit": 20 } },
      { "request_id": "step-2", "command": "spawn_actor", "params": { "class_path": "/Script/Engine.StaticMeshActor" } }
    ]
  }
}
```

原则：

- 默认 `stop_on_error=true`，遇错立即中断
- 保留已成功步骤的结果，便于复盘
- 不允许嵌套 `exec_batch`

## 6. 报告怎么看

每次执行后都要看报告 JSON，关键字段：

- `success`
- `failed_index`
- `failed_command`
- `failed_request_id`
- `failed_error`
- `results`

不要只看最后一条报错字符串，一定要结合 `failed_index` 与已成功步骤一起看。

## 7. 推荐执行顺序

1. 打开 UE Editor 工程
2. 在 UE 中启动：
   - `Window -> UeAgentInterface -> Start UeAgentInterface Server`
3. 先跑：
   - `uai-cli.exe doctor --json-output`
4. 再跑 `run` 或 `batch`
5. 查看报告并按失败点定位
6. 任务结束前按需清理临时 JSON

## 8. 临时文件清理

当 `tmp/*.json` 或 `reports/*.json` 过多时：

- CLI 可按配置自动裁剪（见 `uai-cli.default.json`）
- 也可用脚本：`scripts/cleanup_uai_json.ps1 -ProjectRoot <ProjectRoot>`

## 9. Blueprint / Niagara / Modeling 额外建议

Level / Transform：

- actor 变换优先用 `level_set_actor_transform / location / rotation / scale` 这类专用指令
- 若用 `component_set_property` 写 `RelativeLocation / RelativeRotation / RelativeScale3D`，可能只改到属性值但 transform 未立刻刷新
  - 建议写完后对同一 actor 再执行一次同值 `level_set_actor_scale`（或同值 `level_set_actor_transform`）触发刷新
  - 再用 `mesh_get_closest_vertex` / 截图做结构级验收，避免“回读正确但真几何没变”的假修复

Blueprint：

- 拆成“创建结构”和“连线/编译”两阶段
- 不要每一步都全量 `inspect_nodes(include_pins=true)`

Niagara：

- 大改前先复制测试资产
- 批次结束后检查编译日志
- 避免同批次对同一 system 做 remove/add emitter 混合操作（默认用 CLI 护栏阻断）

Modeling：

- 先 `modeling_activate_mode`
- 先确认 selection，再 `start_tool -> set_property -> invoke_action -> accept/cancel`
- `accept/cancel` 后再确认 active tool 已退出

## 10. 结论

最稳的做法不是“少写几条命令”，而是：

- 用 `uai-cli.exe`
- 用文件承载 JSON
- 用 `run` / `batch` + `exec_batch`
- 用 report 做失败定位与复盘
- 用分阶段批处理避免一次提交过大状态

## 11. 白盒分段验收 batch 模板（示例）

目标：把“肉眼感觉差不多”变成可复盘的结构化验收，重点覆盖：

- **walk 连通**（NavMesh）
- **显式边**（jump/teleport/ladder/设备等，插件侧只做端点投影/距离阈值校验，不验证设备语义）
- **净空**（`level_sweep_capsule_path`）
- **穿插**（`level_check_overlaps`）

示例（把点位当作脚底点/落脚点；`edge_type!=walk` 代表显式边）：

```json
{
  "request_id": "wb-audit-001",
  "command": "exec_batch",
  "params": {
    "stop_on_error": true,
    "commands": [
      {
        "request_id": "nav-build",
        "command": "navmesh_build",
        "params": { "wait_for_finish": true, "timeout_seconds": 30 }
      },
      {
        "request_id": "conn-graph",
        "command": "level_validate_connectivity",
        "params": {
          "points": [
            { "x": 0, "y": 0, "z": 0 },
            { "x": 800, "y": 0, "z": 0 },
            { "x": 800, "y": 0, "z": 400 }
          ],
          "pairs": [
            { "from_index": 0, "to_index": 1, "edge_type": "walk" },
            { "from_index": 1, "to_index": 2, "edge_type": "jump_up" }
          ],
          "project_to_nav": true,
          "project_query_extent": { "x": 50, "y": 50, "z": 200 },
          "max_projection_distance_cm": 200,
          "graph_root_index": 0
        }
      },
      {
        "request_id": "clearance",
        "command": "level_sweep_capsule_path",
        "params": {
          "points": [
            { "x": 0, "y": 0, "z": 0 },
            { "x": 800, "y": 0, "z": 0 }
          ],
          "points_mode": "feet",
          "radius_cm": 34,
          "half_height_cm": 88,
          "step_cm": 50,
          "trace_channel": "Pawn",
          "snap_to_floor": true,
          "floor_clearance_cm": 2,
          "ignore_walkable_floor_hits": true,
          "stop_on_blocking_hit": true
        }
      },
      {
        "request_id": "overlap",
        "command": "level_check_overlaps",
        "params": {
          "shape": "box",
          "center": { "x": 400, "y": 0, "z": 100 },
          "box_extent": { "x": 200, "y": 200, "z": 200 },
          "trace_channel": "Visibility",
          "include_overlaps": false
        }
      }
    ]
  }
}
```
