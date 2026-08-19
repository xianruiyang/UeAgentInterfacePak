# 04 Dissolve Of The Water Sphere

# 04 Dissolve Of The Water Sphere

## 关键术语

- `System`、`Color`、`UV`、`Water`、`Curve`、`粒子`、`系统`、`速度`、`透明度`、`Niagara`、`Particle`、`Normalized Age`、`生命周期`、`颜色`、`曲线`、`Niagara System`、`Emitter`、`Spawn`

## 分段知识

### 00:00:05-00:03:01 关键流程 01

- 本段定位：关键流程 01。
- 知识点：大家好,让我们继续制作Dissolve 以解释什么是物质功能 是的,我们已经在原则上了 它已经准备好了 这是它看起来的 让我们看看Dissolve是什么。
- 知识点：现在需要快速展示 Dissolve使用了我们之前所看的功能 叫SmoothStep 需要制作一个调整 它会为Dissolve作出的责任。
- 知识点：从0到1 现在需要有一个小数学 Smoothness是由它们变得很硬的 是的,我们会看到 在原则上会把0放在这里 这是我们这样做的。
- 知识点：现在需要把它们都分开 用SmoothStep 这是什么意思 需要有一个特色 所以让它是 我们转换成一个调整 它会是一个特色 Dissolve,让我们听一下。
- 知识点：让它是任何一颗 让它是这个 我们把这个调整成一个价值 我们已经把SmoothStep认为成了一点 这是什么意思 我们有两个价值 最低和最高。

**关键画面：**

1. 这一帧是新章节 `04 Dissolve Of The Water Sphere` 的起始状态展示，关卡里已经放置好一个使用水球材质实例的球体，教程先说明会在此前完成的水球基础上继续制作 `Dissolve`
2. 右侧详情面板可确认当前对象是 `Sphere`，材质槽 `Element 0` 使用的是 `MI_WaterBubble`
3. 内容浏览器中同时能看到母材质 `M_WaterBubble` 与实例 `MI_WaterBubble_01`，说明本章的溶解效果将继续围绕现有水球材质体系展开，而不是从空白材质重新开始
4. 左侧场景预览里的球体仍保持青蓝色半透明外观和柔和的表面纹理，这是加入 `Dissolve` 之前的基线效果
5. 这张图可替换为：先确认当前水球材质与实例已经准备好，并以现有青蓝色水球作为后续 `Dissolve` 效果的起始版本
节点定义集：

- `Dissolve`
  - 标量参数
  - `Default Value = 0.0`
- `Smoothness`
  - 标量参数
  - `Default Value = 0.0`
- `Add(1)`
  - 为 `Smoothness` 增加常量 `1.0`
- 上方算术节点
  - 一个带常量 `B = 1.0` 的运算节点，输入来自 `Dissolve`
- `Subtract`
  - 上方算术结果进入 `A`
  - `Smoothness` 相关结果进入 `B`
- `SmoothStep(0,1,0)`
  - 当前作为将要使用的材质函数节点摆在右侧
  - 面板可见 `Min = 0.0`、`Max = 1.0`、`Value = 0.0`
- `T_Dissolve`
  - 新增的溶解噪声纹理采样节点
  - 当前正从噪声纹理列表中选择资源，候选能看到 `T_Voronose002`、`T_Voronose003`、`T_Voronose004`

连线集：

- `Dissolve -> 上方算术节点`
- `Smoothness -> Add(1)`
- `Smoothness` 与上方算术结果分别接入 `Subtract`
- `SmoothStep` 与 `T_Dissolve` 处于待接入状态，当前截图未显示完整连线

设置/参数：

- `Dissolve.Default Value = 0.0`
- `Smoothness.Default Value = 0.0`
- `SmoothStep.Min = 0.0`
- `SmoothStep.Max = 1.0`
- `SmoothStep.Value = 0.0`
- 左下纹理面板表明当前正在为 `T_Dissolve` 选择一个噪声贴图资源

输出/预览：

- 左侧预览对象切成平面卡片，便于检查溶解遮罩纹理和边缘过渡，不再优先看球体外轮廓
- 这张图可替换为：开始搭建 `Dissolve` 控制子图，先建立 `Dissolve` 与 `Smoothness` 两个标量参数以及 `SmoothStep` 所需的上下界运算，同时新增一张专用于溶解的噪声纹理 `T_Dissolve`
节点定义集：

- 常量 `0.05`
  - 当前被选中
  - 作为 `Subtract.A`
- 常量 `0.5531`
  - 实际显示值约为 `0.553144`
  - 一路直接接到 `SmoothStep.Max`
  - 另一路接到 `Subtract.B`
- `Subtract`
  - 计算 `0.05 - 0.553144`
  - 输出接到 `SmoothStep.Min`
- `T_Dissolve`
  - 溶解噪声纹理采样
  - 当前用红通道输出接到 `SmoothStep.Value`
- `SmoothStep`
  - 当前处于 `Previewing`
  - 三个输入分别为：
    - `Min` 来自 `Subtract`
    - `Max` 来自常量 `0.553144`
    - `Value` 来自 `T_Dissolve`

连线集：

- `0.05 -> Subtract.A`
- `0.553144 -> Subtract.B`
- `Subtract -> SmoothStep.Min`
- `0.553144 -> SmoothStep.Max`
- `T_Dissolve.R -> SmoothStep.Value`

设置/参数：

- 常量一：`0.05`
- 常量二：`0.553144`
- 左侧预览区域当前在预览 `SmoothStep` 的结果

输出/预览：

- 左侧预览板当前几乎是深灰色棋盘，只剩很弱的遮罩差异，说明这组 `Min/Max/Value` 组合正在生成一条非常窄的溶解过渡区
- 这张图可替换为：先用 `T_Dissolve` 的红通道作为 `SmoothStep.Value`，再把 `Max` 设为约 `0.5531`，并用 `0.05 - 0.5531` 得到 `Min`，从而构造一个可调的溶解阈值区间

### 00:03:05-00:06:04 关键流程 02

- 本段定位：关键流程 02。
- 知识点：这是这里 这个很酷 我们已经 把Dissolve做好了 可以选择其他声音 让我们看看这个 根据这个标准 我们看看Dissolve 把0放在这里。
- 知识点：所有东西都应该是白色的 所有东西都完全被解决了 5 我看到 我们的质感开始变化了 这里很难看到 它被解决了 我把价值设定好 它会更好地解决 控制它是怎么滑的。
- 知识点：我们可观察到 如果我把它设定为0 那么它会变得很漂亮 现在它们更滑 Dissolve控制了Dissolve 这里可观察到 价值的原则。
- 知识点：在铁汽机上显示了 看看 这里 可以看看 需要把0加在这里 这是为了让你们 看到它正在发生什么事 然后它会把我们 在最低的位置 也会把我们 放在最高的位置。
- 知识点：我们 去 再来 如果Dissolve是0 那么最低的价值是-53 最高价值是0 为什么 在Shinusuto的前提 它开始是-的 所以如果是0在这里。

**关键画面：**

节点定义集：

- `Dissolve`
  - 标量参数
  - `Default Value = 0.0`
  - 左下细节面板还能确认：
    - `Slider Min = 0.0`
    - `Slider Max = 1.0`
    - `Sort Priority = 32`
- `Smoothness`
  - 标量参数
  - `Default Value = 0.0`
- `Add(1)`
  - 对 `Smoothness` 加上常量 `1.0`
- `Multiply`
  - 上方一条输入来自 `Dissolve`
  - 下方一条输入来自 `Add(1)`
- `Subtract`
  - `A` 输入来自 `Multiply`
  - `B` 输入来自 `Smoothness`
- `T_Dissolve`
  - 溶解噪声纹理采样
  - 红通道输出接入 `SmoothStep.Value`
- `SmoothStep`
  - 当前处于 `Previewing`
  - `Min` 输入来自 `Multiply`
  - `Max` 输入来自 `Subtract`
  - `Value` 输入来自 `T_Dissolve.R`

连线集：

- `Smoothness -> Add(1)`
- `Dissolve -> Multiply`
- `Add(1) -> Multiply`
- `Multiply -> SmoothStep.Min`
- `Multiply -> Subtract.A`
- `Smoothness -> Subtract.B`
- `Subtract -> SmoothStep.Max`
- `T_Dissolve.R -> SmoothStep.Value`

设置/参数：

- `Dissolve.Default Value = 0.0`
- `Dissolve.Slider Min = 0.0`
- `Dissolve.Slider Max = 1.0`
- `Dissolve.Sort Priority = 32`
- `Smoothness.Default Value = 0.0`

输出/预览：

- 左侧 `SmoothStep` 预览几乎全白，只剩少量黑色斑点，说明在 `Dissolve = 0`、`Smoothness = 0` 时，绝大部分噪声值都落在通过区间内
- 这张图可替换为：把 `Dissolve` 作为主阈值，先与 `Smoothness + 1` 相乘得到 `SmoothStep.Min`，再用该结果减去 `Smoothness` 得到 `SmoothStep.Max`，最后拿 `T_Dissolve` 的红通道作为比较值，形成一个可通过 `Dissolve` 和 `Smoothness` 共同控制的溶解遮罩
1. 这一帧继续预览 `SmoothStep` 结果，但左侧预览板已经几乎全黑，说明当前调节后的阈值区间把绝大多数 `T_Dissolve` 噪声值都排除在通过区间外
2. 右侧新增了一个 `DebugScalarValues` 调试函数节点，它接收来自前面阈值计算链的一路标量结果，用于在材质图里直接观察当前数值
3. `DebugScalarValues` 的输出又接到一个带常量 `A = 0.0` 的 `Add`，其小预览框中显示红色数字 `1`，说明教程在用最简单的标量显示方式确认极值或当前边界值
4. 当前仍能确认 `SmoothStep` 三个输入关系未变：
   - `Min` 和 `Max` 继续来自左侧 `Multiply` / `Subtract` 链
   - `Value` 继续来自 `T_Dissolve.R`
5. 左下材质基线仍保持：
   - `Material Domain = Surface`
   - `Blend Mode = Translucent`
   - `Shading Model = Unlit`
