# 02 Stylized Tornado

# 02 Stylized Tornado

## 关键术语

- `Alpha`、`UV`、`Multiply`、`Blender`、`AE`、`Mesh`、`Niagara`、`Particle`、`Material`、`颜色`、`Niagara System`、`Emitter`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`、`Opacity`、`Renderer`

## 分段知识

### 00:00:05-00:05:01 UV、Blender

- 本段定位：UV、Blender。
- 知识点：我们把圈子拿出来,然后把上和下的部分拔掉 然后需要減少了数量的角度 因为需要用模式器来增加数量的角度 按Edit Mode,然后按Highlight,然后按Move。
- 知识点：Up 然后需要增加2倍,再按Edit Mode 然后需要选择上和下的角度,然后按Move Up 需要选择2倍,或者3倍 可能会提升一点點,然后在中间加一塊。
- 知识点：需要減少了数量的角度,需要适当延伸了我们Tornado的下半部分 然后把它延伸出来,然后需要用模式器来做模式 我们可观察到我们有多少角度。
- 知识点：可以把数量的角度调整到数量上 可以再增加它 然后需要选择所有角度,然后需要減少它 我覺得这樣就足夠了 我们要看UV的模式 可以已经在模式器上使用了。
- 知识点：使用,现在我们有很多角度 因为需要把我们的角度移到物件上 这是我们的UV 我们现在可观察到它们的样子 然后需要适当改变UV的模式。
- 知识点：我们轉移到色彩,然后按Test 如果我开始移动Test,它现在移动到这里 向左邊,向右 这不太适合我们,它比Tornado更有彈性。
- 知识点：可以做一个彈性的UV,需要选择最後的角度 上方的角度,然后按Proportional Editing 我们有这樣的圆形,它可以被改变,我选择了一些。
- 核对对象：`Blender`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Blender 起始建模场景图
> - 组成部分: 3D 视口 + Outliner + 物体属性面板 + 时间轴
> - 所属: `Blender` 场景中的 `Cube`
> - 目的: 说明这一段将从 Blender 默认立方体起步，为后续龙卷/水晶类形体准备基础几何对象
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | 3D 视口 | `Cube` | 视口处于 `Object Mode`，左上标注 `User Perspective`，当前只选中了一个 `Cube`；场景中央叠着 Blender 启动画面；左侧还能看到相机线框和一个黑色三角形相机指示 | 表示教程从默认场景起步，还未进入编辑具体 UV/顶点阶段 |
> | 右上 | Outliner | `Scene Collection` | 列表里只有 `Camera`、`Cube`、`Light`，其中 `Cube` 被高亮选中 | 说明当前唯一操作对象是默认立方体 |
> | 右侧 | 物体属性面板 | `Cube > Transform` | `Location X/Y/Z=0 m`，`Rotation X/Y/Z=0°`，`Scale X/Y/Z=1.000`，模式为 `XYZ Euler` | 表明对象保持默认变换，方便后续做比例和形体编辑 |
> | 下方 | 时间轴 | Scene Timeline | 处于起始帧附近，终点约到 `250` | 当前画面还没进入动画阶段，仅作为建模/编辑场景 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Cube.Location` | `(0,0,0)` | 物体属性面板 | 让基础体位于世界原点 |
> | `Cube.Rotation` | `(0,0,0)` | 物体属性面板 | 保持默认朝向 |
> | `Cube.Scale` | `(1,1,1)` | 物体属性面板 | 保持默认尺寸，便于后续统一变形 |
>
> 输出/观察:
> - 字幕提到“tornado”底部会有一个 cylinder，但当前截图实际仍停留在默认 `Cube` 场景，说明这是进入建模段之前的起始状态
> - 本图的价值主要是锚定操作环境和初始对象，而不是给出具体变形参数
> 图表转写（UE-GTXT v4）
> - 类型: Blender UV 与圆柱变形编辑图
> - 组成部分: UV Editor + 3D Viewport + Outliner + Modifier 属性面板
> - 所属: `Cylinder`
> - 目的: 把龙卷/水花底部的圆柱体编辑成上窄下宽的轮廓，同时保持一块整齐的矩形 UV，便于后续拉伸和贴图控制
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | UV Editor | `Cylinder` 的 `UVMap` | UV 视图里是一块规则矩形 UV 岛，纵向被均匀切成多列，中央有一条水平边环；左下角有一个选中的 UV 点 | 说明模型虽然在 3D 里被拉成收腰形，但 UV 仍保持平直可控 |
> | 中央偏右 | 3D 视口 | `Cylinder` | 处于 `Edit Mode`，对象已被拉成上窄下宽、接近喇叭口的圆柱；可见纵向边线和顶部、腰部横向边环 | 这是后续做弹性 UV 和形体扭曲的基础截面 |
> | 右上 | Outliner | `Scene Collection` | 当前只剩一个 `Cylinder` 对象被选中 | 说明默认立方体已经换成实际需要的圆柱基础体 |
> | 右侧 | Modifier 面板 | `Cylinder > Subdivision` | 已添加 `Subdivision` 修改器，模式为 `Catmull-Clark`；修改器右上菜单已展开，光标停在 `Duplicate` 一项附近 | 表示作者正在通过细分平滑圆柱表面 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Mode` | `Edit Mode` | 顶部工具栏 | 进入顶点/边级别编辑 |
> | `Object` | `Cylinder` | 视口与 Outliner | 作为龙卷底部基础形体 |
> | `Modifier.Subdivision.Type` | `Catmull-Clark` | Modifier 面板 | 平滑圆柱表面，减少硬边 |
> | `UVMap` | 单块矩形展开 | UV Editor | 让后续纵向纹理或渐变更容易控制 |
>
> 输出/观察:
> - 这张图对应“底部会有一个圆柱体”的实际建模状态，已经从默认方块切换到圆柱并做了初步收腰
> - 教程此时同时关心两件事：3D 轮廓要像龙卷底座，UV 展开又要尽量保持规整
> 图表转写（UE-GTXT v4）
> - 类型: Blender 扭转 UV 校验图
> - 组成部分: UV Editor + 3D Viewport + Outliner
> - 所属: `Cylinder`
> - 目的: 通过移动选中的 UV/顶点区段，制造类似龙卷风的螺旋扭转效果，并用棋盘格纹理检查 UV 是否拉伸合理
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | UV Editor | `Cylinder` 的 `UVMap` | 选中的 UV 岛被拉成一条从左高到右低的长斜四边形，岛内保留均匀的纵向切分；旁边加载了 `checker.png` 棋盘格 | 用于验证扭转后 UV 仍保持可读且格子没有极端挤压 |
> | 右侧 | 3D 视口 | `Cylinder` | 物体已形成上宽下宽、中间收腰的扭转体表面；表面显示斜向螺旋条纹，整体很像龙卷风或扭曲水柱 | 说明前一步对 UV/顶点的移动已经成功产生螺旋视觉节奏 |
> | 右上 | Outliner | `Scene Collection` | 当前仍只操作 `Cylinder` | 表示本段的全部形体变化都集中在同一基础体上 |
> | 右下提示 | 键位提示 | 操作热键 | 屏幕右下显示 `Y`，表示当前变换受 `Y` 轴约束 | 对应字幕里“我移动它们时”这一实际操作方式 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `UV Editor.Image` | `checker.png` | UV Editor 顶栏 | 用棋盘格快速检查 UV 拉伸和扭曲是否均匀 |
> | `Transform Constraint` | `Y` | 屏幕提示 | 沿 Y 方向移动选区，制造斜向扭转节奏 |
> | `Object` | `Cylinder` | 视口与 Outliner | 持续作为龙卷底座/扭曲柱体的几何基础 |
>
> 输出/观察:
> - 字幕直说这种结果“similar to a tornado, something twisted”，这张图就是该效果的直接证据
> - 关键不是生成复杂节点，而是把规整圆柱通过选区移动和 UV 校验，变成可用于后续特效贴图的螺旋体

### 00:05:01-00:09:45 UV

- 本段定位：UV。
- 知识点：可以继续创建物体 后续会将物体变得很像我们之前创建的物体 很像我们的水晶 现在后续会在文件中创建一个新物体 我们稱之为 轉移它们让它变得透明,后续会把它剪成更快的样子。
- 知识点：我们需要什么? 我们需要主色,我们选择颜色 我们可能会把它分成兩部分 这是我们的基礎圖,为了透明性 这里我们有調校,我们不需要 從这里需要把基礎圖剪掉。
- 知识点：需要有颜色圖 我还没给你们看过一个技巧 使用颜色圖,它是最适合在一个质感的物体上 设置成这樣 没有,还是要设置至完全0的等級 什么等級?。
- 知识点：当我们移遠一点,它的規格和規格,它会改变 它幫助我们去进行改善,它改善了游戏 但在这个情况下,我们需要最好的結果 颜色的規格会少一点空间。
- 知识点：而最好的結果,可以设置一个圖 让它永遠都能依靠最好的圖 完全0,全規格 这里我们设置一个圖,让它做到 不要重複 这是最好的设置選項,让它之后没有颜色圖。
- 知识点：特别是颜色圖 我们需要什么?这是溶解 我们不会用颜色在邊緣上 但需要把它放下 可能可以想要自己的版本 我们需要柔軟邊緣 我们也需要移动角落。
- 知识点：但在角落之前,需要再设置一个圖 我記得这里没有圖,现在需要设置 需要设置一个圖给颜色的圖。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Blender FBX 导出准备图
> - 组成部分: UV Editor + 3D Viewport + FBX 导出窗口 + Outliner
> - 所属: `Cylinder`
> - 目的: 在保持扭转圆柱与 UV 展开的前提下，准备把当前模型导出为 FBX 供后续流程使用
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | UV Editor | `Cylinder` 的 `UVMap` | UV 岛仍是斜向长条形展开，旁边保留棋盘格参考图 | 说明导出前 UV 已经整理完成 |
> | 右上 | 3D 视口 | `Cylinder` | 当前模型保留上宽下宽、中间收腰的螺旋体形态 | 表示要导出的就是这根扭转圆柱 |
> | 中央浮窗 | 文件导出窗口 | `Blender File View` | 正在导出 `untitled.fbx`；路径位于 `C:\Users\Stand1k\Documents\`；左侧目录树显示本地磁盘与文档目录 | 用于把当前 Blender 模型转成外部 FBX 文件 |
> | 浮窗右侧 | FBX 导出参数 | `Export FBX` | `Path Mode=Auto`，`Batch Mode=Off`；`Include` 限定为 `Selected Objects`；`Object Types` 中 `Mesh` 被保留；`Transform` 区域可读到 `Scale=1.00`、`Apply Scalings=All Local`、`Forward=Z Forward`、`Up=Y Up`，并勾选了 `Apply Unit` | 这些设置决定导出后的坐标朝向、缩放和对象筛选 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Export.FileName` | `untitled.fbx` | 导出窗口 | 生成要导出的 FBX 文件 |
> | `Include.Limit to` | `Selected Objects` | 导出窗口 | 只导出当前选中的圆柱体 |
> | `Object Types.Mesh` | Enabled | 导出窗口 | 导出网格对象 |
> | `Transform.Scale` | `1.00` | 导出窗口 | 保持原始缩放导出 |
> | `Transform.Apply Scalings` | `All Local` | 导出窗口 | 以本地缩放写入 FBX |
> | `Transform.Forward / Up` | `Z Forward / Y Up` | 导出窗口 | 指定导出坐标轴方向 |
>
> 输出/观察:
> - 这张图说明本段不只是调 UV，还把当前螺旋几何体整理到可以外部导出的状态
> - 左侧 UV、右侧模型和中间导出参数同屏，能证明导出前的形体与贴图展开是一致的
> 图表转写（UE-GTXT v4）
> - 类型: UE 纹理资源属性设置图
> - 组成部分: 纹理预览窗口 + Details 属性面板
> - 所属: `VFX_T_ColorMap_Blue_*`
> - 目的: 为细长蓝色颜色贴图设置合适的导入、压缩与寻址参数，保证这张条形贴图在材质里以最高质量参与最终效果
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | 纹理预览图 | `VFX_T_ColorMap_Blue_*` | 预览图是一条横向细长的蓝到青色渐变条带，当前缩放约 `238%` | 这是后续材质里用来提供主颜色变化的基础图 |
> | 顶部标签 | 资源切换栏 | UE 资源编辑器 | 同时打开了 `MI_tornado*`、`M_WaterBubble`、当前纹理资源页签 | 说明教程正在围绕材质和配套颜色图联动设置 |
> | 右侧上部 | 基本导入信息 | `Texture Details` | `Imported: 512x16`，`Displayed: 512x16`，`Max In-Game: 512x16`，`Resource Size: 6 KB`，`Has Alpha Channel: False`，`Format: DXT1`，`Number of Mips: 10`，`Method: Streamed` | 确认这是一个无 Alpha 的窄条色图，尺寸非常扁长 |
> | 右侧中下 | 纹理参数 | `Texture Details` | `Mip Gen Settings=FromTextureGroup`，`LOD Bias=0`，`Texture Group=World`，`Compression Settings=Default (DXT1/5, BC1/3 on DX11)`，`Padding and Resizing=None`，`Availability=GPU`，`sRGB` 已启用，`X-axis Tiling Method=Clamp`，`Y-axis Tiling Method=Wrap` | 这些设置决定颜色贴图的采样质量和在 U/V 方向上的重复方式 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Imported Size` | `512x16` | 属性面板 | 保持细长条纹色图分辨率 |
> | `Has Alpha Channel` | `False` | 属性面板 | 当前颜色图不依赖 Alpha |
> | `Compression Settings` | `Default (DXT1/5, BC1/3 on DX11)` | 属性面板 | 使用常规纹理压缩 |
> | `sRGB` | Enabled | 属性面板 | 让颜色贴图按颜色空间采样 |
> | `X-axis Tiling Method` | `Clamp` | 属性面板 | 防止横向取样时首尾重复拼接 |
> | `Y-axis Tiling Method` | `Wrap` | 属性面板 | 允许纵向循环采样 |
>
> 输出/观察:
> - 字幕强调“we need the best result”，这张图对应的就是为颜色图保留较稳定采样质量的具体设置
> - 细长条带预览与 `Clamp/Wrap` 组合表明这张贴图更像沿单一方向控制颜色过渡，而不是做普通平铺纹理
> 图表转写（UE-GTXT v4）
> - 类型: UE 材质图遮罩贴图接入图
> - 组成部分: 材质预览视口 + Material Graph + 参数详情面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 在龙卷材质里额外加入一个可参数化的遮罩贴图采样节点，用于控制颜色或透明度过渡区域
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `TexCoord[0]` | `TextureCoordinate` | `Coordinate Index=0` | 提供默认 UV 坐标给遮罩采样 |
> | `T_Mask` | `TextureSampleParameter2D` | `Param2D`；贴图资源为 `T_Gradient20`；`Sampler Type=Color` | 采样一张黑白渐变遮罩图，为后续材质混合提供控制信号 |
> | `M_Tornado` | Material Output | 可见输出口含 `Emissive Color`、`Opacity`、`World Position Offset` | 当前新增的遮罩节点将来会接入这些输出前的计算链 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `TexCoord[0]` | `T_Mask.UVs` | 用默认 UV 采样遮罩贴图 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `T_Mask.Texture` | `T_Gradient20` | 左下 Details | 指定当前遮罩使用的黑白渐变纹理 |
> | `T_Mask.Sampler Type` | `Color` | 左下 Details | 按颜色纹理方式读取遮罩图 |
> | `MaterialExpressionTextureSample.MipValueMode` | `None (use computed mip level)` | 左下 Details | 使用自动计算的 mip 级别 |
> | `MaterialExpressionTextureSample.Sampler Source` | `From texture asset` | 左下 Details | 采样器配置跟随纹理资源自身设置 |
> | `Const Coordinate` | `0` | 左下 Details | 使用第 0 套 UV |
> | `Preview Scale` | 预览窗口可见扭转体黑白渐变 | 左侧材质预览 | 即时检查遮罩方向和落点 |
>
> 输出/预览:
> - 左侧预览球/预览模型显示一根扭转柱体，上下边缘较暗，中间高亮，说明当前遮罩贴图在模型表面形成纵向渐变控制
> - 下方 `Stats` 可见 `Texture samplers: 0/16`、`Texture Lookups (Est.): VS(0), PS(3)`，表明新增贴图采样会进入像素着色阶段
>
> 输出/观察:
> - 字幕直接说“add this option, mask”，这张图就是把遮罩选项正式接进材质图的证据
> - 当前还没展示遮罩与其他颜色/透明节点的完整混合，但已经确定了遮罩来源、UV 输入和预览方向

### 00:09:45-00:14:29 Multiply

- 本段定位：Multiply。
- 知识点：选择Multiply 我们需要设置一个圖,让它在圖邊 像这樣 但在这里我们需要限制 我们改变颜色,然后我们需要限制。
- 知识点：從0到1 需要有这樣的圖 现在我们需要移动角落 需要把它剪輯出来 我们需要质感 聲音 需要选择任何一个圖,然后把它剪輯出来 例如,可以选择这个圖。
- 知识点：转换到一个圖圖 这是一个质感,让我们移动角落 这里有一个很有趣的點,需要展示给大家看 这个圖是我们想移动的角落 按照標準,我们选择50。
- 知识点：我们叫它 Vertex Offset应该会在这里移动 有些事情改变了 需要把Vertex Offset轉移到Emission 这樣它可观察到它在改变。
- 知识点：150 这个质感可以移动 需要展示需要这樣做 相反地,在另一个方向 这里,质感和角落都会移动 白色的價值会移动 黑色的價值会移动 角落会继续移动。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Multiply`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: UE 材质图 Multiply 边缘强化图
> - 组成部分: 材质预览视口 + Material Graph + 材质基础属性面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 通过 `Multiply` 节点把遮罩或灰度输入乘以一个可调参数，强化边缘过渡，让龙卷模型上下边缘形成更明显的尖锐收口
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `TextureSample` | 纹理采样节点 | 当前输出使用 `R` 通道；预览为一条纵向黑白渐变 | 提供边缘衰减或遮罩基础值 |
> | `Mask Multiply` | 标量参数节点 | `Param(15)`，`Default Value=15.0` | 控制边缘强化的放大量级 |
> | `Multiply` | 乘法节点 | 预览中 | 把渐变输入与放大系数相乘，得到更陡的遮罩结果 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `TextureSample.R` | `Multiply.A` | 使用纹理的灰度值作为第一输入 |
> | `Mask Multiply` | `Multiply.B` | 用标量参数放大遮罩强度 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Mask Multiply.Default Value` | `15.0` | 节点显示 | 让边缘变化更激进 |
> | `Material Domain` | `Surface` | 左下材质属性 | 当前材质仍是表面材质 |
> | `Blend Mode` | `Translucent` | 左下材质属性 | 允许透明过渡参与显示 |
> | `Shading Model` | `Unlit` | 左下材质属性 | 以自发光/颜色结果为主，不依赖受光 |
>
> 输出/预览:
> - 左侧预览窗口中的扭转体中部保持亮白，上下边缘迅速变暗，说明 `Multiply` 后的遮罩让边缘被压得更细
> - 下方 `Stats` 可见 `Texture Lookups (Est.): VS(0), PS(3)`，表明当前修改仍主要影响像素阶段采样和结果
>
> 输出/观察:
> - 字幕说“to make the edges like this”，这张图就是把边缘收缩效果具体落到 `Multiply + 标量参数` 上
> - 当前重点不是新增复杂网络，而是把已有黑白渐变通过一个强度参数重新整形
> 图表转写（UE-GTXT v4）
> - 类型: UE 材质图 Vertex Offset 链路总览图
> - 组成部分: 材质预览视口 + 完整 Material Graph 片段 + 参数详情面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 把前面已经建立的颜色、遮罩、乘法结果继续汇入主材质输出，并引入 `T_VertexOffset` 参数，为后续顶点位移或位移可视化做准备
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `TexCoord[0]` | `TextureCoordinate` | `Coordinate Index=0` | 作为贴图采样的统一 UV 输入 |
> | 颜色参数节点 | `VectorParameter` | 预览为亮黄色色块 | 提供当前材质主色或调色输入 |
> | 若干 `Multiply` / `Add` 节点 | 数学节点 | 位于图中央串联 | 负责把颜色、遮罩和偏移相关结果叠加或放大 |
> | `T_Mask` | `TextureSampleParameter2D` | 中央选中节点，预览为灰度纹理 | 继续提供黑白遮罩/渐变信号 |
> | `T_VertexOffset` | 参数节点 | 左下 Details 显示 `Parameter Name = T_VertexOffset` | 作为新的可调参数接入，用于控制顶点偏移相关贴图或数据 |
> | `M_Tornado` | Material Output | 右侧输出含 `Emissive Color`、`Opacity`、`World Position Offset` | 汇总整条材质链结果 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `TexCoord[0]` | 上游采样与遮罩节点 | 统一 UV 驱动多张贴图采样 |
> | 颜色参数与遮罩链 | 中部 `Multiply` / `Add` 链 | 先做颜色和遮罩的混合整形 |
> | `T_Mask` / 其他灰度结果 | 右侧数学节点 | 继续参与最终透明度或位移控制 |
> | 中央整形结果 | `M_Tornado` 输出前节点 | 准备写入最终材质输出 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Parameter Name` | `T_VertexOffset` | 左下 Details | 标识当前新接入的是顶点位移相关参数 |
> | `MaterialExpressionTextureSample.MipValueMode` | `None (use computed mip level)` | 左下 Details | 继续使用自动 mip |
> | `Sampler Source` | `From texture asset` | 左下 Details | 采样规则跟随纹理资源 |
> | `Const Coordinate` | `0` | 左下 Details | 使用第 0 套 UV |
>
> 输出/预览:
> - 左侧预览窗口中的扭转体几乎成为纯黑轮廓，只在边缘和顶部保留轻微渐变，说明当前预览的是偏遮罩/偏位移控制链，而不是最终着色结果
> - 下方 `Stats` 可见 `Base pass vertex shader: 132 instructions`，与字幕提到的 Vertex Offset 相呼应，说明顶点阶段逻辑正在增加
>
> 输出/观察:
> - 这张图把材质从“单个 Multiply 节点微调”推进到“整条颜色/遮罩/位移链合流”的层面
> - `T_VertexOffset` 已经被明确命名并放进图中，但当前截图还不能稳定看清它最终接到 `World Position Offset` 的完整末端
> 图表转写（UE-GTXT v4）
> - 类型: UE 材质图 Vertex Offset 完整节点链
> - 组成部分: 材质预览视口 + Material Graph + 材质基础属性面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 使用一张噪声位移贴图和顶点法线，把扭转模型沿法线推出褶皱/起伏，并通过高度参数统一控制位移强度
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `Panner` | 动态 UV 节点 | 左侧可见 `Coordinate`、`Time`、`Speed` 输入 | 让位移贴图能够随时间滚动 |
> | `T_VertexOffset` | `TextureSampleParameter2D` | `Param2D`；预览为灰色噪声纹理 | 采样用于顶点起伏的噪声图 |
> | `Add(-0.5)` | `Add` | `B=-0.5` | 把纹理采样值从 `0..1` 平移到以 0 为中心的 `-0.5..0.5` |
> | `Multiply(2)` | `Multiply` | `B=2.0` | 把居中的位移值放大到 `-1..1` 区间附近 |
> | `VertexNormalWS` | `Input Data` | 世界空间顶点法线 | 提供位移方向 |
> | 中间 `Multiply` | `Multiply` | 无稳定单独参数显示 | 把位移标量乘到顶点法线向量上 |
> | `Vertex Height` | 标量参数节点 | `Param(25)`，`Default Value=250.0` | 控制整体位移高度/强度 |
> | 右侧 `Multiply` | `Multiply` | 接 `Vertex Height` | 把法线位移结果再按高度参数整体缩放 |
> | `Vertex Offset` | 命名节点/结果节点 | 输出口在右侧 | 形成最终顶点偏移结果，供后续接到材质输出 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `Panner` | `T_VertexOffset.UVs` | 让位移贴图按滚动 UV 采样 |
> | `T_VertexOffset.R` | `Add(-0.5).A` | 读取噪声灰度作为位移源 |
> | `Add(-0.5)` | `Multiply(2).A` | 把居中后的位移值送入放大节点 |
> | `Multiply(2)` | 中间 `Multiply.A` | 提供标量位移强度 |
> | `VertexNormalWS` | 中间 `Multiply.B` | 以顶点法线作为位移方向 |
> | 中间 `Multiply` | 右侧 `Multiply.B` | 送入最终高度缩放 |
> | `Vertex Height` | 右侧 `Multiply.A` | 控制总位移幅度 |
> | 右侧 `Multiply` | `Vertex Offset` | 形成最终顶点偏移结果 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Add.B` | `-0.5` | 节点显示 | 让黑白纹理围绕 0 对称位移 |
> | `Multiply(2).B` | `2.0` | 节点显示 | 将位移重新拉满 |
> | `Vertex Height.Default Value` | `250.0` | 节点显示 | 决定顶点推出的最大高度 |
> | `Blend Mode` | `Translucent` | 左下材质属性 | 保持透明材质行为 |
> | `Shading Model` | `Unlit` | 左下材质属性 | 继续以自发光/颜色为主 |
>
> 输出/预览:
> - 左侧预览中的扭转柱体表面出现层层水平褶皱，说明当前位移链已经真正作用到顶点形态，而不只是颜色/透明度
> - 下方 `Stats` 可见 `Base pass vertex shader: 178 instructions`、`Texture Lookups (Est.): VS(4), PS(1)`，证明这条链把更多采样和计算移到了顶点阶段
>
> 输出/观察:
> - 这张图完整回答了前文“Vertex Offset 应该会在这里移动”的实现方式：用滚动噪声乘世界法线，再乘一个高度参数
> - 相比前两张，这里已经从边缘遮罩整形进阶到真实几何位移，是本段最关键的结构图

### 00:14:29-00:19:08 颜色

- 本段定位：颜色。
- 知识点：因为它從0到1 可能会更加显示在这球上 需要保留結果 我正在创建一个標準 我把它丢掉,例如我创造一个审讯,就会更好看它发生什么样的事。
- 知识点：我们创造一个分别 让我们看看 如果我把它调到0,就没有什么改变 我开始提升了转向的动作 有一个有趣的事情发生 我现在改变音量,让它更好看。
- 知识点：在白色的颜色上,它们在这里有质量 在黑色上,它们在红色上 它们在中间,因为我们改变了转向 如果我现在是,需要把这个缘分开 需要把它转回,需要把它删掉。
- 知识点：你看到结果已经改变了 黑色颜色在这里,它们仍然在位,但只有亮色颜色在移动 这就是为什么我改变了这个分别 然后Tornado会更好看。
- 知识点：缘分从-1到1 我们继续 我还是想展示一个东西 它叫做缘分 它是一样的 缘分是负责数的 缘分是负责加和缘分的 看看结果,是一样的 一笔筒简单。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: UE 顶点位移强度收敛图
> - 组成部分: 材质预览视口 + Vertex Offset 节点链 + Details 参数面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 在已经完成的顶点位移链上，把整体位移高度调低到更稳定的结果，并准备基于当前材质创建实例
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `T_VertexOffset` | `TextureSampleParameter2D` | 预览为灰色噪声图 | 提供位移灰度图 |
> | `Add(-0.5)` | `Add` | `B=-0.5` | 把位移居中到 0 附近 |
> | `Multiply(2)` | `Multiply` | `B=2.0` | 扩大位移正负范围 |
> | `VertexNormalWS` | `Input Data` | 世界空间法线 | 指定位移方向 |
> | 中部 `Multiply` | `Multiply` | 接收位移标量和法线 | 生成法线方向位移向量 |
> | `Vertex Height` | 标量参数节点 | `Default Value=50.0` | 控制总位移高度 |
> | 右侧 `Multiply` | `Multiply` | 与 `Vertex Height` 相乘 | 形成最终位移强度 |
> | `Vertex Offset` | 命名结果节点 | 输出口在右侧 | 作为顶点偏移结果输出 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `T_VertexOffset.R` | `Add(-0.5).A` | 读取噪声灰度 |
> | `Add(-0.5)` | `Multiply(2).A` | 居中后放大 |
> | `Multiply(2)` | 中部 `Multiply.A` | 提供标量位移 |
> | `VertexNormalWS` | 中部 `Multiply.B` | 提供位移方向 |
> | 中部 `Multiply` | 右侧 `Multiply.B` | 送入最终缩放 |
> | `Vertex Height` | 右侧 `Multiply.A` | 控制整体位移量 |
> | 右侧 `Multiply` | `Vertex Offset` | 输出最终顶点偏移 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Vertex Height.Default Value` | `50.0` | 节点显示 | 将之前更激进的位移改成更保守的高度 |
> | `Multiply(2).Const B` | `2.0` | 左下 Details | 保持位移值放大两倍 |
> | `Base pass vertex shader` | `179 instructions` | Stats | 说明顶点阶段已承担主要位移计算 |
> | `Texture Lookups (Est.)` | `VS(4), PS(1)` | Stats | 位移相关采样主要发生在顶点阶段 |
>
> 输出/预览:
> - 左侧预览中的龙卷体表面仍有明显褶皱，但比前一批的高位移版本更均匀，不再显得过分鼓包
> - 字幕说明“我会保存结果，我正在创建一个实例”，表明当前参数已经接近一个可落地的母材质基线
>
> 输出/观察:
> - 本图的重点是把位移链从“能动”收敛到“可用”，核心动作是降低 `Vertex Height`
> - 这也解释了为什么接下来会创建实例：后续偏色和细节调整更适合在实例层完成
> 图表转写（UE-GTXT v4）
> - 类型: UE 顶点位移归一化链调整图
> - 组成部分: 材质预览视口 + Vertex Offset 节点链 + 材质属性面板 + Stats
> - 所属: `M_Tornado`
> - 目的: 把位移纹理从直接 `Add(-0.5)+Multiply(2)` 的写法，整理为包含 `ConstantBiasScale` 的更标准化链路，便于在实例层继续调范围和方向
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `T_VertexOffset` | `TextureSampleParameter2D` | `Param2D`；预览为灰色噪声 | 继续提供位移纹理 |
> | `Add(-0.5)` | `Add` | `B=-0.5` | 图中仍保留旧版居中节点供对比/过渡 |
> | `Multiply(2)` | `Multiply` | `B=2.0` | 图中仍保留旧版放大量级节点 |
> | `ConstantBiasScale` | 数值映射节点 | 插在 `T_VertexOffset` 与 `VertexNormalWS` 相关链之间 | 用更标准的偏移/缩放方式把纹理值映射到需要的区间 |
> | `VertexNormalWS` | `Input Data` | 世界空间法线 | 位移方向来源 |
> | 中部 `Multiply` | `Multiply` | 节点上有“Place a new node”提示遮挡 | 把归一化后的位移强度乘到法线上 |
> | `Vertex Height` | 标量参数节点 | `Default Value=50.0` | 继续控制总位移高度 |
> | 右侧 `Multiply` | `Multiply` | 接 `Vertex Height` | 形成最终位移幅度 |
> | `Vertex Offset` | 命名结果节点 | 输出口在右侧 | 顶点位移最终结果 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `T_VertexOffset` | `ConstantBiasScale` | 先对噪声位移图做标准化映射 |
> | `ConstantBiasScale` | 中部 `Multiply` 输入 | 把处理后的位移值送入法线位移链 |
> | `VertexNormalWS` | 中部 `Multiply` 输入 | 提供位移方向 |
> | 中部 `Multiply` | 右侧 `Multiply.B` | 送入最终高度缩放 |
> | `Vertex Height` | 右侧 `Multiply.A` | 统一控制位移高度 |
> | 右侧 `Multiply` | `Vertex Offset` | 输出最终顶点偏移 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Vertex Height.Default Value` | `50.0` | 节点显示 | 保持更保守的位移强度 |
> | `Blend Mode` | `Translucent` | 左下材质属性 | 维持透明材质工作方式 |
> | `Shading Model` | `Unlit` | 左下材质属性 | 保持自发光/非受光模型 |
> | `Base pass vertex shader` | `177 instructions` | Stats | 顶点阶段仍承担主要位移计算 |
>
> 输出/预览:
> - 左侧预览中的龙卷体成为更均匀的黑色轮廓，说明当前更关注位移形体本身，而非颜色结果
> - 顶部已出现 `M_Tornado_Inst*` 页签，说明教程正在同步准备材质实例用于后续参数实验
>
> 输出/观察:
> - 字幕提到“从 -1 到 1”，这张图对应的正是把位移数据重新整理到对称区间的过程
> - 相比上一张，这里更像一次材质母版清理：把可实例化的控制链标准化，而不是单纯继续加大效果
> 图表转写（UE-GTXT v4）
> - 类型: UE 软边透明度混合链图
> - 组成部分: 材质预览视口 + Opacity/Soft Edge 节点链 + 输出节点 + Details
> - 所属: `M_Tornado`
> - 目的: 把基础透明度、Fresnel 边缘透明度和“是否使用纹理透明度”的开关组合起来，再乘到软边结果上，让龙卷边缘过渡更自然
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `Fresnel Opacity` | 参数/结果节点 | 紫色节点 | 提供基于视角的边缘透明度 |
> | 常量 `1` | `Constant` | `Value=1.0` | 作为 Lerp 的固定端点之一 |
> | `Base Opacity` | 参数节点 | 紫色节点 | 提供基础透明度值 |
> | `Use Texture Opacity?` | 标量参数节点 | `Param(1)`，`Default Value=1.0` | 决定是否启用贴图透明度混合 |
> | `Lerp` | `LinearInterpolate` | 当前被预览 | 在常量值、基础透明度与开关之间做插值 |
> | `Multiply` | 乘法节点 | 位于 `Fresnel Opacity` 后方 | 把 Fresnel 结果与软边/透明度结果相乘 |
> | `Vertex Offset` | 命名节点 | 独立接到输出 | 继续驱动 `World Position Offset` |
> | `M_Tornado` | Material Output | 右侧输出节点 | `Opacity` 与 `World Position Offset` 都已接入 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | 常量 `1` | `Lerp.A` | 作为默认不使用纹理透明度时的基准值 |
> | `Base Opacity` | `Lerp.B` | 提供基础透明度输入 |
> | `Use Texture Opacity?` | `Lerp.Alpha` | 用开关控制在两者之间插值 |
> | `Lerp` | `M_Tornado.Opacity` 之前的连线 | 形成主透明度结果 |
> | `Fresnel Opacity` | 上方 `Multiply.A` | 提供视角软边因子 |
> | 软边/透明度结果 | 上方 `Multiply.B` | 与 Fresnel 相乘形成更柔和边缘 |
> | `Vertex Offset` | `M_Tornado.World Position Offset` | 保持几何位移链不变 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Constant.Value` | `1.0` | 节点显示 | 作为不依赖贴图透明度时的基准不透明度 |
> | `Use Texture Opacity?.Default Value` | `1.0` | 节点显示 | 当前默认启用贴图透明度混合 |
> | `Lerp.Const A / B / Alpha` | `0.0 / 1.0 / 0.5` | 左下 Details | 编辑器给出的当前预览常量缓存值 |
>
> 输出/预览:
> - 左侧预览中的龙卷体呈现干净的白色体块，边缘较柔，不再只是一团黑色位移轮廓，说明当前预览焦点已经切回材质可见结果
> - 底部字幕提到“multiply to our soft edges”，与图里 `Fresnel Opacity` 接到 `Multiply` 的结构一致
>
> 输出/观察:
> - 这张图把 `S04` 的“颜色/边缘”主题具体落实为透明度与软边混合，而不是直接改颜色向量
> - 到这一张为止，`M_Tornado` 已同时具备位移形体、基础透明度和软边控制，材质实例化后的调参空间已经比较完整

