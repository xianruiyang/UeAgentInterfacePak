# 22冲击波Niagara粒子制作

# 22冲击波Niagara粒子制作

## 关键术语

- `Color`、`Alpha`、`Material`、`UV`、`Opacity`、`Texture`、`材质`、`粒子`、`渲染器`、`Niagara`、`Normalized Age`、`Renderer`、`纹理`、`系统`、`蓝图`、`生命周期`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:04:41 UV、材质、粒子

- 本段定位：UV、材质、粒子。
- 知识点：你好在22课上问候大家 上次我们制作了主材质和魔法阵材质 这次就让我们正式制作代表的粒子吧。
- 知识点：需要打开等级 设置过的赞助商和 打开赞助商 打开粒子也要看看吧 这里一个粒子里所有东西都可能制作出了。
- 知识点：这次 上次作为测试制作的部分 需要关闭它 还有光辉 我之前已经设置过了 但这部分只更换材质 就从这里开始 我们之前制作的加法 默认以 用这个创建一个实粒。
- 知识点：命名为 还需要再创建一个持有者吧 用PD3号 需要放进去 打开 需要更换纹粒 纹粒不是这个 但是这个会让光效变得很强 所以强度大约设置为50。
- 知识点：这个水材质 将放在这里 刚才的基础水材质适当 希望这个角色能适当显示出来 所以就这样做了 然后刚才 使用了那个水材质也没关系。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`渲染器`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> UE 初始关卡 `Untitled` 打开，Viewport 显示亮色地形/网格场景。Content Browser 位于 `/Content/Tutorial`，可见 `Level`、`Material`、`Particle`、`Sequencer` 文件夹；Outliner 中世界为 `Untitled (Editor)`，可见 `HLOD`、`Lighting`、`DirectionalLight`、`ExponentialHeightFog`、`SkyAtmosphere`、`SkyLight`、`SM_SkySphere`、`VolumetricCloud`、`Landscape`，底部显示约 `94 actors (73 loaded)`。字幕说明本课将正式制作冲击波粒子。该图记录 p22 的项目入口和制作主题。
> 图表转写（UE-GTXT v4）
> 关卡 `Ex_ShockWave_01` 中打开材质实例 `MI_AdditiveDe_01_Ins`。材质预览为强烈的粉红/白色发光球状纹理。参数面板可见 `Desaturation=0.0`、`Diff_Pow=1.0`、`Diff_Str=1.0`、`Fade_Dist=20.0`；`Global Texture Parameter Values` 中 `Diff_Tex` 指向一个粉白贴图，资源名显示为 `T_StretchSpa...`。Content Browser 位于 `/Content/Resource`，可见多个贴图资源，`A_Hit_new...` 一类贴图被选中；Sequencer `Ex_ShockWave_01` 在底部打开。该图记录准备替换 Glow/加法材质贴图，并把强度参数作为初始参考。
> 图表转写（UE-GTXT v4）
> Static Mesh 编辑器打开 `Cylinder_02`。Viewport 启用 UV/线框显示，画面中是矩形 UV 岛和竖向圆柱/圆盘网格预览。左上统计为 `LOD: 0`、`Current Screen Size: 0.928194`、`Triangles: 720`、`Vertices: 407`、`UV Channels: 2`、`Approx Size: 3.655 x 3.655 x 2.947`、`Num Collision Primitives: 0`、`Estimated Compressed Disk Size: 0.02 MB`。Details 中 `Material Slots` 只有 `Element 0`，材质为 `WorldGridMaterial`；`Nanite Support` 未启用，`LOD Auto`，`Number of LODs=1`。该图记录用于冲击波 Mesh 粒子的圆柱/圆盘网格资产、UV 和 LOD 信息。

### 00:04:43-00:09:42 网格、生命周期、速度