6. 这张图可替换为：在调节 `Dissolve` 阈值时，加入 `DebugScalarValues` 临时观察最小值或最大值的实际数值，确认 `SmoothStep` 的 `Min/Max` 区间确实按预期移动；当区间被推到极端时，遮罩结果会几乎完全变黑
1. 这一帧继续在 `SmoothStep` 子图上做数值验证，当前 `Dissolve` 已被调到约 `0.230398`，而 `Smoothness` 仍为 `0.0`
2. 左下细节面板当前选中的是 `Smoothness` 参数，可确认：
   - `Default Value = 0.0`
   - `Slider Min = 0.0`
   - `Slider Max = 0.0`
   - `Sort Priority = 32`
3. 中间数值链继续保持：
   - `Dissolve -> Multiply`
   - `Smoothness -> Add(1) -> Multiply`
   - `Multiply -> Subtract.A`
   - `Smoothness -> Subtract.B`
   - `Multiply` 与 `Subtract` 分别送入 `SmoothStep` 的两个边界输入
   - `T_Dissolve.R -> SmoothStep.Value`
4. 右侧现在放了两组 `DebugScalarValues + Add(0)` 调试显示，说明教程正在同时观察两条边界值，以验证最小值和最大值会随 `Dissolve` 的变化一起移动
5. 左侧 `SmoothStep` 预览已经出现清晰的黑白分界，右下小预览里也能看到红底上的黑色噪声孔洞，结合字幕 “It corresponds exactly to how smooth the edges will be” 可以确认：`Smoothness` 负责控制溶解边缘过渡带的宽度与柔和程度
6. 这张图可替换为：在 `Dissolve` 提升到约 `0.23` 后，用两组调试标量同时观察 `SmoothStep` 的上下边界；保持 `Smoothness = 0` 时，遮罩边缘较硬，后续只要提高 `Smoothness` 就会把这条黑白分界扩展成更柔和的过渡带

### 00:06:07-00:09:45 透明度

- 本段定位：透明度。
- 知识点：我们想象中 有一个质感 它有一个价值 从0到1 我们似乎把它切掉 用这个溶解 我们看到顺利度 我们把两个数字 分开之间 这不是顺利度 的问题 如果我们把0放在这里。
- 知识点：它们就不会更顺利 如果我们增加它 那么这个分别 会让我们有更差的顺利度 我们看到 从0到1 我们必须要看 这个最低价值的分别 它能提高多少 需要有更多的分别。
- 知识点：用一个滑涂机器 滑涂的形状 让我们得到一个很酷的结果 让它成为溶解 需要把它加进溶解 酷酷 然后我们把溶解 转移到透明度 我们必须要 把它调整到透明度。
- 知识点：如果溶解是0 那么这些都是 基本上 全部的愚蠢费用 这就是 如果我们开始 增加溶解 那么它就不会 溶解了滑涂的结果 而会均衡地 溶解我们的3D物品。
- 知识点：或是溶解任何东西 这就是 很酷的结果 让物品出现 因为它们就溶解了 这就是很酷的东西 我非常推荐 尤其是用水 很常用的 你也可以溶解角色 在整体来说。
- 知识点：是一个非常酷的东西 我们把这些溶解 分成 我们把这些溶解 放在一边 然后我们把它们 放在一边 我们保留了材料 现在我们来看看 结果的结果 它是什么样的。
- 知识点：让我把它 放在一边 这里 我们的溶解在来 这里我们必须 也要分成 一个结果的结果 这是我们的溶解 它溶解了这个物品 0它没有溶解 透明度溶解 根据这个质感。
- 核对对象：`透明度`。

**关键画面：**

1. 这一帧切到 `Desmos`，用图像方式解释材质里 `SmoothStep` 的区间计算，而不是继续展示 UE 材质图本身
2. 左侧公式区能直接确认教程采用的关系是：
   - `t = min(max((s-a)/(b-a),0),1)`
   - `j = min(max((x-a)/(b-a),0),1)`
   - `b = (m + 1) * d`
   - `a = (((m + 1) * d) - m)`
   - `s = min(max(y,0),1)`
3. 当前图中给出的示例参数值是：
   - `d = 0.193`
   - `m = 0.09`
   - 由此计算得到：
   - `b = 0.21037`
   - `a = 0.12037`
4. 右侧坐标图用两个标记点显示：
   - `min` 位于 `(0, a)`，对应约 `(0, 0.12037)`
   - `max` 位于 `(0, b)`，对应约 `(0, 0.21037)`
5. 这张图可替换为：为了说明 `Dissolve` 与 `Smoothness` 如何共同决定 `SmoothStep` 的上下边界，先把材质里的计算抽象成二维函数关系；其中 `d` 对应主阈值，`m` 对应边缘平滑宽度，最终得到 `min=a` 与 `max=b` 两个边界值
1. 这一帧回到 `M_WaterBubble` 的主输出区域，教程开始把刚做好的 `Dissolve` 结果接入正式材质，而不再只停留在 `SmoothStep` 预览
2. 右侧主材质节点当前可见并正在使用的输入包括：
   - `Emissive Color`
   - `Opacity`
   - `World Position Offset`
3. 中间已经存在的颜色和透明度链仍然保留：
   - `Main Color`、`Foam Color`、`Fresnel Color` 通过两级 `Add` 汇总到 `Emissive Color`
   - `Fresnel Opacity` 当前仍接向 `Opacity`
   - `Vertex Offset` 仍接向 `World Position Offset`
4. 画面下方打开了节点搜索菜单，`Named Reroutes` 列表里能直接看到 `Dissolve`、`Distortion`、`Foam Color`、`Fresnel Color`、`Fresnel Opacity`、`Main Color`、`Vertex Offset` 等命名线路，说明教程正打算把新的 `Dissolve` 结果通过命名重路由接入现有主图
5. 字幕明确提到 “take this dissolve, multiply it”，可确认下一步会先把 `Dissolve` 与现有结果做乘法处理，再送入目标链路；但本帧尚未显示完整乘法节点与最终落点，不能提前补写完整接线
6. 这张图可替换为：保留原有 `Emissive/Opacity/World Position Offset` 结构不变，在主输出区准备把新的 `Dissolve` 结果通过命名重路由接回来，并作为后续透明度或相关遮罩链的一部分参与乘法混合
节点定义集：

- 注释框内是完整的 `Dissolve` 子图
- `Dissolve`
  - 标量参数
  - `Default Value = 0.0`
- `Smoothness`
  - 标量参数
  - `Default Value = 0.1`
- `Add(1)`
  - 给 `Smoothness` 加上 `1.0`
- `Multiply`
  - 将 `Dissolve` 与 `Smoothness + 1` 相乘
- `Subtract`
  - 用上一步结果再减去 `Smoothness`
- `T_Dissolve`
  - 溶解噪声纹理
  - 输出接到 `SmoothStep.Value`
- `SmoothStep`
  - 三个输入已完整接好
- 右侧命名结果节点：`Dissolve`
  - 作为整套子图的统一输出

连线集：

- `Smoothness -> Add(1)`
- `Dissolve -> Multiply`
- `Add(1) -> Multiply`
- `Multiply -> SmoothStep.Min`
- `Multiply -> Subtract.A`
- `Smoothness -> Subtract.B`
- `Subtract -> SmoothStep.Max`
- `T_Dissolve -> SmoothStep.Value`
- `SmoothStep -> 结果节点 Dissolve`

设置/参数：

- `Dissolve.Default Value = 0.0`
- `Smoothness.Default Value = 0.1`
- 左下材质基线仍可见：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`

输出/预览：

- 左侧 `SmoothStep` 预览板基本为纯白，说明在当前默认值下，溶解遮罩处于“几乎完全保留”的初始状态
- 上方还能看到已有的 `Fresnel Opacity` 子图，说明教程正把 `Dissolve` 作为和透明度链并列的独立模块整理出来
- 这张图可替换为：将 `Dissolve` 控制逻辑整理成一个可复用的独立子图，使用 `Dissolve` 与 `Smoothness` 计算 `SmoothStep` 的最小值和最大值，再用 `T_Dissolve` 噪声驱动比较值，最后输出到命名结果节点 `Dissolve`

### 00:09:48-00:14:25 速度

- 本段定位：速度。
- 知识点：我们已经用了 一种 由Epic Games的 Team制作的 这是Motion for Wayhouse 像这个样子 功能 功能叫材料 这些是不同的。
- 知识点：这些已经 在物体机器里 已经被击溃了 可以 拿到我们需要的 这就像 这种一个 用材料的功能 我们按下 它有一定的 理论 在这里 可以 用这个功能。
- 知识点：在任何物体上 这就是 这种一种溶解 现在需要示范 我们先创造 我们的物体功能 去到物体功能盘 这里有功能 这些就是 物体功能 他们在追求了 在这里。
- 知识点：物体功能 在这里 MF的词 物体功能 我们叫它 滑溜溜 我们快速开始 它需要什么 它需要一个出口 是的 在 现在在做什么 在 在这里 在这里复制。
- 知识点：这是我们复制的 只有这个 定义的定义 会被击溃 这里 有一个 很有趣的东西 这是这个 这就是这个意思 这里没有功能 我们可观察到 在进入时 有很多不同的东西。
- 知识点：在哪里 怎么 我们怎么没有 做动作的 软面的 滑溜溜 哦 我们看到了 这里 是的 它们的规律 是有速度控制的。
- 知识点：如果我们想要 有什么成分 我们需要 在回应中 创造特别的东西 它们叫成 input in input 功能 input 这里有 在这个功能 input。
- 核对对象：`速度`。

**关键画面：**

节点定义集：

- 注释框：`Distortion`
- `Distortion Speed`
  - 标量参数
  - `Default Value = 0.5`
- `T_Distortion`
  - 纹理对象参数节点
  - 当前贴图预览为黑白噪声纹理
- `Motion_4WayChaos`
  - 材质函数
  - 使用 `Speed (S)` 与 `Texture (T2d)` 输入
- `Mask(RG)`
  - 从材质函数结果里取 `R/G` 两个通道
- `Distortion Influence`
  - 标量参数
  - `Default Value = 0.1`
- 右侧后续乘法链
  - 当前截图只显示连线延续到右侧，完整输出节点未全部进入画面

连线集：

- `Distortion Speed -> Motion_4WayChaos.Speed`
- `T_Distortion -> Motion_4WayChaos.Texture`
- `Motion_4WayChaos.Result -> Mask(RG)`
- `Mask(RG)` 输出继续送往右侧乘法链
- `Distortion Influence` 也送往右侧同一链路参与强度控制

设置/参数：

- `Distortion Speed.Default Value = 0.5`
- `Distortion Influence.Default Value = 0.1`
- 左下材质基线仍保持：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`