### 00:19:08-00:23:48 Niagara、Mesh、颜色

- 本段定位：Niagara、Mesh、颜色。
- 知识点：按照这个图案,我没有想要使用,我把它们设定为0。
- 知识点：它并没有让边界更柔软,以帮助于面具上和下。
- 知识点：我们已经准备了透明性。
- 知识点：我们把主颜色拿出来,并且把颜色从这个环境上转移到这里。
- 知识点：我们会做这些,但是首先需要制造一个环境。
- 知识点：需要选择Niagara,并制造一个新环境。
- 知识点：需要编辑一个环境,需要存在10秒。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Niagara`、`Particle`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: UE 材质图接入 Particle Color 图
> - 组成部分: 材质预览视口 + Emissive/Opacity 节点链 + 输出节点 + 材质属性
> - 所属: `M_Tornado`
> - 目的: 把 Niagara 的 `Particle Color` 输入接进龙卷材质，让粒子系统可以在实例或 Niagara 侧直接驱动颜色
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `Particle Color` | `Input Data` | 输出 `RGB` 与 `A` | 读取 Niagara 传入的粒子颜色与 Alpha |
> | 左侧上游颜色节点 | 上游颜色结果 | 仅部分可见 | 提供当前材质已有的主颜色/渐变结果 |
> | 下方 `Lerp` | `LinearInterpolate` | 保留来自前段的透明度链 | 继续生成主透明度结果 |
> | 下方 `Multiply` | `Multiply` | 接收上游颜色与 `Lerp` 输出 | 先把颜色结果与透明度/遮罩链相乘 |
> | 上方 `Multiply` | `Multiply` | 接 `Particle Color.A` 与下方结果 | 用粒子 Alpha 或颜色数据进一步调制最终发光/颜色 |
> | `Vertex Offset` | 命名节点 | 接到输出下方 | 保持位移链不变 |
> | `M_Tornado` | Material Output | 右侧输出含 `Emissive Color`、`Opacity`、`World Position Offset` | 汇总材质最终结果 |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | 上游颜色结果 | 下方 `Multiply.A` | 提供当前材质颜色基础 |
> | `Lerp` | 下方 `Multiply.B` | 将透明度/软边链用于颜色整形 |
> | `Particle Color.A` | 上方 `Multiply.A` | 用粒子 Alpha 参与调制 |
> | 下方 `Multiply` | 上方 `Multiply.B` | 把已有颜色结果送入最终调制 |
> | `Lerp` | `M_Tornado.Opacity` | 继续驱动主透明度 |
> | `Vertex Offset` | `M_Tornado.World Position Offset` | 保持顶点位移输出 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Material Domain` | `Surface` | 左下材质属性 | 保持表面材质 |
> | `Blend Mode` | `Translucent` | 左下材质属性 | 支持透明边缘 |
> | `Shading Model` | `Unlit` | 左下材质属性 | 以 Emissive 结果为主 |
> | `Base pass vertex shader` | `179 instructions` | Stats | 位移链仍在顶点阶段生效 |
>
> 输出/预览:
> - 左侧预览中的龙卷体几乎透明到接近消失，说明当前预览节点更多是在测试颜色/透明度驱动关系，而不是展示最终外观
> - 右侧输出节点可见 `Emissive Color`、`Opacity`、`World Position Offset` 三条主链都在使用
>
> 输出/观察:
> - 本图对应字幕里“把主颜色拿出来，并且把颜色从这个环境上转移到这里”，具体做法就是把 `Particle Color` 作为 Niagara 到材质的颜色桥梁
> - 这一步完成后，龙卷颜色不再只能靠材质常量或实例参数，Niagara 粒子本身也能参与控制
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System 初始发射器配置图
> - 组成部分: Niagara System Overview + Initialize Particle 详情面板 + 预览窗口 + 时间线
> - 所属: `NS_Tornado` / 发射器 `Empty`
> - 目的: 新建一个 Niagara 发射器环境，并把它作为龙卷效果的基础承载体，先设置生命周期等基础粒子属性
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央左 | System Overview | `NS_Tornado` | 系统节点下可见 `Properties`、`User Parameters`、`System Spawn`、`System Update`、`System State` | 表明当前正在新建/编辑完整 Niagara System |
> | 中央 | 发射器栈 | `Empty` | 发射器包含 `Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Emitter State`、`Particle Spawn > Initialize Particle`、`Particle Update`、`Particle State`、`Render > Sprite Renderer` | 当前是从空发射器起步逐步补模块 |
> | 右侧 | Initialize Particle 详情 | `Empty > Particle Spawn > Initialize Particle` | `Lifetime Mode=Direct Set`，`Lifetime=10`；`Color Mode=Unset`；`Position Mode=Simulation Position`；`Position Offset=0.0`；`Mass Mode=Unset / (Mass of 1)`；Sprite/Mesh/Ribbon 多项属性都还是 `Unset` | 说明先只建立最基础的粒子生命期和默认属性骨架 |
> | 下方 | 时间线 | `Empty` | 时间轴右侧到约 `10.10` 秒，播放头在 `0.18` 秒附近 | 与字幕提到“需要存在 10 秒”一致 |
> | 左下 | 参数浏览 | System Attributes | 可见 `ExecutionState`、`LoopCount`、`NormalizedLoopAge` 等系统属性 | 便于后续把系统参数暴露给 Niagara 使用 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Initialize Particle.Lifetime Mode` | `Direct Set` | 详情面板 | 直接指定每个粒子的寿命 |
> | `Initialize Particle.Lifetime` | `10` | 详情面板 | 让基础效果持续 10 秒 |
> | `Initialize Particle.Color Mode` | `Unset` | 详情面板 | 颜色暂时不在初始化阶段硬编码 |
> | `Initialize Particle.Position Mode` | `Simulation Position` | 详情面板 | 使用模拟空间位置作为基础 |
> | `Initialize Particle.Position Offset` | `0.0` | 详情面板 | 当前无额外初始偏移 |
>
> 输出/预览:
> - 左侧预览窗口当前几乎没有稳定可见粒子，说明此时还处在系统骨架搭建阶段
> - 底部时间线和右侧 `Lifetime=10` 相互印证，说明这个发射器首先被当作一个 10 秒持续对象来配置
>
> 输出/观察:
> - 这张图对应字幕里“需要选择 Niagara，并制造一个新环境；需要编辑一个环境，需要存在 10 秒”
> - 当前重点是搭系统和生命周期，而不是立即追求可见形态
> 图表转写（UE-GTXT v4）
> - 类型: UE 龙卷材质完整输出链总览图
> - 组成部分: 材质预览视口 + 完整 Material Graph + 输出节点 + Stats
> - 所属: `M_Tornado`
> - 目的: 把此前拆开的颜色、粒子颜色、软边、遮罩、消融、深度淡出和顶点位移链统一接回母材质输出，形成可直接给 Niagara 使用的最终龙卷材质
>
> 节点定义集:
> | 节点名 | 节点类型 | 关键参数 | 作用 |
> |---|---|---|---|
> | `Particle Color` | `Input Data` | 输出 `RGB` 与 `A` | 读取 Niagara 侧颜色输入 |
> | `Main Color` | 颜色参数节点 | 青蓝色节点 | 提供龙卷主色 |
> | `Fresnel Opacity` | 参数节点 | 紫色节点 | 提供边缘软化因子 |
> | 常量 `1`、`Base Opacity`、`Use Texture Opacity?` | 常量/参数节点 | `Use Texture Opacity?` 默认 `0.0` | 组成基础透明度开关与插值链 |
> | `Lerp` | `LinearInterpolate` | 位于左下中部 | 在常量不透明度和基础透明度之间插值 |
> | 多个 `Multiply` | 数学节点 | 分别串联颜色、透明度、Mask 与粒子颜色 | 逐步把多个控制因子叠乘到最终结果 |
> | `Mask` | 参数/纹理相关节点 | 品红色节点 | 提供遮罩权重 |
> | `Dissolve` | 参数节点 | 绿色节点 | 控制消融/裁切阈值 |
> | `Depth Fade` 参数 | 标量参数节点 | `Default Value=100.0` | 提供深度淡出距离 |
> | `DepthFade` | 材质表达式节点 | 输入 `Opacity` 与 `FadeDistance` | 在几何交界处柔化透明过渡 |
> | `Vertex Offset` | 命名节点 | 独立接到底部输出 | 保持顶点位移结果 |
> | `M_Tornado` | Material Output | 右侧输出节点 | 接收 `Emissive Color`、`Opacity`、`World Position Offset` |
>
> 连线集:
> | 起点 | 终点 | 关系 |
> |---|---|---|
> | `Particle Color.RGB` | 上方颜色链输入 | 让 Niagara 颜色参与最终发光色 |
> | `Main Color` | 右上 `Multiply` | 把主色与粒子颜色/上游颜色相乘 |
> | `Lerp` | 左中 `Multiply` 与输出透明度链 | 继续提供基础透明度结果 |
> | `Fresnel Opacity` | 左中 `Multiply` | 用视角软边调制透明度 |
> | `Mask` | 中部 `Multiply` | 继续限制可见区域 |
> | `Dissolve` | 中右 `Multiply` | 参与消融/裁切调制 |
> | 中右 `Multiply` | `DepthFade.Opacity` | 把透明度结果送入深度淡出 |
> | `Depth Fade` 参数 | `DepthFade.FadeDistance` | 指定深度淡出距离 |
> | `DepthFade` | `M_Tornado.Opacity` | 形成最终透明度输出 |
> | 右上颜色链 | `M_Tornado.Emissive Color` | 形成最终发光颜色 |
> | `Vertex Offset` | `M_Tornado.World Position Offset` | 形成最终顶点位移 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Use Texture Opacity?.Default Value` | `0.0` | 节点显示 | 当前默认不额外依赖贴图透明度 |
> | `Depth Fade.Default Value` | `100.0` | 节点显示 | 控制与场景交界处的淡出范围 |
> | `Base pass shader without light map` | `181 instructions` | Stats | 当前像素阶段材质已经比较完整 |
> | `Texture samplers` | `5/16` | Stats | 材质已使用 5 个纹理采样器 |
> | `Texture Lookups (Est.)` | `VS(4), PS(5)` | Stats | 顶点与像素阶段都在共同工作 |
>
> 输出/预览:
> - 左侧预览里的龙卷体已经显示为亮青蓝色、带顶部更亮区域的成片状态，不再只是黑白测试体
> - 顶部标签可见 `MI_TornadoStylized_01*`，说明当前母材质已进入可实例化、可用于效果整合的阶段
>
> 输出/观察:
> - 这张图把 `S05` 里“Niagara、Mesh、颜色”三件事真正合到一起：Niagara 用 `Particle Color` 驱动，Mesh 用 `Vertex Offset` 变形，颜色由 `Main Color` 和软边/深度淡出链共同决定
> - 到这一张为止，`M_Tornado` 已具备可直接用于 Niagara 龙卷发射器的完整材质输出结构