- 本段定位：网格、生命周期、速度。
- 知识点：位置是从0表示到1 这是这种网格 所以需要使用这个网 覆盖检查带加号标记 需要添加材料 上次时间做了这个网状材料 实例就是一个 做了1号曲。
- 知识点：1号曲,然后文件夹移动 我先把全部开着 目前我们现在 首先要做的是 这个用速度线上对齐 在这个视角中 看起来很自然 这个固体能量掉落的速度。
- 知识点：先验证效果爆发 当打到极限 刚根据固体掉落的速度 从这一部分开始纹理 到这里扩散的部分 制作一些张力感的平移 这个球体掉到地面 然后碰到这个角色。
- 知识点：这个角色就会释放出 放射状的能量 先简单设置一下生命周期和大小 生命周期要大概1.2 就是得考虑掉落时间到扩散 的时间 因为要思考这些 以及网格大小。
- 知识点：设置为均匀 这个大小应该合适 这里看啊 这个网格中心高度适当抬高 所以通过位置 气筒位置 适当降低音乐的音量 然后选择我们制作的材料 就这样出现了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`生命周期`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 中选中 `Empty002 / Mesh Renderer`。Particle Counts 显示 `Glow_01` 为 `[Active]`，`Empty` 与 `Empty001` 为 `[Disabled]`，`Empty002` 为 `[Active]` 但当前 `0 Current, 0 Max (est.)`。`Empty002` Stack 包含 `Emitter State(Self Once)`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Mesh Renderer`。Mesh Renderer 中 `Source Mode=Particles`、`Facing Mode=Default`、`Locked Axis Enable` 未勾选；Meshes 数组 `Index[0]=None`，`Enable Material Overrides` 未勾选，`Override Materials` 为 `0 Array elements`；`Sort Mode=None`，`Sort Only when Translucent` 勾选；Bindings 可见 `Position=PARTICLES Position`、`Color=PARTICLES Color`、`Velocity=PARTICLES Velocity`。该图记录新建 `Empty002` 后先选中 Mesh Renderer，但尚未指定网格和材质。
> 图表转写（UE-GTXT v4）
> `Empty002 / Initialize Particle` 选中。Point Attributes 中 `Lifetime Mode=Direct Set`、`Lifetime=1.2`，`Color Mode=Unset`，`Position Mode=Simulation Position`；Position Offset 显示 X/Y/Z 为 `0.0`。Sprite Attributes 中 Size/Rotation/UV 均为 `Unset`。Mesh Attributes 中 `Mesh Scale Mode=Uniform`，`Mesh Uniform Scale=0.5`，`Mesh Renderer Array Visibility Mode=Unset`。Preview 中出现一个灰色圆盘/圆柱形 Mesh，并带有竖向中心柱。该图记录 `Empty002` 的寿命和网格统一缩放设置。
> 图表转写（UE-GTXT v4）
> Texture 编辑器打开 `ramp_01`。预览为一条细长竖向渐变贴图，从底部白色过渡到上方黑色。Details 显示 `Imported: 64x1024`、`Displayed: 64x1024`、`Max In-Game: 64x1024`、`Resource Size: 52 KB`、`Has Alpha Channel: False`、`Format: DXT1`、`Number of Mips: 11`。`sRGB` 勾选；`X-axis Tiling Method=Wrap`，`Y-axis Tiling Method=Clamp`；`Brightness=1.0`、`Brightness Curve=1.0`、`Vibrance=0.0`。该图记录用于材质渐变/扩散的竖向 ramp 纹理设置。

### 00:09:44-00:14:13 颜色、纹理

- 本段定位：颜色、纹理。
- 知识点：这种细节也要始终不忽视 所以需要使用这个纹理 将玻璃纹理放入这个纹理 因为现在颜色太混了。
- 知识点：暂时只放接近白色的颜色 所以暂时只放接近白色的颜色 首先要看扩散器的磁转 好像得看看 2.5 做的适当短一些大约2.5 现在画笔太硬了。
- 知识点：这种感觉散开 因为湿针值还在调整中 暂时就是麦式 就是水彩的任何形式 大概这种感觉 太弱了需要适当提高一点 这里已经有一点 Ever。
- 知识点：Lanshan的纹理了 怪物设置值适当降低一点 颜色平铺设置在1左右 给个2.3左右 这里颜色部分我们看看。
- 知识点：颜色部分我们看看 我们最开始在这部分感觉到 能量球的某种颜色 黄色感觉的 颜色感觉有点 到最后变了 适当变成紫色 会有些变化 先保持一定的差异。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 材质实例 `MI_Mesh_01_Ins_01` 打开。预览为破碎的白黄/绿亮片。参数面板中可见 `Color_Tile_U=0.5`、`Color_Tile_V=0.5`、`ColorBias=1.0`、`Desaturation=0.0`、`Diff_Tile_U=0.75`、`Diff_Tile_V=1.0`、`Edge_Pow=1.0`、`Mask_Str=1.0`、`Normal_Tile_U=0.75`、`Normal_Tile_V=0.3`、`Opacity_Pow=1.0`、`Opacity_Str=20.0`、`RGB_Offset=0.01`。纹理参数显示 `Color_Tex=T_CloudScape_08_Details`，`Diff_Tex` 正在浏览到 `ramp_01`，`Normal_Tex=T_CloudScape_08_Details_N`，`Opacity_Tex=T_Beam_Gradient_02`。向量参数可见 `BottomColor` 为绿色 `(0,1,0,1)`，`TopColor` 为红色 `(1,0,0,...)`。该图记录先用 `ramp_01` 替换 Diff 纹理，并查看材质实例的基础颜色结果。
> 图表转写（UE-GTXT v4）
> `Empty002 / Dynamic Material Parameters` 选中。`Dynamic Parameter Index 0` 的 `Write Parameter Index 0` 已勾选；`Panning=Float from Curve`，曲线类型为 `Curve for Floats`，输入为 `PARTICLES NormalizedAge`，曲线从约 `1.5` 逐渐降到 `0`，`Scale Curve=1.0`。`Distortion=0.2`、`EdgeStr=0.0`、`ColorPow=0.0`；Index 1、Index 2、Index 3 的 `Write Parameter` 未勾选。左侧曲线编辑器显示同一条红色下降曲线。Particle Counts 中 `Glow_01` Active，`Empty` 和 `Empty001` Disabled，`Empty002` Active。该图记录主 Mesh 粒子的 Panning 先随生命周期下降，暂时关闭边缘和颜色强度。
> 图表转写（UE-GTXT v4）
> `MI_Mesh_01_Ins_01` 参数继续调整。预览为横向散开的破碎发光片，颜色偏黄绿并带紫色暗部。可见标量值：`Diff_Tile_U=1.0`、`Diff_Tile_V=1.5`、`Edge_Pow=5.0`、`Mask_Str=1.0`、`Normal_Tile_U=2.0`、`Normal_Tile_V=0.3`、`Opacity_Pow=1.0`、`Opacity_Str=2.0`、`RGB_Offset=0.005`。纹理参数为 `Color_Tex=T_Cloud_Wisp_Chromatic_Tile`、`Diff_Tex=ramp_01`、`Normal_Tex=T_CloudScape_08_Details_N`、`Opacity_Tex=T_Beam_Gradient_02`。向量参数中 `BottomColor=(0.5,0.0,1.0,1.0)`，`TopColor=(1.0,1.0,0.2,1.0)`。该图记录把主 Mesh 材质调成黄到紫的颜色变化，并降低透明度强度。

### 00:14:13-00:18:47 Texture、颜色

- 本段定位：Texture、颜色。
- 知识点：在水彩之中先调整成这样形状 现在是平移的感觉 和湿针的感觉 从内部分开始适当详细地 抓一下 我们来看角色部分 现在这个timing就完全不对吧。
- 知识点：这里中间部分 再加一个点 首先会减掉怪物的价钱 为了快速匹配 这里掉落的timing 在2.3的timing 以相似的感觉到达 但是tension有点。
- 知识点：需要进一步控制 这种方式 我们就看看吧 有什么正合适吧 这个手柄的区别非常大吧 刚才在0.3左右的timing 对位置进行panning重要。
- 知识点：这个线性的图和 这个能量球 与texture panning的那条线 要自然地结合 这个timing应该正合适吧 而且外观的形状也不错吧。
- 知识点：湿针在最初对这个珠子起作用时 即使弱也没关系 所以一开始决定设定为0.1 之后会逐渐提高怪物的价值 这到达0.3的时候 从0.4开始就提高外公的值。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Texture`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Empty002 / Dynamic Material Parameters` 仍选中，Preview 中 Mesh 粒子呈白色花瓣状扩散。`Panning=Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线从约 `1.5` 下降到接近 `0`；`Distortion=0.2`、`EdgeStr=1.0`、`ColorPow=1.0`。左侧曲线编辑器显示 `Index 0 Param 1` 的下降曲线。Particle Counts 显示 `Glow_01` Active、`Empty` Disabled、`Empty001` Disabled、`Empty002` Active。字幕说明正在调平移与失真感觉。该图记录在 Panning 曲线基础上打开边缘强度和颜色强度。
> 图表转写（UE-GTXT v4）
> 关卡 `Ex_ShockWave_01` 处于 `[Pilot Active - Cine Camera Actor]`，Viewport 中角色站在网格地面上，当前看不到明显冲击波主体。Outliner 可见 `Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`Shock Wve 01` 等对象；Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见 `MI_Additive...` 与 `MI_Mesh_01_Ins_01`，`MI_Additive...` 被选中。底部 Sequencer 显示当前约在 `0065` 帧，Niagara 窗口的 Particle Counts 中 `Empty002` 为 Inactive。该图用于在 Sequencer 相机视角中检查冲击波 Mesh 粒子的出现时机。
> 图表转写（UE-GTXT v4）
> `Empty002 / Scale Color` 选中。`Scale Mode=RGB and Alpha Separately`；`Scale RGB=Vector from Curve`，曲线输入为 `PARTICLES NormalizedAge`，当前 Scale Curve X/Y/Z 均显示 `1.0`，RGB 三条曲线随生命周期下降；`Scale Alpha=Float from Curve`，同样由 `PARTICLES NormalizedAge` 驱动并从高值逐渐降到接近 0。Particle Counts 显示 `Glow_01` Complete，`Empty` 与 `Empty001` Disabled，`Empty002` Inactive。该图记录主 Mesh 粒子颜色与 Alpha 开始按生命周期衰减。

### 00:18:49-00:23:43 颜色、纹理

- 本段定位：颜色、纹理。
- 知识点：反而这样适当溢出掉落的感觉 更好 那正好是更合适的时机 颜色的部分需要看 一开始适当有点 黄色的感觉 适当紫色的颜色我试试看。
- 知识点：二通道 这个值在0.35 设置值 绿通道是0.5 0.5左右 0.2左右 这个通道 反方向从0.2开始 应该是现在从黄色开始 眼睛逐渐变 就这样感觉进行吧。
- 知识点：需要再往前拉一下时机 下落时 迅速变为紫色 把这里这样调整好 α值先放着 然后再变 我们现在看到 下落时扩散 整体上亮度太弱了 力量显得有点弱。
- 知识点：应该是最强的要素 所以边缘部分 做成曲线 把这个值适当给强一点 然后逐渐变弱 需要有调解 但如果开始太强的话 会有些负担 适当快一点减少 与完全消失相比。
- 知识点：适当 留一点边缘 这个程度我觉得可以 这个程度 做完后再看看 具体到也有点色调变得平淡吧 刚才是那个色调差异有点大 适当消失 有点顺滑的感觉。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Empty002 / Dynamic Material Parameters` 中，`Panning=Float from Curve` 的曲线从约 `1.5` 分段下降到接近 `0`，输入为 `PARTICLES NormalizedAge`。`Distortion` 也改为 `Float from Curve`，曲线从低值逐步上升，画面 Key Data 显示当前点约为 `Time=0.4`、`Value=0.1`；`EdgeStr=1.0`、`ColorPow=1.0`。Preview 中主 Mesh 粒子为白色小型破碎花瓣状。该图记录 Panning 与 Distortion 分别用生命周期曲线控制：一个下降，一个逐步增强。
> 图表转写（UE-GTXT v4）
> `Empty002 / Dynamic Material Parameters` 继续展开。`Panning` 和 `Distortion` 均为 `Float from Curve`；`EdgeStr` 也改为 `Float from Curve`，左侧曲线编辑器提示当前点 `Time=0`、`Value=50`，曲线随后快速下降到低值。`ColorPow` 保持 `1.0`。Preview 中粒子呈暗紫色圆环/花瓣状扩散。Particle Counts 显示 `Glow_01` Complete，`Empty` 与 `Empty001` Disabled，`Empty002` Inactive。字幕说明如果开始太强会有负担。该图记录边缘强度用高初值快速衰减曲线处理。
> 图表转写（UE-GTXT v4）
> `Empty002 / Scale Color` 选中。`Scale RGB=Vector from Curve`，输入为 `PARTICLES NormalizedAge`；RGB 曲线中红色在前段快速下降后保持低值，绿色保持较低并略下降，蓝色在中段升高后保持高值，当前 X/Y/Z 数值栏均显示 `1.0`。`Scale Alpha=Float from Curve`，Alpha 在起始短时间内升到约 `1.0`，随后逐渐下降到接近 `0`。Particle Counts 显示 `Glow_01` Complete，`Empty` 与 `Empty001` Disabled，`Empty002` Complete。字幕说明先控制主线的移动。该图记录主 Mesh 粒子从偏黄/红过渡到偏蓝紫，并用 Alpha 曲线淡出。

### 00:23:43-00:28:39 Alpha、材质、精灵

