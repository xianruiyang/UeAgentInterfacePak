# 004_材质常用部分详解和SkyLight

# 004_材质常用部分详解和SkyLight

## 关键术语

- `UV`、`Add`、`Power`、`Texture`、`Actor`、`Photoshop`、`PS`、`Fire`、`材质`、`网格`、`Niagara`、`纹理`、`贴图`、`系统`、`蓝图`、`速度`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:04:58 Texture、Fire、材质

- 本段定位：Texture、Fire、材质。
- 知识点：好,我们继续回到这个工程 我刚才已经保存了这个关卡了 如果你们还没有保存这个关卡的话,你们保存资源 我给你们演示一下怎么保存关卡 当我们创建了一个关卡之后,我们去保存的时候。
- 知识点：它就会要求你保存这个关卡 然后你要保存在什么位置 可以直接在这里新建一个文件夹 然后叫,我就叫这个fire 然后保存在什么位置呢。
- 知识点：你们就保存在你们新建的那个文件夹里面 就像这样,我新建一个文件夹 命名我就不命了,然后我点击这个文件夹 保存 那这个时候 我新建这个文件夹下面就有我保存的关卡了。
- 知识点：叫mash mash就是模型的意思啊 然后我们找到这个小火堆 fbx的一个文件 拖拽进去 然后这个时候你不用改任何的参数。
- 知识点：直接点导入 当我们导入之后我们就有了他的模型 和材质 对吧 好,我们再建一个,我们再把贴图导进来 我们新建一个 新建一个文件夹叫map。
- 知识点：其实在我们工作的过程中也经常有把这个map命名为 texture的一个命名啊 他们经常也经常是缩写为 tex 这三种 这三种其实都是,这个是纹理的意思。
- 知识点：这个是贴图的意思 其实都可以啊 看你喜欢 然后我这里就叫map了 然后我们把纹理导入进来 纹理在这个texture里面。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Texture`、`材质`、`纹理`、`贴图`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）: 在 `Fire` 目录下保存当前关卡后，Content Browser 中可见 `01` 关卡资产和 `01_BuiltData` 构建数据注册表；主视口显示默认地面与关卡基础光源，World Outliner 中已有 `DirectionalLight`、`ExponentialHeightFog`、`Landscape2`、`LandscapeGizmoActiveActor2`、`PostProcessVolume`。此图用于确认关卡已经保存到 `Fire` 内容目录。
> 图表转写（UE-GTXT v4）: 在 `Fire` 目录内建立资源分类文件夹，Content Browser 中可见 `Map`、`Mesh`、`Texture` 三个子文件夹；右键菜单处于 `文件夹 > 新建文件夹`，提示会在 `/Game/Fire` 中创建新文件夹。教程使用 `Map` 存贴图/纹理资源，也说明项目中常见命名还包括 `Texture` 或缩写 `Tex`。
> 图表转写（UE-GTXT v4）: 将小火堆 FBX 导入 `Fire/Mesh` 后，视口中出现火堆 Static Mesh，Content Browser 里生成 `火堆` 网格资产和 `Model001_Material5` 材质资产。右侧选中的 `ExponentialHeightFog` 细节面板显示 `Fog Density=1.0`、`Fog Height Falloff=0.2`、`Start Distance=1300.0`、`Fog Cutoff Distance=0.0`，本图主要验证模型和材质已导入。

### 00:04:59-00:09:45 Actor、材质、网格

- 本段定位：Actor、材质、网格。
- 知识点：这个时候可以点 过场动画里面有一个摄像机 电影相机Actor 拖进来 好,我们场景里面这里就多了一个面板对吧 这个就是它相机的一个视角。
- 知识点：可观察到我移动它的时候它是在变化的 我们给它旋转 然后现在这个坐标轴它是一个世界坐标轴对吧 我们不需要这种正对的 因为需要斜向去旋转它。
- 知识点：我们就改成物体坐标轴 去旋转它 然后拉远一点点 直到我们感觉这个角度还可以 那我们就按照这个相机去调了 如果我们不点中这个相机的情况的话。
- 知识点：我们还有一种方式就是 在这个窗口这里 调用一个视口 把这个视口调出来 调出来了之后 我们开了两个视口对吧 那我一个视口需要要它是摄像机的视角。
- 知识点：把它调亮一点试试 然后这个物效再离我们适当远一点点 好现在我们给这个 给这个模型一个基本的材质效果。
- 知识点：那材质是什么呢 那我们现在来说一下 材质是个什么东西 好我们看到这个石头之后 其实它表面的颜色。
- 知识点：和它表面的这些纹理信息 还有它这个 它这个材质是不是 光滑还是粗糙 这些就是它的材质 那我们接着回到引擎 来说一下材质效果。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）: 从左侧 Place Actors 的 `过场动画` 分类拖入 `电影摄像机actor`，World Outliner 中新增并选中 `CineCameraActor1`；视口右下出现 `CineCameraActor1` 的相机预览窗口。Details 中当前相机设置可读为胶片背板 `16:9 Digital Film`、镜头 `Universal Zoom`、当前焦距 `35.0`、当前光圈 `2.8`、当前聚焦距离 `100000.0`。此图用于确认相机 Actor 已加入场景并可通过预览检查构图。
> 图表转写（UE-GTXT v4）: 编辑器处于双视口布局：左侧视口使用 `CineCameraActor1` 的相机视角并显示三分网格/操作安全线/标题安全线设置，右侧视口显示场景中相机 Actor 的位置和变换手柄。Details 中 `CineCameraActor1` 的 Transform 可读为位置约 `X=2060.6, Y=1693.9, Z=823.9`，旋转约 `X=0.32, Y=-14.?, Z=-66.?`，缩放 `1,1,1`；相机设置仍为 `16:9 Digital Film`、`Universal Zoom`、焦距 `35.0`、光圈 `2.8`。图中坐标仅来自该截图读数，不额外推断教程要求的固定坐标。
> 图表转写（UE-GTXT v4）: 在相机视角下打开 `Model001_Material5` 材质编辑器。材质编辑器左侧为材质球预览，中央为 `Model001_Material5` 材质主节点，右侧 Palette 可搜索材质函数/节点；材质主节点当前尚未连接新的 Base Color、Metallic、Specular、Roughness 等输入。Content Browser 中选中 `Model001_Material5`，提示显示路径 `/Game/Fire/Mesh`、材质域 `Surface`、混合模式 `Opaque`、着色模型 `Default Lit`。

### 00:09:46-00:13:36 材质、颜色、自发光

- 本段定位：材质、颜色、自发光。
- 知识点：在这个基础颜色上面 好现在我们来讲解一下 这个材质上的一些基本参数 那这个基础颜色是什么呢。
- 知识点：可以按住3加右键 可以呼出一个颜色的节点 然后我们点在上面 可观察到我们现在给的是一个黑色 对吧 如果给成一个蓝色的话 点确定 那这个石头。
- 知识点：这个火堆 它就有了一个蓝色的效果 这是基础颜色 你也可以改成别的颜色 然后确定 它都会实时的进行一个改变 然后这个金属度是什么呢 其实顾名思义啊。
- 知识点：我们按1加右键 我们按1加右键 会呼出一个1为节点 那这个时候连上去 如果我们没有金属度 可以看这个地方 这个材质球的效果。
- 知识点：因为金属度它需要一些反射来支持 当我们把金属度给成0的时候 那它这个表面是没有任何金属的感觉的 如果我们给成1之后 我们来看一下有什么改变。
- 知识点：那这个东西是不是就有一种金属的质感的感觉了 好,我们来说一下高光度 我们也是按1加右键 可以呼出一个1为节点 给连上去 这个高光度有点特殊。
- 知识点：因为这个金属度如果为1的话 那高光度是没有任何效果的 可观察到我们调动它的时候 我们给它0.5 我们给它1 它都没有任何效果 但是如果我们把金属度给降为0的话。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`贴图`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质主节点 + Palette + 材质球预览
> - 所属: `Model001_Material5`
> - 目的: 准备讲解材质主输入。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 本模块必须描述的信息 |
> |---|---|---|---|
> | 左侧 | 效果图 | `Model001_Material5` 预览球 | 当前为默认灰色材质预览 |
> | 中央 | 材质节点图 | `Model001_Material5` | 主节点输入列表可见，尚未接入本步骤新增节点 |
> | 右侧 | Palette | 材质编辑器节点库 | 可见 `Blends`、`Coordinates`、`Cubemaps` 等分类 |
>
> 输出: 该图作为讲解 Base Color、Metallic、Specular、Roughness、Emissive 等主输入前的起始状态；当前无关键连线需要复建。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质球预览 + Palette
> - 所属: `Model001_Material5`
> - 目的: 用常量节点演示 Base Color、Metallic、Specular 对材质外观的影响。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Constant3Vector(1, 0.552, 0.473)` | 粉橙色基础颜色 | 颜色值 `(1,0.552,0.473)` | RGB 输出 |
> | N02 | `Scalar Constant(0)` | 金属度测试值 | `0` | Float 输出 |
> | N03 | `Scalar Constant(1)` | 高光度测试值 | `1` | Float 输出 |
> | N04 | `Model001_Material5` 主节点 | 材质输出 | `Base Color`, `Metallic`, `Specular` | 材质结果 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.RGB` | `N04.Base Color` | 设置材质基础颜色为粉橙色 |
> | Data | `N02.Value` | `N04.Metallic` | 将金属度设为 `0` |
> | Data | `N03.Value` | `N04.Specular` | 将高光度设为 `1` |
>
> 效果/预览:
> - 材质球显示浅粉橙色，表面非金属。
> - Palette 仅作为节点库背景，不参与当前材质输出。
>
> 连线覆盖检查: 图中可见的三个常量输出都已追到材质主节点输入；`Roughness`、`Emissive Color`、`Normal` 等输入在本图未连接。
> 输出: 读者可通过 `3 + 右键` 创建颜色常量、`1 + 右键` 创建标量常量，并连接到对应材质主输入复建该状态。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质球预览
> - 所属: `Model001_Material5`
> - 目的: 对比 Base Color、Metallic、Specular、Roughness、Emissive 的输入值和材质球反光状态。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Constant3Vector(0.172, 0.095, 0.0812)` | 暗棕基础颜色 | 颜色值 `(0.172,0.095,0.0812)` | RGB 输出 |
> | N02 | `Scalar Constant(0)` | 金属度 | `0` | Float 输出 |
> | N03 | `Scalar Constant(0.5)` | 高光度 | `0.5` | Float 输出 |
> | N04 | `Scalar Constant(0)` | 粗糙度 | `0` | Float 输出 |
> | N05 | `Constant3Vector(0, 0, 0)` | 自发光颜色 | 黑色 | RGB 输出 |
> | N06 | `Model001_Material5` 主节点 | 材质输出 | `Base Color`, `Metallic`, `Specular`, `Roughness`, `Emissive Color` | 材质结果 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.RGB` | `N06.Base Color` | 设置暗棕基础颜色 |
> | Data | `N02.Value` | `N06.Metallic` | 金属度为 `0` |
> | Data | `N03.Value` | `N06.Specular` | 高光度为 `0.5` |
> | Data | `N04.Value` | `N06.Roughness` | 粗糙度为 `0`，产生清晰高光反射 |
> | Data | `N05.RGB` | `N06.Emissive Color` | 自发光为黑色，不额外发光 |
>
> 效果/预览:
> - 材质球呈暗棕/粉棕色，表面有明显镜面高光。
> - 该效果来自 `Roughness=0` 与非零 `Specular`，而不是来自自发光。
>
> 连线覆盖检查: 五个参与材质输出的常量节点均已列入连线表；图中未显示纹理采样或 UV 处理。

### 00:13:39-00:18:14 Photoshop、材质、颜色

- 本段定位：Photoshop、材质、颜色。
- 知识点：好,点确定 我们先把这个粗糙度给高一点 点错了 可观察到它现在就发了一个白色的光 为什么它会发白色呢 但是可观察到它边缘又有一些蓝色的光。
- 知识点：这是为什么呢 因为当我们的亮度超过1之后 它就会变白 如果我给到1 这个时候它还是一个蓝色的效果 但是如果我给到2 它就会变白了 因为它的RGB都快超过1了。
- 知识点：如果红色、绿色、蓝色都超过1的话 就相当于在Photoshop里面 它的RGB都超过255 这个值 它就会变白 因为我们的颜色这个东西。
- 知识点：色彩构成这本书 好 好 当我们说完了基础颜色 金属度、高光度、粗糙度和自发光之后 我们再来说一下它们的数值范围 当我们挪到这个基础颜色上面去之后。
- 知识点：可观察到 它说定义材质的整体颜色 自动将所有通道限制在0到1之间 这个时候可以测验证效果 当我把这个颜色连上去之后。
- 知识点：因为它的亮度已经被限制在了0到1之间 你也可以理解为像Fotoshop里面一样 限制在了0到255之间 但是当我们连到它的自发光颜色之后。
- 知识点：只有自发光是没有这个限制 也就是说 如果我们要做的效果是不需要它爆光的 那我们就给到基础颜色上面去。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Photoshop`、`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）: `Model001_Material5` 中继续使用暗棕 Base Color、`Metallic=0`、`Specular=0.5`、粗糙度和自发光相关输入。左侧材质球显示棕色材质并有可见高光；顶部字幕说明 `Base Color`、`Metallic`、`Specular`、`Roughness`、`Anisotropy` 的值都在 `0..1` 范围内，而 `Emissive Color` 的值没有上限。本图用于从普通 PBR 输入过渡到自发光范围说明。
> 图表转写（UE-GTXT v4）
> - 类型: Material颜色设置
> - 组成部分: 颜色选择器 + 材质节点图 + 材质球预览
> - 所属: `Model001_Material5`
> - 目的: 演示颜色通道超过 `1` 时的自发光/高亮效果。
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Constant3Vector.R` | `0.520393` | float | 取色器/Details | 蓝紫色中的红色分量 |
> | `Constant3Vector.G` | `0.57828` | float | 取色器/Details | 蓝紫色中的绿色分量 |
> | `Constant3Vector.B` | `2.0` | float | 取色器/Details | 蓝色分量超过 `1`，用于演示高能量颜色 |
> | `ColorPicker.HexLinear` | `8594FF00` | hex | 取色器 | 线性颜色读数 |
> | `ColorPicker.HexSRGB` | `BFC8FF00` | hex | 取色器 | sRGB 读数 |
>
> 效果/预览:
> - 材质球显示偏白的淡蓝表面，边缘有蓝色倾向。
> - 图中仍保留 `Base Color`、`Metallic`、`Specular`、`Roughness`、`Emissive Color` 等主输入；颜色节点正处于编辑状态。
>
> 输出: 当颜色分量超过 `1` 时，更适合接入 `Emissive Color` 表达发光；若接入 `Base Color`，基础颜色输入会被限制在 `0..1` 范围。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质球预览 + 字幕标注
> - 所属: `Model001_Material5`
> - 目的: 使用贴图和 `MSR` 参数分离基础颜色与材质属性。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Texture Sample` | 木材/火堆贴图采样 | 未显示 UV 输入，使用默认 UV | `RGB` |
> | N02 | `MSR Param(0,0,0,1)` | 材质属性参数 | 默认值 `R=0,G=0,B=0,A=1` | `R`,`G`,`B`,`A` |
> | N03 | `Model001_Material5` 主节点 | 材质输出 | `Base Color`, `Metallic`, `Specular`, `Roughness` | 材质结果 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.RGB` | `N03.Base Color` | 贴图颜色作为基础颜色 |
> | Data | `N02.R` | `N03.Metallic` | `MSR` 红通道控制金属度 |
> | Data | `N02.G` | `N03.Specular` | `MSR` 绿通道控制高光度 |
> | Data | `N02.B` | `N03.Roughness` | `MSR` 蓝通道控制粗糙度 |
>
> 效果/预览:
> - 左侧材质球显示木材/石头纹理贴图。
> - 顶部字幕强调 `Base Color`、`Metallic`、`Specular`、`Roughness` 等值范围为 `0..1`，`Emissive Color` 无上限。
>
> 连线覆盖检查: `Texture Sample.RGB` 和 `MSR` 的三个可见属性通道已记录；`MSR.A` 在本图未连接到材质主输入。