输出/预览：

- 左侧预览卡片仍是青蓝色流动水纹，说明当前正在讨论的是已有 `Distortion` 子图如何抽成可复用结构，而不是改变最终配色
- 这张图可替换为：把扭曲逻辑单独整理成一个 `Distortion` 模块，使用 `T_Distortion` 作为噪声来源，经 `Motion_4WayChaos` 生成流动向量，取 `RG` 两个通道后再用 `Distortion Influence(0.1)` 控制强度
节点定义集：

- 当前标签页已切到材质函数 `MF_SmoothDissolve`
- `Input In (Scalar)`
  - 函数输入节点
  - 左下细节面板可确认：
    - `Input Name = In`
    - `Input Type = Function Input Scalar`
- `Dissolve`
  - 标量参数
  - `Default Value = 0.0`
- `Smoothness`
  - 标量参数
  - `Default Value = 0.1`
- `Add(1)`
  - 给 `Smoothness` 加上 `1.0`
- `Multiply`
  - 用 `Dissolve` 与 `Smoothness + 1` 计算一条边界
- `Subtract`
  - 在乘法结果基础上减去 `Smoothness`
- `SmoothStep`
  - 继续作为核心函数节点
- `Output Result`
  - 函数输出节点
  - 当前尚未接好

连线集：

- `Smoothness -> Add(1)`
- `Dissolve -> Multiply`
- `Add(1) -> Multiply`
- `Multiply -> SmoothStep.Min`
- `Multiply -> Subtract.A`
- `Smoothness -> Subtract.B`
- `Subtract -> SmoothStep.Max`
- `Input In -> 预期用于 SmoothStep.Value`
- `SmoothStep -> 预期接到 Output Result`

设置/参数：

- `Dissolve.Default Value = 0.0`
- `Smoothness.Default Value = 0.1`
- 底部提示明确显示：`[SM6] Missing function output 'Result'`
- 说明教程正在把先前材质图里的 `SmoothDissolve` 逻辑抽成独立材质函数，但函数输出还没完全接好

输出/预览：

- 左侧预览球是默认灰色棋盘球，说明当前函数还没有形成完整可用输出
- 这张图可替换为：新建材质函数 `MF_SmoothDissolve`，把原先的 `Dissolve / Smoothness / SmoothStep` 区间计算迁入函数内部，并增加一个标量类型的函数输入 `In` 作为外部传入的比较值；此时函数框架已经搭好，但 `Result` 输出还未最终连通
节点定义集：

- 材质函数：`MF_SmoothDissolve`
- 既有边界计算链
  - `Dissolve`
  - `Smoothness`
  - `Add(1)`
  - `Multiply`
  - `Subtract`
- `Texture Sample`
  - 当前作为示例输入纹理
- `Input Value (Scalar)`
  - 函数输入节点
  - 输入值先经过 `Saturate`
- `Saturate`
  - 输出接到 `SmoothStep.Value`
- `SmoothStep`
  - 结果已经完整参与函数输出
- `Output Result`
  - 函数输出节点
  - 当前已接到 `SmoothStep`

连线集：

- `Dissolve / Smoothness / Add(1) / Multiply / Subtract` 继续组成 `SmoothStep.Min` 与 `SmoothStep.Max`
- `Input Value (Scalar) -> Saturate -> SmoothStep.Value`
- `SmoothStep -> Output Result`
- 下方 `Texture Sample` 当前用于给输入值做示例预览或测试

设置/参数：

- 左下细节面板当前选中 `Output Result`
  - `Output Name = Result`
- 字幕明确提到 “Let it be our mask”，说明函数输出被定义为后续直接可用的遮罩

输出/预览：

- 左侧预览板现在恢复为几乎全白，右侧 `SmoothStep` 与 `Output Result` 预览都显示红色有效结果，说明材质函数的输出链已经连通
- 这张图可替换为：完成 `MF_SmoothDissolve` 材质函数的封装，把外部传入的标量输入先做 `Saturate` 限制到 `0-1`，再送入 `SmoothStep.Value`，最终将 `SmoothStep` 结果输出为名为 `Result` 的遮罩

### 00:14:25-00:17:52 关键流程 05

- 本段定位：关键流程 05。
- 知识点：当你制作面具 它通常会被展示到一个圣诞 为什么? 因为现在我正在移动到圣诞 我例如想找到它 所以我写MFMouse 它不在 找到它需要 制作一些面具。
- 知识点：你已经可以找到它 在整个标题上 它正在按照原理 然后我们制作一个面具 这是一个实体的功能 这不是很方便 所以如果我们想进入 我们的标题中的所有文字。
- 知识点：有些 我们需要制作出 标题的面具 这是它 标题的类型 Misc 让它在这里 还有类型 可以选择其他 OT 这是它 现在我删掉 现在可以做什么?。
- 知识点：可以找到它 可以找到什么 Smooth MF 这里它是 MFSmoothDissolveall 在整体上非常酷 这是我们的意思 可以选择。
- 知识点：SmoothHeatAlloDissolve 可以现在 改变预计 就是这里 比如 我们想要的 温度和质量 从最底部来 预计32度 或者比较少。
- 知识点：Dissolve会更高 和Smoothness会比较低 我们保持 让我们看看 适当紧密 这些预计的预计 已经改变了 基本上我们要做什么? 我们要拔掉。
- 知识点：拔掉 拔掉 我们有一个功能 我们只需要 转移这些预计 Dissolve这里 Smoothness这里 还有我们的质量 我们只转移R频道这里 这就是。

**关键画面：**

1. 这一帧回到 `M_WaterBubble` 总图的中尺度视图，教程开始说明为什么要把若干子图整理成材质函数或模块，便于后续在内容库中快速搜索和复用
2. 画面中能同时看到已经分组好的几块核心结构：
   - 上方主颜色相关子图
   - 中间 `Distortion` 子图
   - 右上 `Vertex Offset` 子图
   - 下方开始进入 `Foam Color` 区域
3. 左侧预览卡片保持青蓝色流动水纹，说明当前主要是在整理结构和复用方式，而不是改变材质最终表现
4. 结合本段标题 `关键流程 05` 和上下文文字，可以确认教程正在从“直接堆在一个材质里”过渡到“把通用逻辑抽成函数/模块”，为后面把 `SmoothDissolve` 接回主材质做准备
5. 当前截图没有展示新的具体连线变化，因此这张图只应记录模块化整理意图和已有子图布局，不应补写不存在的新接线
节点定义集：

- `Dissolve`
  - 标量参数
  - `Default Value = 0.0`
- `Smoothness`
  - 标量参数
  - `Default Value = 0.1`
- `T_Dissolve`
  - 溶解噪声纹理采样
  - 当前使用红通道输出
- 材质函数调用：`MF_SmoothDissolve`
  - 输入端清晰可见：
    - `Dissolve (S)`
    - `Smoothness (S)`
    - `Value (S)`
  - 输出端为 `Mask`
- 右侧命名结果节点：`Dissolve`

连线集：

- `Dissolve -> MF_SmoothDissolve.Dissolve`
- `Smoothness -> MF_SmoothDissolve.Smoothness`
- `T_Dissolve.R -> MF_SmoothDissolve.Value`
- `MF_SmoothDissolve.Mask -> 结果节点 Dissolve`

设置/参数：

- `Dissolve.Default Value = 0.0`
- `Smoothness.Default Value = 0.1`
- 左下细节面板当前选中的是材质函数调用节点
  - `Material Function = MF_SmoothDissolve`

输出/预览：

- 左侧预览卡片保持原有青蓝色水纹，说明此时是在把封装好的溶解函数接回主材质逻辑，尚未直接改变当前主预览
- 这张图可替换为：将封装好的 `MF_SmoothDissolve` 作为函数调用节点接入主材质，用 `Dissolve`、`Smoothness` 和 `T_Dissolve.R` 三个输入生成统一的 `Mask` 输出，再写回命名结果节点 `Dissolve`
节点定义集：

- `TexCoord[0]`
  - `Coordinate Index = 0`
- `Main (ScaleScroll)`
  - 向量参数
  - `Default Value = (1,1,0,0)` 一类四分量缩放/滚动参数
- `Append` × 2
  - 把 `Main (ScaleScroll)` 的分量重新组合成两组二维数据
- `Multiply(0)`
  - 当前节点标题显示常量为 `0.0`
  - 与上方 `Append` 结果相连
- `Panner`
  - `Coordinate` 与 `Speed` 都由前面拼装出的二维数据驱动
- `T_Dissolve`
  - 溶解噪声纹理采样
  - `UVs` 输入来自 `Panner`
  - 红通道继续送往右侧的溶解链
- 右侧还能看到：
  - `Dissolve` 标量参数，`Default Value = 0.0`
  - `Smoothness` 标量参数，`Default Value = 0.1`

连线集：

- `Main (ScaleScroll)` 分量 -> 两个 `Append`
- 上方 `Append -> Multiply(0)`
- `Multiply(0) -> Panner.Coordinate` 或其前置坐标链
- 下方 `Append -> Panner.Speed`
- `Panner -> T_Dissolve.UVs`
- `T_Dissolve.R` 输出继续接到右侧的 `Dissolve/Smoothness` 遮罩计算链

设置/参数：

- `TexCoord[0].Coordinate Index = 0`
- `Main (ScaleScroll)` 当前作为控制溶解纹理缩放和滚动的统一参数
- 左下细节面板当前选中的是 `TexCoord[0]`
  - `UTiling = 1.0`
  - `VTiling = 1.0`

输出/预览：