- 本段定位：Alpha、材质、精灵。
- 知识点：结束一下 接下来在精灵爆炸中 这里有个黑调在品牌中 这个我之前都使用过 再加一个黑调试试 这个用鉛笔来制作 保存一次 我现在没有提到中间的保存。
- 知识点：请记得一定要保存 如果一直重复同样的事情 会变得无聊 本地检查一下 你自己做一下 一次结束 大部分做好了 生命周期。
- 知识点：0.7程度 现在下来之前先产生 延迟 点0点 在下降的时机 差不多对的时候产生 然后名字取为 黑色 接下来大小是350 程度 然后它现在是精灵 相机对焦了。
- 知识点：但是这要改为自定义 使用自定义对焦相量 在这里 对焦精灵 对焦对焦 就可以使其具有固定的真值 所以在C轴方向 观看 会看向天空 在地面这样 以基准感觉铺设。
- 知识点：这样就可以 所以就这样使用 但是因为要和地面适当分开 用相机偏移 大约拉10 因为地面部分需要有一点空间 先找一下材质。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`纹理`、`生命周期`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> UE 关卡 `Ex_ShockWave_01` 处于 `[Pilot Active - Cine Camera Actor]` 相机视图，场景为暗色棋盘地面与角色。右侧 Outliner 可见 `Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`Shock Wve 01`。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，选中 `MI_Additive...`，旁边可见 `MI_Mesh_01_Ins_01` 等材质实例。画面下方 Niagara 窗口显示 `ShockWve_01`，粒子计数中 `Glow_01 Complete`、`Empty Disabled`、`Empty001 Disabled`、`Empty002 Complete`；当前选中 `Empty002 / Dynamic Material Parameters`，Sequencer 时间约在 `0068`。该图记录完成上一层 Mesh 粒子后回到关卡与材质目录，准备加入黑色精灵爆炸层。
> 图表转写（UE-GTXT v4）
> Niagara 系统 `ShockWve_01` 中新增并选中 `Black_01 / Initialize Particle`。粒子计数显示 `Black_01 Complete`，同时 `Glow_01 Complete`、`Empty002 Complete`，`Empty` 与 `Empty001` 禁用。`Black_01` Stack 可见 `Emitter State Self Once`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Sprite Facing and Alignment`、`Particle State`、`Sprite Renderer`。`Initialize Particle` 参数中 `Lifetime Mode=Direct Set`、`Lifetime=0.7`，`Color Mode=Unset`，`Position Mode=Simulation Position` 且 Position Offset 三轴为 `0`；`Sprite Size Mode=Uniform`，`Uniform Sprite Size=350.0`，Sprite Rotation/UV、Mesh、Ribbon 属性均保持未设置状态。该图记录黑色精灵层的生命周期和初始尺寸。
> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 选中 `Black_01 / Sprite Renderer`。Stack 中 `Black_01` 包含 `Initialize Particle`、`Sprite Facing and Alignment`、`Camera Offset`、`Particle State`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer`。Renderer 绑定中 `Sprite Size Binding=PARTICLES SpriteSize`、`Sprite Facing Binding=PARTICLES SpriteFacing`、`Sprite Alignment Binding=PARTICLES SpriteAlignment`、`Sub Image Index Binding=PARTICLES SubImageIndex`、`Dynamic Material Binding=PARTICLES DynamicMaterialParameter`，Dynamic Material 1/2/3 分别绑定到对应粒子参数，`Camera Offset Binding=PARTICLES CameraOffset`，`Custom Sorting Binding=PARTICLES NormalizedAge`，`Normalized Age Binding=PARTICLES NormalizedAge`，`Renderer Visibility Tag Binding=PARTICLES VisibilityTag`，`Renderer Enabled Binding=None`。Cutout 区域中 `Use Material Cutout Texture` 未勾选，`Opacity Source Mode=OSM Alpha`，`Alpha Threshold=0.1`。该图记录精灵渲染器依赖粒子属性驱动朝向、偏移、透明度和排序。

### 00:28:41-00:33:32 颜色、透明度、纹理

- 本段定位：颜色、透明度、纹理。
- 知识点：适当慢慢消失 这个现在调整大小 缩放大小 用这个 刚开始 0值适当太小了 到大约4 填充分 现在的单点太强了 会适当降低1值 其实太黑出来。
- 知识点：那又会很刺眼 我就总是要抓住眼刺的部分 这个曲线 适当晃动一点 适当一点 首先这个尺寸应该差不多可以了 反正这里会额外 再加一个侧边色调 所以我加了一次平面色。
- 知识点：现在出现了呢 好像与刚才的某种颜色 感觉更 突出地显现出来 那么 再保存一次 然后需要加一个 来支持这个的辅助元素吧 我先改一下名字 需要把这个名字定为Hash1。
- 知识点：复制证据来使用 复制 再进行周 需要再创建一个材料了 然后再放进去 需要打开它 因为可能会有这个bug 所以先关掉一次 请再次进行合成 首先看看这个材料是否正确。
- 知识点：调解 需要验证效果这个纹理 看起来是正确的 因为纹理太尖锐了 正在出现 但现在的平移值 似乎不一样 看起来不要太快 我们先调整这个 再看看那么纹理。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `ShockWve_01` 中选中 `Black_01 / Particle State`。预览窗口里出现暗紫色黑心环形爆发层，与既有冲击波层叠加。粒子计数显示 `Glow_01 Active`、`Empty002 Active`、`Black_01 Active`，`Empty` 与 `Empty001` 禁用。`Black_01` Stack 包含 `Initialize Particle`、`Sprite Facing and Alignment`、`Camera Offset`、`Particle State`、`Scale Color`、`Sprite Renderer`；`Particle State` 面板可见按生命周期结束杀死粒子的选项已启用。Timeline 中 `Black_01` 轨道位于约 `0.94` 的预览时刻。该图记录黑色精灵层被激活后，使用生命周期终止规则控制消失。
> 图表转写（UE-GTXT v4）
> Niagara 系统中选中复制后的 `CoreMesh_01001 / Mesh Renderer`。System Overview 中可见 `CoreMesh_01`、`CoreMesh_01001`、`Glow_01`、`Black_01` 等发射器；粒子计数中 `CoreMesh_01 Complete`、`Black_01 Complete`、`CoreMesh_01001 Complete`。Mesh Renderer 设置为 `Source Mode=Particles`、`Facing Mode=Default`，Meshes 的 `Index[0]=Cylinder_02`；`Enable Material Overrides` 已勾选，Override Materials 的 `Index[0]` 使用 `Explicit Mat=MI_Mesh_01_Ins_01`，`Sort Mode=None`，`Sort Only when Translucent` 已勾选。Sub Image Size 为 `1,1`。该图记录为侧边/辅助色调复制核心 Mesh 层，并继续沿用圆柱网格和材质覆盖。
> 图表转写（UE-GTXT v4）
> 选中 `CoreMesh_01001 / Dynamic Material Parameters`，顶部标签同时可见 `MI_Mesh_01_Ins_02`。预览窗口中暗紫色环形/花瓣状冲击波正在播放；粒子计数显示 `Glow_01 Active`、`CoreMesh_01 Active`、`Black_01 Active`、`CoreMesh_01001 Active`。动态参数 `Panning` 使用 `Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线从较高值向 `0` 降低；`Distortion` 使用 `Float from Curve`，曲线随归一化年龄上升；`EdgeStr` 使用 `Float from Curve`，曲线从约 `50` 降向较低值。该图记录复制材质层的平移、扭曲和边缘强度曲线。

### 00:33:32-00:38:06 生命周期、速度、颜色

- 本段定位：生命周期、速度、颜色。
- 知识点：元素其实在柱子上的表现似乎不需要 所以 Panning部分 再一次预先调校一下 我觉得可以 最好 首先找一下这个Panning的大致位置。
- 知识点：0.5看不见 这个值还是从柱子出来的 得去复制 在-0.5这个位置 那么通过增加一点 从-0.5开始 到-1.5左右 这可能是因为非常快的原因。
- 知识点：这种感觉 速度大致合适 那么在这里调整一下素材的音调 让它更明显 功率值不能太强 引导可能可以 扩大范围让它更明显 颜色稍后再处理。
- 知识点：比之前好很多 这种感觉 再多摸一下 如果太快太累 似乎有点不太合适 自然地 略微一点 这个也会提前出现吧 需要减少延迟 大约0.2 现在感觉有点匹配。
- 知识点：再适当调整一下时机 或者这个朋友也可以适当大一点 在布置这种次要元素时 大约0.3 需要觉得适当减少生命周期。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 仍选中 `CoreMesh_01001 / Dynamic Material Parameters`。预览窗口在早期时间出现明亮白黄竖向能量形态，并叠加暗色扩散层；粒子计数中 `Glow_01`、`CoreMesh_01`、`Black_01`、`CoreMesh_01001` 均为 `Active`。右侧参数继续显示 `Panning`、`Distortion`、`EdgeStr` 三组 `Float from Curve`，其中 `Panning` 为下降趋势，`Distortion` 为上升趋势，`EdgeStr` 为高到低。Timeline 当前靠近起始段。该图记录在较早播放时刻检查复制 Mesh 层的速度、亮度和纹理移动结果。
> 图表转写（UE-GTXT v4）
> `CoreMesh_01001 / Dynamic Material Parameters` 的曲线编辑器聚焦到 `Index 0 Param 1`，左下曲线提示显示 `FloatCurve Time: 0.1 Value: -0.673`。右侧 `Panning` 使用 `Float from Curve`，Key Data 中可见起始值约为 `-0.5`，曲线整体位于负值区域并向更低值过渡；`Distortion` 曲线保持随时间上升，`EdgeStr` 继续从高值降低。预览中紫粉/白色冲击波环形形态更明显。该图记录将 Panning 从约 `-0.5` 推向更快的负向平移区间，以调节纹理流动速度。
> 图表转写（UE-GTXT v4）
> 曲线编辑器切到 `Index 0 Param 2`，提示可见 `Time: 0.4 Value: 0.1`。右侧 `Distortion` 的 `Float from Curve` 仍以 `PARTICLES NormalizedAge` 为输入，Key Data 中末端可见 `Time=1.0`、`Value=0.3`，曲线从低值上升到约 `0.3` 后保持较缓变化；下方 `EdgeStr` 保持高到低的曲线。预览中紫粉/白色冲击波保持可见，边缘起伏比前一张更稳定。该图记录在 Panning 之后继续调节扭曲强度，让次要 Mesh 层的扩散不至于过强。

### 00:38:06-00:43:01 Alpha、材质、颜色

