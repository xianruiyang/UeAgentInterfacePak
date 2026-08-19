# 08.虚幻引擎Sequencer设置

# 08.虚幻引擎Sequencer设置

## 关键术语

- `Sequencer`、`Houdini`、`粒子`、`光束`、`粗糙度`、`破碎`、`StatcMeshActor`、`StatcMeshActr`、`StaticMeshActor`、`StatcMeshActx`、`Niagara`、`材质`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`

## 分段知识

### 00:00:07-00:05:07 Sequencer

- 本段定位：Sequencer。
- 知识点：咱們把角色放这里,放在中间位置,像角色选择界面那樣 适当居中一点,看起来舒服就行 让角色看起来像是在做動作,让我们先建个關卡序列器,在項目里新建一个叫EX2的文件夾。
- 知识点：就叫它EX2 现在用希臘石这个角色,先把模型拖進来 直接拖進去就行,位置我已預設好了,只要把角色轉到170度左右,对準就行 轉到170度左右,位置对齊就行,现在有點高,适当往下調一点。
- 知识点：差不多就这个样子,接下来还要調一下角色灯光 现在太暗了,得加个攝像機 加个攝像機,先大致放在中间,視角再适当放大點,大概这樣就行。
- 知识点：鏡頭再靠前一点动画用的是Remote Master Swordplay这組動作 根據動作节奏,把幀數調到240幀左右 播放看看,这是带旋轉刀刃感的動作特效。
- 知识点：動作特别长,準備階段刀身会慢慢翻起微光,像被魔力靜然一樣 让刀身的光效更自然些背景後方,坑洞区域现在有灯光和貼圖元素露出来,颜色太搶眼了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`序列`、`颜色`。

**关键画面：**

这张图是在新的暗色遗迹关卡里准备 Sequencer 演示资源。左侧 Content Browser 当前定位在 `Content/Signature/Test`，可见两个关键资源：

- 一个 `Niagara System` 资源，名称显示为 `HoudiniEven...`
- 一个 Houdini 点缓存资源，名称显示为 `Niagara_Tes...`

主视口中已经能看到角色站位区域和周围漂浮的白色标记点，说明作者先把用于动作演示的主场景打开，再把 Houdini/ Niagara 相关资源准备到当前工程目录下。右侧 Outliner 列出的是 `Main (Editor)` 场景中的 `Beach` 与多个 `StaticMeshActor`，此时重点还不是调特效，而是先把 Sequencer 需要用到的关卡、角色和基础资源整理到位。
这张图是在 `Main` 关卡里把 `Greystone` 角色正式拖入场景并加入 Sequencer。左侧 Content Browser 当前定位在 `Content/Characters/Heroes/Greystone/Meshes`，资源列表中选中的是 `Greystone` 的 `Skeletal Mesh`；主视口中角色被放在楼梯中轴线前方，背后是亮绿色的环境光/瀑布区域，用来构成角色展示镜头的主背景。

右侧 Outliner 当前选中的是 `Greystone`，Details 面板可确认其基础 Transform 为：

- `Location = (16698.0, 11303.0, 0.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

底部 Sequencer 已经创建了 `Ex_02` 序列，并出现 `Greystone` 轨道及其 `Animation` 子轨道。这说明当前步骤是在先把角色摆到镜头中心附近，再准备把动作动画挂到 Sequencer 上，后续再根据镜头和灯光去微调角色朝向与高度。
这张图显示角色已经进入镜头预览阶段。主视口左上角标明 `Pilot Actor: CineCameraActor4`，说明作者已经创建并驾驶第四个电影摄影机来检查最终构图；画面中 `Greystone` 站在楼梯中央，背后是强烈的绿色背景光和上方悬浮的场景元素，用来形成角色展示的主视觉中心。

右侧 Outliner 中可以看到：

- `CineCamera... / Ex_02`
- `Ex_02` 序列
- `Greystone / Ex_02`

底部 Sequencer 当前打开的也是 `Ex_02`，时间线上已有 `Camera Cuts` 轨道和镜头缩略图，播放头大约位于 `0128` 帧附近，项目帧率是 `30 fps`。这一画面的意义是：在把角色和动画放进序列后，需要立即用摄影机视角检查角色是否居中、背景是否过亮、动作姿势是否适合当前镜头，再继续做灯光和背景清理。

### 00:05:07-00:09:42 关键流程 02

- 本段定位：关键流程 02。
- 知识点：颜色太刺眼,得把这些元素處理一下,先把貼圖的名字看一下 名字叫霧霧的这个也用不着了 那些綠色元素也太眨眼,乾脆都關掉,背景现在太搶眼了。
- 知识点：需要稍作優化,選中Static Component後往下拉,把渲染設置里的Visible全部关闭 只有这个有內部選項,得一个个關掉其他地方还有兩个没處理,一起清理乾淨。
- 知识点：雖然直接隱藏也能暫时看不見,但保存後会失效,所以建議把隱藏理解为关闭可見性 还有一个,那些雜亂的網格都清掉了前面像霧一樣的半透明霧效,也是用網格做的。
- 知识点：像这种霧效基本都刪掉了您看大缸里,这里叫蒼氏穹頂,区域分得挺清楚 按文件夾分好,所以这最後一个房间就叫蒼氏穹頂,所有貼圖都集中放在这里。
- 知识点：接下来,往下拉,全選一遍貼圖貼圖太多了,各种花紋都堆在一起 背景牆上的所有元素都已轉为貼圖處理,数量雖多,但非关键要素,可統一設为不可見,全部設为不可見即可。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是在 `Ex_02` 序列里回看角色镜头效果，并开始判断哪些背景元素过于抢眼。主视口中 `Greystone` 站在画面中央，背后有很强的绿色发光背景和悬浮装饰物，明显会分散视线，因此作者接下来要做的不是继续摆角色，而是清理或关闭背景里不需要的可见元素。

底部 Sequencer 当前打开的是 `Ex_02`，可以看到：

- `Camera Cuts` 轨道
- `CineCameraActor4` 轨道
- 镜头缩略图覆盖整段时间线
- 播放头位于约 `0004` 帧

左侧 Content Browser 仍停在 `Greystone/Meshes`，右侧 Outliner 保留 `Greystone / Ex_02`、`CineCamera... / Ex_02` 等对象。这张图的作用是确定基准镜头：角色位置和动作已经基本成立，下一步重点转向清理背景中颜色太亮、太杂的网格或贴图元素。
这张图把视角推近到背景发亮区域，直接在 Outliner 中定位需要清理的装饰贴花。右侧当前展开的是 `ChamberOfDoom_Decals` 文件夹，下面列出了多组贴花/材质实例条目，名称以 `MI_Concrete_Crack...`、`MI_D_Concrete_Crack...` 等开头，后缀包含 `sez...`、`sf2` 一类变体名。

画面中间的绿色发光墙面和周围漂浮碎片正是需要削弱的背景来源，所以这一阶段的实际操作是：

- 在 Outliner 中先按区域文件夹定位到 `ChamberOfDoom_Decals`
- 展开其子项，逐个找到背景墙面上过亮、过杂的 decal/mesh 元素
- 准备在组件渲染设置里关闭它们的 `Visible`

这张图的重点不是镜头或角色，而是确认“哪些背景元素在抢戏”。作者通过先找出这批 `Concrete_Crack`/decal 资源，后续就能统一关闭可见性，避免绿色背景和裂纹贴图把角色主视觉压过去。
这张图是在关闭背景干扰元素后的结果验证画面。与前两张相比，原本刺眼的绿色背景光和墙面贴花已经明显被压下去，角色 `Greystone` 在楼梯中央的剪影更突出，背景只保留了必要的空间轮廓和少量暖色点光源，不再被大面积高饱和装饰抢走注意力。

右侧 Outliner 当前列出的是一批需要逐项处理的静态网格资源，名称包括：

- `SM_Old_Wood_Boards_...`
- `SM_Old_Wooden_Door_...`
- `SM_Old_Wooden_Pole_...`
- `SM_Pit_02_NT`
- `SM_Quarry_Cliff_...`

这说明作者是在区域文件夹里继续逐个检查背景网格和装饰件，把不该出现在角色后方的显眼元素设为不可见。底部 Sequencer 仍停在 `Ex_02` 的同一帧附近，因此这一张的重点是验证“清理后镜头是否更干净”：角色已经成为画面焦点，后续才适合继续接入 Houdini、光束和 Niagara 特效。

### 00:09:42-00:14:22 Houdini、光束

- 本段定位：Houdini、光束。
- 知识点：通过这种方式为角色補光即可当前光源賴輕微綠調,建議調至偏紅的自然色調 亮度可適当提升,使角色更清晰,光束角度也可適度擴大,以增強照明覆蓋範圍。
- 知识点：这樣就行,側角度設在25度左右,適当放寬一点,營造出奇幻游戏里常見的那种氛圍 大致就是这樣了,相機、灯光和角色動作大致都安排好了,您就按这个状态往下走就行。
- 知识点：这个動作片段会直接復用,所以得先導出,再導入Houdini處理 順便也用上吧,記得一起導出圆網格,按这个方式導出就行 接下来在武器材质里,也把發光区域适当提亮的效果提前做好比較好。
- 知识点：您看这里標着鈍的,材质元素3里的这个材质,应该是鈍和劍共用的 这部分只要把这个材质貼到画面显示的位置就行。
- 知识点：只要把这个材质用上,把發光效果用參數提取出来,再通过关键針調節就行 再把它附到武器上,当作视觉重點。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Houdini`、`材质`、`光束`。

**关键画面：**

这张图开始处理角色补光。主视口里显示的是一个 `SpotLight` 的可视化锥体线框，光束从右侧斜打向角色与楼梯中央区域，说明作者正在通过补光灯而不是环境光整体提亮角色。当前选中的对象是 `ChamberofDoom_SpotLight_12`。

右侧 Details 面板可确认这盏灯的主要参数为：

- `Location = (16684.0, 11434.0, 4555.5)`
- `Rotation = (233.39, -8.448, 262.9...)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 12.0 EV`
- `Intensity Units = EV`
- `Light Color` 为浅绿色

右侧 Outliner 同时可见一组 `ChamberofDoom_SpotLight...` 条目，说明场景里原本就有多盏聚光灯。当前这一步的重点是挑出合适的一盏并直接改它的方向、亮度和颜色，让角色从暗部里被提出来，同时为后续 Houdini/光束特效预留更干净的主光关系。
这张图是在 `Pilot Actor: CineCameraActor4` 镜头里回看补光调整后的结果。角色 `Greystone` 已经从几乎全黑的剪影状态变成可清楚辨认盔甲体积和金属高光的状态，说明作者已经把补光灯从原本偏绿、偏弱的设置改成更适合作为角色主补光的暖色配置。

右侧 Details 面板中，当前选中的 `ChamberofDoom_SpotLight_12` 可确认参数为：

- `Intensity = 15.0 EV`
- `Intensity Units = EV`
- `Light Color = (R=255, G=220, B=200)`，偏暖白/浅红色
- `Attenuation Radius = 3200.0`
- `Inner Cone Angle = 0.0`
- `Outer Cone Angle = 90.0`

底部 Sequencer 播放头位于约 `0010` 帧，说明作者是在镜头时间线开头阶段检查角色亮度是否合适。这一步的重点是让人物皮肤和盔甲高光从背景中跳出来，同时保留场景整体的暗色氛围，不把补光打成过白或过平。
这张图打开的是角色护盾/武器相关材质 `M_Greystone_shield` 的 `Material Graph`，目的是把原本写死在材质里的发光效果改成可参数化控制，后续就能通过关键帧在 Sequencer 中调节明暗。当前能可靠确认的内容如下：

- 左侧预览窗口显示的是护盾、剑和角色局部的贴图/UV 预览。
- 中央主图中可见两个材质函数节点：
  - `MF_GreystoneEffects`
  - `MF_CharacterHairMaster`
- `MF_CharacterHairMaster` 节点输入端可见：
  - `Material (MA)`
  - `LookUpNormalImg (S)`
  - `BrightnessModulation (S)`
  - `Occlusion (S)`
- 右侧输出连接到 `Material Attributes`。

- 左下 `Details` 面板中当前材质基础设置可见为：
  - `Material Domain = Surface`
  - `Blend Mode = Opaque`
  - `Shading Model = Default Lit`
  - `Two Sided` 未勾选
  - `Use Material Attributes` 已勾选
  - `Cast Ray Traced Shadows` 已勾选
  - `Subsurface Profile = SSP_Greystone_Skin`

- 底部 `Stats` 可见：
  - `Base pass shader: 508 instructions`
  - `Resources Used: 19`
  - `Resource Limit: 64`

这张图能确认作者已经进入角色材质层面，为发光效果做参数化改造；但由于左侧来线和发光相关的具体参数节点未完整显示，无法从当前截图可靠还原“发光参数是由哪个具体节点提取、如何命名以及接到哪一路关键帧控制”，这部分需。
### 00:14:22-00:18:54 粗糙度、破碎

- 本段定位：粗糙度、破碎。
- 知识点：可以和灯光配合使用,用破碎材质屬性處理最後一部分,請对鏡面区域做微調 其他如金屬度、表面粗糙度、高光度均保持一致連接,只保留鏡面颜色。
- 知识点：表面粗糙度、高光度全部保持一致連接,僅保留鏡面区域的颜色 連接範圍只需到斷裂處即可 这种情况下最方便的是使用預設,简单一次性完成。
- 知识点：基本無需反覆調節參數,只需添加少量可控制的參數即可 添加少量可控制的參數,将鏡面颜色接入,再連接至最終材质,功率設为約3即可。
- 知识点：颜色值按此设置,让色彩柔和融入 外部表现效果,尝试調至約500亮度,結合世界本身的曝光調節功能 需強效疊加曝光調節功能,并在此處添加光照衰減,才能清晰呈现亮度效果。
- 知识点：这屬於一次性操作,直接使用也無妨 參數播一下,看看效果光已经進去了 調到500左右,也不至於过曝,灯光本身夠亮,这樣控制就差不多了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`颜色`。

**关键画面：**

这是 `M_Greystone_shield` 材质图里进一步处理“破碎/镜面区域”的补充图。当前画面已经不只是参数化发光，而是开始把材质属性拆开，只对镜面相关部分做局部微调，再回接到最终材质。

- `节点定义集`
  - `MF_GreystoneEffects`：位于左侧灰色注释区内，可见输入包括 `Material (MA)`、`IntensityMask (S)`、`Mask (T2D)`，输出为 `Result`。
  - `MF_CharacterEffects`：中间主节点，输入包括 `Material (MA)`、`LookUpNormalImg (S)`、`BrightnessModulation (S)`、`Occlusion (S)`，输出为 `FinalMat`。
  - `M_Greystone_shield`：右侧最终材质属性输出节点，输入为 `Material Attributes`。
  - `BreakMaterialAttributes`：当前正在通过右键搜索面板准备插入，搜索关键字为 `bre...`，结果列表中高亮显示 `BreakMaterialAttributes`。

- `连线集`
  - `MF_GreystoneEffects.Result` 接到 `MF_CharacterEffects.Material (MA)`。
  - `MF_CharacterEffects.FinalMat` 接到右侧 `M_Greystone_shield.Material Attributes`。
  - 当前正在 `MF_CharacterEffects` 与最终输出之间准备加入 `BreakMaterialAttributes`，用于拆分材质属性后只修改局部通道。

- `设置/参数`
  - 左下材质基础设置仍为：
    - `Material Domain = Surface`
    - `Blend Mode = Opaque`
    - `Shading Model = Default Lit`
    - `Use Material Attributes` 已勾选
    - `Subsurface Profile = SSP_Greystone_Skin`

- `输出/预览`
  - 左侧预览窗口显示护盾、剑和角色相关贴图 UV。
  - 底部 `Stats` 仍可见 `Base pass shader: 508 instructions`、`Resources Used: 19`。

这张图的核心意思是：不要整套材质全部重做，而是在现有材质函数输出到最终材质之前插入 `BreakMaterialAttributes`，把材质属性拆开后仅对镜面/破碎区域需要的通道做小范围改动。
这张图是在 `M_Greystone_shield` 材质里把镜面/发光相关参数调亮后直接应用的画面。中央弹窗显示 `Apply changes to original material and its use in the world. 100%`，说明作者已经把当前调整写回原材质并同步到场景实例中，用于立刻检查最终表现。

- `节点定义集`
  - `Multiply`：中右区域，可见输入端 `A`、`B`，输出继续向上接到材质属性链。
  - `Constant3Vector`：左下区域，节点标题显示数值 `5,3,1.25`，内部常量分别为 `X=5.0`、`Y=3.0`、`Z=1.25`，预览色为白色偏暖。
  - 标量节点 `Value = 500.0`：位于 `Multiply` 左下，用作高强度放大值。
  - 右上材质属性拆分链仍可见若干通道，例如 `ClearCoatRoughness`、`AmbientOcclusion`、`Refraction`、`PixelDepthOffset`、`ShadingModel`、`Displacement`。

- `连线集`
  - `Constant3Vector(5,3,1.25)` 接入 `Multiply` 的一个输入。
  - `Value = 500.0` 接入 `Multiply` 的另一个输入。
  - `Multiply` 输出继续回接到右侧材质属性链中的某个通道，用于提高镜面/发光区域的最终强度。

- `设置/参数`
  - 左下基础材质设置仍保持：
    - `Material Domain = Surface`
    - `Blend Mode = Opaque`
    - `Shading Model = Default Lit`
    - `Use Material Attributes` 已勾选

- `输出/预览`
  - 左侧预览窗口中护盾和剑的高亮区域已经被明显抬亮，画面接近过曝白色，说明当前参数正在测试高强度镜面/发光上限。
  - 底部 `Stats` 可见：
    - `Base pass shader: 412 instructions`
    - `Resources Used: 18`
    - `Resource Limit: 64`
    - `Samplers Used: 3`
    - `Sampler Limit: 32`

这一步的意义是先把镜面颜色和亮度乘子拉到一个足够显眼的强度，再回到场景里看是否需要压回更温和的数值。
这张图是在 `Pilot Actor: CineCameraActor4` 镜头里回看护盾/武器材质改动后的结果。角色 `Greystone` 做出挥剑姿势时，胸前护盾与武器的高亮/镜面区域已经被明显提亮，成为画面里最强的视觉焦点之一，说明前一张材质图里对镜面颜色和亮度乘子的调整已经成功反馈到实际镜头中。

底部 `Sequencer` 当前显示：

- 序列为 `Ex_02`
- `Camera Cuts` 与 `CineCameraActor4` 轨道已建立
- 播放头位于约 `0077` 帧
- 相机组件参数区可见：
  - `Current Aperture = 2.8`
  - `Current Focal Length = 20.0`
  - `Manual Focus Distance = 100000.0`

右侧 Outliner 仍保留 `Greystone / Ex_02`、`CineCamera4 / Ex_02` 等对象。这一步的重点是验证材质亮部在真实镜头下是否足够醒目但不过曝：现在角色主体已经从暗背景里跳出来，同时护盾和武器的亮面能成为后续光束、破碎和动作特效的视觉重心。

### 00:18:54-00:23:03 关键流程 05

- 本段定位：关键流程 05。
- 知识点：把點光源的EV選項改成別的,再给它加些关键針 先別急着加关键針,先把亮度調到8左右,看看效果有没有顯现 記得用附加节点把这玩意兒連到灰石上。
- 知识点：通过它連到灰石上,用FxSortop这个插槽,关键針已经加好了,確保它一直貼着 这里变換屬性默認不会自動生成,得手動建一个 第一針做了附加,但原来的位置數據又被疊加進来。
- 知识点：結果完全看不見了,所以得把數值設成0 設成0,附加状态下的物体才能对準正確位置 不如往中间挪一点,这樣看着更清爽,Z轴方向移动50左右就行。
- 知识点：颜色也用剛才調好的參數就行,现在这,光看起来不太亮,點光源的存在感有點弱 看起来好像没加進去似的,嗯,现在確實不太明顯,反正後面VDB还会調亮。
- 知识点：既然是用於投射照明,屆时用VDB資源对比调整会更准确 现在先做好附加就行,这里加个变換关键針,这參數容易出問題,導致变換值反復变動。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是在 `Ex_02` 的 `Sequencer` 里把角色发光和点光源都接入时间线控制。当前时间线顶部仍是 `Camera Cuts` 和 `CineCameraActor4`，播放头停在约 `0082` 帧；右侧 Outliner 选中的是 `PointLight`，其 Details 可见基础 Transform 为 `Location = (16770.0, 11680.0, 4260.0)`、`Rotation = (0.0, 0.0, 0.0)`、`Scale = (1.0, 1.0, 1.0)`。

在 `Greystone` 轨道下可以明确看到：

- `SkeletalMeshComponent0`
- `Material Slot: M03_SwordShieldFur_skin`
- 参数轨道 `Emissive_Str`
- 当前参数值 `500.0`
- 两个已打上的关键帧
- 动画片段 `Emote_Master_SwordPlay_T3`

这说明当前步骤已经把武器/护盾材质里的发光强度参数抽成可动画化属性，并在 Sequencer 中直接加关键帧控制。与此同时，点光源也保留在同一序列里，便于后续把灯光强度、附加关系和角色发光节奏一起同步调整。
这张图是在镜头视角中直接调整附加到角色附近的 `PointLight`。当前主视口仍为 `Pilot Actor: CineCameraActor4`，角色已经站在镜头中央，左前方有一个点光源图标和旋转 Gizmo，说明作者正在把这盏灯对位到更适合投射在角色武器/身体上的位置，而不是继续只靠场景原始灯光。

右侧 Outliner 中可见 `Greystone / Ex_02` 和 `PointLight / Ex_02`，说明点光源已经被放入同一序列上下文。Details 面板当前显示：

- `Location.X = 0.0`
- `Location.Y = 0.0`
- `Location.Z = -50.0`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 8.0 EV`

这表明作者已经把附加后的偏移量归零，只保留 `Z = -50` 的微调，让点光源在附加状态下能对准角色附近的正确位置。当前这一步的关键是先把灯附着稳定，再通过少量位移修正避免附加后位置叠加错乱，保证后续关键帧控制时光源能一直跟着角色动作走。
这张图展示的是 `Ex_02` 序列里点光源绑定与参数动画的完整落位结果。当前 Sequencer 已经不仅包含相机、角色和角色材质发光轨道，还把一盏跟随角色/武器的点光源完整纳入控制链中，用来补足武器发光的存在感。

可确认的轨道结构包括：

- `Camera Cuts`
- `CineCameraActor4`
  - `CameraComponent`
  - `Current Aperture = 2.8`
  - `Current Focal Length = 20.0`
  - `Manual Focus Distance = 100000.0`
- `Greystone`
  - `SkeletalMeshComponent0`
  - `Material Slot: M03_SwordShieldFur_skin`
  - `Emissive_Str = 0.0`（当前帧值）
  - `Animation = Emote_Master_SwordPlay_T3`
- `PointLight`
  - `LightComponent0`
  - `Intensity = 15.0`
  - `Light Color`
  - `Attach`
  - `Transform`
  - 附着目标显示为 `Greystone (FX_Sword_Top)`

这说明作者已经把点光源附着到角色武器相关的 `FX_Sword_Top` 位置上，并在 Sequencer 中同时保留它的强度、颜色、附着和变换控制。这样后续就可以一边播放角色动作，一边让武器发光参数和补光灯同步变化，避免光源脱离武器或在动作过程中丢失对位。

### 00:23:03-00:25:16 粒子

- 本段定位：粒子。
- 知识点：反应已经有了,接下来把VDB导入使用稍作调整,让效果更自然 可以關掉投射陰影,關掉投射陰影後,反应变得特别明顯了 數值調的太高了,角色周圍都快有明顯的光韻反应了。
- 知识点：反正點光源的作用就是提亮VDB的烟霧效果,點光源的作用就是提亮用於VDB的烟霧效果 就当它是用来提亮的,角色攝像機背景和灯光的初步設置就先到这里。
- 知识点：下次接着做模拟,把粒子模拟做好後導入,就能搞定收尾了,这期就先到这里 謝謝大家認真看完,感謝觀看。
- 核对对象：`粒子`。

**关键画面：**

这张图是在 `Pilot Actor: CineCameraActor4` 镜头里回看点光源与角色发光参数同步后的效果。角色 `Greystone` 的护盾和胸前高亮区域已经非常明显，说明材质里的 `Emissive_Str` 与附着点光源正在共同作用；主视口中的旋转 Gizmo 贴在角色武器/护盾附近，表明作者仍在微调点光源朝向或附着后的局部位置。

右侧 Outliner 当前选中的是 `PointLight / Ex_02`，其下为 `PointLightComponent (LightComponent0)`。底部 Sequencer 仍打开 `Ex_02`，播放头位于约 `0103` 帧，相机轨道保留：

- `Current Aperture = 2.8`
- `Current Focal Length = 20.0`
- `Manual Focus Distance = 100000.0`

这一画面的重点是验证“提亮用”的点光源是否已经起效。此时角色主体已经从暗背景里被有效拉出来，后续只需要基于 VDB/粒子实际导入效果再决定是否继续压低或抬高这盏灯的存在感。
这张图继续在 `Pilot Actor: CineCameraActor4` 镜头中检查附着点光源的最终表现。角色此时处于动作前冲/挥击姿态，左前方的点光源图标和旋转 Gizmo 仍贴在角色武器附近，说明光源已经跟随到位，并且正在验证它在动作变化时是否还能稳定照亮武器与护盾。

右侧当前选中的仍是 `PointLight / Ex_02`，`PointLightComponent (LightComponent0)` 面板中可确认：

- `Temperature = 6500.0`
- `Affects World` 已开启
- `Cast Shadows` 已关闭
- `Indirect Lighting Intensity = 1.0`
- `Volumetric Scattering Intensity = 1.0`

底部 Sequencer 播放头位于约 `0022` 帧，说明作者是在动作早期阶段检查补光是否过强。这里的关键判断是：这盏点光源主要用于提亮角色和后续 VDB/烟雾的反应，因此关闭投射阴影后，亮度反馈会更直接，也更容易看清武器附近的高亮变化。
这张图是本页角色镜头、补光和材质发光调节后的阶段性收尾画面。主视口仍为 `Pilot Actor: CineCameraActor4`，角色 `Greystone` 在动作过程中，护盾和武器高亮区域已经足够明显，但人物整体还没有被打平，说明当前补光和材质发光的组合已经达到了“突出主视觉但不过曝”的阶段目标。

右侧仍选中 `PointLight / Ex_02`，`PointLightComponent (LightComponent0)` 面板中可见：

- `Temperature = 6500.0`
- `Affects World` 已开启
- `Cast Shadows` 已关闭
- `Indirect Lighting Intensity = 1.0`
- `Volumetric Scattering Intensity = 1.0`

底部 Sequencer 保持在 `Ex_02`，播放头位于约 `0061` 帧。当前画面要表达的结论是：角色摄像机、背景清理、补光灯、武器/护盾发光参数这些前置工作已经基本就位，后续只要把粒子或 VDB 模拟做好并导入，就可以进入收尾整合阶段。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