### 00:18:14-00:22:58 颜色、粗糙度、火焰

- 本段定位：颜色、粗糙度、火焰。
- 知识点：它的粗糙度的话 需要应该给到0.8 它是一个比较粗糙的感觉对吧 好,这个时候我们回到场景看一下 现在我们看感觉它有点黑 那这个时候怎么办呢。
- 知识点：我们给它拽一盏灯光进来 拖到它头顶上 那我们想一下火焰应该是什么样的颜色呢 我们直接给它调成暖黄色 然后这个亮度给强 给到50 给到30吧。
- 知识点：点成可移动啊 如果你没有点成可移动的话 可以发现这里一直都有一个光照 需要重建这个提示 我们直接改成可移动 它就没有了 这个时候需要发现地面上有一个很明显的高光对吧。
- 知识点：那我们并不需要这个高光 可以直接在这里 这里有个高光范围给它改成0 把它关掉 那我们火焰的话 颜色还是适当再偏黄一点点吧。
- 知识点：再偏红一点点啊 饱和度适当给高一点点 给到20 嗯,感觉差不多 这个时候需要发现啊 这个有些地方它非常的黑 那我们这个时候需要拖一盏天光进来。
- 知识点：那这个天光是什么意思呢 天光其实就是模拟天空的一个反射光源 比如说 我们现在新建一个关卡去演示一下 好,现在我们场景里面只剩下一个光源和一个平面。
- 知识点：还有一个立方体 可以发现 虽然我们有了一个定向光源 但是它这个影子 这里还是这么黑的 就算我们丢一个高度物进来 它的影子也不会有任何改变。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）: 保存 `Model001_Material5` 时，材质节点图处于 `Texture Sample.RGB -> Base Color`、`MSR.R/G/B -> Metallic/Specular/Roughness` 的状态；Details 中 `MSR` 参数默认值可读为 `R=0.0, G=0.2, B=0.8, A=1.0`。左侧材质球显示带纹理的粗糙表面，保存进度条处于 `0%`。顶部字幕继续说明普通材质输入值在 `0..1`，自发光颜色值无上限。
> 图表转写（UE-GTXT v4）: 场景中使用双视口观察定向光照效果，左侧视口里立方体在平面上投出明显阴影，右侧视口显示同一场景的远景。Place Actors 的 `光源` 分类打开，右侧选中 `DirectionalLight`；Details 中光源 `Intensity=10.0 lux`，`Source Angle=0.5357`，`Source Soft Angle=0.0`，`Temperature=6500.0`，`Affects World`、`Cast Shadows` 等复选项处于启用状态。该图用于解释只有 Directional Light 时阴影区域仍然很暗。
> 图表转写（UE-GTXT v4）: 火堆场景中新增并选中 `SkyLight`，World Outliner 可见 `PointLight`、`SkyLight` 和 `火堆` 等对象；双视口显示火堆在相机视角和普通视角下的亮度状态。`SkyLight` Details 中可读字段包括 `Real Time Capture=false`、`Cubemap=None`、`Source Cubemap Angle=0.0`、`Cubemap Resolution=128`、`Sky Distance Threshold=150000.0`、`Intensity Scale=1.0`，`Affects World` 与 `Cast Shadows` 启用。此图用于确认用 SkyLight 补充环境反射光，减轻暗部过黑。