- 左侧预览卡片仍保持青蓝色水纹，说明当前操作是在给溶解噪声增加可控的缩放与移动方式，而不是直接展示溶解后的最终外观
- 这张图可替换为：不要直接用静态 UV 采样 `T_Dissolve`，而是复用 `Main (ScaleScroll)` 一类二维参数，通过 `Append + Panner` 给溶解噪声加入可调的缩放和滚动，从而让 `Dissolve` 遮罩也能随参数移动和变形

### 00:17:58-00:22:43 UV、粒子、系统

- 本段定位：UV、粒子、系统。
- 知识点：我们转移到UV 现在我们只能 从这里控制Dissolve 是的 在这个调整中 但是需要 直接控制Dissolve 在这个粒子的系统上。
- 知识点：我们交换 需要 调整到设计中 现在我来示范 在本体上 我们可观察到 现在可以 把所有的调整都改变 我把车停车 让它能够 更好看 我们有Dissolve。
- 知识点：在这里 我没有调整到哪里 我们可观察到 我已经很晚了 因为我们没有 把这个Dissolve 调整到哪里 这里是它的颜色。
- 知识点：这意味着 这里是不太方便的 所以我们先把这个弄干净 还有 这里是主色 我把这个调整到哪里 把调整到哪里 Dissolve是放的 这是Dissulfide。
- 知识点：这是我们的Dissolve 这是我们的Dissolve 我们看到的所有 这是我们的Dissolve 我们把所有的都拦掉 我们开始 这里是Dissolve。
- 知识点：所有的调整 我们有的调整都很棒 滑润和调整的线 可以增加 这个线的调整 它也可以 把这个调整和调整都移动 这里我们把 调整和调整的东西 都调整得很滑润。
- 知识点：所有的调整都很棒 很酷 所有的调整都很酷 现在我们把这个调整到0 是的 可能是这样 可以把这个调整 从最高调整到最高 是的 现在可以 把所有调整。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`系统`、`颜色`、`透明度`。

**关键画面：**

1. 这一帧明确强调：主材质里已经可以直接通过参数控制 `Dissolve`，不必再进入材质函数内部修改
2. 中间可见的函数调用链路为：
   - `Dissolve` 标量参数，`Default Value = 0.0`
   - `Smoothness` 标量参数，`Default Value = 0.1`
   - `MF_SmoothDissolve`
   - 右侧命名结果节点 `Dissolve`
3. 当前还能确认：
   - `Dissolve -> MF_SmoothDissolve.Dissolve`
   - `Smoothness -> MF_SmoothDissolve.Smoothness`
   - 下方来自 `T_Dissolve` 的值继续送入 `MF_SmoothDissolve.Value`
   - `MF_SmoothDissolve.Mask -> 结果节点 Dissolve`
4. 左下细节面板当前选中的是 `Dissolve` 参数，可确认：
   - `Default Value = 0.0`
   - `Slider Min = 0.0`
   - `Slider Max = 1.0`
   - `Sort Priority = 32`
5. 左侧预览卡片仍显示青蓝色流动水纹，说明此时只是确认参数控制权已经回到主材质，而不是立即改变可见结果
6. 这张图可替换为：将 `MF_SmoothDissolve` 接回主材质后，把 `Dissolve` 暴露为主材质里的直接可调参数，后续无论在材质实例还是粒子系统里，都可以从这里驱动溶解进度
1. 这一帧把多个模块同时放进同一视野，说明教程正在把 `Dissolve` 与已有的 `Vertex Offset` 等结构并列整理，准备统一接到粒子或系统可驱动的参数入口
2. 上方完整可见的是 `Vertex Offset` 模块，保持原有的局部位置、时间、噪声贴图、法线和高度参数链路，最终输出到命名结果节点 `Vertex Offset`
3. 中间的 `Dissolve` 注释框里能明确看到：
   - 一个 `Dynamic Parameter` 节点
   - `Smoothness` 标量参数
   - `MF_SmoothDissolve` 函数调用
   - 右侧命名结果节点 `Dissolve`
4. 可确认的关键关系是：
   - `Dynamic Parameter` 的某个通道被拿来替代或补充 `Dissolve` 的直接控制来源
   - `Smoothness` 继续接入 `MF_SmoothDissolve`
   - `MF_SmoothDissolve.Mask -> 结果节点 Dissolve`
5. 左下细节面板当前选中的是一个注释框，标题显示为 `Soft Edges`，说明当前画面处于模块整理视图，而不是具体参数编辑视图
6. 这张图可替换为：为了让溶解效果能由粒子系统实时驱动，把 `Dissolve` 模块改成接收 `Dynamic Parameter` 作为主要输入来源之一，再与现有 `Smoothness` 一起送入 `MF_SmoothDissolve`，最后继续输出统一的 `Dissolve` 遮罩结果
节点定义集：

- 材质函数：`MF_SmoothDissolve`
- `SmoothStep`
  - 当前仍是整个溶解逻辑的核心遮罩结果
- `Floor`
  - 对 `SmoothStep` 输出做离散化处理
- `Subtract`
  - 以 `SmoothStep` 与 `Floor` 的结果做差
- 一个右上角加法/混合节点
  - 用于合成最终的主遮罩输出
- `Output Mask`
  - 函数输出之一
- `Output Edge`
  - 函数输出之二

连线集：

- `SmoothStep -> Floor`
- `SmoothStep -> Subtract.A`
- `Floor -> Subtract.B`
- `Floor` 与 `Subtract` 的结果继续进入右上角合成节点
- 合成节点 -> `Output Mask`
- `Subtract` -> `Output Edge`

设置/参数：

- 左下细节面板当前选中的是一个 `Add` 节点，可见：
  - `Const A = 0.0`
  - `Const B = 1.0`
- 从输出命名可以直接确认该函数现在不再只输出单一 `Result`，而是拆成 `Mask` 与 `Edge` 两路结果

输出/预览：

- `Output Mask` 预览是红色有效结果，而 `Output Edge` 预览当前接近黑色，说明函数已经把主体遮罩和边缘信息拆开
- 左侧大预览板仍几乎纯白，表明在当前输入值下主体遮罩处于完整保留状态
- 这张图可替换为：在 `MF_SmoothDissolve` 内部，不仅输出主体溶解遮罩 `Mask`，还额外通过 `SmoothStep - Floor(SmoothStep)` 分离出一条边缘带作为 `Edge` 输出，便于后续在材质里单独控制溶解边缘表现

### 00:22:43-00:25:52 Color、粒子

- 本段定位：Color、粒子。
- 知识点：让我们看看这里 其實质感是有點差的 现在我可以快速把这个標準 Tau取代很快 然后需要回到原位 让我们看看 这就是結果 基本上这里所有东西都一樣。
- 知识点：但这是个很有趣的东西 它会轉向这个层面 如果我放0 那它就不会有任何邊線 如果我放0就只会有1 也就是 越快速越会轉向层面 这就是正常的情况。
- 知识点：我们有这种噪音 这里是这些順滑的转换 它们被这Floor切斷了 Floor只取代了意思 它把这个價值轉向了 也就是它们被切斷了 然后我從这噪音取代。
- 知识点：我取走这些圆形的圆形 然后我们只剩下这个 我们只剩下这个 我把它们取走 只有这个圆形留下 然后我把这个圆形轉向这里 然后需要把这个圆形 加到Floor里。
- 知识点：这就是基本上这里 你就可以快速地取代 这是怎麼做的 这里没有任何差別 这樣就更好 所以我们只要把圆形擦掉 这就是結果 为什么这个? 有趣的是。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`粒子`、`颜色`。

**关键画面：**

1. 这一帧把整张材质图缩到总览层级，重点不是单个节点，而是观察多个模块如何一起汇入主材质输出
2. 从整体布局上可以可靠确认至少存在三块主要注释区域：
   - 上方一条长条状模块
   - 中间一块较大的综合模块
   - 下方一块较窄的辅助模块
3. 这些模块中的多条结果线都向右侧主材质节点汇聚，说明教程正在检查把 `Mask`、`Edge`、颜色层、位移层等结构重新组合后的总装状态
4. 左侧预览卡片保持青蓝色流动水纹，没有明显溶解破碎，说明当前总装结构在默认参数下仍维持“完整显示”的基线效果
5. 左下细节面板当前展开的是材质 `Translucency` 一组设置，能看到如 `Screen Space Reflections`、`Lighting Mode` 等选项，说明这时也在顺手核对透明材质的整体渲染表现
6. 这张图可替换为：将已经整理好的多个功能模块重新汇总到主材质节点，先做一次全图层级的结构检查，确保颜色、透明度、溶解和位移等分支都已接回总输出且默认外观仍正确
节点定义集：

- 材质函数：`MF_SmoothDissolve`
- `SmoothStep`
  - 当前作为原始连续溶解遮罩
- `Floor`
  - 对 `SmoothStep` 做离散化
- `Subtract`
  - 计算 `SmoothStep - Floor(SmoothStep)`
- `Output Mask`
  - 直接接收 `SmoothStep` 的主遮罩输出
- `Output Edge`
  - 接收 `Subtract` 的边缘输出

连线集：

- `SmoothStep -> Output Mask`
- `SmoothStep -> Floor`
- `SmoothStep -> Subtract.A`
- `Floor -> Subtract.B`
- `Subtract -> Output Edge`

设置/参数：

- 当前截图重点不在参数数值，而在两个输出的视觉区别
- `Output Mask` 预览显示红底配少量黑色孔洞
- `Output Edge` 预览只保留一圈较薄的红色边缘斑带

输出/预览：

- 左侧大预览板能直接看出：主体是一整块白色区域，中间被黑色噪声孔洞切开
- 这张图可替换为：`Output Mask` 保留主体可见区域，而 `Output Edge` 只保留由 `SmoothStep - Floor(SmoothStep)` 提取出来的边界带。这样后续材质既能控制整体溶解遮罩，也能单独给溶解边缘加颜色或发光
节点定义集：

- `MF_SmoothDissolve`
  - 当前可见两个输出：
    - `Edge`
    - `Mask`
- `Dissolve Edge Color`
  - 颜色参数
  - 当前默认值为黑色一类深色
- `Multiply`
  - 用于把 `Edge` 与 `Dissolve Edge Color` 相乘
- 结果节点 `Dissolve Edge Color`
  - 保存边缘颜色层结果