### 00:23:48-00:28:24 关键流程 06

- 本段定位：关键流程 06。
- 知识点：首先,我们需要一个普通的圖案,以致左邊有黑色的圖案,右邊有更光亮的圖案。
- 知识点：我们删除圖案,我们删除剪輯器,这里需要有这些黑色的圖案。
- 知识点：在原理上要关闭,现在我们需要删除大小。
- 知识点：它们应该是5和12倍,幅度只有16倍。
- 知识点：剪輯之后,我们需要8倍,RGB和8倍。
- 知识点：按下剪輯,然后把这个圖案输入到 Unreal Engine,这就是在这里删除的方式。
- 知识点：而我们有一个橘色圖案,需要选择0.8。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Substance Designer 起始环境图
> - 组成部分: Home 起始页 + Recent 文件列表 + 左侧入口导航
> - 所属: `Substance 3D Designer`
> - 目的: 从 Substance Designer 开始制作教程所需的黑白梯度/图案贴图，后续会把它导入 Unreal Engine 供龙卷材质使用
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | 起始入口菜单 | Designer Home | 可见 `New Substance graph...`、`Open package...`、`New MDL graph...`、`Import Axf...` 等按钮，侧栏还有 `Home`、`Learn` | 表示教程正从新图或已有包入口开始准备贴图制作 |
> | 中央上方 | 欢迎横幅 | Designer Home | 标题为 `Welcome to Substance 3D Designer`，配有程序化材质介绍横幅 | 只是软件首页说明，当前还没进入具体节点图 |
> | 中央下方 | Recent 列表 | 最近工程 | 可见 `LensFlareAnim.sbs`、`Lightning_Ring.sbs`、`WaterRingSoft.sbs`、`Lesson_Niagara_Ray.sbs` 等最近文件 | 说明作者已有多个特效相关 `.sbs` 图案工程可复用或参考 |
> | 左下 | 附加链接 | About Designer / Docs | 有 `Online documentation`、`Website`、`Forums`、`Community assets` | 与当前贴图制作无直接运算关系 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Home Action` | `New Substance graph...` 可用 | 起始页按钮 | 准备新建图案贴图工程 |
> | `Recent File Example` | `WaterRingSoft.sbs` 等 | Recent 列表 | 表明教程环境中已有可参考的程序化图案文件 |
>
> 输出/观察:
> - 字幕明确说“首先，我们需要一个正常的梯度，以便左侧有黑色值”，说明当前真正任务是开始做一张黑到亮的基础图案
> - 这张图本身还没有节点结构，它的作用是锚定接下来将使用 Substance Designer 而不是 UE 材质图来生成源贴图
> 图表转写（UE-GTXT v4）
> - 类型: UE 渐变色带纹理属性图
> - 组成部分: 纹理预览窗口 + Details 属性面板
> - 所属: `VFX_T_ColorMap_Turqu_*`
> - 目的: 把从外部工具生成或整理好的细长颜色图导入 UE，并设置适合龙卷材质使用的压缩、Alpha 与平铺方式
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | 纹理预览图 | `VFX_T_ColorMap_Turqu_*` | 画面下方是一条横向细长的青绿色渐变色带，上方大部分为黑色空白；顶部显示缩放约 `872%` | 说明这张图本质上是一条用于颜色映射的长条纹理 |
> | 顶部标签 | 资源页签 | UE 编辑器 | 同时打开了 `MI_TornadoStylized_01*`、`M_Tornado*`、`NS_Tornado*`、当前纹理页签 | 表明这张颜色图正被用于龙卷材质和 Niagara 联动流程 |
> | 右侧上部 | 基本导入信息 | `Texture Details` | `Imported: 512x16`，`Displayed: 512x16`，`Max In-Game: 512x16`，`Resource Size: 11 KB`，`Has Alpha Channel: True`，`Format: BC7`，`Number of Mips: 10`，`Method: Streamed` | 说明这是带 Alpha 的窄条色图，品质比前面的普通色图更高 |
> | 右侧中下 | 压缩与纹理参数 | `Texture Details` | `Compression Settings=BC7 (DX11, optional A)`；`Texture Group=World`；`Padding and Resizing=None`；`Availability=GPU`；`sRGB` 已启用；`X-axis Tiling Method=Wrap`；`Y-axis Tiling Method=Wrap` | 确保颜色条在两个方向都可重复平铺，并保留 Alpha 数据 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Imported Size` | `512x16` | 属性面板 | 保持细长条纹分辨率 |
> | `Has Alpha Channel` | `True` | 属性面板 | 允许同一纹理携带透明/遮罩信息 |
> | `Compression Settings` | `BC7 (DX11, optional A)` | 属性面板 | 以较高质量保存颜色和可选 Alpha |
> | `sRGB` | Enabled | 属性面板 | 按颜色纹理方式采样 |
> | `X-axis Tiling Method` | `Wrap` | 属性面板 | 横向允许循环采样 |
> | `Y-axis Tiling Method` | `Wrap` | 属性面板 | 纵向也允许循环采样 |
>
> 输出/观察:
> - 字幕提到“按下剪辑，然后把这个图案输入到 Unreal Engine”，这张图就是导入后在 UE 中确认该图的证据
> - 与前面 `VFX_T_ColorMap_Blue_*` 相比，这张图明确带 Alpha 且使用 `BC7`，说明它更适合作为最终风格化颜色条或图案贴图
> 图表转写（UE-GTXT v4）
> - 类型: Niagara 动态材质参数接入图
> - 组成部分: Niagara System Overview + Dynamic Material Parameters 详情 + 预览窗口 + 时间线
> - 所属: `NS_Tornado` / 发射器 `Empty`
> - 目的: 在 Niagara 发射器里把动态材质参数写给龙卷材质，用于实时驱动 `Dissolve` 等参数，并切换到 Mesh 渲染模式承载龙卷网格
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央左 | System Overview | `NS_Tornado` | 系统节点与发射器 `Empty` 仍然存在 | 说明当前仍在同一龙卷 Niagara 系统内工作 |
> | 中央 | 发射器栈 | `Empty` | 发射器可见 `Emitter Spawn`、`Emitter Update`、`Particle Spawn > Initialize Particle`、`Particle Update > Dynamic Material Parameters`、`Render > Mesh Renderer` | 表示当前重点从基础初始化转到材质参数驱动与网格渲染 |
> | 右侧 | Dynamic Material Parameters 详情 | `Empty > Particle Update > Dynamic Material Parameters` | `Write Parameter Index 0` 已启用；参数名为 `Dissolve`，数值约 `0.54399`；`Param1-0`、`Param2-0`、`Param3-0` 当前都为 `0.0`；其他 `Index 1/2/3` 的写入未启用 | 用 Niagara 动态材质参数直接驱动材质里的消融值 |
> | 左侧预览 | Niagara Preview | `NS_Tornado` | 预览中出现一小段偏白灰色的龙卷/圆环形状，位置靠左上，整体还在早期测试状态 | 用于确认 `Dissolve` 改动会影响当前可见网格形态 |
> | 下方 | 时间线 | `Empty` | 播放头位于约 `1.52s`；总时长仍到约 `10.10s` 以上 | 表示正在观察中途时刻的材质参数变化 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Dynamic Material Parameter[0].Write` | Enabled | 详情面板 | 开启第 0 号动态材质参数写入 |
> | `Dynamic Material Parameter[0].Name` | `Dissolve` | 详情面板 | 对应材质里的消融控制参数 |
> | `Dynamic Material Parameter[0].Value` | `0.54399` | 详情面板 | 将当前网格裁切/消融强度设为约 0.54 |
> | `Dynamic Material Parameter[1..3].Write` | Disabled | 详情面板 | 暂时不写其他动态材质参数 |
> | `Render Module` | `Mesh Renderer` | 发射器栈 | 使用网格而不是纯 Sprite 来渲染龙卷 |
>
> 输出/观察:
> - 这张图把前面材质里定义的 `Dissolve` 真正接到了 Niagara 侧，说明龙卷外观已开始由系统运行时参数驱动
> - 字幕里提到“橘色图案，需要选择 0.8”，而当前图上稳定可读的是 `Dissolve≈0.544`，所以这里只记录已确认的 Niagara 动态参数值，不猜测未清晰显示的其他颜色参数

### 00:28:24-00:33:01 Alpha、Mesh

- 本段定位：Alpha、Mesh。
- 知识点：我们需要的就是这个 可以改善它 第一次 我不喜欢它看起来 需要改善它 但是可以改善它 第二次 可以改善它 第三次 可以改善它 然后可以改善它的。
- 知识点：好我们来看看 Dzolov Extruder 这个主要的 就是Dzolov Extruder 所以可以改善它 那如果可以改善它 可以改善它。
- 知识点：我应该改变什么? 这里,因为我把那些材料切掉了, 它都清除了, 所以它都还好, 基本上。
- 知识点：现在我们来看看結果。
- 知识点：但这次的結果并不适合, 因为这里的大小大了。
- 知识点：需要改变到某种軟的聲音, 因为如果我们用这种鋼線的转换, 它看起来不太好。
- 知识点：可能我们也需要改变一些圖案, 以为可以更加地明顯。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质实例 Alpha/Mesh 联调图
> - 组成部分: 材质实例预览视口 + `MI_TornadoStylized_01` 参数面板
> - 所属: `MI_TornadoStylized_01`
> - 目的: 在材质实例层同时调整龙卷网格的位移、颜色图、遮罩和软边参数，改善当前 Alpha 与 Mesh 结合后的整体观感
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | 预览视口 | `MI_TornadoStylized_01` | 中央是青蓝色半透明龙卷柱体，顶部和边缘有明显锯齿状起伏，底部有淡青色雾化过渡 | 用于实时观察材质实例参数对网格形态和透明度的影响 |
> | 右上 | 颜色向量参数 | `MI_TornadoStylized_01` | 颜色向量可见 `R=2.0`、`G=2.0`、`B=0.25`、`A=1.0`，并且 `Smoothness=1.0` | 定义整体偏青黄的主发光色与表面平滑度 |
> | 右中上 | Global Scalar Parameter Values | `MI_TornadoStylized_01` | `Depth Fade=100.0`，`Mask Multiply=5.0`，`Use Texture Opacity?=0.0`，`Vertex Height=48.773113` | 说明当前实例正在微调透明度、遮罩强度和位移高度 |
> | 右中 | Global Texture Parameter Values | `MI_TornadoStylized_01` | `T_VertexOffset=T_Noise58`；`T_Main=T_NoiseSoft_01`；`Colormap=VFX_T_ColorMap_Turquoise_08`；下方可见 `Main (Scale)(Scroll)` 和 `Vertex Offset (Scale)(Scroll)` 的向量条 | 这些纹理共同决定龙卷表面噪声、主图案和青色颜色条 |
> | 右下中 | Mask / Soft Edge | `MI_TornadoStylized_01` | `T_Mask=T_Gradient20`；`Fresnel Influence=1.0`，`Fresnel Opacity Exp=5.0`，`Fresnel Opacity Power=4.0` | 用渐变遮罩和 Fresnel 软边塑造龙卷外缘透明过渡 |
> | 右下 | General / Parent | `MI_TornadoStylized_01` | `Parent=M_Tornado`，底部还能看到 `Blend Mode=Translucent` | 说明当前实例继承自母材质 `M_Tornado` |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Color RGBA` | `2.0, 2.0, 0.25, 1.0` | 参数面板 | 提供偏青亮色的主发光色 |
> | `Depth Fade` | `100.0` | 参数面板 | 决定与地面交界的透明淡出范围 |
> | `Mask Multiply` | `5.0` | 参数面板 | 加强遮罩影响 |
> | `Use Texture Opacity?` | `0.0` | 参数面板 | 当前不依赖额外纹理透明度 |
> | `Vertex Height` | `48.773113` | 参数面板 | 控制龙卷褶皱/位移高度 |
> | `T_VertexOffset` | `T_Noise58` | 参数面板 | 提供位移噪声 |
> | `Colormap` | `VFX_T_ColorMap_Turquoise_08` | 参数面板 | 提供青色条形颜色图 |
> | `T_Mask` | `T_Gradient20` | 参数面板 | 提供遮罩渐变 |
>
> 输出/观察:
> - 字幕提到“需要改变 Texture Blending Vertices”，而当前图里最直接相关的是 `Vertex Height`、位移纹理和遮罩/软边组合，说明作者正在实例层找更合适的网格与 Alpha 平衡
> - 当前龙卷已经具备成片雏形，但顶部锯齿和体量仍显得偏硬，这也符合字幕中“第一次不喜欢它看起来，需要改善它”的描述
> 图表转写（UE-GTXT v4）
> - 类型: 材质实例 Alpha/位移增强调参图
> - 组成部分: 材质实例预览视口 + `MI_TornadoStylized_01` 参数面板
> - 所属: `MI_TornadoStylized_01`
> - 目的: 继续加大网格位移和软边参数，验证更强烈的褶皱与透明边缘是否能让龙卷轮廓更明显
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | 预览视口 | `MI_TornadoStylized_01` | 龙卷体变得更细、更透明，顶部边缘翘起更明显，左上还能看到一条黄色警告提示 `T_VertexOffset...LowResBlurredNoise as Color` | 说明当前位移贴图与透明参数都被调得更激进 |
> | 右上中 | Main Color / Colormap | `MI_TornadoStylized_01` | `T_Main=T_NoiseSoft_01`；`Colormap=VFX_T_ColorMap_Turquoise_08`；`Main (Scale)(Scroll)` 向量条仍可见 | 维持青色风格和主图案来源不变 |
> | 右中 | Mask | `MI_TornadoStylized_01` | `Mask Multiply=5.0`；`T_Mask=T_Gradient20` | 保持遮罩权重和渐变遮罩 |
> | 右中下 | Soft Edge | `MI_TornadoStylized_01` | `Fresnel Influence=0.5`；`Fresnel Opacity Exp=1.0`；`Fresnel Opacity Power=1.0` | 把软边参数调得更平缓，减少过硬边界 |
> | 右下中 | Vertex offset | `MI_TornadoStylized_01` | `T_VertexOffset=LowResBlurredNoise`；`Vertex Height=150.0`；`Vertex Offset (Scale)(Scroll)` 的向量参数为 `R=1.0,G=1.0,B=0.25,A=1.0` | 大幅提高位移强度，并改用更柔的低分辨率模糊噪声 |
> | 右下 | General | `MI_TornadoStylized_01` | `Parent=M_Tornado` | 仍然继承同一母材质 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Mask Multiply` | `5.0` | 参数面板 | 维持遮罩强度 |
> | `Fresnel Influence` | `0.5` | 参数面板 | 降低 Fresnel 影响，避免边缘过分突出 |
> | `Fresnel Opacity Exp` | `1.0` | 参数面板 | 让透明过渡更柔 |
> | `Fresnel Opacity Power` | `1.0` | 参数面板 | 继续软化边缘曲线 |
> | `T_VertexOffset` | `LowResBlurredNoise` | 参数面板 | 用更柔和的噪声替代更硬的位移图 |
> | `Vertex Height` | `150.0` | 参数面板 | 大幅提高位移高度，强化龙卷起伏 |
> | `Vertex Offset (Scale)(Scroll)` | `1.0, 1.0, 0.25, 1.0` | 参数面板 | 控制位移贴图的缩放与滚动相关向量 |
>
> 输出/观察:
> - 这一版龙卷的透明度更高，但顶部和中段的扭曲感更强，正好对应字幕里“第二次、第三次继续改善”的试错过程
> - 字幕还提到“这次的结果并不适合，因为这里的大小大了”，而当前 `Vertex Height=150.0` 正是一个明显偏大的尝试值
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Mesh 缩放曲线调节图
> - 组成部分: Niagara System Overview + `Scale Mesh Size` 详情面板 + 预览窗口 + 时间线
> - 所属: `NS_Tornado` / 发射器 `Empty`
> - 目的: 通过网格缩放曲线控制龙卷网格在粒子生命周期中的尺寸变化，修正上一张里“大小过大”的问题
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央左 | System Overview | `NS_Tornado` | 发射器 `Empty` 的 `Particle Update` 下已加入 `Scale Mesh Size` 和 `Dynamic Material Parameters`，`Render` 仍是 `Mesh Renderer` | 说明当前在 Niagara 侧继续修网格尺寸而不是回材质 |
> | 右侧 | `Scale Mesh Size` 详情 | `Empty > Particle Update > Scale Mesh Size` | `Scale Factor` 类型是 `Vector From Curve`；曲线面板以 `PARTICLES.NormalizedAge` 为横轴；红色 `X` 曲线从起始较高值逐渐下降到末端更低值；底部 `Scale Curve` 初值显示为 `1.0 / 1.0 / 1.0` | 用生命周期曲线控制网格随时间缩放 |
> | 左侧预览 | Niagara Preview | `NS_Tornado` | 预览里能看到一段偏青色龙卷体，但因为视角和景深较重，形态较模糊 | 用于实时观察缩放曲线对龙卷体量的影响 |
> | 下方 | 时间线 | `Empty` | 播放头约在 `1.55s`；总时长仍在 `10s+` 范围 | 说明当前观察的是粒子中前期的尺寸状态 |
> | 左下 | 参数浏览 | System Attributes | 仍可见 `LoopCount`、`LoopedAge`、`NormalizedLoopAge` 等系统属性 | 与右侧曲线使用 `NormalizedAge` 呼应 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Scale Factor.Type` | `Vector From Curve` | 详情面板 | 使用曲线而非常量缩放 |
> | `CurveIndex` | `PARTICLES.NormalizedAge` | 详情面板 | 让缩放跟随粒子生命周期归一化时间变化 |
> | `Scale Curve Initial` | `1.0 / 1.0 / 1.0` | 详情面板 | 起始三轴缩放基线 |
> | `X Curve Trend` | 从高到低下降 | 曲线面板 | 让龙卷在生命周期内逐渐缩小或收束 |
>
> 输出/观察:
> - 字幕提到“需要改变到某种软的声音……这种钢线的转换看起来不太好”，这里对应的实际操作是从网格尺度变化入手，让龙卷体量过渡更柔和
> - 这张图说明问题并不只在 Alpha，Niagara 的网格尺寸曲线也是龙卷观感的重要控制点