### 00:22:58-00:27:48 PS、材质、颜色

- 本段定位：PS、材质、颜色。
- 知识点：好,我们继续回来 我们看到这个木材 它现在是有一个赤红的效果 但是它没有一种正在燃烧的感觉 那这个效果正在燃烧的这个效果 我们要怎么去制作呢。
- 知识点：我们要在它的材质里面去制作 正在燃烧的效果 它肯定是一种比较高能量的一个效果 刚才我在喝水的时候 已经把这里给改过一下了 这个地方大家要记一下。
- 知识点：基础颜色、金属度、高光粗糙 和各项域性的尺 都是在0-1的范围之间的 然后金属度和高光度 它们两个的尺是有观念的 然后金属度为1的时候。
- 知识点：它肯定是要发光的 因为它的能量比较高 它自然会有一些光的感觉 那我们把这张火焰的纹理贴图 给拖入材质或模块输入这个材质里面去。
- 知识点：我们连到自发光 这个时候可以发现一个 整体都在发光的感觉 整体都有一种火焰的纹理 铺在上面 然后有一种发光的感觉 很明显这样并不是我们想要的一个效果。
- 知识点：可观察到这是一个什么样的效果 它就是一个黑一个白的效果 当我们把这个一半黑一半白的效果 输入到自发光颜色会怎么样呢?。
- 知识点：那它就会发白 因为它的RGB都为1了 那我们给个一半黑一半白的效果 也就是说它有一半是没有发光的 有一半是发光的 那这个时候我们再回到这个纹理。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`贴图`、`颜色`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）: 火堆 Static Mesh 已应用 `Model001_Material5`，右侧 Details 的材质槽 `元素 0` 指向该材质；Content Browser 中可见火焰、木材、法线等贴图资源，例如 `Fire_008_tex`、`Fire_056_tex`、`Fire_057_tex`、`Smoke_026_tex_NRM`、`圆形小火星`、`小火星`。双视口展示火堆材质贴图已经覆盖到木头和石头上，但燃烧区域仍需要进一步用材质节点控制。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览 + Details面板
> - 所属: `Model001_Material5`
> - 目的: 从贴图红通道提取炽热区域，形成黑白遮罩。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Texture Sample` | 火堆/木材贴图采样 | 默认 UV | `R`, `RGB` 等通道 |
> | N02 | `Mask (R)` | 提取红通道 | `N01.R` | 单通道遮罩 |
> | N03 | `Multiply(2)` | 放大遮罩亮度 | `A=N02`, `B=2` | 放大后的遮罩 |
> | N04 | `Floor` | 二值化遮罩 | `N03` | 黑白遮罩输出 |
> | N05 | `MSR Param(0,0.2,0.8,1)` | 材质属性参数 | `R=0,G=0.2,B=0.8,A=1` | `R/G/B` 连接材质属性 |
> | N06 | `Model001_Material5` 主节点 | 材质输出 | `Base Color`, `Metallic`, `Specular`, `Roughness` 等 | 材质结果 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.R` | `N02.Input` | 只取贴图红通道作为热区基础 |
> | Data | `N02.Output` | `N03.A` | 将红通道遮罩送入乘法 |
> | Data | `N03.Output` | `N04.Input` | 亮度放大后进入 `Floor` |
> | Data | `N05.R/G/B` | `N06.Metallic/Specular/Roughness` | `MSR` 参数继续控制材质属性 |
>
> 效果/预览:
> - 左侧模型预览显示木头中部红橙区域更亮，暗部仍保持黑/灰。
> - `Floor` 预览为黑底红色亮区，用于验证红通道遮罩的区域选择。
>
> 连线覆盖检查: 红通道遮罩链 `Texture Sample.R -> Mask(R) -> Multiply(2) -> Floor` 已完整记录；图中上方贴图到 Base Color 的连线只露出局部，不额外补写未显示端点。
> 图表转写（UE-GTXT v4）: 火焰/木材贴图与材质节点同时显示：上方视口中火堆局部出现明亮橙红燃烧区域；下方材质图保留 `MSR` 参数连线，并在新材质函数/编辑窗口中预览贴图组合。该阶段说明直接把火焰纹理连到自发光会让整体发亮，因此需要用遮罩限定燃烧区域。

