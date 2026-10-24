# 预览类型差异

先按[资产预览](asset-preview.md)选择当前导出的目标与组；本页只补充各类型的原生差异，不是固定能力清单。

## Niagara 与动画、物理

Niagara 播放控制绑定该资产编辑器自身的时间轴；以 `status` 的可用能力和时间基准为准，
时间轴位置不等于粒子模拟年龄。沿途事件与起始帧的采集见[预览截图与时间轴](preview-capture.md)。

Persona 的 `subject` 可临时选择骨骼网格和参考姿势，不写资产的 PreviewMesh。Montage 的 `playback`
按原生 section 模式与 `StartSection` 控制，BlendSpace 只导出适用的 `BlendInputX/Y`；轴名称、范围和
过滤后输入从 status 读取。参考姿势没有动画时间轴；切换后以重新导出的能力为准，失效的 timeline/reset
采集设置会清除，切回动画后按需重新设置。Montage 当前 slot 缺少原生公开读回接口，不导出为可双向编辑字段。

PhysicsAsset 的 play/stop 启停原生物理模拟，status 返回模拟模式；不支持把 pause/seek 当作刚体轨迹定位。

## Texture

二维 Texture 预览的 `view` 表示缩放和适用的朝向，`image` 表示通道、采样及适用的体/立方纹理选项。
`CustomZoom` 是自定义倍率；要使用它，同时将 `ZoomMode` 设为 `Custom`。`status` 的 `image_readback`
可提供当前 Mip、layer、slice、face、曝光与实际缩放；未导出为编辑字段的项目不能当作可写参数。

## UMG

截图使用当前 Designer 的真实布局；`widget` 只导出原生允许临时修改的尺寸。
Custom 尺寸归资产默认值时，在 status 中只读，不借 preview 写回 CDO；DPI 与视图缩放也从 status 读取。

## 音频

`audio` 配置控制试听音量与音调，动作支持 play/pause/stop，不生成图像 capture 组。
试听复用 UE 共享组件；其他资产正在试听时须先明确处理该试听，不能暗中抢占。