- 结果节点 `Dissolve`
  - 保存主体遮罩结果
- 右侧已有主颜色链
  - `Particle Color`
  - `Main Color`
  - `Foam Color`
  - `Fresnel Color`
  - 两级 `Add`

连线集：

- `MF_SmoothDissolve.Edge -> Multiply`
- `Dissolve Edge Color -> Multiply`
- `Multiply -> 结果节点 Dissolve Edge Color`
- `MF_SmoothDissolve.Mask -> 结果节点 Dissolve`
- 右侧原有颜色链仍保持：
  - `Main Color` 与 `Foam Color` 先相加
  - 再与 `Fresnel Color` 等颜色层继续混合
  - `Particle Color` 也参与后续颜色总合

设置/参数：

- 左下细节面板当前选中的是 `Dynamic Parameter`
  - `Index [0] = Dissolve`
  - 其余索引名仍为默认 `Param2 / Param3 / Param4`
  - `Parameter Index = 0`
- 说明 `Dynamic Parameter` 的第一个通道被正式命名并用于驱动溶解

输出/预览：

- 左侧当前预览的是 `Multiply` 结果，整块几乎全黑，说明在当前默认边缘颜色下，边缘附加色层还没有被明显点亮
- 这张图可替换为：把 `MF_SmoothDissolve` 的 `Edge` 输出与一个独立的 `Dissolve Edge Color` 参数相乘，生成专门的溶解边缘颜色层；同时保留 `Mask` 作为主体溶解遮罩，并让 `Dynamic Parameter[0]` 正式承担粒子侧的 `Dissolve` 驱动职责

### 00:26:54-00:31:30 System

- 本段定位：System。
- 知识点：可以自己设置颜色 可以控制光亮度 让我们有时Dissolve 所以,这里会有 可观察到一小塊的板子 是的,因为我设置了 一个动态的功能。
- 知识点：它只能用在 particle的时间 它可以创建什么只能見到 快速把所有东西轉向这里 在看着我们 物体Dissolve,等等 这里有个光线。
- 知识点：它可以调整这些邊界 如果我们不需要 把颜色给任何颜色 我们只需要把颜色调整到黑 基本上,所有东西都一樣 这是一个很好的功能 我加了这个物体功能。
- 知识点：非常酷,基本上 需要把Dissolve轉向这里 现在需要轉向 系统的 particle 我只想把这个动态 适当调整一点 你也知道,例如。
- 知识点：让它快速变成有光线 我们把它按照標準转换 所有东西都设置为0,我们来看看 我们开始用Foam 0.75 我还会把颜色调整。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`系统`、`颜色`。

**关键画面：**

这是 `MI_WaterBubble_01` 材质实例的参数调色界面，教程此时在微调水花泡沫的高亮边缘颜色

- 当前打开的是 `Foam` 分组中的颜色参数取色器
  - 颜色取样结果接近白色偏青蓝
  - 取色器中可见 `R = 6.156993`
  - `G = 21.399872`
  - `B = 25.0`
  - `A = 1.0`
  - `H = 191.463531`
  - `S = 0.75372`
  - `V = 25.0`
  - `Hex Linear = FFFFFF`
  - `Hex sRGB = FFFFFF`
- `Foam` 分组里可以确认当前启用了泡沫相关颜色控制
  - 上方泡沫贴图槽已启用
  - `Foam Color` 复选框为开启状态
  - 下方泡沫颜色条显示为浅青蓝色
- 左侧视口同步预览效果
  - 水花主体保持半透明青蓝色
  - 外轮廓出现更亮的白色高光边
  - 说明这一步的目的不是改形状，而是把泡沫边缘调得更亮、更冷色
- 右侧还能看到同一材质实例中已存在的相关分组
  - `Dissolve`
  - `Distortion`
  - `Foam`
  - `Fresnel Color`
  - `Main Color`

这张图可替换为：在 `MI_WaterBubble_01` 的 `Foam` 参数组中打开 `Foam Color` 颜色选择器，把泡沫边缘颜色调成接近白色的浅青蓝色，使水花外轮廓获得更亮的发光泡沫边，同时在视口里直接核对整体仍保持蓝绿色水泡主体
这是 `MI_WaterBubble_01` 材质实例在完成泡沫颜色调整后的整体参数状态，重点是确认 `Dissolve`、`Foam` 和 `Fresnel` 三组参数如何共同塑造水泡外观

- `Dissolve` 分组当前可见设置
  - `T_Dissolve = T_Noise111`
  - `Dissolve (Scale/Scroll)` 已启用
  - `Dissolve Edge Color` 已启用，当前为纯黑
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
  - `Smoothness = 0.121942`
- `Distortion` 分组当前可见设置
  - `T_Distortion = T_Inky_Smoke_Tile`
  - `Distortion Influence = 0.1`
  - `Distortion Speed = 0.5`
- `Foam` 分组当前可见设置
  - `T_Foam = T_WaveNoise_01`
  - `Foam (Scale/Scroll)` 已启用
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = -0.75`
  - `Foam Color` 已启用，颜色条显示为浅青蓝
    - 当前可见输入值包括 `R = 0.10`
    - `G = 0.89576`
    - `B = 1.0`
    - `A = 1.0`
- `Fresnel Color` 分组当前可见设置
  - `Fresnel Color` 已启用，颜色渐变为青蓝到亮蓝
  - `Fresnel Exp = 2.0`
- `Global Scalar Parameter Values`
  - `Depth Fade = 100.0`

视口预览结果：

- 中央预览体已经从不规则水花切换成较完整的球形水泡
- 球体主体为柔和的浅青蓝色
- 外轮廓有明显的亮蓝边缘
- 表面能看到宽而柔和的横向流动条纹，说明泡沫纹理和扭曲贴图都已经参与到最终表现

这张图可替换为：在 `MI_WaterBubble_01` 中确认水泡系统的关键实例参数组合，使用 `T_Noise111` 作为溶解贴图、`T_Inky_Smoke_Tile` 作为扭曲贴图、`T_WaveNoise_01` 作为泡沫贴图，保持黑色 `Dissolve Edge Color`、较低 `Smoothness = 0.121942`、`Distortion Influence = 0.1`、`Distortion Speed = 0.5`，并把 `Foam Color` 与 `Fresnel Color` 调成浅青蓝系，从而得到一个带亮边和表面波纹的半透明球形水泡
这是把 `MI_WaterBubble_01` 临时挂到场景 `Sphere` 静态网格上做最终观感检查的场景截图，教程说明这个上方测试球已经完成验证，接下来可以移除，效果将直接显示在 Niagara 粒子系统本体上

- 场景层级
  - 当前关卡为 `Stylized_WaterSplash`
  - `Outliner` 中同时可见 `NS_StylizedWaterSplash` 与一个单独的 `Sphere`
  - 当前选中对象是 `Sphere`
- 右侧 `Details` 面板可确认
  - `Static Mesh = Sphere`
  - `Materials -> Element 0 = MI_WaterBubble_01`
  - 该球体只是材质预览载体，不是最终粒子表现的必要组成
- 视口结果
  - 深色背景下能清楚看到一个小型发光水泡
  - 主体呈浅青蓝色，边缘更亮
  - 表面仍保留柔和的波纹层次，说明材质实例参数已达到可用状态
- 画面字幕直接给出操作意图
  - 可以把上面的这个移除
  - 之后效果会直接出现在粒子系统自身上

这张图可替换为：完成 `MI_WaterBubble_01` 的材质调试后，把它临时赋给场景中的 `Sphere` 静态网格检查最终观感；确认球体上的青蓝色水泡外观成立后，删除这个辅助 `Sphere` 预览对象，只保留 `NS_StylizedWaterSplash` 粒子系统本体来承载同样的视觉效果

### 00:31:30-00:36:28 关键流程 09

- 本段定位：关键流程 09。
- 知识点：它显示在上方 三秒鐘後它突然消失 在这里,首先 让我给大家看看,基本上 我们要怎麼让它移动一点 我们需要把它转换 这可以在物体更新上。
- 知识点：我们需要 新的一个模式 我们只需要不创建新的 我们需要创建已经存在的模式 这是物体的位置 这个模式就设置了 我们的位置 现在它是,是的。
- 知识点：我们可观察到它变成3.5 在这里为了提升起點 但在更新上 它其實是從下方取出的位置 因此我们需要创建这个位置 我们需要 加上一个vector。
- 知识点：加vector到位置 我们要取出最初的位置 我们应该要取出最初的位置嗎? 它存在着 最初的位置 就是这个位置的生命 我们取出最初的位置 然后再升到3.5。
- 知识点：再升到3.5 我们取出最初的位置 然后我们把它转换到自己的位置 我们只想把它移动到Z的位置 因此我们要做一个vector 这樣它会更方便。
- 知识点：我们不只觸碰XY,而是Z 这里需要取出一條圆形 然后需要把它移动到地球上 然后需要把它移动到地球上 这就是加上和減少 这里 我们来写一个很重要的圖。
- 知识点：这是第二个圖 最後我们把它放在1 它存在着 需要把它存在着 然后它会升上去 对,卡了 我们甚至会把它斷掉 然后它会向上升 可以这樣做 是的,我们看到这里我们需要一个減少圖。

**关键画面：**

这是进入 `NS_StylizedWaterSplash` 后、准备开始为水泡添加运动逻辑前的发射器基线状态截图，当前选中的是网格发射器 `WaterSphereMesh`

Niagara Stack 结构：

- System 侧只有系统总览
  - `Properties`
  - `User Parameters`
  - `System Spawn`
  - `System Update`
  - `System State`
- 发射器 `WaterSphereMesh` 当前包含
  - `Properties`
  - `Emitter Summary`
  - `Emitter Spawn`
  - `Emitter Update`
  - `Particle Spawn`
    - `Initialize Particle`
  - `Particle Update`
    - `Particle State`
  - `Render`
    - `Mesh Renderer`

右侧 `Mesh Renderer` 细节当前可确认：

- `Meshes[0] = Sphere`
- `Enable Material Overrides` 已开启
- `Override Materials[0].Explicit Mat = MI_WaterBubble_01`
- `Source Mode = Particles`
- `Facing Mode = Default`
- `Sort Mode = None`

左侧预览窗口结果：

- 粒子系统里已经能看到一个小型青蓝色水泡
- 它此时主要是静态显示状态，尚未体现明显的上升或位移动画

这张图可替换为：回到 `NS_StylizedWaterSplash` 的 `WaterSphereMesh` 发射器，确认网格渲染器仍使用 `Sphere + MI_WaterBubble_01` 的组合，并检查当前 `Particle Update` 中还只有 `Particle State`，说明接下来要把水泡移动逻辑补到粒子更新阶段
这是 `WaterSphereMesh` 发射器开始实现上升运动的关键设置图，教程在 `Particle Update` 中新增了一个 `Set (PARTICLES) Position` 模块，并把粒子位置改写为“初始位置 + 仅作用于 Z 的偏移量”

Niagara Stack 变化：

- `Particle Update` 不再只有 `Particle State`
- 新增模块
  - `Set (PARTICLES) Position`

模块结构：

- `PARTICLES.Position`
  - 写入方式为 `Add Vector to Position`
- `Position`
  - 输入来源是 `PARTICLES INITIAL Position`
  - 说明位置更新不是基于上一帧累计漂移，而是回到初始位置作为基准
- `Vector`
  - 使用 `Make Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = Float from Curve`

曲线设置：

- `FloatCurve = Curve for Floats`
- `Curve Index = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线形状可见为
  - 前半段基本贴近 0
  - 接近寿命后段开始快速上升
  - 末端到达正值

