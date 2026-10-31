# 预览截图与时间轴

先在资产 workspace 的 `preview/` 中应用配置，见[资产预览](asset-preview.md)。
截图只触发已应用配置，不再次传相机、环境或采样参数。
策略与结果字段的正式合同见项目 `Plugins/UeAgentInterface/docs/active/t44_capture_media_operation.md` 的 Asset preview workspace capture 节；
SDK 调用与 operation 示例见 `UeAgentInterfaceCMD/docs/active/t44_capture_media_operation.md`。

## 按观察目标采样

- 静态颜色、形状或构图可用单图；运动方向、速度、扰动、消隐、循环与衔接使用 `mode="sequence"`。
- 帧间隔要能辨认相邻变化，采样时段要覆盖当前要判断的过程；持续效果观察生命周期交替，
  阶段效果按需覆盖开始、过渡或结束。不固定帧数、时长或每次必查的阶段，也不只挑一张好看的静帧。
- 对比前后效果时保持可比较的取景、曝光和播放条件。先看帧表中的整体变化，再读取相关逐帧原图判断细节；
  缩小的帧表不能证明原始画面细节。仍有疑点时，只补能区分原因的时段或视角。

日常场景、场景中材质和照明评价使用 `subject_ref="capture-subject:viewport:active"`；省略 `policy_id` 默认走 `viewport/v1`，取得目标 Editor 视口 backbuffer。`max_size` 只控制输出缩放。
该策略在后台零尺寸时自动按窗口所属单显示器工作区初始化同一原生视口；无需模型手设尺寸、重试或打开最小化窗口。显示器信息不可用时有有界降级，显式合法尺寸仍优先。初始渲染尺寸来源和固定约束恢复读
`capture.viewport_initialization`；参数及默认值以 Plugin 正式合同为准，不把策略尺寸当成原窗口测量值。
尺寸不足或原生捕获失败时说明实际限制，不将另一渲染路径当作同一画面的替代；此策略本身不会自动转到 SceneCapture。
场景动态多帧走 `policy:image-capture:viewport-sequence/v1`，取景与调用见[场景制作](scene-creation.md#形成目标画面)。
`level-sequence/v1` 是另一个独立场景相机渲染入口，即使 fallback 到 viewport 也只借用相机几何，
不复制视口的曝光历史和显示状态。不要为提高普通截图分辨率而把空序列当成等价替代；
需要独立序列相机渲染时显式选该 policy，按其公开合同使用；读取终态 `capture_receipt` 中实际 `policy_id`、`policy_defaulted`、render path、尺寸、相机和帧信息。
与用户前台画面对比时保留同一机位及显示状态，不为截图默认切换 Game View；它会切换 UE 的 Editor/Game 显示标志，不能只当作隐藏图标。
原生捕获可临时启用 realtime 并执行 warmup；读取回执中的实际状态与恢复结果。恢复配置不回退已经推进的曝光或渲染历史，单张 backbuffer 也不能单独证明与用户当时屏幕显示一致。
主图用 `result.primary_artifact`，逐帧 `raw_artifact_index` 对应 `result.additional_artifacts`；
`result.artifacts` 仍可枚举全部产物，但不要将其第一项猜成主图。

## 触发采集

动态内容使用下面的多帧入口；静态单图将 `mode` 改为 `single`。

```python
started = client.capture.image_execute(
    subject_ref="capture-subject:asset:" + asset_path,
    parameters={"mode": "sequence"},
)
started.raise_for_error()
```

资产 subject 省略策略时由现有 `asset-preview/v1` 按实际类与 target 取图；不支持的资产或目标明确报错，不切换渲染器。
省略策略使用 `parameters=`；显式 `policy_id` 优先，原三位置参数调用仍有效，空值/空白不是默认。Actor取景、图/窗口、独立序列相机等不同观察职责仍显式选择策略。地图资产引用不代表切图，当前Level画面使用上方 viewport subject。

多图用 `mode="sequence"`，帧数和间隔从目标的 `capture.hjson` 读取；多目标时传 index 中的
`target` 名称。按[非 PIE 长任务](sdk-and-runners.md#非-pie-长任务与恢复)用 `started.operation.finish()`
取得终态收据并释放，消费业务状态、清理结果和 `artifacts`；失败时也保留已取得产物，释放后仍可 materialize。
取得结果后实际查看 `primary_artifact` 和所需的 `additional_artifacts`，不把路径、收据或成功状态当作看过画面。
需要真实渲染尺寸时编辑已导出的
`RenderWidth/RenderHeight`；两者为0沿用正尺寸视口，后台零尺寸则自动按单显示器工作区初始化同一视口；单个为0按原生或显示器比例补足。`Width/Height`只缩放输出。
检查实际图像和收据的`native_width/height`，不把插值放大当作细节增加；显式渲染尺寸覆盖在采集结束后恢复。

## 选择时间推进方式

只使用当前目标实际导出的选项：

| Sampling | 适用目标与行为 |
| --- | --- |
| `Realtime` | 按间隔观察实际预览；`ResetBeforeCapture`/`WarmupSeconds` 用于准备 |
| `Timeline` | 直接求值姿态或数值；不用于依赖沿途事件的模拟，Niagara 不支持这种采集 |
| `Continuous` | Niagara System/Emitter、LevelSequence 从原生播放范围起点（通常 0）正常播放到请求位置，多图沿同一轨迹继续，不逐点跳转 |

需要保留粒子模拟和沿途事件时使用适用的 `Continuous`，而不是先 seek 再截图。
观察实时播放使用 `Realtime`；只比较可独立求值的姿态或数值才选择 `Timeline`。
这里的事件范围是原生资产预览，不能据此声称 PIE 游戏事件已验证。

`TimeUnit=Frames` 使用 `StartFrame`/`StepFrames`，帧率以原生预览为准（status 返回分子/分母）；
`Seconds` 使用 `StartTimeSeconds`/`StepTimeSeconds`。Sequencer 起点是 focused sequence 的绝对本地时间，可为该原生范围内的负值；步长与等待时长仍非负。起点设置对单图同样生效；没有原生帧率时使用 Seconds。
Continuous 必然从起点重建过程。

## 读取实际结果

请求时间和实际时间分别报告，不能把请求间隔当作达到的帧率。连续播放优先保留原生求值区间，
可能晚于请求帧；查看 `actual_asset_frame`/`frame_deviation`，Niagara 再看真实 `simulation_age_seconds`。
请求帧或 desired age 不能代替实际结果。

多张图若落在相同实际时间，不能当作多个运动阶段；采样间隙跨过关键变化时，该过程尚无图像证据。
需要动画或视频回放时，按实际采样时间组织逐帧原图，处理重复时刻并保留时间间隔；
不要直接用请求帧率编码成等速回放，或插帧补成未观察到的过程。只有影响当前判断的缺口才需要补采。

单图的采样时刻记录在 `capture.sample`，多图在逐帧结果中；`end_preview_state` 是恢复播放后的结束状态，
不能代替截图时刻。采集负责后台所需的原生视口更新，报告配置边界、结束状态，恢复临时播放状态/速率并保留实际推进后位置。
同一资产的导入会排在当前采集之后；共享 profile 被其他资产窗口改变时，收据记录变化而不回写覆盖。