- 本段定位：Alpha、材质、颜色。
- 知识点：音曲线变动非常大 这个程度 确实,因为这个亮度 饱和度似乎有点不足 颜色部分还没调整好 张力感适当匹配的感觉 这个色调 这个颜色的色调。
- 知识点：似乎还有点不足 所以颜色部分适当调一下 先看看Alpha部分 Alpha是一个 这个部分减少了很多 这一部分就是 简单的线性处理 缩放颜色。
- 知识点：用色彩的方式看看 这一部分的情况 开始时也一样 有黄色的混合感觉 现在有点扩散 饰饱和度似乎太高了 所以 适当调整一下色调 一开始适当比黄色亮一点。
- 知识点：适当带点粉色出来 现在在7号的最后消失时 饱和度很高 适当提高比例适当降低饱和度 这样感觉应该还不错 我们来看一下 确实感觉调整了一下 但我觉得这里中间色调。
- 知识点：应该再有一个混合 所以会尝试增加内部分 在添加中间色调之前 这里的颜色只要适当 降低饱和度 适当降低 感觉有点太蓝了 这程度上好像可以了 一点风扇看起来快了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `CoreMesh_01001 / Dynamic Material Parameters` 仍被选中，预览左侧显示明亮白橙竖向能量带。曲线编辑器聚焦 `Index 0 Param 3`，右侧动态参数中 `Panning` 起始 Key Data 可见 `0.0 / -0.5`；`Distortion` 末端 Key Data 可见 `1.0 / 0.3`；`EdgeStr` 使用 `Float from Curve`，曲线从约 `50` 降至低值。左侧曲线区选中点的数值框显示约 `0.5`，用于调整当前参数强度。该图记录材质动态参数在进入颜色/Alpha 调整前的最终大幅曲线校正。
> 图表转写（UE-GTXT v4）
> 选中 `CoreMesh_01001 / Scale Color`。`Scale Mode=RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，曲线输入为 `PARTICLES NormalizedAge`；可见红、绿、蓝三条曲线，其中红色曲线从高值下降，绿色曲线降到约 `0.5` 附近，蓝色曲线接近 `1` 并较平。下方 `Scale Alpha` 使用 `Float from Curve`，曲线先快速升至接近 `1`，随后线性下降到接近 `0`。左下曲线提示显示 `Name: Z Time: 0.5 Value: 1`。该图记录通过 RGB 与 Alpha 分离曲线降低饱和度、控制中后段透明度。
> 图表转写（UE-GTXT v4）
> `ShockWve_01` System Overview 中新增 `Glow_02` 发射器；粒子计数显示 `Glow_01 Active`、`CoreMesh_01 Active`、`Black_01 Active`、`CoreMesh_01001 Active`、`Glow_02 Active`。选中的 `CoreMesh_01001 / Mesh Renderer` 绑定列表显示 `Position Binding=PARTICLES Position`、`Color Binding=PARTICLES Color`、`Velocity Binding=PARTICLES Velocity`、`Mesh Orientation Binding=PARTICLES MeshOrientation`、`Scale Binding=PARTICLES Scale`、`Dynamic Material Binding=PARTICLES DynamicMaterialParameter`，Dynamic Material 1/2/3 对应绑定到粒子动态材质参数，`Custom Sorting Binding=PARTICLES NormalizedAge`，`Normalized Age Binding=PARTICLES NormalizedAge`，`Camera Offset Binding=PARTICLES CameraOffset`，`Renderer Visibility Tag Binding=PARTICLES VisibilityTag`，`Renderer Enabled Binding=None`。`Sort Order Hint=15`，Motion Vector 为 `Auto Detect`。该图记录新增发光辅助层后，核心 Mesh 渲染器仍按粒子属性驱动材质与排序。

### 00:43:01-00:47:49 Alpha、材质、颜色

- 本段定位：Alpha、材质、颜色。
- 知识点：感觉会更柔和一些 那么接下来 后续会复制刚刚制作的 水材质来用 生成了2号 用0.2号 然后放在这里 打开纹理。
- 知识点：使用这个纹理来进行混合 需要作为基础 颜色强度使用 现在是加法 所以可能没出来 现在出来了 很好出来延迟 也就一样去 我适当减少一下我的角色。
- 知识点：只给出混合的感觉 快速消失会更好 所以 比起黑色这样适当上升一点 这个程度 再往前拉一点 把大小适当减少一点 毕竟 位置在这里中间 然后就会给出某种感觉。
- 知识点：大小也再适当减少一点 颜色是最重要的 必须是 能补充中间值的颜色值 用曲线 制作出这里的某些重要元素的变化 而且 这样把这个值 设为一值重新。
- 知识点：根据Alpha来使用 这一部分可能还需要 做的更多 大约10吗?那就掉到10左右 和这个 相同的数字 颜色值图表看一下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`纹理`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `ShockWve_01` 中 `CoreMesh_01001` 仍被选中，Preview 显示紫色黑心环形冲击波，边缘带白紫色火焰状扩散。System Overview 中可见 `CoreMesh_01`、`CoreMesh_01001`、`Glow_01`、`Glow_02`、`Black_01`。粒子计数显示五个主要发射器均为 `Active`。右侧仍是 Mesh Renderer 的 Bindings 区域，保留 Dynamic Material 与 NormalizedAge 等绑定；字幕提示“这个水材质也得制作”。该图记录在已有层级上继续制作/复制水感材质，用于补充中间混合色。
> 图表转写（UE-GTXT v4）
> 选中新增的 `Glow_02 / Scale Color`。`Scale Mode=RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，红、绿、蓝曲线从接近 `1` 的值向较低值下降，输入为 `PARTICLES NormalizedAge`；`Scale Alpha` 使用 `Float from Curve`，曲线先维持较高透明度权重，然后随归一化年龄下降。预览中紫粉色环形扩散层更柔和，中心保持暗色。System Overview 中 `Glow_02` 位于 `Glow_01` 与 `Black_01` 之间，表示新增发光混合层。字幕提示“根据 alpha 来使用”。该图记录 Glow_02 通过颜色曲线和 Alpha 曲线参与中间色混合，而不是单独作为强亮主体。
> 图表转写（UE-GTXT v4）
> 回到关卡 `Ex_ShockWave_01` 的 `[Pilot Active - Cine Camera Actor]` 视图，角色站在暗色棋盘地面中央，当前画面中冲击波核心元素已经消失或接近消失。右侧 Outliner 可见 `Lighting` 文件夹、`DirectionalLight`、`ExponentialHeightFog`、`SM_SkySphere`、`Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`Shock Wve 01`。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见并选中 `MI_Additive...`，旁边还有另一个环形 `MI_Additive...`、白色圆形材质和 `MI_Mesh_01_Ins_01/02`。下方缩小的 Niagara 窗口仍显示 `ShockWve_01` 与多发射器粒子计数。字幕提示“现在这里核心元素消失时”。该图记录回到关卡相机检查核心元素消失时机和材质实例准备状态。

### 00:47:49-00:50:17 关键流程 11

- 本段定位：关键流程 11。
- 知识点：和谐感更像渐变一样 瞬间浮现的感觉 这种部分和这里外圈部分之后 也会有魔法阵原型 所以可以用它来 一定程度的混合 现在就那样的作用 觉得也不错。
- 知识点：尺寸适当大一点也觉得没问题 这里有扇子掉落有什么 这种波动线的感觉 也觉得不错 还有某种张力 看起来不算差 没用太多元素吧 除了黑色这些。
- 知识点：大概用了大概三个左右的话 表现的还挺柔和的 那么接下来这里要填充 外圈的魔法阵设计 和中间适当填充一点空间 不要太重的亮度 这些也不要太沉重。
- 知识点：只适当添加边缘中心的细节 感觉不错 那么将从魔法缘开始添加细节元素 将GlowR复制 使用比较好 最后魔法圈 需要用这个圈 希望能看得清楚 这个所以适当往前移一点。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 关卡 `Ex_ShockWave_01` 的 `[Pilot Active - Cine Camera Actor]` 视图显示角色周围的紫色外圈冲击波：外缘为不规则紫白亮边，中心较暗，外围还有若干淡紫色拖尾。右侧 Outliner 可见 `Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`Shock Wve 01`。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见 `MI_MagicCircle_01`、多个 `MI_Additive...` 和 `MI_Mesh_01_Ins_01/02`。下方缩小的 Niagara 窗口仍打开 `ShockWve_01`。该图记录进入外圈魔法阵/中心填充前的关卡预览效果。
> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 选中 `Glow_02 / Scale Sprite Size`。System Overview 中可见 `CoreMesh_01`、`CoreMesh_01001`、`Glow_01`、`Glow_02`、`Black_01`；左侧 Timeline 选中 `Glow_02` 轨道。右侧 `Scale Sprite Size Mode=Uniform Curve`，`Uniform Curve Sprite Scale` 使用 `Curve for Floats`，输入为 `PARTICLES NormalizedAge`，曲线从低值逐步上升，Key Data 末端可见 `Time=1.0`、`Value=3.75`。粒子计数显示主要层均为 `Active`。该图记录 Glow_02 的尺寸随生命周期增大，用于让外圈混合层更柔和。
> 图表转写（UE-GTXT v4）
> `ShockWve_01` 中新增并选中 `MagicCircle_01` 发射器。粒子计数显示 `MagicCircle_01 Active`，同时 `Glow_02 Active`、`Black_01 Active`、`CoreMesh_01001 Active`。`MagicCircle_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Sprite Facing and Alignment`、`Camera Offset`、`Particle State`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer`。右侧 `Emitter State` 中 `Life Cycle Mode=Self`、`Inactive Response=Complete (Let Particles Finish then Kill)`、`Loop Behavior=Once`、`Loop Duration Mode=Fixed`、`Loop Duration=1.0`、`Loop Delay=0.2`。该图记录复制/新增魔法阵层，并设置一次性播放和延迟。

### 00:50:23-00:55:20 Material、材质、精灵

- 本段定位：Material、材质、精灵。
- 知识点：循环延迟器适当再慢一排 这样出声 生命周期大约一秒 慢慢消失 首先需要换一下材质 这里有什么呢 简单往这边移动 放进去 现在好像没有动态 所以这样暂时删掉精灵大小反正。
- 知识点：因为不需要意识咖啡大小 这里暂时加上动态 就出来了 大小好像要大很多 这个因为得和网格大小对齐 这样 要大很多 这里是Material。
- 知识点：那是Blend模式 适当需要修正一下 将使用加法 在外侧最外圆的感觉 因为就会使用这个 所以降低到 这个程度 现在适当整理一下边缘 然后 纹理将使用这个纹理。
- 知识点：而不是这个颜色平谱 要多给一点吧 设为3 其余的设为-2 适当增强冷静感 闪闪发光的感觉 保持住 在这里应该 将保存 Material似乎就这样可以了。
- 知识点：材料适当关掉 这样出现 现在平移值没有进入 魔法阵已经进入 所以我适当缩小这个大小 感觉魔法阵的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`材质`、`纹理`、`生命周期`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 打开材质 `M_MagicCircle_01` 的 Material Graph。图中左侧有贴图坐标/参数节点，连到三组 Texture Sample；可见贴图采样预览均为灰白魔法阵纹理。多条 UV/参数线汇入 `Multiply` 节点，再接到右侧输出链，包含 `Desaturation`、`Power` 与最终材质输出节点。Details 中选中 Texture Sample，`MipValueMode=MipLevel (absolute, 0 is full resolution)`，纹理参数名为 `Color_Tex`，资源显示 `T_CloudScape_00_Details`。Stats 面板显示 `Texture samplers: 4/16`、`Texture Lookups ...`、`User interpolators ...`、`Shader Count: 2`。该图记录魔法阵材质的贴图采样与输出结构。
> 图表转写（UE-GTXT v4）
> `MagicCircle_01 / Emitter State` 被选中，Preview 中中心位置出现很暗的魔法阵纹理。System Overview 显示 `MagicCircle_01` 与 `Glow_02`、`Black_01`、`CoreMesh_01001` 等层叠存在。右侧 Emitter State 参数保持 `Loop Behavior=Once`、`Loop Duration=1.0`、`Loop Delay=0.2`；粒子计数显示 `MagicCircle_01 Active`。Timeline 中 `MagicCircle_01` 轨道位于约 `1.04` 的播放时刻。该图记录魔法阵层在 Niagara 中已经生成，但亮度/材质动态仍需继续调整。
> 图表转写（UE-GTXT v4）
> 选中 `MagicCircle_01 / Dynamic Material Parameters`。Preview 中中心魔法阵清晰可见，外圈仍有淡紫色冲击波。右侧 `Dynamic Parameter Index 0` 勾选 `Write Parameter Index 0`，`Panning` 使用 `Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线从约 `0.8` 附近轻微变化；Key Data 可见 `Time=0.0`、`Value=0.8`。`Param1-0`、`Param2-0`、`Param3-0` 均显示 `0.0`，其余 Dynamic Parameter Index 1/2/3 未展开或未写入。左下曲线编辑器显示 `Scale Color` 的 RGB/Alpha 曲线，同时字幕提示将最后的值平移到约 `0.5`。该图记录魔法阵材质的 Panning 动态参数和颜色曲线联调。

