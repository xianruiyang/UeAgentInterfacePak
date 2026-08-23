# Viewport 投影、取景与截图验证

本页只组织跨任务稳定的判断顺序，不拥有 UE 版本事实或 UAI command 契约。版本事实回到
`ue-kb` 的登记来源，参数和返回回到当前 UAI manifest，项目结果回到真实 readback 与图像 artifact。

## 何时读取

- 需要在 Level viewport 中 frame Actor、构图、截图或比较屏幕结果。
- 视觉 oracle 使用 FOV、屏幕边距、像素覆盖、遮挡或图像区域。
- 同一 world 存在多个 viewport，或者当前 viewport projection 尚未确定。

若只是执行语义已知、与空间和渲染无关的 UAI 查询，本页不触发。

## 最小判断合同

1. **语义 frame**：先明确目标是 Perspective 还是 Orthographic 图像，不把“属于同一 world”
   当作 projection 等价证据。Perspective 使用视野与距离形成近大远小的画面；Orthographic 的
   屏幕尺度不应套用 perspective FOV oracle。
2. **写入 frame**：从 UAI `viewport.instance.list` 取得 exact `viewport_ref` 和
   `viewport_type`，把二者与目标 world 一起冻结。需要 perspective 取景时只选择
   `viewport_type=perspective`。
3. **读回 frame**：修改前读取完整 viewport state；frame 后用同一 identity 独立读取 camera
   state，并由 capture artifact 检查实际画面。command 成功 envelope 不能代替读回。
4. **验证 frame**：核对目标 Actor 的独立 bounds/transform、图像尺寸与内容 oracle，再恢复
   原 state 并读回。未知的 projection 行为必须保留为未覆盖维度。

涉及坐标、方向、bounds 或屏幕投影时同时使用 AgentBase-owned `understand-space`，建立
`Fsemantic -> Fwrite -> Fread -> Fverify`；本页只补 UE viewport identity、projection 和产品验收入口。

## 来源与当前产品证据

- UE 5.7 版本事实通过 `ue-kb` 的官方来源
  `references/UE5_7Doc/docs/get-started/unreal-engine-for-new-users/viewport-toolbar/index.md`
  与 `references/UE5_7Doc/docs/gameplay-systems/gameplay-framework/cameras/index.md` 获取；查询后必须
  fetch chunk，并保留 source URL。当前项目产品运行于 UE 5.6，所以这些来源只提供可定位背景，
  不替代当前版本的 manifest、Plugin 源码或产品 readback。
- 当前 UAI 契约读取 Plugin 正式 `t45_viewport_graph_control.md` 和 command manifest。
- T52 产品证据位于
  `plan/results/TROOT-UAI-52-OWNED-RHI-REAL-CONTENT-VISUAL.r10.json`：错误选择正交 viewport
  失败；保持同一 frame policy、只改为同 world perspective viewport 后，真实内容 frame、capture、
  image oracle、restore 和 cleanup 在 UE 5.6 上通过。该当前产品结果决定行为证据边界，不外推
  非透视 command 行为，也不把 UE 5.7 文档静默降格为 5.6 规范。