### 00:27:48-00:32:37 UV、Add、Power

- 本段定位：UV、Add、Power。
- 知识点：那这个时候我们要怎么办呢? 我们需要的是这个木头上面比较高冷的区域 那我们点中这张图 然后这个细节面板这里点进这个纹理。
- 知识点：那什么地方是它比较高冷的? 也就是说它比较熾热的地方 那这些灰色的地方我们不需要它这么亮对吧? 可以查看它每一个通道的一些信息啊。
- 知识点：我们现在这里把这些通道给过滤掉 我们只要红色通道 那可以看得到这些 这个红色通道它就是我们需要的比较高冷的一些白色的区域 那我们看绿色通道它就不是我们需要的那个区域对吧?。
- 知识点：我们点回来啊 看红色通道它显示是这种地方 把绿色和蓝色点掉 看 这种高冷的区域我们现在也是得到了一张黑白的图片对吧? 所以我们只需要调用它的红色通道去和我们的这个纹理做一个呈法。
- 知识点：我们再把它呈上这个纹理 右键停止预览 这个时候你就会发现 它只有这些比较高冷的区域 有这个流动的效果了 如果你觉得太过分的话 可以给到4。
- 知识点：我们把它连上它的UV 这张火焰纹里的UV 然后我们选中这个partner节点的时候 它有一个速度Y。
- 知识点：我们给速度0.1 然后点保存 你就会发现这张贴图它在流动对吧? 如果你的贴图是没有流动的话 你记得看一下这个实时节点和实时更新有没有勾啊。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Add`、`纹理`、`贴图`、`速度`、`颜色`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览
> - 所属: `Model001_Material5`
> - 目的: 将火焰纹理和遮罩纹理相乘，再提升自发光强度。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Texture Sample` | 火焰纹理采样 | 默认 UV | `RGB` |
> | N02 | `Texture Sample` | 黑白遮罩/木材热区采样 | 默认 UV | `RGB` |
> | N03 | `Multiply` | 合成火焰纹理与遮罩 | `A=N01.RGB`, `B=N02.RGB` | 限定区域的火焰纹理 |
> | N04 | `Multiply(10)` | 提升亮度 | `A=N03`, `B=10` | 强化后的发光输出 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.RGB` | `N03.A` | 火焰颜色/纹理输入 |
> | Data | `N02.RGB` | `N03.B` | 黑白遮罩限制发光区域 |
> | Data | `N03.Output` | `N04.A` | 遮罩后的火焰进入亮度放大 |
> | Data | `N04.Output` | 材质主节点自发光链路方向 | 用于驱动火焰发光，图中主节点端点在右侧局部遮挡 |
>
> 效果/预览:
> - 左侧预览平面中，只有遮罩区域显示火焰纹理，背景保持普通材质。
> - `Multiply(10)` 表示自发光亮度放大。
>
> 连线覆盖检查: 两个 Texture Sample 到第一个 Multiply、再到 `Multiply(10)` 的关键链路已记录；右侧材质主节点端点局部被裁切，按上下文确认为自发光链路，端点细节待后续图补齐。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览 + Details面板
> - 所属: `Model001_Material5`
> - 目的: 使用 `Power` 调整火焰纹理对比，并与遮罩/亮度节点合成。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Texture Sample` | 火焰纹理采样 | 默认 UV | `RGB` |
> | N02 | `Texture Sample` | 遮罩/木材热区纹理采样 | 默认 UV | `RGB` |
> | N03 | `Multiply` | 火焰纹理与遮罩相乘 | `A=N01.RGB`, `B=N02.RGB` | 遮罩后的火焰纹理 |
> | N04 | `Multiply(10)` | 提升输出亮度 | `A=N03`, `B=10` | 高亮输出 |
> | N05 | `Power(X, 5)` | 增强火焰纹理对比 | `Base=N02.RGB`, `Exp=5` | 对比增强遮罩 |
> | N06 | `Add(0)` | 加法测试/偏移节点 | `A=N02.RGB`, `B=0` | 与原输入等价的测试输出 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.RGB` | `N03.A` | 火焰纹理颜色输入 |
> | Data | `N02.RGB` | `N03.B` | 遮罩纹理限制显示区域 |
> | Data | `N03.Output` | `N04.A` | 遮罩火焰进入亮度放大 |
> | Data | `N02.RGB` | `N05.Base` | 同一遮罩输入进入 Power |
> | Data | `N02.RGB` | `N06.A` | 同一遮罩输入进入 Add 测试 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Power.Exp` | `5` | float | 节点标题/Details | 提高黑白遮罩对比 |
> | `Add.B` | `0` | float | 节点标题 | 当前不改变输入，仅用于演示偏移 |
>
> 效果/预览:
> - 左侧预览窗口标题为 `Previewing: MaterialExpressionPower_0`，黑底上只剩少量白色热区，说明 `Power` 提高了亮区选择性。
> - 材质设置面板可见材质域为 `Surface`、混合模式为 `Opaque`、着色模型为 `Default Lit`。
>
> 连线覆盖检查: `N02.RGB` 分叉到 `Multiply`、`Power`、`Add` 的三条可见线均已记录；`Multiply(10)` 右侧输出端点在截图右侧之外，不补写未显示主输入。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览 + Details面板
> - 所属: `Model001_Material5`
> - 目的: 对火焰纹理使用 `Power` 并准备接入 Panner 产生流动 UV。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Texture Sample` | 火焰纹理采样 | 左侧可见 UV 输入来自前级节点 | `RGB` |
> | N02 | `Power(X, 5)` | 调整火焰纹理对比 | `Base=N01.RGB`, `Exp=5` | 对比增强火焰纹理 |
> | N03 | `Multiply(1)` | 亮度系数占位 | `A=N02.Output`, `B=1` | 与输入等价的输出 |
> | N04 | 下方 `Texture Sample` | 遮罩/木材纹理采样 | 未显示完整输入 | `R/G/B/RGB` |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | 前级 UV 节点输出 | `N01.UVs` | 火焰纹理使用外部 UV 驱动，下一图显示为 Panner |
> | Data | `N01.RGB` | `N02.Base` | 火焰纹理进入 Power |
> | Data | `N02.Output` | `N03.A` | Power 结果进入亮度乘法 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Power.Exp` | `5` | float | 节点标题/Details | 控制火焰纹理对比 |
> | `Multiply.B` | `1.0` | float | Details | 当前不改变 Power 输出亮度 |
>
> 效果/预览:
> - 左侧预览为高对比黑白噪声/火焰纹理，白色区域代表更亮的火焰贡献。
>
> 连线覆盖检查: 可见主链为 `Texture Sample.RGB -> Power(Base, Exp=5) -> Multiply(A, B=1)`；左侧 UV 来源只露出端点，按下一图补充为 `Panner`。