### 00:55:20-01:00:00 Alpha、网格、颜色

- 本段定位：Alpha、网格、颜色。
- 知识点：目标是就是这种感觉 完全是直接经过的状态 适当更多 到最后就让它像命一样 直接经过的感觉 所以应该调整一下张力 现在总觉得有些慢 所以虽然慢了一步。
- 知识点：这样做之后 好了现在时机似乎不错 我觉得应该看看颜色值 接下来parameter 是在multi-rally只给了 timing值。
- 知识点：调平只需对准颜色 现在这个的颜色 复制过来后有点太饱和了 所以这个部分 暂时恢复为默认 颜色似乎不必给出变化值。
- 知识点：只是无论如何 因为会回归一些设计感的感觉 这种感觉会有 这里的颜色也 这似乎是修改为 一指的但变成了0.8 需要把它改为一指 glow部分。
- 知识点：这也出现一指 alpha是开始的时候想 遮住那部分一点 0.1时机会变为 适当一点进mhk lost stage 有点慢似乎留下了什么 适当跨点消失。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `MagicCircle_01 / Dynamic Material Parameters` 继续显示，Preview 中魔法阵位于明亮粉白冲击波中心，外围有柔和扩散层。`Panning` 的 `Float from Curve` 仍以 `PARTICLES NormalizedAge` 为输入，曲线从约 `0.8` 向较低值下降；左下 `Scale Color` 曲线中 `Scale RGB` 的选中点约为 `0.8`。粒子计数显示 `MagicCircle_01 Active`，同时 `Glow_02`、`Black_01`、`CoreMesh_01001` 等层有效。该图记录在看到目标效果后，继续对魔法阵颜色和透明度曲线做降低处理。
> 图表转写（UE-GTXT v4）
> 选中 `MagicCircle_01 / Scale Color`。右侧 `Scale Mode=RGB and Alpha Separately`，`Scale RGB` 勾选并显示常量 `X=1.0`、`Y=1.0`、`Z=3.0`；`Scale Alpha` 使用 `Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线先从 `0` 附近快速升至 `1`，在中段保持高值，末端降到约 `0.8`。左下曲线编辑器与右侧曲线一致。Preview 中中心魔法阵与亮色冲击波叠加。该图记录魔法阵颜色强度和 Alpha 曲线的主要设置。
> 图表转写（UE-GTXT v4）
> 选中 `SubMesh_01 / Mesh Renderer`，System Overview 中新增 `CoreMesh_02` 与 `SubMesh_01`，并保留 `MagicCircle_01`、`Glow_02`、`Black_01` 等层。Preview 显示暗紫外圈与中心小片状细节。Mesh Renderer 设置为 `Source Mode=Particles`、`Facing Mode=Default`，Meshes 的 `Index[0]=Cylinder_02`；`Enable Material Overrides` 已勾选，Override Materials 的 `Explicit Mat=MI_Mesh_01_Ins_02`，`Sort Mode=None`，`Sort Only when Translucent` 已勾选。Content Browser 位于 `/Content/Resource`，选中 `Cylinder_02`，周围可见魔法阵、圆环、法线、噪声和线条贴图。该图记录新增细节网格层并指定圆柱网格与材质实例。

### 01:00:00-01:04:55 颜色、纹理

- 本段定位：颜色、纹理。
- 知识点：有个地方但现在似乎不太出来 可能是因为 如果是远程的远程 大概可以维持在0.2 寿命也大概是0.7 尺寸 朋友是这种碗一样 圆形的形状 所以需要调整为非均匀。
- 知识点：在此之前 一次圆了 这个非常大的愿望 所以打开时可能看不见 但往后拉就能看到 在这里这部分是外圈 现在是0号 越往中心越是一直的部分 这种感觉。
- 知识点：这种笔之所以看不见 我认为是 一围双面 先复制一个马达重新放进去 放到3号 检查双面 可观察到把这样聚集的 就是现在这个麦特 这种感觉可以做得非常实用。
- 知识点：非常好 所以这一部分 就只是我们以前用的那个 这个是我们做追踪器中心 接下来这个形状的这个部分 有点 既然成为了笔 感觉可以改一下纹理。
- 知识点：纹理就用这个吧 反正只是适当增加点细节 其他的纹理 应该也可以不改 眼色值就普通的使用比亚丝 现在的平铺值大概是3值到2 然后出来的感觉就是。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `SubMesh_01 / Dynamic Material Parameters`。System Overview 中 `CoreMesh_02`、`SubMesh_01`、`MagicCircle_01` 与 `Glow_02/Black_01` 层同时存在。右侧 `Panning` 使用 `Float from Curve`，曲线在负值区间由约 `-0.6` 向约 `-1.4` 下降；`Distortion` 使用 `Float from Curve`，曲线从约 `0.1` 上升到约 `0.25-0.3`；`EdgeStr` 使用 `Float from Curve`，曲线从高值逐步下降。Timeline 选中 `SubMesh_01`，当前时间约 `0.34`。该图记录细节网格层的平移、扭曲和边缘强度动态参数。
> 图表转写（UE-GTXT v4）
> 打开材质实例 `MI_Mesh_01_Ins_03`。右侧参数面板显示 `ColorBias=2.0`、`Desaturation=0.0`、`Diff_Tile_U=3.0`、`Diff_Tile_V=2.0`、`Edge_Pow=1.0`、`Mask_Str=1.0`、`Normal_Tile_U=2.0`、`Normal_Tile_V=0.3`、`Opacity_Pow=0.5`、`Opacity_Str=5.0`、`RGB_Offset=0.005`。纹理参数中 `Color_Tex=T_Cloud_Wisp_Chromatic_Tile`，`Diff_Tex=Eff_Wave01_01_ClampV_SQ_Tex`，`Normal_Tex=T_CloudScape_00_Details_N`，`Opacity_Tex=T_Beam_Gradient_02`。向量参数中 `BottomColor` 为紫色，`TopColor` 为浅黄色；Parent 为 `M_Mesh_01`，Blend Mode 可见为 `Additive`，Shading Model 为 `Unlit`。该图记录第三个 Mesh 材质实例的纹理、颜色和透明度参数。
> 图表转写（UE-GTXT v4）
> 选中 `SubMesh_01 / Initialize Particle`。右侧 `Lifetime Mode=Direct Set`，`Lifetime=0.7`；`Color Mode=Unset`；`Position Mode=Simulation Position`，Position Offset 三项为 `0.0`；`Mesh Scale Mode=Non-Uniform`，Mesh Scale 为 `X=0.4`、`Y=0.4`、`Z=0.2`。Sprite 与 Ribbon 属性保持 Unset。Preview 中明亮中心外侧出现若干粉紫色片状细节，粒子计数显示 `SubMesh_01 Active`。该图记录将细节 Mesh 改为非均匀尺寸，并降低竖向厚度值。

### 01:04:55-01:09:46 Alpha、网格、颜色

- 本段定位：Alpha、网格、颜色。
- 知识点：我们再看看动态 Pen的值 这里再擦掉一次 找一下位置 在0值这里位置 那么是0.1 似乎不需要太大的Pen宽度 实际上就像细节那样一点点。
- 知识点：因为会添加 从0.1开始 相反现在要传播 所以就这种感觉传播 似乎设定得太快了 张力有点 这里适当慢慢地变 这样想一想 接着 外国的值 现在包含了在0.1。
- 知识点：0.3之间 但似乎不需要太强 在这里我们先看看 最初从0值开始 适当拖延时间 比起直接太强 就选择平稳 以更新的感觉前进 只是适当帮助一下 喷发的感觉。
- 知识点：后续会尝试这样做 而且现在完全看不清楚 感觉边缘的强度 要适当高一点 就像瞬间擦过的感觉 这个程度的数值 应该会显现出来 这个程度是可以变为0的。
- 知识点：不过 会很快减少 希望在这个部分不会影响任何进展 想要展示这个程度 颜色值暂时用后面 整则白色 不过 把Alpha通道去掉 让慢慢消失的 时机开始。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `SubMesh_01 / System Location`。右侧 Offset 字段显示 `X=0.0`、`Y=0.0`、`Z=-10.0`，`Offset Coordinate Space=Local`。Timeline 当前约 `1.18`，`SubMesh_01` 轨道被选中。粒子计数中 `SubMesh_01 Active`，其他主要层部分为 Complete 或 Active。Preview 中中心效果几乎淡出，只剩暗色背景与少量残留。该图记录为了观察动态质感，对细节层做局部偏移并检查后段状态。
> 图表转写（UE-GTXT v4）
> `SubMesh_01 / Dynamic Material Parameters` 再次被选中。`Panning` 曲线位于负值区间并向更低值下降；`Distortion` 使用 `Float from Curve`，Key Data 末端可见 `Time=1.0`、`Value=0.2`，曲线从约 `0.1` 平滑上升；`EdgeStr` 曲线从约 `3` 逐步下降到接近 `0`。左下曲线编辑器选中 `Index 0 Param 2`，曲线从约 `0.1` 上升到约 `0.2`，提示框显示所选点时间约 `0.2`。Preview 中亮色中心仍可见，周围细节层较柔和。该图记录降低 Pen/扭曲强度，让细节层平稳传播。
> 图表转写（UE-GTXT v4）
> 回到关卡 `Ex_ShockWave_01` 的 `[Pilot Active - Cine Camera Actor]` 视图，画面中下部可见非常明亮的粉白冲击波中心，外缘被画面裁切，周围是暗色棋盘地面。右侧 Outliner 保持 `Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`Shock Wve 01` 等对象。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见并选中 `MI_MagicCircle_01`，旁边有 `MI_Additive...`、`MI_Mesh_01_Ins_01/02/03`。缩小的 Niagara 窗口中选中 `SubMesh_01 / Scale Color`，`Scale Mode=RGB and Alpha Separately`，RGB 常量显示约 `X=1.0`、`Y=1.0`、`Z=1.0`，下方 Alpha 曲线仍为 `Float from Curve`。该图记录回到关卡相机中检查外圈细节与中心亮度，并保留 SubMesh 颜色曲线作为后续调整点。