效果含义：

- 粒子在生命前段基本停留在原位
- 到生命后段时沿 Z 轴抬升
- 因为 `X`、`Y` 保持 0，所以不会横向漂移

这张图可替换为：在 `WaterSphereMesh` 的 `Particle Update` 中添加 `Set Particles.Position`，将其模式设为 `Add Vector to Position`，位置基准取 `Particles.Initial.Position`，再用 `Make Vector` 只给 `Z` 通道接入一个以 `Particles.NormalizedAge` 为索引的浮点曲线，而 `X/Y` 维持 0，从而让水泡在生命周期后段只向上抬升
这是 `WaterSphereMesh` 发射器里用曲线驱动网格尺寸变化的设置图，教程在 `Particle Update` 中选中了 `Scale Mesh Size` 模块，并通过 `NormalizedAge` 曲线控制水泡在生命周期中的缩放幅度

Niagara Stack 当前可见顺序：

- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Set (PARTICLES) Position`
- `Render`
  - `Mesh Renderer`

`Scale Mesh Size` 模块设置：

- `Scale Factor`
  - 输入模式为 `Vector from Float`
- `Value`
  - 输入为 `Float from Curve`
- 曲线数据
  - `FloatCurve = Curve for Floats`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
  - 当前可见曲线走势为
    - 起点较低
    - 前半段逐渐上升
    - 中后段保持接近稳定
    - 末段没有明显骤降

预览结果：

- 左侧视口里水泡此刻尺寸较小
- 结合当前模块可判断，教程在用缩放曲线塑造水泡出现后的成长节奏，而不是固定网格尺寸

这张图可替换为：在 `WaterSphereMesh` 的 `Particle Update` 中使用 `Scale Mesh Size` 模块，把 `Scale Factor` 设为 `Vector from Float`，再让这个浮点值由 `Particles.NormalizedAge` 索引的曲线驱动，使网格球体在生命周期内按曲线逐步放大并趋于稳定，而不是始终保持固定大小

### 00:36:28-00:41:03 Curve

- 本段定位：Curve。
- 知识点：它会向上升,再次向上升 我们也会用圖形 这里有兩种圖形 这里,这就是为什么每个角度都会減少 我创建了MAKE VECTOR 这比較方便 可以创建它。
- 知识点：MAKE VECTOR是这樣的 可以立刻创建一个FORM CURVE VECTOR 并反应每个角度 这比較方便 你決定它是否方便 这就是你的反应。
- 知识点：这就是CURVE 我们来減少它 让它減少它 然后这里开始了 我们来減少它 这里,是的,減少它 变化 是的,现在看起来有點奇怪 在Y方面,基本上是一樣的。
- 知识点：我们已经有一点 我们来減少它 这里,已经減少它 你看到有趣的情况 我们来減少它 这里是最初的圖形 这里是它的圖形 这里,它出现了 这里,我们看到了。
- 知识点：它減少了它的圖形 是的,就像在準備飛行 而其他圖形 这里已经減少了 是的,因为我们可观察到 它在飛行中似乎伸展上去 然后減少了 減少了 我现在只想要的。
- 知识点：X和Y 是伸展的 是的,目标是它伸展得更高 这里是Z 按照標準,我们这里有一个單位 差不多每次 这里,是的,这里 哦,这里的單位变幅了 是的,在这里。
- 知识点：,我们看到了一个圖形 它非常地迅速地开始F 我按下了F,是的,自動 在这里自動,可能更快 我们要看它如何運作 就是,按照標準 我们有一个標準的一种減少。
- 核对对象：`Curve`。

**关键画面：**

这是 `Curve` 小节里继续细化水泡尺寸节奏的第一步，教程在 `WaterSphereMesh` 的 `Particle Update` 中又加入了一个额外的 `Scale Mesh Size 001` 模块，并正在为它的 `Scale Factor` 选择新的向量输入方式

Niagara Stack 当前可见顺序：

- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Mesh Size 001`
  - `Set (PARTICLES) Position`

右侧 `Scale Mesh Size 001` 细节：

- 当前编辑参数为 `Scale Factor`
- 默认值仍是三通道统一的
  - `X = 1.0`
  - `Y = 1.0`
  - `Z = 1.0`
- 已打开输入类型/动态输入下拉菜单
  - 可见可选项包括
    - `Vector from Curve`
    - `Vector from Float`
    - `Multiply Vector`
    - `Multiply Vector by Float`
    - `Random Range Vector`
    - `Random Vector`
    - `Rotate Vector`
    - `Select Vector from Array`

画面意图：

- 教程并不是只保留一个固定缩放模块
- 而是准备叠加第二层尺寸控制
- 通过把统一的 `(1,1,1)` 常量改成动态输入，为后续“按生命周期曲线变化尺寸”做准备

这张图可替换为：在 `WaterSphereMesh` 的 `Particle Update` 里追加第二个 `Scale Mesh Size 001` 模块，保持初始 `Scale Factor = (1,1,1)`，然后打开输入类型菜单，准备把该缩放值从常量改成 `Vector from Curve` 或 `Vector from Float` 一类的动态曲线输入，用来叠加控制水泡的尺寸变化节奏
这是第二个 `Scale Mesh Size 001` 模块的具体曲线配置图，教程把 `Scale Factor` 改成 `Make Vector`，并分别用三条基于 `Particles.NormalizedAge` 的曲线控制 `X`、`Y`、`Z` 缩放，从而做出更接近拉伸水泡的形态变化

模块结构：

- `Scale Mesh Size 001`
  - `Scale Factor = Make Vector`
  - `X = Float from Curve`
  - `Y = Float from Curve`
  - `Z = Float from Curve`

曲线设置：

- 三个轴的 `CurveIndex` 都是 `PARTICLES.NormalizedAge`
- 三个轴的 `Scale Curve` 都是 `1.0`

各轴可见曲线形状：

- `X` 曲线
  - 前半段接近 `1.0`
  - 中段基本保持不变
  - 后半段快速下降到接近 `0`
- `Y` 曲线
  - 走势与 `X` 基本一致
  - 也是前段维持、后段明显收缩
- `Z` 曲线
  - 大部分时间接近 `1.0`
  - 后段略微上升
  - 末端可见数值约为 `1.065`

视觉含义：

- 横向 `X/Y` 在生命周期后段被压缩
- 纵向 `Z` 没有跟着缩小，反而略微增加
- 因此网格球体不会只是整体等比缩小，而会更像向上轻微拉长、底部收拢的水滴/泡体

这张图可替换为：把第二个 `Scale Mesh Size 001` 的 `Scale Factor` 设为 `Make Vector`，其中 `X` 与 `Y` 使用相同的 `NormalizedAge` 曲线，在生命后段从约 `1` 快速缩到接近 `0`；`Z` 则保持在 `1` 附近并在末段略微升到约 `1.065`，从而让水泡后期横向收窄、纵向微拉伸，形成更自然的上升变形
这是 `Curve` 小节末尾新增网格旋转控制的设置图，教程在 `WaterSphereMesh` 的 `Particle Update` 中加入 `Update Mesh Orientation` 模块，让已经完成尺寸与位移调节的水泡再获得持续旋转

Niagara Stack 当前可见顺序：

- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Mesh Size 001`
  - `Update Mesh Orientation`
  - `Set (PARTICLES) Position`

`Update Mesh Orientation` 模块设置：

- `Orientation Method = Rotation Rate`
- `Rotation Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = 1.0`
- `Rotation Rate = 5.0`
- `Rotation Coordinate Space = Mesh`

效果含义：

- 旋转轴只沿 `Z` 方向启用
- 因为坐标空间是 `Mesh`，旋转围绕网格自身轴向进行
- 这会让水泡表面的条纹和内部扭曲纹理在播放时产生轻微滚动感，而不是完全静止

预览结果：

- 左侧水泡已呈现较明显的竖向拉伸形态
- 表面横向亮纹仍在，配合旋转后更适合表现流体内部轻微翻卷

这张图可替换为：在 `WaterSphereMesh` 的 `Particle Update` 中增加 `Update Mesh Orientation`，将朝向模式设为 `Rotation Rate`，旋转向量设为 `(0, 0, 1)`，旋转速率设为 `5.0`，坐标空间使用 `Mesh`，让拉伸后的水泡围绕自身 Z 轴持续转动，增强流体感和表面纹理的动态变化

### 00:42:00-00:44:38 关键流程 11

- 本段定位：关键流程 11。
- 知识点：T,你能够 再多一点,例如 5,让它是3 然后2.5,是 它会稍後可以调整 至於後備,是的 需要它能够姿勢很好的 这就是Dissolve会幫助。
- 知识点：我们有 能够避開 所產生的材料 这里可以避開 用粵語 是的,我们要怎麼 我只要拿着它,我们就会慢慢地拿到它 我们就会拿着它,我们就会拿着它。
- 知识点：这是在半生命中的这种情况 这是在半生命中的这种情况 我把它调到0.5 我真的不喜欢它的缝纵 它是缝纵的质感,所以需要改变它 它是缝纵的质感,所以需要改变它。
- 知识点：现在我们来拿一些 缝纵 这里是这个蝌蝓 这里是这个蝌蝓 在本体上,我还是会改变它的轻度 在本体上,我还是会改变它的轻度 他把这么大的质感设置在这里。
- 知识点：他在这里 很强的缝纵,是的,它是缝纵的轻度 在本体上,可以把更多的一个质感放在这里 在本体上,可以把更多的一个质感放在这里。

**关键画面：**

这是对 `Update Mesh Orientation` 模块继续细调的截图，教程把原本固定的旋转速率改成曲线驱动，并将旋转方向翻转为沿负 `Z` 轴旋转

模块位置：

- `WaterSphereMesh -> Particle Update -> Update Mesh Orientation`

当前设置：

- `Orientation Method = Rotation Rate`
- `Rotation Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = -1.0`
- `Rotation Rate = Float from Curve`
- `FloatCurve = Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 2.5`
- `Rotation Coordinate Space = Mesh`

可见曲线走势：

- 生命周期前段接近 `0`
- 中段小幅上升
- 后段继续抬高到更大的正值
- 说明旋转不是匀速，而是随着粒子寿命逐渐加快

效果含义：

- 水泡会围绕自身本地负 `Z` 轴旋转
- 前期旋转较弱
- 后期旋转更明显
- 这样能让表面条纹和内部扭曲在生命后段更活跃，而不是从一开始就高速转动

这张图可替换为：在 `Update Mesh Orientation` 中保留 `Rotation Rate` 朝向模式，但把 `Rotation Vector` 改为 `(0, 0, -1)`，并将 `Rotation Rate` 从固定值改成以 `Particles.NormalizedAge` 为索引的浮点曲线，`Scale Curve` 设为 `2.5`，使水泡在生命周期后段逐渐加快自转
这是回到 `MI_WaterBubble_01` 材质实例后的整体参数检查图，教程在不改节点结构的前提下，观察当前溶解、扭曲和泡沫参数叠加后，水泡已经形成较明显的拉伸拖尾和流体条纹

当前可见材质实例参数：

- `Dissolve`
  - `T_Dissolve = T_Noise111`
  - `Dissolve (Scale/Scroll)` 已启用
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = 0.0`
  - `Dissolve Edge Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
  - `Smoothness = 0.121942`
- `Distortion`
  - `T_Distortion = T_Inky_Smoke_Tile`
  - `Distortion Influence = 0.1`
  - `Distortion Speed = 0.5`
- `Foam`
  - `T_Foam = T_WaveNoise_01`
  - `Foam (Scale/Scroll)` 已启用
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = -0.75`
  - `Foam Color` 为浅青蓝
- `Fresnel Color`
  - 已启用
  - `Fresnel Exp = 2.0`
- `Global Scalar Parameter Values`
  - `Depth Fade = 100.0`

视口结果：

- 水泡主体不再是规整球体
- 上半部被拉成长条状的半透明水体
- 下半部仍保留较厚的青蓝色主体
- 表面有宽幅横向亮纹，说明泡沫纹理仍在参与外观塑形

这张图可替换为：在 `MI_WaterBubble_01` 中保留 `T_Noise111`、`T_Inky_Smoke_Tile`、`T_WaveNoise_01` 的组合，并维持 `Smoothness = 0.121942`、`Distortion Influence = 0.1`、`Distortion Speed = 0.5`、`Foam A = -0.75`、浅青蓝 `Foam Color` 和 `Fresnel Exp = 2.0`，然后在视口确认这些参数叠加后，水泡已经出现向上拉伸的拖尾与横向流体纹理
这是把前面所有调整回放到场景实例后的结果检查图，当前在关卡中直接选中了 `NS_StylizedWaterSplash`，用于观察整套水泡运动是否符合预期

场景状态：

- `Outliner` 中当前选中对象为 `NS_StylizedWaterSplash`
- 右侧 `Details` 面板显示的是该 Niagara Actor 实例
  - `Transform`
    - `Location = (0.0, 0.0, 0.0)`
    - `Rotation = (0.0, 0.0, 0.0)`
    - `Scale = (1.0, 1.0, 1.0)`
  - `Niagara System Asset = NS_StylizedWaterSplash`
- 下方内容浏览器仍定位在
  - `Content/VFX_Library/Materials/Instances/StylizedWaterSplash`
  - 当前选中资产为 `MI_WaterBubble_01`

视口结果：

- 当前这一帧的屏幕中没有明显可见的水泡主体
- 结合字幕“然后急剧下飞”和前面已经完成的位移、缩放、旋转调整，可以确认这里是在检查粒子快速运动后的时序表现
- 这张图强调的是回到场景实例层验证整体行为，而不是继续改单个模块参数

这张图可替换为：完成 `WaterSphereMesh` 的位置、缩放、旋转和材质参数调整后，回到关卡中直接选中 `NS_StylizedWaterSplash` 实例进行整体验证；保持系统实例放在原点，播放检查粒子是否会按新设定快速离开初始位置并表现出更明显的运动节奏变化

### 00:47:37-00:50:01 速度

- 本段定位：速度。
- 知识点：这种结果,现在我首先 其它缝纵已经改变了 这里可以调整它 可以调整它 可以调整它 调整它 调整它 调整它 调整它 调整它 调整它 调整它。
- 知识点：调整它 调整它 需要用这四个一樣的 它控制速度的分數 是我们的控制式 加速是速度 我们把所有东西都用这樣 我们来看看 这里的速度是0。
- 知识点：它不会在我们里面移动任何东西 所以在这里在x上度过 可以这樣做 或者是在y上 就像是解決動作一樣 我们可观察到我们有一个角色。
- 知识点：像是这个 我们先把自己限制到一个滑板上 滑板的最高是0 这是它如何消失或出现 这个繩子的颜色。
- 知识点：就这樣 而且也会是 代表一个质感 可以用这个磅板 如果我们拿着它 看看它是怎樣的 需要看到 它只是一个角色的面膜。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这是在材质图 `M_test` 中测试遮罩通道与溶解控制的实验截图，教程临时用一个材质实例 `M_test_Inst` 来验证不同纹理通道对形体显隐和边缘发光的影响

节点定义集：

- 左侧一个纹理通道拆分节点
  - 输出可见 `RGB / R / G / B / A`
- `Component Mask`
  - 标题显示为 `Mask (R B)`
  - 细节面板里可确认
    - `R` 勾选
    - `G` 未勾选
    - `B` 勾选
    - `A` 未勾选
- `Texture Sample`
  - 左侧 `UVs` 输入接入自 `Mask (R B)`
  - 右侧输出 `RGB / R / G / B / A / RGBA`
- 右上仍能看到此前的溶解函数链一部分
  - `Smoothness` 参数
  - `MF_SmoothDissolve`
  - 后续连接到材质输出侧

连线集：

- 左侧纹理拆分节点某一输出 -> `Mask (R B)` 输入
- `Mask (R B)` 输出 -> `Texture Sample.UVs`
- `Smoothness` 参数 -> `MF_SmoothDissolve.Smoothness (S)`
- `MF_SmoothDissolve` 后续输出继续连向材质结果侧

设置/参数：

- 当前调试窗口为 `M_test_Inst`
- `Global Scalar Parameters`
  - `Dissolve = 0.80845`
  - `Smoothness = 0.027429`
- `Global Vector Parameters`
  - `Color` 已启用，颜色条为青蓝色

输出/预览：

- 小型实例预览窗里可见两个上下分离的黑色主体块
- 外边缘被亮青蓝色描边
- 说明当前遮罩与溶解设置把形体切成了上下两段，并保留了明显的溶解边缘发光

这张图可替换为：在测试材质 `M_test` 中，用 `Component Mask (R,B)` 组合纹理通道并把结果送入 `Texture Sample.UVs` 做实验，同时在测试实例 `M_test_Inst` 中把 `Dissolve` 调到约 `0.80845`、`Smoothness` 调到约 `0.027429`，观察上下两段遮罩形状如何被显现，并确认边缘会保留亮青蓝色的溶解描边
这是 `M_test` 材质图里演示“样式缩放”和“滚动速度”如何共同控制遮罩 UV 的关键截图，教程用 `Append`、`Multiply`、`Add(1)` 组合一个可调的 UV 偏移/缩放链，再在测试实例里观察显隐形状变化

节点定义集：

- 一个向量参数，标题可见为 `... (Scale|Scroll)`
  - 参数色条为亮黄色
  - 提供多通道控制值
- 上方 `Append`
  - 用于拼出一组二维向量
- 下方 `Append`
  - 也是向量拼接节点，当前被选中
- `Multiply`
  - 位于上方链路中
- `Add(1)`
  - `B = 1.0`
  - 用于在乘法结果上加偏移
- `Texture Sample`
  - `UVs` 端口接收上游组合后的结果
- `Time`
  - 连接到下方一个 `Multiply(0,)`
  - 该链路用于时间驱动的滚动速度实验

连线集：

- `Scale|Scroll` 参数的多个颜色通道 -> 两个 `Append` 节点输入
- 上方 `Append` -> `Multiply`
- `Multiply` -> `Add(1).A`
- `Add(1)` 输出 -> `Texture Sample.UVs`
- `Time` -> 下方 `Multiply`

设置/参数：

- 测试实例 `M_test_Inst`
  - `Dissolve = 0.501809`
  - `Smoothness = 0.027429`
  - `Color` 为青蓝色

输出/预览：

- 小预览窗里，上方形成拱形黑色遮罩，下方是较平的半圆遮罩
- 边缘仍带亮青蓝描边
- 左侧大视口中当前测试网格几乎被整块黑色遮罩覆盖，说明 UV 组合已显著改变纹理采样分布