### 00:33:01-00:37:52 AE

- 本段定位：AE。
- 知识点：在1.5倍的一秒, 如果我分開,例如, 一个大数字, 在一秒,2秒会过3秒。
- 知识点：在0倍減少, 在0倍減少,在1倍減少。
- 知识点：这就是在一秒中, X在游戏中选择。
- 知识点：我们设置了自動減少, 在一秒半,我们有这樣的減少, 它減少到这个程度。
- 知识点：在这里,我们还需要在Dissolve上 把它混合起来,这樣会看起来不錯。
- 知识点：0倍,例如,從0倍減少到1倍減少。
- 知识点：这是在什么情况下發生的? 这是在什么情况下發生的? 在什么情况下發生的? 例如,你能把 这點放得更高。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara 发射器年龄驱动缩放曲线图
> - 组成部分: Niagara System Overview + `Scale Mesh Size` 详情面板 + 预览窗口 + 时间线
> - 所属: `NS_Tornado` / 发射器 `Empty`
> - 目的: 不再直接用粒子生命周期，而改用发射器年龄乘系数来驱动网格缩放曲线，让龙卷在更短时间段内完成明显的尺寸衰减
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | 发射器栈 | `Empty` | `Particle Update` 下仍有 `Scale Mesh Size` 与 `Dynamic Material Parameters`，`Render` 为 `Mesh Renderer` | 说明当前继续通过 Niagara 动态调整网格外观 |
> | 右侧上部 | `Scale Mesh Size` 曲线图 | `Empty > Particle Update > Scale Mesh Size` | `Scale Factor` 仍是 `Vector From Curve`；红色 `X` 曲线从左侧较大值持续下降到右侧较低值 | 通过一条递减曲线控制龙卷沿时间缩小 |
> | 右侧下部 | 曲线索引设置 | `Scale Mesh Size` | `CurveIndex` 类型为 `Multiply Float`；`A=EMITTER.Age`；`B=4.0`；`Scale Curve` 初值仍为 `1.0 / 1.0 / 1.0` | 表示把发射器年龄乘以 4 倍后再拿去采样缩放曲线 |
> | 左侧预览 | Niagara Preview | `NS_Tornado` | 视口里可见一根细小、偏青色的龙卷柱体，底部较暗，上段稍亮 | 用于观察当前缩放驱动下的早期尺寸结果 |
> | 下方 | 时间线 | `Empty` | 播放头约在 `0.19s`，系统总长仍到 `10s+` | 对应字幕里关于“1 秒、1.5 秒、2 秒”的时间讨论 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Scale Factor.Type` | `Vector From Curve` | 详情面板 | 使用曲线控制网格缩放 |
> | `CurveIndex.Type` | `Multiply Float` | 详情面板 | 对时间输入先做乘法重映射 |
> | `CurveIndex.A` | `EMITTER.Age` | 详情面板 | 以发射器运行时间作为基础驱动 |
> | `CurveIndex.B` | `4.0` | 详情面板 | 将年龄放大 4 倍，使曲线变化更快发生 |
> | `Scale Curve Initial` | `1.0 / 1.0 / 1.0` | 详情面板 | 三轴缩放基线 |
>
> 输出/观察:
> - 字幕反复提到“1 秒、1.5 倍、2 秒”，这张图就是把时间逻辑具体落到 `EMITTER.Age * 4.0` 这样的曲线采样方式上
> - 相比上一批只按 `NormalizedAge` 线性衰减，这里开始尝试更激进的时间映射，以便更快地收缩龙卷体量
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Dissolve 动态曲线图
> - 组成部分: Niagara System Overview + `Dynamic Material Parameters` 详情面板 + 预览窗口 + 时间线
> - 所属: `NS_Tornado` / 发射器 `Empty`
> - 目的: 用一条浮点曲线驱动材质里的 `Dissolve` 值，让龙卷在生命周期里先快速出现、保持一段、再在后段重新增大/变化
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | 发射器栈 | `Empty` | `Particle Update` 下仍有 `Scale Mesh Size`、`Dynamic Material Parameters`，`Render` 为 `Mesh Renderer` | 说明当前继续在 Niagara 里驱动材质表现 |
> | 右侧上部 | `Dynamic Material Parameters` 曲线 | `Empty > Particle Update > Dynamic Material Parameters` | `Write Parameter Index 0` 已启用；参数名为 `Dissolve`；类型切为 `Float from Curve`；曲线左端从高值迅速跌到接近 `0.05`，中段长时间保持低值，末端又升回接近 `0.9` | 用关键帧曲线控制龙卷消融出现与消失节奏 |
> | 右侧下部 | 曲线输入设置 | `Dissolve` | `CurveIndex=PARTICLES.NormalizedAge`；`Scale Curve=1.0`；其余 `Param1-0/Param2-0/Param3-0` 仍为 `0.0` | 用粒子归一化年龄采样这条 Dissolve 曲线 |
> | 左侧预览 | Niagara Preview | `NS_Tornado` | 能看到一小段偏青色龙卷体，字幕说“also appears and increases” | 对应曲线末段重新抬升的视觉效果 |
> | 下方 | 时间线 | `Empty` | 播放头约在 `7.87s`，接近整个 10 秒发射器后段 | 适合观察 Dissolve 后段变化 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Dynamic Material Parameter[0].Name` | `Dissolve` | 详情面板 | 对应材质中的消融参数 |
> | `Dynamic Material Parameter[0].Type` | `Float from Curve` | 详情面板 | 用曲线而非常量值驱动参数 |
> | `CurveIndex` | `PARTICLES.NormalizedAge` | 详情面板 | 让曲线跟随粒子生命周期推进 |
> | `Key Data (visible)` | `0.05 / 0.0` | 曲线面板下方 | 当前选中关键点附近可见的一组键值数据 |
> | `Scale Curve` | `1.0` | 详情面板 | 维持曲线默认缩放 |
>
> 输出/观察:
> - 字幕提到“在这里，我们还需要在 Dissolve 上把它混合起来，这样会看起来不错”，而这张图给出的正是具体的 Dissolve 动画曲线
> - 曲线形状说明作者不是简单线性变化 Dissolve，而是要先迅速露出主体，再在末段做第二次增强或收束
> 图表转写（UE-GTXT v4）
> - 类型: 关卡内 Niagara 与材质实例联调图
> - 组成部分: 关卡主视口 + 材质实例窗口 + Outliner + 内容浏览器
> - 所属: `NS_Tornado` 与 `MI_TornadoStylized_01`
> - 目的: 在实际关卡中边观察 Niagara 龙卷成片效果，边继续调实例里的遮罩、软边和位移参数，验证 `mask` 对最终外观的帮助
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 主视口 | 关卡效果图 | `NS_Tornado` | 黑暗背景里能看到一串沿竖向分布的青色碎片/切片状龙卷段，整体偏离散 | 说明当前在实际场景里检验 Dissolve、Mask 和 Mesh 组合后的结果 |
> | 中央浮窗左侧 | 材质实例预览 | `MI_TornadoStylized_01` | 预览窗口中的小型龙卷体仍是青色半透明柱体 | 用于在不离开关卡的情况下同步看实例参数的局部效果 |
> | 中央浮窗右侧 | 实例参数面板 | `MI_TornadoStylized_01` | `Mask Multiply=25.0`；`T_Mask=T_Gradient20`；`Fresnel Influence=0.5`；`Fresnel Opacity Exp=1.0`；`Fresnel Opacity Power=10.0`；`T_VertexOffset=LowResBlurredNoise`；`Vertex Height=150.0`；`Vertex Offset (Scale)(Scroll)` 下 `R=1.0,G=1.0,B=0.25,A=1.0` | 这些参数共同决定龙卷体的切片感、软边和位移强度 |
> | 右上 | Outliner | 当前关卡 | 当前选中的是 `NS_Tornado`（`NiagaraActor`） | 说明主视口里看到的效果正来自这个 Niagara Actor |
> | 下方 | 内容浏览器 | `ColorMaps` 目录 | 下面能看到一排 `VFX_T_ColorMap_*` 色带纹理缩略图 | 说明作者正在同时比较不同颜色图资源 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Mask Multiply` | `25.0` | 实例参数面板 | 大幅增强遮罩影响，使龙卷形体被切得更明显 |
> | `Fresnel Influence` | `0.5` | 实例参数面板 | 保留中等强度的边缘软化 |
> | `Fresnel Opacity Exp` | `1.0` | 实例参数面板 | 维持较柔的透明度指数 |
> | `Fresnel Opacity Power` | `10.0` | 实例参数面板 | 明显加强软边权重分布 |
> | `T_VertexOffset` | `LowResBlurredNoise` | 实例参数面板 | 继续使用柔和噪声做位移 |
> | `Vertex Height` | `150.0` | 实例参数面板 | 保持较大的位移高度 |
> | `Selected Actor` | `NS_Tornado` | Outliner | 当前联调对象 |
>
> 输出/观察:
> - 字幕提到“but with the help of this mask”，这张图正对应通过把 `Mask Multiply` 推高到 `25` 来强化切片可见性
> - 主视口中的龙卷已经不是完整实体，而更像被切开的青色层片，说明当前参数组合确实显著改变了 Alpha 与 Mesh 的表现方式

### 00:37:52-00:38:45 关键流程 09

- 本段定位：关键流程 09。
- 知识点：但我们看到它们是在軟化的转换中。
- 知识点：我只用了面積, 让邊界和上下都很軟。
- 知识点：但转换中的东西 很简单。
- 知识点：例如,你可用不同的色彩卡 来做不同的变化。
- 知识点：也就是, 这很容易改变 色彩。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡内颜色卡联调图
> - 组成部分: 关卡主视口 + 材质实例窗口 + Outliner/Actor Details + 内容浏览器
> - 所属: `NS_Tornado` 与 `MI_TornadoStylized_01`
> - 目的: 在实际关卡中通过替换或联调不同颜色卡与遮罩参数，验证龙卷在软边过渡下的最终色彩表现
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 主视口 | 关卡效果图 | `NS_Tornado` | 黑暗背景中可见一根完整的青蓝色螺旋龙卷体，形态比前批更连续、更少切片感 | 用于观察最终颜色卡和软边组合后的成片效果 |
> | 中央浮窗左侧 | 材质实例预览 | `MI_TornadoStylized_01` | 小预览里仍是同一根青色龙卷体 | 方便对照实例参数调整与关卡表现 |
> | 中央浮窗右侧 | 实例参数面板 | `MI_TornadoStylized_01` | 可见 `Depth Fade=100.0`、`Use Texture Opacity?=0.0`；`T_Main` 指向一张烟雾/噪声贴图；`Colormap` 指向一张 `VFX_T_ColorMap_*` 青色条；`Main (Scale)(Scroll)` 向量为 `R=1.0,G=1.0,B=0.0,A=1.5`；`Mask Multiply=5.0`；`T_Mask=WhiteSquareTextu...`；`Fresnel Influence=0.5`、`Fresnel Opacity...=1.0` | 说明作者正在用不同颜色卡和遮罩图组合测试最终视觉 |
> | 右侧 | Actor 详情 | `NS_Tornado (Instance)` | 选中 `NS_Tornado`；可见 `Auto Activate` 已启用；`Scale X/Y/Z=1.0` | 说明当前看到的效果是场景中实际运行的 Niagara Actor |
> | 下方 | 内容浏览器 | `ColorMaps` 目录 | 能看到一排 `VFX_T_ColorMap_Green_06`、`...Pink_00`、`...Red_01` 等不同色带贴图 | 对应字幕所说可用不同色彩卡做变化 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Depth Fade` | `100.0` | 实例参数面板 | 控制与地面交界的软淡出 |
> | `Use Texture Opacity?` | `0.0` | 实例参数面板 | 当前不依赖额外纹理透明度 |
> | `Main (Scale)(Scroll)` | `1.0, 1.0, 0.0, 1.5` | 实例参数面板 | 控制主图案的缩放/滚动参数 |
> | `Mask Multiply` | `5.0` | 实例参数面板 | 控制遮罩强度 |
> | `T_Mask` | `WhiteSquareTextu...` | 实例参数面板 | 当前改用白方块类遮罩图 |
> | `Selected Actor` | `NS_Tornado` | Actor 详情 | 当前联调对象 |
>
> 输出/观察:
> - 字幕说“例如，你可用不同的色彩卡 来做不同的变化”，而这张图下方的 `ColorMaps` 浏览器正好证明当前在对比多种颜色条贴图
> - 相比前一批偏碎片化的结果，这里主视口中的龙卷已经更完整，说明颜色卡与软边配置开始进入相对稳定的收尾状态
> 图表转写（UE-GTXT v4）
> - 类型: 关卡内颜色卡对照图
> - 组成部分: 关卡主视口 + Outliner/Actor Details + 内容浏览器
> - 所属: `NS_Tornado`
> - 目的: 直接在关卡里对照龙卷当前效果和底部多组颜色卡纹理，强调后期换色流程非常简单
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 主视口 | 关卡效果图 | `NS_Tornado` | 画面中央是一根青蓝色龙卷体，主体更完整，底部与地面之间有柔和淡出 | 用于作为颜色卡替换后的即时结果参考 |
> | 右侧 | Actor 详情 | `NS_Tornado (Instance)` | 仍选中 `NS_Tornado`；`Scale X/Y/Z=1.0`，`Auto Activate` 已启用 | 确认当前预览的是场景中真实运行的 Niagara Actor |
> | 下方 | 内容浏览器 | `ColorMaps` 目录 | 一整排 `VFX_T_ColorMap_*` 色带纹理可见，包含 `Green`、`Icyblue`、`Pink`、`Purple`、`Red` 等多种配色版本 | 说明换色主要依赖替换/选择不同颜色卡资源 |
> | 右上 | Outliner | 当前关卡 | 当前高亮 `NS_Tornado` 这一 `NiagaraActor` | 保持关卡中唯一目标对象明确 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Selected Actor` | `NS_Tornado` | Actor 详情 | 当前联调对象 |
> | `Transform.Scale` | `1.0 / 1.0 / 1.0` | Actor 详情 | 场景里未再用 Actor 缩放掩盖材质/网格问题 |
> | `Auto Activate` | Enabled | Actor 详情 | 进入场景就自动播放效果 |
> | `ColorMap Options` | 多个 `VFX_T_ColorMap_*` | 内容浏览器 | 用不同颜色条快速切换龙卷配色 |
>
> 输出/观察:
> - 字幕说“它很简单”，这张图正好把“简单”落实为一个很直接的操作思路：在关卡中保持 `NS_Tornado` 不变，只切换下方不同颜色卡纹理
> - 这也说明教程收尾阶段已经不再大改节点结构，而是在现有系统上做低成本外观变体
> 图表转写（UE-GTXT v4）
> - 类型: 暖色颜色卡变体对照图
> - 组成部分: 关卡主视口 + 材质实例窗口 + 内容浏览器 + Actor 详情
> - 所属: `NS_Tornado` 与 `MI_TornadoStylized_01`
> - 目的: 展示把同一龙卷效果切换到偏暖黄/白色颜色卡后的结果，证明这个系统可以很容易得到不同配色版本
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 主视口 | 关卡效果图 | `NS_Tornado` | 原本青蓝色的龙卷已经变成亮黄白色，底部泛着暖色辉光，整体依然保持同样的螺旋形体 | 说明此时主要变化来自颜色卡，而不是网格结构 |
> | 中央浮窗 | 材质实例窗口 | `MI_TornadoStylized_01` | 预览里同样显示暖黄白色龙卷；`Use Texture Opacity?=0.0`；`T_Main` 仍指向同一噪声主图；`Colormap` 已换成一张偏暖色的 `VFX_T_ColorMap_*`；`Main (Scale)(Scroll)` 仍为 `R=1.0,G=1.0,B=0.0,A=1.5` | 表示换色主要靠替换颜色卡资源，不需要重做主图或时间参数 |
> | 下方 | 内容浏览器 | `ColorMaps` 目录 | 仍显示大量 `Green / Pink / Purple / Red / Yellow` 类颜色卡缩略图 | 说明暖色只是众多可选变体之一 |
> | 右侧 | Actor 详情 | `NS_Tornado (Instance)` | `NS_Tornado` 仍被选中，缩放保持 `1.0 / 1.0 / 1.0` | 保持场景对象不变，只替换实例颜色资源 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Use Texture Opacity?` | `0.0` | 实例参数窗口 | 当前换色不依赖额外透明贴图 |
> | `T_Main` | 与前图相同的烟雾/噪声主图 | 实例参数窗口 | 保持图案结构不变 |
> | `Colormap` | 切换为偏暖黄/白色 `VFX_T_ColorMap_*` | 实例参数窗口 | 直接改变龙卷最终配色 |
> | `Main (Scale)(Scroll)` | `1.0, 1.0, 0.0, 1.5` | 实例参数窗口 | 保持主图案运动/缩放参数一致 |
> | `Selected Actor` | `NS_Tornado` | Actor 详情 | 当前场景中的联调对象 |
>
> 输出/观察:
> - 这张图最直接地证明了教程结论：只要更换颜色卡，整套龙卷效果就能迅速从冷青色切到暖黄白色
> - 同时主视口与实例预览都保持了相同的形体和透明逻辑，说明颜色变化并没有破坏原来的软边与位移结构