### 01:09:46-01:14:18 Alpha、网格

- 本段定位：Alpha、网格。
- 知识点：用比例网格尺寸 需要再增加那种爆炸感的张力 但是这里会通过浮动通道来调整 所以通过多重浮动 通过浮动的像料 把这个朋友做成曲线来用 就从一个竖着的角度开始。
- 知识点：以迷你化的方式 适当增大一点 差不多就行了 这种生长的感觉 我们来看看 中间部分的解读适当多了一点 确实更多 随着细节的增加 看的视角适当好一点。
- 知识点：的细节部分似乎 已经进行到某种完成 然后这里下方的部分 在消失时似乎有点突出 这个Alpha通道 需要适当修改一下图表 我觉得快一点消失比较好。
- 知识点：我觉得那种消失的感觉 更自然比较好 我觉得往这个感觉走比较好 现在大致的元素 几乎都制作完了 接下来是用于火花的材料 还有后期效果 瞬间冲击感可以更强一点的感觉。
- 知识点：和这个相机震动一起处理 就可以完成了 那么接下来 只需添加大约两个火花元素 和后期效果 再加上震动就结束了 现在在此之前看一看 元素之间是否有突出的部分。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 选中 `SubMesh_01 / Scale Color`，同时打开 Add new Module 菜单并在搜索框输入 `scale`。菜单建议项包括 `Scale Color`、`Scale Beam Width`、`Maintain in Camera Particle Scale`、`Scale Color by Speed`、`Scale Ribbon Width`、`Scale Mesh Size`、`Scale Mesh Size by Speed`、`Scale Sprite Size`、`Scale Sprite Size by Speed`。右侧 `Scale Mode=RGB and Alpha Separately`，RGB 常量 `X=1.0`、`Y=1.0`、`Z=1.0`，`Scale Alpha` 使用 `Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线中段保持高值后降到接近 `0`。该图记录在 SubMesh 细节层上继续查找 Scale 类模块，并调整 Alpha 快速消失。
> 图表转写（UE-GTXT v4）
> `SubMesh_01 / Scale Color` 仍被选中。右侧 `Scale Alpha` 曲线以 `PARTICLES NormalizedAge` 为输入，Key Data 可见 `Time=0.5`、`Value=1.0`；曲线从 `1` 附近迅速下降，在后段保持接近 `0`。左下曲线编辑器显示对应 Alpha 曲线从约 `1.0` 降到 `0`，当前点在约 `0.2` 附近。System Overview 中 `CoreMesh_02`、`SubMesh_01`、`MagicCircle_01`、`Glow_02`、`Black_01` 等层存在。该图记录 SubMesh 细节层后半段透明度被压低，用来减少消失时的突出残留。
> 图表转写（UE-GTXT v4）
> 选中 `CoreMesh_01 / Mesh Renderer`。System Overview 中 `CoreMesh_01`、`CoreMesh_02`、`SubMesh_01`、`MagicCircle_01`、`Glow_01`、`Glow_02`、`Black_01` 等发射器可见。右侧 Mesh Renderer 设置为 `Source Mode=Particles`、`Facing Mode=Default`，Meshes `Index[0]=Cylinder_02`，`Enable Material Overrides` 已勾选，Override Materials 的 `Explicit Mat=MI_Mesh_01_Ins_01`，`Sort Mode=None`，`Sort Only when Translucent` 已勾选，SubUV Blending 未启用，Renderer Visibility 为 `0`。左下曲线编辑器仍显示魔法阵/细节层相关曲线。该图记录在添加火花前检查既有 Mesh 渲染器，确认主要元素没有明显异常。

### 01:14:18-01:19:10 生命周期、速度

- 本段定位：生命周期、速度。
- 知识点：Glow2这部分适当延迟 这里部分再多一点 混合 感觉更自然 好像可以 我放了13号 感觉更混合 感觉更自然 在眼里有些碍眼的 比之前小的差异。
- 知识点：现在从Spark开始试试看 做成Admiya2 用Spark搭配 这部分自我做成 圆形 这部分同样延迟0.2左右 给一点 这部分是 其实这个地方上检查。
- 知识点：没做的部分 这部分需要检查一次 虽然图形不会改变 但只是习惯而已 这部分大约会 会喷出1000个爆发 尺寸非常大 所以会这样出来 生命周期随机在1.5到0.8左右。
- 知识点：流出一些差距 然后尺寸随机 雷飞均匀的 大约在5的大小 这样随机值会出现 然后要做插图线 接下来用球形定位做球 大约100的大小 表面就设置为0。
- 知识点：而且规模大约 设置为0.1 缩小一点 这里加速度 按i作为点 速度大约是为700 让它扩散开 不过目标是像这样 比如说像手把的形状 扩展成扁平的形状。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 回到关卡 `Ex_ShockWave_01` 的相机视图，角色站在暗色棋盘地面上，当前没有明显冲击波主体。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见 `MI_MagicCircle_01`、`MI_Additive...`、`MI_Mesh_01_Ins_01/02/03`。缩小的 Niagara 窗口中 `ShockWve_01` 打开，右侧选中 `CoreMesh_01 / Dynamic Material Parameters`，可见 `Panning` 使用 `Float from Curve`。Sequencer 当前时间靠近 `0047`。该图记录添加火花前在关卡视图和现有材质/粒子层之间做一次检查。
> 图表转写（UE-GTXT v4）
> Niagara 新增并选中 `Spark_01 / Initialize Particle`，Viewport 左侧显示正在 `Compiling...`，编译列表包含 `Glow_01_0`、`Empty`、`CoreMesh_01_3`、`Black_01_2`、`Glow_02_8`、`MagicCircle_01_11`、`SubMesh_01_15`、`Spark_01_16` 等。`Spark_01` Stack 包含 `Emitter State Self Once`、两个 `Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Sprite Renderer`。右侧 `Lifetime Mode=Random`，`Lifetime Min=1.0`，`Lifetime Max=2.0`；Position Mode 为 `Simulation Position`，Sprite/Mesh/Ribbon 属性未设置。Timeline 选中 `Spark_01` 轨道。该图记录火花层新增后，使用随机生命周期并等待系统编译。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_01 / Scale Velocity`。Preview 中冲击波中心周围出现大量白色火花点，粒子计数显示 `2000 Current, 2000 Max (est.) - [Spark_01] [Active]`。`Spark_01` Stack 包含两个 `Spawn Burst Instantaneous`、`Shape Location Sphere`、`Add Velocity From Point`、`Add Velocity 001 Linear`、`Scale Velocity`、`Solve Forces and Velocity`、`Sprite Renderer`。右侧 `Scale Velocity` 的 `Coordinate Space=Local`，Velocity Scale 为 `Multiply Vector by Float`，Vector 的 `X=1.0`、`Y=1.0`、`Z=1.0`，Float 为 `1.0`。该图记录火花层生成大量粒子，并先以统一速度比例扩散。

### 01:19:10-01:23:49 Color、Alpha、Material

