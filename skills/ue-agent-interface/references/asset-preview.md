# 资产预览

材质外观、网格和资产自身效果优先在对应资产预览中观察；只有游戏运行逻辑才进入
[PIE](pie.md)。资产预览不要求先创建展示关卡。

本页承载公共配置与动作；截图读[预览截图与时间轴](preview-capture.md)，
具体资产的特殊组和原生限制按需读[预览类型差异](preview-types.md)。

## 打开与收尾

需要持续交互时使用公共资产编辑器会话，等到 active 后再编辑或采集：

```python
with client.operation.named("asset-preview"):
    started = client.editor.session(
        "asset_editor", "asset:" + asset_path,
        "policy:asset-editor:open/v1", {"ownership": "managed"},
    )
started.raise_for_error()
handle = started.operation
ready = handle.wait(
    until=lambda r: r.payload.get("latest_signal", {}).get("payload", {}).get("phase") == "active",
    timeout=45,
)
ready.raise_for_error()
state = ready.payload
if state.get("terminal") or state.get("latest_signal", {}).get("payload", {}).get("phase") != "active":
    raise RuntimeError(state)  # 保留未就绪的业务状态与诊断。
# 编辑与采集完成后：
closed = handle.close(timeout=45)
closed.raise_for_error()
print(closed.payload.get("lifecycle_status"), closed.payload.get("cleanup_complete"), closed.diagnostics)
```

默认 `managed` 接续 UAI 创建的窗口，包括预览配置、动作或截图隐式打开的窗口，并在内容导入重载后
保留归属。多个会话共享窗口，最后持有者负责关闭；用户原有窗口仅借用，收尾时保持打开。
动作和截图完成后仍保留预览，需要收尾时可用上述 open 会话领取并关闭。

只有明确负责关闭已有窗口时才使用 `{"ownership": "adopt"}`，包括旧操作已释放的遗留窗口。
检查关闭结果的 `cleanup_complete`；本次负责关闭的窗口以真实窗口登记消失为准，借用的用户窗口仍保持打开。
关闭不自动保存或丢弃未保存内容。`cleanup_pending` 或本地超时不代表已清理：
处理诊断指出的编辑器状态后，用 `client.operation.recover("asset-preview").close(timeout=45)` 继续收尾；
不重放原操作，也不将仍打开的窗口记为恢复成功。

## 编辑预览配置

普通资产 workspace 随支持能力导出 `preview/`。先读 `preview/index.hjson` 选择目标与参数组，
按[公共 HJSON 编辑流程](hjson-workspace.md)直接修改组文件，再调用同一 `import_changes()`。
没有导出的组不能从另一类型照搬；`requires_open_preview` 表示真实相机等需先打开对应预览后刷新。
未打开时标为 defaults 的值不是实时读回。

`view` 管相机，`display` 管显示，`subject` 管临时预览载体，`environment` 与 `post_process`
管环境和后处理，`playback` 管速率等稳定播放配置，`simulation` 管原生模拟选项，`capture` 管渲染/输出尺寸及多图采样配置。只编辑需要改变的字段；如只切换材质形状，
修改 `Shape` 即可，不同时回填旧 `Mesh`。各组仍使用公共类型、引用、枚举和诊断。

`view` 的 `OrbitCamera`、`LookAtLocation`、`CameraLocked` 沿用原生相机状态。环绕模式下
`Location/Rotation` 表示绕观察中心的变换；按世界坐标指定普通相机姿态时设置 `OrbitCamera=false`。
固定轴正交视图的方向由 `Projection` 决定，`Rotation` 不改变其观察轴向。

作用域沿用 UE：`viewport` 为该预览视口，`shared_profile` 会影响使用同一原生 profile 的其他预览。
Texture 中的 `viewport_and_user_defaults` 还会更新原生用户默认设置；以 index 对具体字段的分组为准。
导入只应用修改字段，不自动保存内容资产或额外执行 SaveConfig；UE 自身关闭窗口等原生持久化行为仍适用。
预览编辑不等于资产内容修改，亦不自动开始播放或进入 PIE。

内容导入重建资产编辑器时保留仍有效的预览设置。若旧 section 或预览 Mesh 引用已失效，
自动恢复保留新编辑器的原生有效选择，并在结果 `warnings` 中说明；刷新后的 workspace 给出当前值。
主动写入无效预览参数仍明确报错。

## 执行原生动作

瞬时动作使用 index 的 `actions`，不往配置中反复写入当前时间。入口返回 `Result`，
成功后从 `started.operation` 取得句柄，按 [SDK 长任务流程](sdk-and-runners.md#非-pie-长任务与恢复)推进和释放：

```python
started = client.editor.session(
    family_id="asset_editor", subject_ref="asset:" + asset_path,
    policy_id="policy:asset-editor:preview-action/v1",
    parameters={"action": "focus"},
)
started.raise_for_error()
handle = started.operation
```

预览动作 `action="status"` 读取当前预览状态；`focus` 按原生当前选择取景，Blueprint 的 `reset_view` 恢复整个预览对象的原生相机；支持播放的目标还可 `play`、`pause`、`reset`、
`seek`（仅 seek 携带 `time_seconds`）。有限动作按同一长任务流程用 `handle.finish()` 取得终态及 details 并释放；
操作释放不关闭预览窗口。Sequencer 的 `time_seconds` 是当前 focused sequence 本地绝对时间，允许其时间轴中的负起点；动画与 Flipbook 仍按自身 `[0, Duration]` 范围。截图在原生取景过渡结束后开始采集。
动作能力以当前 index/status 为准，不把一种资产的播放接口套到另一种资产。
不要关闭用户窗口来绕过能力缺口。需要图像时按[预览截图与时间轴](preview-capture.md)触发已配置的采集。