这张图可替换为：在测试材质 `M_test` 中，把 `Scale/Scroll` 参数拆分后通过 `Append` 组装成二维向量，再先经过 `Multiply` 调整样式幅度、再经 `Add(1)` 叠加偏移后送入 `Texture Sample.UVs`；同时保留 `Time` 乘法链作为滚动速度来源，从而把“乘法控制形状/缩放、加法控制滚动速度”的关系直接可视化到测试实例里
这是把测试材质实例 `M_test_Inst` 临时套到场景角色网格上观察条纹颜色和滚动效果的验证图，教程不再只看球体预览，而是直接在复杂轮廓上检查溶解线条的表现

场景状态：

- 右侧 `Outliner` 当前选中的是角色对象 `Gideon_Inquisitor`
- 右下 `Details` 可见
  - `Transform = (0,0,0) / (0,0,0) / (1,1,1)`
  - `Skeletal Mesh Asset = GideonInquisitor`
- 下方内容浏览器位于 `Content/VFX_Library/Materials/MM`
  - 可见 `M_test`
  - `M_test_Inst`
  - `M_UberMaterial`
  - 当前选中的是 `M_test_Inst`

测试实例参数：

- `Global Scalar Parameters`
  - `Dissolve = 0.999543`
  - `Smoothness = 0.170058`
- `Global Vector Parameters`
  - `Color` 为高饱和粉紫到黄色的测试色带
  - `Dissolve (Scale|Scroll)` 已启用
    - `R = 5.0`
    - `G = 7.0`
    - `B = 0.192`
    - 其余通道在图中未完整显示

输出/预览：

- 主视口里角色轮廓只剩下细长的亮色描边线
- 说明高 `Dissolve` 值已经让主体几乎完全消失，只留下溶解边缘
- 小预览窗也几乎看不到实体块，只剩下浅色背景上的细微结果

这张图可替换为：将 `M_test_Inst` 临时应用到场景中的 `Gideon_Inquisitor` 网格上做复杂轮廓测试，把 `Dissolve` 提高到约 `0.999543`、`Smoothness` 提高到约 `0.170058`，并把 `Dissolve (Scale|Scroll)` 向量至少调到 `R=5.0`、`G=7.0`、`B=0.192` 的量级，用来观察主体几乎消失后仅保留条纹式溶解边线的视觉效果

### 00:50:13-00:51:38 UV

- 本段定位：UV。
- 知识点：如果我只拿着B 需要过 它会是一个很順滑的層次 代表一个质感 现在看 它会变成这樣 需要減少滑鼠 角色消失 我们從上下 我们把它像这樣消失 这个物料的特徵是。
- 知识点：我们的系统是UV 組合 这里最重要的是 需要有什么形状 然后它 会 非常好消失 無論是它的体積 或是它的形状 这个面膜 你所說是由於 物体的隔離箱。
- 知识点：这很酷 如果我们想要对方的形状 在另一邊 我们只要向这里向後移动 所以它不会是從下方 而是從上下 这是我们如何消失的 这是非常酷的东西 这瓶子在很多个案中使用。
- 知识点：那就是这 在下一个影片 需要回到效果 并加上細節。
- 核对对象：`系统`。

**关键画面：**

这是 `UV` 小节里回到角色轮廓测试后的基线截图，教程把测试实例 `M_test_Inst` 的 `Dissolve` 拉回到 0，先观察未经溶解推进时，遮罩和边缘描边在复杂轮廓上的基础表现

场景状态：

- 当前仍在关卡视口中观察 `Gideon_Inquisitor` 角色轮廓
- 下方内容浏览器位于 `Content/VFX_Library/Materials/MM`
  - 当前选中资产是 `M_test_Inst`

测试实例参数：

- `Global Scalar Parameters`
  - `Dissolve = 0.0`
  - `Smoothness = 0.170058`
- `Global Vector Parameters`
  - `Color` 为高饱和粉紫测试色

输出/预览：

- 主视口里角色主体完整呈现为黑色实心剪影
- 外轮廓包着一圈较细的亮色边线
- 小预览窗里的球体也恢复为完整黑球
- 说明当前只是确认 UV/遮罩本身的基础形状，还没有开始推进溶解

这张图可替换为：在角色轮廓测试阶段，先把 `M_test_Inst` 的 `Dissolve` 归零，保留 `Smoothness = 0.170058` 和现有测试色，只观察基础遮罩是否能完整覆盖角色外形，并确认边缘会形成一圈稳定的描边，为后续继续推进 UV 溶解方向做基线参考
这是 `UV` 小节中验证“同一遮罩方向可作用于不同几何体”的截图，教程把 `M_test_Inst` 同时应用到角色和一个 `Cube` 上，观察它们都会从底部开始出现相同方向的溶解边缘

场景状态：

- 主视口里同时可见
  - 左侧 `Gideon_Inquisitor` 角色
  - 右侧一个 `Cube`
- 右下 `Details` 当前选中对象是 `Cube`
  - `Location = (36.0, -314.0, 55.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Static Mesh = Cube`
  - `Materials -> Element 0 = M_test_Inst`

测试实例参数：

- `Global Scalar Parameters`
  - `Dissolve = 0.376457`
  - `Smoothness = 0.036115`
- `Global Vector Parameters`
  - `Color` 仍为高饱和粉紫测试色

输出/预览：

- 角色和立方体底部都出现一条亮色溶解边
- 上方主体仍是黑色遮罩实体
- 小预览窗中的球体也表现为底部先亮起一圈边缘
- 说明这套遮罩逻辑不是依赖具体模型轮廓，而是沿统一的 UV/方向关系推进

这张图可替换为：把 `M_test_Inst` 同时测试在角色网格和 `Cube` 静态网格上，并将 `Dissolve` 调到约 `0.376457`、`Smoothness` 调到约 `0.036115`，验证无论几何体大小或轮廓如何变化，溶解都会先从底部出现一条高亮边缘，再向上推进主体显隐
这是 `UV` 小节最后的总结图，教程把 `M_test` 的整套材质链缩到总览级别，同时用左侧平面预览和右侧球体实例验证：这套做法本质上是用 UV 组合生成一个可控的方向性遮罩，用来决定物体从哪一侧开始消失

节点定义集：

- 左上一个主输入/函数节点
  - 输出多路信号进入下游
- 中间存在多组基础运算节点
  - `Add`
  - `Multiply`
  - 若干小型组合节点
- 一个黄色向量参数
  - 用于控制缩放/滚动一类的 UV 参数
- 一个红色 `Time` 节点
  - 参与下方滚动链
- 一个 `Texture Sample`
  - 作为遮罩或采样结果的核心来源
- 右上颜色与溶解相关参数链
  - 青色 `Color` 向量参数
  - `Dissolve`
  - `Smoothness`
  - 材质函数/运算后接入结果端

连线集：

- 主输入节点的输出分别送入多组 `Add/Multiply`
- 黄色向量参数与 `Time` 一起参与中下部 UV 组合链
- UV 组合链的结果驱动 `Texture Sample`
- `Dissolve`、`Smoothness` 与 `Color` 共同参与右侧最终材质输出

设置/参数：

- `M_test_Inst`
  - `Dissolve = 0.326627`
  - `Smoothness = 0.036115`
  - `Color` 仍为高饱和粉紫测试色

输出/预览：

- 左侧平面预览显示一个从上亮到下暗的垂直渐变矩形
- 右侧球体实例显示上方出现高亮边缘、下方保持黑色主体
- 说明当前遮罩方向已经从“底部先消失”切换到“顶部开始出现分界”，本质上是在验证 UV 方向切换后的通用性

这张图可替换为：把 `M_test` 材质图缩回整体视角，确认整套方案由 `Time`、缩放/滚动向量参数、若干 `Add/Multiply`、`Texture Sample` 与 `Dissolve/Smoothness/Color` 参数共同组成；然后在 `M_test_Inst` 中以 `Dissolve = 0.326627`、`Smoothness = 0.036115` 观察左侧平面和右侧球体，验证同一套 UV 遮罩既可以控制物体从底部消失，也可以通过方向调整改成从顶部形成溶解分界

## 补充视觉证据

### S01 00:01:38

这是 `M_WaterBubble` 材质图的补充参数证据图，展示早期溶解遮罩是如何由 `T_Dissolve` 贴图经过数值偏移与 `SmoothStep` 整理后生成的

节点定义集：

- 一个绿色标量参数
  - 标题结尾可见为 `...move`
  - `Default Value = 0.0`
- 一个绿色标量参数
  - 标题结尾可见为 `...thness`
  - `Default Value = 0.0`
- `Multiply`
  - `B = 1.0`
- `Add(1)`
  - `B = 1.0`
- `Subtract`
  - 接收上游两路标量结果
- `Texture Sample`
  - 节点标题为 `T_Dissolve`
  - 贴图资源栏显示为 `T_Voronoise002`
  - 右侧输出 `RGB / R / G / B / A / RGBA`
- `SmoothStep(0,1)`
  - `Min = 0.0`
  - `Max = 1.0`
  - `Value` 输入接收自 `T_Dissolve`

连线集：

- `...move` 参数 -> `Multiply.A`
- `Multiply` -> `Subtract.A`
- `...thness` 参数 -> `Add(1).A`
- `Add(1)` -> `Subtract.B`
- `T_Dissolve` 采样输出 -> `SmoothStep.Value`

设置/参数：

- 左下细节面板当前选中的是 `T_Dissolve` 纹理采样节点
  - `MipValueMode = None (use computed mip level)`
  - `Sampler Source = From texture asset`
  - `Const Coordinate = 0`
  - `Const Mip Value = -1`
  - `Sampler Type = Color`

输出/预览：

- 左侧平面预览显示为带有柔和横向波纹的浅青蓝色水面纹理
- 说明这一段仍处于基础遮罩/采样调试阶段，重点不是最终发光边，而是先把溶解噪声经过 `SmoothStep` 变成更可控的 0 到 1 过渡

这张图可替换为：在 `M_WaterBubble` 的早期溶解链中，使用 `T_Dissolve` 贴图 `T_Voronoise002` 作为基础噪声，并配合两个标量参数分别做位移/阈值调整，经 `Multiply`、`Add(1)`、`Subtract` 后，再把采样结果送入 `SmoothStep(0,1)` 压成可控的平滑遮罩，用于后续驱动水泡材质的溶解过渡

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