### 00:32:37-00:34:58 材质、颜色、纹理

- 本段定位：材质、颜色、纹理。
- 知识点：那我们下面这个纹理也是没有任何颜色的 也是一个黑白的图 那它们两个相乘的话肯定还是一个黑白的图 那这并不是我们想要的对吧? 所以我们需要在这上面给它乘以一个颜色。
- 知识点：还是按着M点右键 连上去 然后我们再按3点右键乘以一个颜色 我们乘以一个什么颜色呢? 我们先乘以一个橙色 给到3 调到一个比较像火焰的颜色。
- 知识点：我们给它连上去 这个时候可以发现我们把这个右键停止预览 它就有一种火焰的感觉了对吧? 我们到可能现在有点太纯了 这个颜色它还是不够。
- 知识点：还是不够红 再给它往上调一调 把这个绿色的值再给它降一点 蓝色值直接给它降到0.082吧 或者我们直接给它再降一点点 这样子看它好像就有一种。
- 知识点：它就有一种比较像燃烧的感觉了 我们保存资源 再到里面去看 这个时候可以感觉它流动的有那么一点点的快 可以适当有这么一点点感觉就好了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览 + Details面板
> - 所属: `Model001_Material5`
> - 目的: 用 Panner 驱动火焰纹理 UV，并通过颜色相乘得到火焰自发光颜色。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Panner` | 让火焰纹理 UV 随时间移动 | `Coordinate`, `Time`, `Speed` | 平移后的 UV |
> | N02 | `Texture Sample` | 火焰纹理采样 | `UVs=N01.Output` | `RGB` |
> | N03 | `Power(X, 5)` | 增强纹理对比 | `Base=N02.RGB`, `Exp=5` | 高对比火焰纹理 |
> | N04 | `Multiply(10)` | 提高发光强度 | `A=N03.Output`, `B=10` | 高强度火焰纹理 |
> | N05 | `Constant3Vector(3, 0.389, 0.06)` | 暖橙颜色 | 颜色值 | RGB 输出 |
> | N06 | `Texture Sample` | 下方遮罩/木材纹理采样 | 局部可见 | 通道输出 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.Output` | `N02.UVs` | Panner 驱动火焰纹理流动 |
> | Data | `N02.RGB` | `N03.Base` | 火焰纹理进入 Power |
> | Data | `N03.Output` | `N04.A` | 对比增强结果进入亮度乘法 |
> | Data | `N05.RGB` | 后级 Multiply 输入 | 暖橙颜色参与最终火焰颜色合成 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Panner.SpeedX` | `0.0` | float | Details | 水平方向不平移 |
> | `Panner.SpeedY` | `0.03` | float | Details | 垂直方向缓慢平移火焰纹理 |
> | `Power.Exp` | `5` | float | 节点标题 | 增强对比 |
> | `Multiply.B` | `10` | float | 节点标题 | 提升发光强度 |
>
> 效果/预览:
> - 左侧预览显示材质贴图中火焰区域被黑色背景限制，当前用于检查流动纹理和亮区分布。
> - 图中启用了实时预览/实时节点/实时更新按钮，配合 Panner 查看流动效果。
>
> 连线覆盖检查: `Panner -> Texture Sample.UVs -> Power -> Multiply(10)` 主链已记录；右侧连接到材质主节点的最终端点在本截图边缘外，按后续图和上下文确认为自发光合成链路。
> 图表转写（UE-GTXT v4）
> - 类型: Material颜色设置
> - 组成部分: 颜色选择器 + 材质节点图 + 材质预览
> - 所属: `Model001_Material5`
> - 目的: 给黑白火焰纹理乘以暖橙颜色。
>
> 节点与连线:
> | ID | 节点/连线 | 作用 |
> |---|---|---|
> | N01 | 上游 `Multiply(10)` 输出 | 提供高强度火焰纹理 |
> | N02 | `Constant3Vector(3.0, 0.483, 0.203)` | 提供暖橙颜色，红色通道超过 `1` 用于自发光强度 |
> | N03 | `Multiply` | 将高强度火焰纹理与暖橙颜色相乘 |
> | N04 | 后级 `Multiply` | 继续与其他遮罩/强度链合成后送往材质输出方向 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Constant3Vector.R` | `3.0` | float | 取色器/Details | 高红色强度，自发光用 |
> | `Constant3Vector.G` | `0.482812` | float | Details | 橙色中的绿色分量 |
> | `Constant3Vector.B` | `0.203125` | float | Details | 橙色中的蓝色分量 |
> | `ColorPicker.HexLinear` | `FF773300` | hex | 取色器 | 线性颜色读数 |
> | `ColorPicker.HexSRGB` | `FFB67C00` | hex | 取色器 | sRGB 读数 |
>
> 效果/预览:
> - 左侧材质预览平面中燃烧区域呈橙黄高亮，但整体仍偏黄。
>
> 连线覆盖检查: 颜色常量输出进入 Multiply 的一侧，上游火焰亮度链进入另一侧；后级输出方向可见但最终主节点端点在右侧画面外。
> 图表转写（UE-GTXT v4）
> - 类型: Material
> - 组成部分: 材质节点图 + 材质预览 + Details面板
> - 所属: `Model001_Material5`
> - 目的: 最终调整火焰颜色，让流动火焰更偏红并保持自发光强度。
>
> 节点:
> | ID | 节点 | 角色 | 关键输入 | 关键输出 |
> |---|---|---|---|---|
> | N01 | `Panner` | 驱动火焰纹理 UV | `SpeedX=0.0`, `SpeedY=0.03` | 平移 UV |
> | N02 | `Texture Sample` | 火焰纹理采样 | `UVs=N01.Output` | `RGB` |
> | N03 | `Power(X, 5)` | 提高纹理对比 | `Base=N02.RGB`, `Exp=5` | 高对比火焰纹理 |
> | N04 | `Multiply(10)` | 提升发光强度 | `A=N03.Output`, `B=10` | 高强度输出 |
> | N05 | `Constant3Vector(3.0, 0.389, 0.06)` | 最终暖红颜色 | 颜色值 `(3,0.389,0.06)` | RGB 输出 |
> | N06 | 后级 `Multiply` | 合成强度纹理与颜色 | `A=N04.Output`, `B=N05.RGB` | 暖红火焰输出 |
>
> 连线:
> | 类型 | 从 | 到 | 含义 |
> |---|---|---|---|
> | Data | `N01.Output` | `N02.UVs` | 火焰纹理随时间流动 |
> | Data | `N02.RGB` | `N03.Base` | 火焰纹理进入 Power |
> | Data | `N03.Output` | `N04.A` | 对比增强后提高亮度 |
> | Data | `N04.Output` | `N06.A` | 高强度火焰纹理进入颜色合成 |
> | Data | `N05.RGB` | `N06.B` | 暖红颜色乘到火焰纹理上 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Panner.SpeedX` | `0.0` | float | Details | 不做水平 UV 平移 |
> | `Panner.SpeedY` | `0.03` | float | Details | 产生缓慢纵向流动 |
> | `Color.R` | `3.0` | float | 节点标题 | 自发光红色强度 |
> | `Color.G` | `0.389` | float | 节点标题 | 降低绿色，让火焰更偏红 |
> | `Color.B` | `0.06` | float | 节点标题 | 降低蓝色，减少冷色成分 |
>
> 效果/预览:
> - 左侧火堆/材质预览区域显示木材燃烧处为偏红橙色亮斑，暗区仍由遮罩保留。
> - 该图的视觉结果用于验证颜色调整后更接近燃烧火焰。
>
> 连线覆盖检查: Panner、Texture Sample、Power、Multiply(10)、颜色常量和后级 Multiply 的可见关键连线均已记录；最终材质主节点输入在本截图右侧边界外，不额外断言未显示 Pin。
> 输出: 按文字复建后，应得到由 Panner 流动驱动、经 Power 提高对比、乘以暖红高强度颜色的自发光火焰材质链。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