## 补充视觉证据

### S01 00:02:42

> 图表转写（UE-GTXT v4）
> - 类型: Blender 条纹材质 UV 校验补充图
> - 组成部分: UV Editor + 3D Viewport + Outliner
> - 所属: `Cylinder`
> - 目的: 补充说明龙卷基础体在 Blender 阶段已经通过规则条纹图检查过 UV 方向与分布，为后续颜色条/遮罩贴图进入 UE 做准备
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 | UV Editor | `Cylinder` 的 `UVMap` | 可见一块近似矩形 UV 岛，上面贴有横向黑白条纹，条纹均匀分布 | 用于检查 UV 在高度方向上的分布是否平整连续 |
> | 右侧 | 3D 视口 | `Cylinder` | 模型是上宽下宽、中间收腰的龙卷基础体，表面清晰显示一圈圈横向条纹 | 说明二维 UV 条纹已正确投射到三维模型表面 |
> | 右上 | Outliner | `Scene Collection` | 当前只选中 `Cylinder` | 表明这张补图仍聚焦同一个基础体 |
>
> 设置/参数:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `UV Pattern` | 横向黑白条纹 | UV Editor | 检查 UV 拉伸和环向分布是否均匀 |
> | `Object` | `Cylinder` | 视口与 Outliner | 作为龙卷基础网格 |
>
> 输出/观察:
> - 这张补图说明教程在最早阶段就用非常简单的黑白条纹验证过网格与 UV 的关系
> - 后面之所以能快速替换不同颜色卡和遮罩，本质上依赖的就是这里已经建立好的规整 UV 基础

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