- 本段定位：Color、Alpha、Material。
- 知识点：从1.25的速度开始 逐渐降低到0.05的速度 现在有点强烈 需要快速降低这个速度 这个程度 又把范围 调成1秒的维度 沿着1.2走到1.2的程度。
- 知识点：这里 添加一个colorize 以便给detail一个移动的感觉 给这边大约20的 颤动的感觉 从material开始试试吧。
- 知识点：用之前用过的这个 应该有点向上抬起的感觉吧 所以 这里的vector 用material的话3个轴就可以单独控制了。
- 知识点：这里的Z轴 只用flot平面曲线来制作 用这个曲线制作 一开始不抬起 随着时间的推移慢慢抬起来的话 一开始就用1的指 开始 然后渐渐地增大到。
- 知识点：大约加入12的轴 这样自动处理 这样应该 现在似乎球体在地面上 也生成了 所以底部调整到大约0.5 不让它生成 低于0的值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Material`、`速度`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Spark_01 / Scale Velocity` 继续被选中，Preview 中白色火花点形成宽大的环形散布。粒子计数显示 `1802 Current, 2000 Max (est.) - [Spark_01] [Active]`。右侧 `Velocity Scale` 的 Float 改为 `Float from Curve`，输入为 `PARTICLES NormalizedAge`，曲线从约 `1.0` 逐渐降到接近 `0.05`；Key Data 可见 `Time=0.0`、`Value=1.0`。左下曲线编辑器也显示对应速度曲线。字幕提示速度逐渐降低到 `0.05`。该图记录火花速度随生命周期快速衰减。
> 图表转写（UE-GTXT v4）
> `Spark_01 / Scale Velocity` 展开为 `Multiply Vector by Float`。Vector 使用 `Make Vector`，`X=1.0`、`Y=1.0`，`Z` 使用 `Float from Curve`；Z 曲线从接近 `1.0` 随归一化年龄下降到接近 `0`。下方 Float 也使用 `Float from Curve`，曲线从高值降到低值，Key Data 末端可见时间约 `1.5`。Preview 中紫色冲击波和火花环叠加，火花带有向上/外扩的视觉层次。该图记录将速度向量拆分，让 Z 分量也由曲线单独控制。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_01 / Scale Color`。右侧 `Scale Mode=RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，输入为 `PARTICLES NormalizedAge`，可见蓝色曲线从接近 `1` 降到 `0`，红绿曲线也在后段降低；`Scale Alpha` 使用 `Float from Curve`，Key Data 可见 `Time=0.2`、`Value=1.0`，曲线随后逐步下降到低值。Preview 中火花与紫色冲击波叠加。该图记录火花颜色和透明度开始转为曲线控制。

### 01:23:49-01:28:44 Opacity、颜色

- 本段定位：Opacity、颜色。
- 知识点：让这个饱和度适当提高一点的感觉 这里三通道 现在重叠在一起 就是因为蓝色通道从直给出 蓝色通道就这样 以以保持不变 红色通道的情况是从 0.15左右开始的。
- 知识点：0.5适当给最重要的是 绿通道比例 一直0.5值开始 需要让它变成0 这种感觉 规模这里被绿 通过图表的矢量 强度适当调高一点 从0.2开始。
- 知识点：开始大约50 应该可以这样做 这种感觉 应该可观察到 这样试试看 一开始尺寸太大了 颜色值太大了。
- 知识点：大约7 适当缩小一点 动态部分应该没问题 颜色值 红色适当调低一点 感觉太红 这里再试一次 需要适当减少一下数量 我跨有2分钟的时间 删掉一个。
- 知识点：会更舒服吧 而且当持续 有些遗憾发生 核心元素似乎有点削弱了力量 这里Opacity的功率值 颜色区域。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Spark_01 / Scale Color` 继续显示，Preview 中火花围绕黑色中心和紫色外圈分布。右侧 `Scale RGB` 的 `Vector from Curve` 中，蓝色曲线从高值下降到低值，红/绿通道也在时间推进时降低；`Scale Alpha` 的 `Float from Curve` 在 `Time=0.2` 附近保持 `1.0`，之后下降。左下曲线编辑器选中 `Scale RGB`，蓝色通道曲线由约 `1` 降到 `0`。该图记录继续压低火花通道强度，减少过饱和或过红的观感。
> 图表转写（UE-GTXT v4）
> 关卡相机视图中角色站在棋盘地面中央，效果主体暂时不可见或很弱。Content Browser 位于 `/Content/Tutorial/Material/Ex_03`，可见 `MI_MagicCircle_01`、两个 `MI_Additive...`、`MI_Mesh_01_Ins_01/02/03`。缩小的 Niagara 窗口仍打开 `ShockWve_01`，右侧选中 `Spark_01 / Initialize Particle`。Outliner 中可见 `DirectionalLight`、`ExponentialHeightFog`、`SM_SkySphere`、`Cine Camera Actor`、`Ex_ShockWave_01`、`Floor`、`Phase GDC`、`PostProcessVolume`、`SpotLight`。该图记录在关卡中检查火花/核心元素强度和可见性。
> 图表转写（UE-GTXT v4）
> 关卡相机视图继续显示角色与棋盘地面，效果主体较弱。Content Browser 切到 `/Content/Complete/Material/Ex_03_Shockwave`，可见 `MI_AdditiveDe_v01_01`、`MI_AdditiveDe_v02_01`、`MI_MagicCircle_v01`、`MI_Mesh_v01_01`、`MI_Mesh_v01_02`、`MI_Mesh_v01_03` 等完成版材质实例；`MI_Mesh_v01_01` 被选中。缩小的 Niagara 窗口显示 `Spark_01` 仍在 `Initialize Particle` 附近，Sequencer 时间靠近 `0057`。字幕提示约 `1.4` 程度。该图记录参考完成版材质并继续核对 Spark/核心元素强度。

### 01:28:44-01:32:51 材质、网格、速度

- 本段定位：材质、网格、速度。
- 知识点：大约8 而且刚才改成了1.2 1.4程度 这种感觉好像不错 向外扩散的辅助手段 平移适当 希望能适当慢一点 0.1 张力的速度感适当更匹配一下。
- 知识点：这个程度刚刚好 感觉有点向外延展 这样最后整理元素 是非常重要的 持续发现适当不自然的部分 逐步调整 让它看起来更自然 这在最后真的很重要。
- 知识点：其实制作和混合 一些元素 我觉得在这一部分完成 元素呢几乎都填满了 在快要爆发之前 为了展示有一点时间差的爆发 想适当配合手的动作 现在大致元素都填满了。
- 知识点：看起来已经完成了 那么 只需添加后期效果 只需添加摇晃 就可以完成了 后期将写两种 首先是 我们一直在使用的无限尝验证效果吧 将其制作并收集 将其制作并收集。
- 知识点：我们先存一次吧 可以保存到这一年 我就保存到这一年 因为工作过的记录太多了 这个将使用网格材质。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 关卡相机视图中角色周围几乎没有强可见效果，只能看到暗色棋盘和少量弱粒子。Content Browser 仍在 `/Content/Complete/Material/Ex_03_Shockwave`，选中 `MI_Mesh_v01_01`。缩小的 Niagara 窗口中 `CoreMesh_02` 被选中，右侧可见 `Dynamic Material Parameters`，并显示 `Index 3 / All` 区域和 `Write Parameter` 选项。Sequencer 时间靠近 `0045`，字幕提示“在快要爆发之前”。该图记录在爆发前时间点检查完成版材质参考和 `CoreMesh_02` 动态材质状态。
> 图表转写（UE-GTXT v4）
> 关卡相机视图与完成版材质目录保持打开，选中资源仍为 `MI_Mesh_v01_01`。缩小 Niagara 窗口中 `Spark_01` 或相邻层仍处于 `Initialize Particle`/粒子设置区域，Sequencer 时间靠近 `0054`。关卡预览中角色处于等待爆发的姿态，周围效果较弱，字幕和上下文指向约 `1.4` 的调整量。该图记录在完成版参考下微调火花或核心层的尺寸/速度，目标是让向外扩散的辅助效果更自然。
> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 中新增或选中 `Refraction_01 / Mesh Renderer`。System Overview 中可见 `Spark_01` 与 `Refraction_01`，底部还有被折叠/下移的 `Empty`、`Empty001`。Preview 左侧显示明亮粉白冲击波和火花点。粒子计数中 `Spark_01 Active` 约 `1000 Current, 1000 Max (est.)`，`Refraction_01 Active` 但当前估计为 `0 Current, 0 Max`。右侧 Mesh Renderer 设置为 `Source Mode=Particles`、`Facing Mode=Default`，Meshes 的 `Index[0]=SM_FX_BasePlane`；`Enable Material Overrides` 已勾选，Override Materials `Index[0]` 为空或尚未指定，`Sort Mode=None`，`Sort Only when Translucent` 勾选，SubUV Blending 未启用，绑定区下方可见 `Position Binding=PARTICLES Position`。该图记录开始建立后期折射 Mesh 层，准备用平面网格材质做冲击感补充。

### 01:32:54-01:37:39 渲染器、精灵、网格

- 本段定位：渲染器、精灵、网格。
- 知识点：Other Poets 上爆炸的时 因为是用原始的 然后网格 在精明爆炸时指示 用网格面平面器 然后用相机面来使用过 这次是 因为会按Z轴对齐。
- 知识点：出时网格 朝下下量来 朝Z轴方向制作 用相机天影 制作时是向前拉着使用 是 决定性低爆破线 这样做的话 是的 在这个程度 无论如何 再掉落到地面的使机上。
- 知识点：适当进取出来的 感觉的效果适当 给一下的话 似乎地面更 在下降时可以保持张力 骨折只需要这些帮助 然后再加一个 我们制作骨折 随机时还制作了一个。
- 知识点：镜像模糊 需要第一次使用它 通过这个 这个是没有使用 网格渲染器的精灵方式 延迟和帧数保持不均 生命时间适当延长 因为不使用网格 而是精灵 均匀地。
- 知识点：窗口也会大一些 朝下 删除朝下 偏移也给窗口调整 然后现在 颜色 颜色只使用零 只有α值 弯曲制造后 零在零处生成。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`渲染器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara `ShockWve_01` 中选中 `Refraction_01 / Mesh Renderer`。System Overview 中可见 `Spark_01` 与 `Refraction_01`，Preview 显示明亮粉白冲击波和火花点。粒子计数中 `Spark_01 Active` 约 `1000 Current, 1000 Max (est.)`，`Refraction_01 Active`。右侧 Mesh Renderer 设置为 `Source Mode=Particles`、`Facing Mode=Default`，Meshes `Index[0]=SM_FX_BasePlane`；`Enable Material Overrides` 已勾选，Override Materials `Index[0]` 的 `Explicit Mat=MI_Refraction_01_Ins_01`，`Sort Mode=None`，`Sort Only when Translucent` 勾选，Sub Image Size 为 `1.0 / 1.0`。该图记录折射后期层使用平面网格和折射材质实例。
> 图表转写（UE-GTXT v4）
> `Refraction_01 / Mesh Renderer` 继续被选中，Override Materials 的 `Explicit Mat` 仍为 `MI_Refraction_01_Ins_01`，鼠标提示显示材质实例路径 `/Game/Tutorial/Material/MI_Refraction_01_Ins_01`。System Overview 中 `Refraction_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Initial Mesh Orientation Vector`、`Camera Offset`、`Particle State`、`Dynamic Material Parameters`、`Mesh Renderer`。Preview 中冲击波与火花保持可见。该图记录折射层材质实例路径和模块组成，确认材质已经放入 Mesh Renderer。
> 图表转写（UE-GTXT v4）
> Niagara 正在编译，列表包含 `Glow_01_0`、`Empty`、`CoreMesh_01_3`、`Black_01_2`、`Glow_02_8`、`MagicCircle_01_11`、`SubMesh_01_15`、`Spark_01_16`、`Refraction_01_17`、`RadialBlur_01_20`。System Overview 中新增 `RadialBlur_01`，选中 `RadialBlur_01 / Scale Color`。右侧 `Scale Mode=RGB and Alpha Separately`，`Scale RGB` 常量为 `X=1.0`、`Y=1.0`、`Z=1.0`，`Scale Alpha=1.0`。该图记录复制或新增径向模糊层，并在编译状态下初始化颜色/Alpha 设置。

