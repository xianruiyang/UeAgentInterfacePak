# 资产预览

学习已导入包、筛选形制时用文件夹总览；材质、网格、动画、Niagara等本体问题需要隔离观察时，在对应原生资产编辑器中
取景并调用公开截图入口。已有有效场景画面能回答本体问题时直接复用，不固定先做原生预览再做场景预览。资产预览不要求先创建展示关卡，也不启动关卡PIE；
依赖游戏运行的行为才进入 [PIE](pie.md)。

本页承载公共配置与动作；单图、动态多帧的选择与采集读[预览截图与时间轴](preview-capture.md)，
具体资产的特殊组和原生限制按需读[预览类型差异](preview-types.md)。
截图使用 `capture-subject:asset:<object-path>` 时可省略 `policy_id`，默认由资产预览 owner 按真实类型和目标取图；这不是所有资产共用的离屏渲染器。没有适用预览时保留诊断，图/窗口或独立序列相机等其他观察显式选策略。

## 文件夹资产总览

用 `client.asset.folder_preview(folder=content_folder)` 对所需UE内容目录取得带名称的原生缩略图总览，无需逐个打开资产窗口。按当前空间用途和视觉方向选择目录、类型及候选，不为“学完整个包”默认查看所有资产。它返回普通Operation：命名后提交，`finish()`取得回执，再materialize图片artifacts；结果未知时恢复该命名Operation。

默认递归、每页 24 项，优先原生缓存，仅为当页缺图资产逐项生成；需要筛选类型、调整页大小、仅查缓存或续页时，读取 `asset.folder.preview` 的公开 usage/`describe --parameter options`。回执的 `asset_catalog` 把名称、完整路径、类型、缩略图状态与图上位置对应起来；用 `next_after` 继续同一目录和筛选条件。按 `primary_artifact` 后接 `additional_artifacts` 的显式顺序查看各张图，不以 `artifacts` 遍历顺序推断页序。失败或不支持项仍保留定位，不能把占位项算作已经看过的形态；对选中或缺图且影响判断的资产，再进入下方单资产原生预览。

拟定场景缩放前，需要实际尺寸时用公开 `asset.sample` 的 `bounds` 采样。StaticMesh/SkeletalMesh 返回资产本地厘米空间的中心与半尺寸；它不同于要求场景组件身份的 `world.mesh.closest_vertex`，无需先落图取顶点来猜资产大小。

网格材质路径正确但画面仍疑似缺材质时，`asset.sample` 的 `section` 采样可核对实际 LOD0 面段引用和材质槽索引；参数和返回字段从公开 usage/describe 读取，不能只凭槽列表推断所有面段绑定正确。

总览和原生预览用于判断资产本体与选型，不证明实际场景的照明、邻接、通路或组合完成。选型可在场景替换前进行；新场景组合审阅仍遵守[场景制作](scene-creation.md)中对应旧内容先退出的顺序。

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
动作和截图完成后仍保留预览；当前资产判断结束且无继续需要时，用上述open会话按归属完成收尾，不让临时资产窗口长期占用场景工作。用户借用窗口仍保持打开。

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
管环境和后处理，`playback` 管速率等稳定播放配置，`simulation` 管原生模拟选项，`capture` 管渲染/输出尺寸及多图采样配置。后台原生预览尺寸为0时截图自动按窗口所属显示器工作区临时初始化，无需先手改 `RenderWidth/RenderHeight`；回执说明尺寸来源与恢复，未切换为另一渲染器。只编辑需要改变的字段；如只切换材质形状，
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
不要关闭用户窗口来绕过能力缺口。打开窗口、`play` 或 `status` 只提供会话与播放状态，
不代替视觉观察；按[预览截图与时间轴](preview-capture.md)取得已配置的真实图像。
动态效果使用多帧观察运动及阶段变化；依赖模拟历史时沿同一轨迹连续推进，不逐点 seek 拼成运动证据。