### 01:37:39-01:42:37 材质、颜色、动态参数

- 本段定位：材质、颜色、动态参数。
- 知识点：这样消失掉 然后颜色应该差不多这样 动态参数 零生成后 几乎是 从一点一开始 从零开始 适当快速减少效果 这样感觉就是先折叠一下 然后之后 什么呢。
- 知识点：没有放入材质 放入辐射膜 会产生效果吧 以形式形状生成的模糊效果 炸裂瞬间的冲击 有什么那种缩放的 模糊进入了 对开始出现时 为了让它更自然一些。
- 知识点：技能 吸管大小 快速地 生成一下吧 过于快速 似乎表现得不错 如果太长的话 会干扰其他元素 黑色掉了算有点 不深了 适当一点 确实有什么 放射状模糊进入了。
- 知识点：那瞬间的 某种波动 爱果好像适当升起的感觉 二拍拍手适当举一下 这种话几乎完成了 只需要用相机抖动结束 相机抖动就 这个将会用不同强度。
- 知识点：第一个就是我们以前做的 复制纹 试着写写看 用第二个数值 先全部保存这个 关闭马达材料 然后 首先根据时间安排放置 然后调整数值 大约在16帧时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`材质`、`颜色`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `RadialBlur_01 / Scale Color`。粒子计数显示 `RadialBlur_01 Active` 且 `Refraction_01 Active`，Preview 中明亮冲击波和火花点继续显示。右侧 `Scale RGB` 常量为 `X=0.0`、`Y=0.0`、`Z=0.0`，`Scale Alpha` 使用 `Float from Curve`，输入为 `PARTICLES NormalizedAge`；曲线起始提示 `Time=0`、`Value=1.05`，随后快速下降到低值。该图记录径向模糊层不靠 RGB 着色，主要用 Alpha 曲线控制出现和消失。
> 图表转写（UE-GTXT v4）
> 关卡相机视图中冲击波完整爆发：中心暗色，外圈为紫色/粉白扩散片，周围有大量紫白火花点，角落可见魔法阵方形细节。右侧仍有 Outliner；下方 Content Browser 在 `/Content/Complete/Material/Ex_03_Shockwave`，可见完成版材质实例。缩小的 Niagara 窗口中选中 `RadialBlur_01 / Scale Sprite Size`，`Scale Sprite=Uniform Curve`，曲线从低值快速上升到接近 `1`。该图记录径向模糊/后期层加入后，整体爆发瞬间的可见效果。
> 图表转写（UE-GTXT v4）
> Sequencer `Ex_ShockWave_01` 打开，当前时间约 `0017`。轨道包含 `Camera Cuts`、`Cine Camera Actor`、`Phase GDC`、`Shock Wve 01`。`Cine Camera Actor / CameraComponent` 下可见 `Current Aperture=2.8`、`Current Focal Length=35.0`、`Intensity (Post Process)=3.0`、`Manual Focus Distance=100000.0`、`Size Scale (Post Process)=2.0`、`Spawned` 等项；`Phase GDC` 下有 `Animation`，片段名可见 `Ability_B_Alt`；`Shock Wve 01` 下有 `Spawned` 和 `Transform` 关键帧。Viewport 中角色上方显示相机/灯光 Gizmo，字幕为“播放”。该图记录保存后在 Sequencer 中按时间安排播放冲击波、角色动作和相机参数。

### 01:42:45-01:45:58 纹理

- 本段定位：纹理。
- 知识点：目标是塞伊适当抢一点 比一般的声乐更有冲击感 适当提高延迟 毕竟希望在Z轴上 更强烈地表达 这个程度 更强烈地加入 适当减少指导 再增加时间以免太大幅度摇摆。
- 知识点：可以适当提高主干吗 这种程度应该不错 果然加入这种摇晃感 紧张感就会有一些不同的感觉 总是在最后 总是按照工作时的顺序 后期效果 或刀刃摇晃等效果。
- 知识点：最好只用做最后的支撑 感觉 那么这样就完成了 包括摇晃 这是第三个势力 摇晃的效果与元素的节奏混合部分 与纹理平移的其他元素。
- 知识点：一起使用时 纹理平移的某种感觉 一起呈现 的部分适当重点 看一下会更好 那个部分是最重要的 那我认为在这次这个例子中 现在看平移的动作 或细节元素们适当添加一下。
- 知识点：使得适当呈现了一个 眼睛突出的东西 几乎没有 应该展示的东西明确展示 脑人的部分 持续抓住 这种过程适当重要 看一下会更好 眼睛不能突出 那么这次立刻到此为止 结束 需要在这里你们辛苦了 辛苦了。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 数据蓝图 `ExShake_02` 打开，右侧 Details 显示 `Camera Shake Pattern` 为 `Perlin Noise Camera Shake Pattern`。`Location Amplitude Multiplier=3.5`，`Location Frequency Multiplier=7.0`；Location 的 `X/Y/Z` Amplitude 和 Frequency 均显示 `1.0`。Rotation 区域中 `Rotation Amplitude Multiplier=0.0`、`Rotation Frequency Multiplier=1.0`；FOV Amplitude 为 `0.0`、Frequency 为 `1.0`；Timing 中 `Duration=0.4`、`Blend In Time=0.0`、`Blend Out Time=0.2`。左侧关卡预览显示冲击波爆发画面。该图记录第一组相机抖动参数，用于增强爆发冲击感。
> 图表转写（UE-GTXT v4）
> `ExShake_02` 的 Camera Shake 参数继续显示。`Location Amplitude Multiplier` 调整为 `5.0`，`Location Frequency Multiplier=8.0`；Location 的 `Z` Amplitude 为 `2.5`，X/Y Amplitude 与 Frequency 仍为 `1.0`。Rotation Amplitude Multiplier 仍为 `0.0`，FOV Amplitude 为 `0.0`；Timing 中 `Duration=0.5`、`Blend In Time=0.1`、`Blend Out Time=0.2`。左侧关卡预览为角色和棋盘地面，字幕提示“总是在最后”。该图记录第二次提高相机抖动强度和持续时间，让最终爆发更有张力。
> 图表转写（UE-GTXT v4）
> Sequencer `Ex_ShockWave_01` 打开，当前时间约 `0067`。`Cine Camera Actor / CameraComponent / Camera Shake` 轨道中放置了 `ExShake_02_C` 片段，时间条位于中后段。Viewport 中角色站在暗色棋盘地面，效果已经结束或处于尾段。Content Browser 位于 `/Content/Tutorial/Sequencer`，可见 `CamTest_01`、`Ex_Projectile...`、`Ex_ShockWave_01`、`Ex_StrikeExp_01`、`ExShake_01`、`ExShake_02` 等资源。该图记录最终把相机抖动片段放入 Sequencer，并检查结束时的画面状态。

## 补充视觉证据

### S01 00:00:22

> 图表转写（UE-GTXT v4）
> UE 初始关卡 `Untitled` 中打开 `Open Level` 对话框。左侧目录树展开 `/Content/Tutorial/Level`，右侧资源区显示 `Ex_Projectile_01` 和 `Ex_ShockWave_01` 等 Level 资源；鼠标提示选中 `Ex_ShockWave_01 (Level)`，路径为 `/Game/Tutorial/Level`，Primary Asset Name 为 `/Game/Tutorial/Level/Ex_ShockWave_01`，Disk Size 约 `38.708 KiB`，Date Modified 为 `23.4.8`。右侧 Outliner 为 `Untitled (Editor)`，可见默认天空/灯光相关对象。该补充图记录 p22 使用的冲击波关卡资产入口。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

