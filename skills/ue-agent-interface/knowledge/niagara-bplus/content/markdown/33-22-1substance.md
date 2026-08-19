# 33 - 22-1Substance纹理资源生产

# 33 - 22-1Substance纹理资源生产

## 关键术语

- `Color`、`Opacity`、`Substance`、`材质`、`拖尾`、`纹理`、`我们要首先制作的纹理是魔法阵纹理`、`然后半径随机值似乎不太需要`、`用您方便的方法制作也没关系`、`Niagara`、`Niagara System`、`Emitter`、`Particle`、`Spawn`、`Initialize Particle`、`Lifetime`、`Alpha`、`Renderer`

## 分段知识

### 00:00:06-00:03:50 纹理、用您方便的方法制作也没关系

- 本段定位：纹理、用您方便的方法制作也没关系。
- 知识点：这次后续会制作大约两张纹理资源。
- 知识点：我们要首先制作的纹理是模仿正纹理, 然后与第二个例子中制作的方法稍有不同, 比如说后续会从一开始就一个个地在3寸中构建图案。
- 知识点：接下来后续会制作C横向的四代形状的长纹理。
- 知识点：这次将使用于之前制作的方法,不同的方式,表达不同的质感。
- 知识点：需要可以再制作一个这样制作两张纹理。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这一张是用 Substance 3D Designer 开始制作本节第一张“魔法阵纹理”的起始界面。当前还没有真正摆出节点网络，重点是在一个空的 `Substance_graph` 里准备从库中的噪声或图案节点开始搭建。字幕“我们要首先制作的纹理是魔法阵纹理”与画面完全对应：这不是成品图，而是纹理制作流程的起点。

当前图中可确认的工作区状态：

```text
软件：Adobe Substance 3D Designer

Explorer
- Unsaved Package*
  - Substance_graph

Graph 区域：
- 画布为空
- 底部提示：No output node defined

2D View：
- 当前为全黑预览
```

左侧 `Library` 当前可见分类与资源：

```text
当前展开分类：
- Texture generators / Noises

可见资源示例：
- 3D Perlin Noise
- 3D Ridged Noise
- 3D Simplex Noise
- 3D Voronoi
- 3D Worley Noise
- Anisotropic Noise
- Blue Noise Fast
- BnW Spots 1 / 2 / 3
```

右侧界面当前可见状态：

```text
Properties 面板标题为：Sharpen - PROPERTIES
但当前图中没有看到对应节点放入画布，因此只能确认界面曾停留在 Sharpen 属性页
```

输出/预览：
- 这一步的重点是建立空白纹理图并准备从库中选基础噪声/图案节点
- 复现时可以先新建一个空的 Substance Graph，确认 2D View 为空、尚未定义输出节点，再从 `Texture generators / Noises` 或后续图案节点开始搭魔法阵纹理
这一张已经开始搭建魔法阵纹理的第一组基础图形。当前可见流程是先准备两个 `Shape` 节点，经 `Blend` 组合后，再送入 `Splatter Circular Grayscale` 做环形分布。字幕提到“半径随机值似乎不太需要”，而右侧正好停在 `splatter_circular` 的属性面板，因此这张图的重点是：用环形散布节点控制重复图样，但把半径随机这类扰动保持很低或关闭，先得到更规整的基础法阵轮廓。

节点定义集：

```text
1. Shape
   - 1024x1024 - L16

2. Shape
   - 1024x1024 - L16

3. Blend
   - 1024x1024 - L16

4. Splatter Circular Grayscale
   - 1024x1024 - L16
```

连线集：

```text
Shape(上) -> Blend
Shape(下) -> Blend
Blend -> Splatter Circular Grayscale
```

右侧当前可见的 `splatter_circular - PROPERTIES` 参数：

```text
Radius = 0
Radius Random = 0
Ring Radius Multiplier = 1
Angle Random = 0
Spiral Factor = 0
Spread = 1
Offset along Direction = 0
Global Offset = 0
```

输出/预览：

```text
2D View 中是一个很小的、位于画面中央的灰白色环形/花纹状结果
整体仍然很稀疏，说明当前只是把基础形状按圆形排布出来
```

用途说明：
- 这一步是在做魔法阵中心或环带上的基础重复图元分布
- 复现时可先用两个简单 `Shape` 组合出一个单元图形，再交给 `Splatter Circular Grayscale` 环绕摆放；若想保持规整圆阵，可先把 `Radius Random`、`Angle Random`、`Spiral Factor` 维持在 0
这一张继续在同一个 `Substance_graph` 里扩展魔法阵纹理的构形方法。上半部分保留了上一张的 `Shape + Shape -> Blend -> Splatter Circular Grayscale` 环形散布链；下半部分则新增了一条 `Shape -> Shape Mapper` 的独立分支，用另一种方式生成环状分布。字幕“用您方便的方法制作也没关系”与画面一致，说明这里强调的是构图思路而不是唯一标准答案。

节点定义集：

```text
上方分支：
1. Shape
2. Shape
3. Blend
4. Splatter Circular Grayscale

下方分支：
5. Shape
6. Shape Mapper
```

连线集：

```text
上方：
Shape(上) -> Blend
Shape(中) -> Blend
Blend -> Splatter Circular Grayscale

下方：
Shape(下) -> Shape Mapper
```

当前画面可确认的结果状态：

```text
Splatter Circular Grayscale 节点缩略图中可见一圈小型环状分布图样
下方 Shape Mapper 节点缩略图中也可见环状点/小图形排布
右侧 2D View 当前显示的是一个大尺寸的细白圆环
```

右侧当前可见 `shape - PROPERTIES` 参数：

```text
Pattern = Square
Scale = 0.99
Size X = 1
Size Y = 1
Angle = 0
Rotation 45° = False
Non Square Expansion = True
```

待确认点：

```text
当前选中的应是一个 Shape 节点，因此右侧显示的是 Shape 参数
但画面中没有显示这条下方分支后续是否已经再与上方分支合并
所以这里只记录“新增了可独立生成圆环轮廓的 Shape -> Shape Mapper 分支”，不补写未显示的混合步骤
```

用途说明：
- 这一步说明魔法阵纹理可以通过多条分支分别构建基础圆环、重复图元或外围装饰，再在后续阶段按需要组合
- 复现时如果不想完全依赖 `Splatter Circular Grayscale`，也可以先单独做一个 `Shape Mapper` 环状轮廓分支，再决定后面如何和其他花纹叠加

### 00:03:58-00:07:23 关键流程 02

- 本段定位：关键流程 02。
- 知识点：在这里需要多重叠一些Blend。
- 知识点：这个现在要精确匹配这个尺寸。
- 知识点：这样大致做完之后, 会制作大约四个完整的圆。
- 知识点：尺寸调整需要在放入其他元素后进行。
- 知识点：再加一个Transpun节点。

**关键画面：**

这一张进入“关键流程 02”后，开始把前一小节里得到的圆环分布进一步整理成可精确匹配尺寸的独立分支。当前画面可确认：上方仍保留 `Blend -> Splatter Circular Grayscale` 的基础散布链；下方则把另一条环状结果继续送入 `Transformation 2D`，用于后续缩放、平移或旋转匹配。结合正文“这个现在要精确匹配这个尺寸”，这张图的重点是把生成出来的环形元素单独拿出来做二维变换对齐。

节点定义集：

```text
上方分支（画面局部可见）：
1. Blend
2. Splatter Circular Grayscale

下方分支：
3. Shape Mapper
4. Transformation 2D
```

连线集：

```text
Blend -> Splatter Circular Grayscale
Shape Mapper -> Transformation 2D
```

当前图中可确认的结果状态：

```text
Splatter Circular Grayscale 缩略图中可见一圈小型环状散布结果
Transformation 2D 缩略图中可见一个较规整的细白圆环
右侧 2D View 当前显示的也是细白圆环，说明此时主要在检查下方变换后的环形轮廓
```

右侧当前可见属性状态：

```text
当前右侧面板标题显示为：shape_mapper - PROPERTIES

Base Parameters
- Output Format = 16 Bits per Channel
- Pixel Size Width = 1
- Pixel Size Height = 1
- Pixel Ratio = Square
- Tiling Mode = H and V Tiling
- Random Seed = 0

Output Size 的 Width / Height 当前画面显示为 0，右侧标注为 Input x 1
```

待确认点：

```text
右侧属性面板标题与画布中当前可见高亮框存在不完全一致的情况
因此这里只把它当作“当前这一组环形节点的基础输出属性”，不强行断言所有参数都专属于 Transformation 2D
```

用途说明：
- 这一步是在把圆环类元素独立拿出来做尺寸校准，为后续叠加多个环层做准备
- 复现时可先得到一个干净的圆环分支，再接 `Transformation 2D` 做二维对齐和尺寸匹配
这一张把“多重叠一些 Blend”和“精确匹配尺寸”具体展开成一条可复建的环形分支。当前图中可以明确看到：下方 `Shape Mapper` 先产出一圈基础圆环，然后分成两路，一路经过上方 `Transformation 2D` 后直接参与 `Blend`，另一路经过下方第二个 `Transformation 2D` 后再与上方结果进行最终 `Blend`。这正对应正文里的两点：先通过二维变换调尺寸，再把多个圆环层叠起来，逐步接近完整法阵轮廓。

节点定义集：

```text
上方旧分支（保留在画面中）：
1. Shape
2. Shape
3. Blend
4. Splatter Circular Grayscale

下方当前重点分支：
5. Shape Mapper
6. Transformation 2D（上）
7. Blend（中）
8. Transformation 2D（下）
9. Blend（右）
```

连线集：

```text
上方旧分支：
Shape -> Blend
Shape -> Blend
Blend -> Splatter Circular Grayscale

下方当前重点分支：
Shape Mapper -> Transformation 2D（上）
Shape Mapper -> Transformation 2D（下）
Transformation 2D（上） -> Blend（中）
Blend（中） -> Blend（右）
Transformation 2D（下） -> Blend（右）
```

当前图中可确认的结果状态：

```text
Shape Mapper 缩略图中是基础圆环
两个 Transformation 2D 缩略图都显示被调整后的圆环版本
中间 Blend 与右侧 Blend 缩略图都显示由多层圆环叠加形成的更复杂环带
2D View 中当前显示的是一个大尺寸细白圆环，并带有可编辑边框与中心控制点
```

右侧当前可见 `Transformation 2D - PROPERTIES` 参数：

```text
Random Seed = 0

Specific Parameters
- Rotation Angle = 0.00
- Stretch Width = 100.00%
- Stretch Height = 100.00%

可见快捷操作：
- 90cw
- 180
- 90ccw
- Hori Mirror
- Vert Mirror
- x2
- /2
```

待确认点：

```text
中间 Blend（左输入）来自哪一路外部节点在当前画面中没有完全展示
但可以可靠确认：Shape Mapper 结果至少被分成两路，经两个 Transformation 2D 与两个 Blend 逐层叠加
```

用途说明：
- 这一步是在为法阵纹理建立多层同心圆结构，而不是只保留单个圆环
- 复现时可把同一个环形源复制成两路，用 `Transformation 2D` 分别调整，再通过两级 `Blend` 叠加出更丰富的圆带层次
这一张继续在同一张法阵纹理上叠加更多环层，同时开始引入一个新的 `Shape` 作为额外图形源。字幕明确提到“在这里启用将旋转角度设置为 45 度的功能”，而右侧当前正显示这个 `Shape` 的属性，因此可以可靠确认：作者准备通过一个 `Square` 形状，并视需要启用 `Rotation 45°`，为后续的法阵构图增加菱形/斜向方形元素，而上方已经搭好的多级 `Blend + Transformation 2D` 链则继续负责把这些环形层叠加到一起。

节点定义集：

```text
已有主分支（当前画面可见）：
1. Shape
2. Shape Mapper
3. Transformation 2D（上）
4. Blend
5. Transformation 2D（中）
6. Blend
7. Transformation 2D（下）
8. Blend
9. Blend（最右）

新增源节点：
10. Shape（当前选中）
```

连线集：

```text
Shape -> Shape Mapper
Shape Mapper -> Transformation 2D（上）
Shape Mapper -> Transformation 2D（中）
Shape Mapper -> Transformation 2D（下）
Transformation 2D（上） -> Blend
Blend -> Blend
Transformation 2D（中） -> Blend
Transformation 2D（下） -> Blend
多个 Blend 输出继续汇入右侧最终 Blend
```

当前图中可确认的结果状态：

```text
上方主链的多个节点缩略图都显示同心圆/圆环叠加结果
最右侧 Blend 缩略图中可见更复杂的法阵环带结构
中下方新增 Shape 节点缩略图是黑底上的白色方块
右侧 2D View 当前显示的也是这个白色方块
```

右侧当前可见 `shape - PROPERTIES` 参数：

```text
Pattern = Square
Scale = 0.5
Size X = 1
Size Y = 1
Angle = 0
Rotation 45° = False（当前画面显示值）
```

待确认点：

```text
字幕在讲启用 45 度旋转，但当前截图里 `Rotation 45°` 还显示为 False
因此这张图只能可靠说明“正在定位并准备使用这个参数”，不能写成“本图中已经启用成功”
```

用途说明：
- 这一步是在给法阵纹理准备额外的方形/菱形构图元素，同时继续丰富外围圆环层次
- 复现时可先建立一个 `Square` 形状节点，并关注 `Rotation 45°` 这个快捷开关；如果要做斜向方框或菱形装饰，再在后续节点中把它并入主法阵结构

### 00:07:30-00:12:11 Opacity

- 本段定位：Opacity。
- 知识点：再复制一个底部的阴影。
- 知识点：放入屏幕中就会这样。
- 知识点：会出现这种格子图案。
- 知识点：再用混合模式一个。
- 知识点：这个是为了做成像袋子一样。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`。

**关键画面：**

这一张进入 `Opacity` 小节后，开始单独制作一个用于透明遮罩的几何图形。当前画面中新增了一条简单分支：一个 `Shape` 输出一个白色菱形/方形图形，再送入 `Transformation 2D` 做二维偏移和排列，右侧 2D View 里已经形成四向开口、中心交叉的 X 型遮罩。结合正文“放入屏幕中就会这样”“会出现这种格子图案”，这一步是在为后续透明区域或底部阴影准备基础遮罩形状。

节点定义集：

```text
当前小节新分支：
1. Shape
2. Transformation 2D

上方旧分支仍保留在画面中，但本图重点不是它
```

连线集：

```text
Shape -> Transformation 2D
```

当前图中可确认的结果状态：

```text
Shape 缩略图中是黑底白色菱形/方形
Transformation 2D 缩略图中是黑底白色 X 型开口图案
右侧 2D View 中同样显示大尺寸 X 型遮罩，并带有编辑框与控制点
```

右侧当前可见 `Transformation 2D - PROPERTIES` 参数：

```text
Width = 100.0%
Height = 100.0%

Offset
- X = 0.4959
- Y = 0

Mipmap Mode = Automatic
Mipmap Level = 0
```

输出/预览：
- 这一步的核心不是环形法阵，而是生成一个可用于 `Opacity` 的基础遮罩形状
- 复现时可先用一个简单 `Shape` 生成白色方形/菱形，再通过 `Transformation 2D` 的偏移把它做成四向开口的 X 型遮罩，为后续混合提供形状基础
这一张把上一张的 X 型遮罩继续扩展成更完整的 `Opacity` 图案。当前可以确认作者不是只保留单个遮罩，而是复制和叠加了多条类似分支，用多个 `Shape`、`Transformation 2D` 和 `Blend` 把白色菱形/X 型图案铺成格子化结构。右侧属性明确显示 `Blend Mode = Screen`，这与正文“再用混合模式一个”直接对应，说明这里正在用屏幕混合把这些遮罩图层叠成更复杂的不透明度图案。

节点定义集：

```text
上方主分支：
1. Shape
2. Transformation 2D
3. Blend
4. Shape
5. Shape
6. Blend
7. Blend（最右，当前选中链末端）

下方辅助分支：
8. Shape
9. Transformation 2D
10. Blend
11. Shape
```

连线集：

```text
上方：
Shape -> Transformation 2D -> Blend
Shape -> Blend
Shape -> Blend（与上一路共同形成中心格子）
Blend -> Blend（右）

下方：
Shape -> Transformation 2D -> Blend
Shape -> Blend

下方 Blend 的输出当前未显示是否已接入上方最右 Blend
```

当前图中可确认的结果状态：

```text
右侧 2D View 显示黑白相间的大型格子/菱形图案
中心是白色菱形，四周由黑白交替的对角块围出棋盘般的节奏
多个 Blend 缩略图都显示从单个 X 型遮罩逐渐发展成更复杂格子的过程
```

右侧当前可见 `Blend - PROPERTIES` 参数：

```text
Opacity = 1
Blending Mode = Screen
Alpha Blending = Screen (10)
Use Source Alpha = 未见启用
Cropping Area
- Left = 0
- Right = 1
- Top = 0
- Bottom = 1
```

待确认点：

```text
下方辅助分支是否在后续帧中并入右侧最终 Blend，当前截图没有完全显示
所以这里只记录“存在一条并行的格子遮罩辅助分支”，不补写未显示的终端连接
```

用途说明：
- 这一步是在把单个透明遮罩扩展成可重复、可铺开的格子化 `Opacity` 结构
- 复现时可复制同类形状分支，并通过 `Blend Mode = Screen` 叠加出更复杂的黑白遮罩图案
这一张把前面几段做出的圆环骨架与 `Opacity` 遮罩正式叠到了一起。上方仍能看到最初的 `Blend -> Splatter Circular Grayscale` 环形散布链，以及 `Shape Mapper -> 多个 Transformation 2D -> 多级 Blend` 的同心圆分支；下方则露出 `Shape -> Transformation 2D -> Blend` 的格子/菱形遮罩分支。右侧 2D View 已经出现一个完整的魔法阵外环：外圈有细密花纹，中层是交错线条和几何框，中央保留空心圆。结合字幕“只要不太紧就可以了”，这一步的目的就是把这些层叠关系控制到合适密度，而不是无限加满。

节点定义集：

```text
上方分支 A：
1. Shape
2. Shape
3. Blend
4. Splatter Circular Grayscale

上方分支 B：
5. Shape
6. Shape Mapper
7. Transformation 2D（多路）
8. Blend（多级）

下方分支 C（当前仅部分露出）：
9. Shape
10. Transformation 2D
11. Blend

最终合成：
12. Blend（当前选中，负责把多路结果叠加）
```

连线集：

```text
Shape + Shape -> Blend -> Splatter Circular Grayscale
Shape -> Shape Mapper -> 多路 Transformation 2D -> 多级 Blend
下方 Shape -> Transformation 2D -> Blend
上方环形结果与下方遮罩结果共同汇入右侧最终 Blend
```

当前图中可确认的结果状态：

```text
右侧 2D View 中是接近成品的魔法阵外环
最外圈有细小重复花纹
中间一圈由细线构成交错几何框架
内部仍保留大面积黑色空心圆
整体是白线黑底的灰度遮罩/纹理结构
```

右侧当前可见 `Blend - PROPERTIES` 参数：

```text
Random Seed = 0
Opacity = 0.35
Blending Mode = Screen
Cropping Area
- Left = 0
- Right = 1
- Top = 0
- Bottom = 1
```

待确认点：

```text
下方分支在画面中只露出上半部分，完整终端连接没有全部显示
但可以可靠确认它属于前一张建立的格子/Opacity 分支，并在这一张参与了总合成
```

用途说明：
- 这一步是在平衡法阵纹理的“结构复杂度”和“可读性”，把外圈花纹、环形骨架、Opacity 遮罩整合成接近成品的灰度纹理
- 复现时如果叠加后图案过密，可优先像本图这样调低最终 `Blend` 的 `Opacity`，而不是直接删掉整个分支

### 00:12:11-00:17:04 拖尾

- 本段定位：拖尾。
- 知识点：下面的部分可以保持不变。
- 知识点：适当增加了一点厚度。
- 知识点：需要修正一下对这个圆的感觉。
- 知识点：这个第三个圆的大小是。
- 知识点：需要再适当放大一点。
- 知识点：我就会再适当放大一点。
- 知识点：其实到了一定程度。
- 核对对象：`拖尾`。

**关键画面：**

这一张进入“拖尾”小节后，开始针对现有圆环纹理做厚度调整。字幕“感觉有点太薄了”与右侧 2D View 完全对应：作者保留了内层几何框架不动，只在外围同心圆部分继续叠加更宽的白色圆环，让整体更适合作为拖尾纹理使用。相较前一小节的精细法阵结构，这里重心已经转到“读得清、厚度够”的环带轮廓。

节点定义集：

```text
上方旧分支：
1. Shape
2. Shape
3. Blend
4. Splatter Circular Grayscale

中间当前重点分支：
5. Shape
6. Shape Mapper
7. Transformation 2D（上）
8. Blend（上）
9. Transformation 2D（中）
10. Blend（右）
11. Transformation 2D（下）

下方仍保留上一节的遮罩/格子分支（当前仅部分可见）
```

连线集：

```text
Shape + Shape -> Blend -> Splatter Circular Grayscale
Shape -> Shape Mapper
Shape Mapper -> Transformation 2D（上） -> Blend（上）
Shape Mapper -> Transformation 2D（中） -> Blend（右）
Blend（上） -> Blend（右）
Blend（右） -> Transformation 2D（下）
```

当前图中可确认的结果状态：

```text
右侧 2D View 中已经出现三层明显更厚的外圆环
中间仍保留前一阶段的几何交错线框
最中心是黑色空心圆
整体比前一批更偏向“可读的拖尾轮廓”，而不是只追求细线装饰
```

右侧当前可见 `shape - PROPERTIES` 参数：

```text
Pattern = Square
Scale = 1
Size X = 1
Size Y = 0.12
```

待确认点：

```text
当前右侧属性标题显示为 Shape，但画布中高亮框位于右侧 Blend 一带附近
因此这里只把可见数值当作当前正在调的形状源参数，不额外断言它具体对应哪一条最终连接支路
```

用途说明：
- 这一步是在给拖尾纹理增加环带厚度，让最终拖尾在屏幕上不至于显得过细
- 复现时若法阵外圈太薄，可保留中心结构不变，只单独增厚外圈圆环分支
这一张从大环带切到了拖尾纹理中的点状/节奏图案分支。当前画面可确认：左侧已有两个局部格形结果先做 `Blend`，再送入一个 `Shape Mapper`；与此同时，下方单独准备了一个 `Splatter Circular Grayscale` 节点，当前 2D View 里显示的是四个均匀分布的白色圆点。字幕提到“希望现在这个可以旋转大约 90 度”，结合右侧正处于 `splatter_circular` 属性面板，可以确认作者正在调这组分布点的方向与排布，用它们来修正拖尾纹理中局部圆点或小节拍装饰的方向感。

节点定义集：

```text
1. Blend（左上）
2. Blend（左下）
3. Blend（中左）
4. Shape Mapper
5. Blend（中上）
6. Splatter Circular Grayscale
7. Blend（右）
```

连线集：

```text
Blend（左上） -> Blend（中左）
Blend（左下） -> Blend（中左）
Blend（中左） -> Shape Mapper
Shape Mapper -> Blend（中上）
Splatter Circular Grayscale -> Blend（右）
Blend（中上） -> Blend（右）
```

当前图中可确认的结果状态：

```text
Shape Mapper 缩略图中仍是圆环类结果
Splatter Circular Grayscale 缩略图与右侧 2D View 都显示四个白色圆点，按 2x2 的节奏分布
说明这里正在加入独立的小圆点装饰，而不是继续加粗主圆环
```

右侧当前可见 `splatter_circular - PROPERTIES` 参数：

```text
Scale = 1.5
Scale Random = 0
Scale by Pattern Number = 0
Invert Pattern Number = False
Scale by Ring Number = 0
Invert Ring Number = False
```

待确认点：

```text
字幕提到要旋转约 90 度，但当前截图右侧 Rotation 区域只露出了标题和旋钮起始位置，没有看到最终角度数值
因此这里只能写“正在调整旋转方向”，不能写成“已经精确设置为 90 度”
```

用途说明：
- 这一步是在给拖尾纹理添加节拍点/装饰点分布，避免只有圆环没有内部节奏
- 复现时可用 `Splatter Circular Grayscale` 先做规则点阵，再与环形主结构通过 `Blend` 合并
这一张继续完善拖尾里的点状装饰，但比上一张更进一步：作者先在下方新增两个大圆形 `Shape`，通过 `Blend` 组合出一个基础局部图案，再把它送入另一个 `Splatter Circular Grayscale` 节点。字幕“然后在这里添加图案，与这里结合就可以了”与当前结构完全对应，说明这里的目的就是把新的小图案挂到已有拖尾主结构上，而不是单独存在。

节点定义集：

```text
上方已存在主分支（当前局部可见）：
1. Blend
2. Shape Mapper
3. Blend
4. Splatter Circular Grayscale
5. Blend

下方当前新增分支：
6. Shape（上）
7. Shape（下）
8. Blend
9. Splatter Circular Grayscale
```

连线集：

```text
上方：
Blend -> Shape Mapper
Shape Mapper -> Blend
Splatter Circular Grayscale（上方既有） -> Blend

下方新增：
Shape（上） -> Blend
Shape（下） -> Blend
Blend -> Splatter Circular Grayscale
```

当前图中可确认的结果状态：

```text
下方两个 Shape 缩略图都是大白圆
它们经过 Blend 后得到一个局部组合圆形图案
右侧 2D View 中显示两个竖向分布的小白圆环/圆点
说明当前这个 Splatter Circular Grayscale 正在把新的局部图案按规则方式复制排布
```

右侧当前可见 `splatter_circular - PROPERTIES` 参数：

```text
Size X = 0.1
Size Y = 0.1
Size Random X = 0
Size Random Y = 0
Scale = 1
Scale Random = 0
Scale by Pattern Number = 0
Invert Pattern Number = False
Scale by Ring Number = 0
```

待确认点：

```text
右侧预览只显示了两个竖向排列的小图案，当前截图没有完整展示它稍后如何再与上方主分支合并
但可以可靠确认：这条新增分支是为了生成可附加到拖尾纹理上的局部装饰图案
```

用途说明：
- 这一步是在为拖尾纹理增加可重复的小型装饰单元，让最终图案除了粗环和格形外还有附加节奏点
- 复现时可先用两个基础圆形 `Shape` 组合出单个图样，再交给 `Splatter Circular Grayscale` 批量分布，最后再并入主纹理

### 00:17:04-00:21:55 关键流程 05

- 本段定位：关键流程 05。
- 知识点：这里设置为剪发,这样移动的话应该可以, 有点胖的就像星月,让它适当细一些。
- 知识点：再复制一个,如果只是这样放进去会显得有点单调。
- 知识点：这样构成的过程其实是像纸一样剪贴,然后不断间贴的那种感觉。
- 知识点：按住几,就是那个shift,让它大概位于中央。
- 知识点：再复制一个circulator,然后放进去后就会这样。

**关键画面：**

这一张进入“关键流程 05”后，开始把前面做好的拖尾元素组织得更丰富，同时为后续新增圆形单元做准备。当前画面中，左到右已经连起多条由 `Shape`、`Transformation 2D`、`Blend`、`Shape Mapper`、`Splatter Circular Grayscale` 组成的拖尾装饰链；中下方则新放了一个独立的 `Shape` 节点，右侧属性显示它的图案类型是 `Disc`。结合正文“如果只是这样放进去会显得有点单调”“再复制一个 circulator”，可以确认这里是在准备新的圆形装饰源，后面会把它并入现有拖尾结构，打破单一感。

节点定义集：

```text
当前画面可见主链（从左向右）：
1. Shape
2. Transformation 2D
3. Blend
4. Shape
5. Shape
6. Blend
7. Shape Mapper
8. Blend
9. Shape
10. Shape
11. Blend
12. Splatter Circular Grayscale
13. Blend（右上）

新增独立源：
14. Shape（当前选中）
```

连线集：

```text
左侧多条 Shape/Transformation 2D/Blend 分支 -> Shape Mapper -> 上方后续 Blend
中右下方两个 Shape -> Blend -> Splatter Circular Grayscale
Splatter Circular Grayscale -> 右上 Blend

当前选中的新增 Shape 还未接线，处于准备加入主结构的阶段
```

当前图中可确认的结果状态：

```text
右侧 2D View 显示两个上下排列的空心圆环
说明当前工作焦点已经从方块/菱形图样切到圆形装饰单元
当前选中的新增 Shape 节点缩略图仍是纯色块，表示它刚被放入、尚未进入后续组合
```

右侧当前可见 `shape - PROPERTIES` 参数：

```text
Pattern = Disc
Scale = 0.8
Size X = 1
Size Y = 1
```

用途说明：
- 这一步是在为拖尾纹理增加新的圆形装饰源，避免之前只靠格形和点状节奏造成单调
- 复现时可先新建一个 `Pattern = Disc` 的 `Shape` 作为圆形源，再决定它是直接并入 `Blend` 还是交给后续 `Splatter Circular` 一类节点处理
这一张把上一张准备好的圆形源真正做成了拖尾中的成组装饰单元。下方主分支先从一个大圆形 `Shape` 出发，分出两路：一路直接进入 `Blend` 做出弯月/镂空圆弧轮廓，另一路通过两个 `Transformation 2D` 生成一个较大的实心圆和一个较小的实心点，再与前一路结果合并。之后，这个局部图样被送入 `Splatter Circular Grayscale`，右侧 2D View 已经能看到上下两组对称的小圆环图案。字幕“然后也要制作对面的这两个部分”与当前结果一致，说明作者在做成对、对称的拖尾装饰，而不是只留单侧。

节点定义集：

```text
当前重点分支：
1. Shape
2. Blend（左）
3. Transformation 2D（上）
4. Transformation 2D（下）
5. Blend（中）
6. Splatter Circular Grayscale（下）
7. Blend（右）

上方还有一条较早的圆形/点阵分支仍保留在画面中，但本图重点不是它
```

连线集：

```text
Shape -> Blend（左）
Shape -> Transformation 2D（上） -> Blend（中）
Shape -> Transformation 2D（下） -> Blend（中）
Blend（左） -> Blend（中）
Blend（中） -> Splatter Circular Grayscale（下）
Splatter Circular Grayscale（下） -> Blend（右）
```

当前图中可确认的结果状态：

```text
Blend（左）缩略图中可见类似弯月/被切掉一部分的圆形轮廓
Transformation 2D（上）缩略图中是较大的实心圆
Transformation 2D（下）缩略图中是较小的实心点
Blend（中）把三者合成后，形成“圆环 + 小点”的局部图样
右侧 2D View 显示上下两组对称的小装饰单元
```

待确认点：

```text
右侧当前属性面板显示的是 Substance_graph 的整体属性，不是当前节点参数
因此这张图只基于节点缩略图和 2D View 记录结构，不补写具体数值参数
```

用途说明：
- 这一步是在为拖尾纹理制作成对的局部圆形装饰，增强“纸片剪贴后再成组排布”的感觉
- 复现时可把一个基础圆形拆成“弧线轮廓 + 大圆 + 小点”三部分，再先在局部合成，最后通过 `Splatter Circular Grayscale` 复制成对称组
这一张把拖尾纹理从“圆形和点状装饰”再推进到“放射状尖刺层”。下方新分支可确认：一个 `Shape` 先经过 `Transformation 2D` 变成细长的尖刺/叶片形，再送入新的 `Splatter Circular Grayscale` 进行环绕复制；随后这一圈尖刺图案与上方已经存在的圆形装饰分支一起汇入右侧 `Blend`。右侧 2D View 已经显示出完整的放射状白色尖刺环，因此这张图的重点就是正文所说“再复制一个 circulator，然后放进去后就会这样”。

节点定义集：

```text
上方已存在分支（当前局部可见）：
1. Shape
2. Blend
3. Splatter Circular Grayscale
4. Blend

中部已存在分支：
5. Shape
6. Blend
7. Transformation 2D
8. Transformation 2D
9. Blend
10. Splatter Circular Grayscale

下方当前新增分支：
11. Shape
12. Transformation 2D
13. Splatter Circular Grayscale
14. Blend（右下，负责与其他分支合并）
```

连线集：

```text
下方新增：
Shape -> Transformation 2D -> Splatter Circular Grayscale -> Blend（右下）

中部已存在：
局部圆形装饰 Blend -> Splatter Circular Grayscale -> Blend（右下）

上方已存在：
另一条圆形/点阵装饰分支 -> Blend
```

当前图中可确认的结果状态：

```text
下方新增 Shape 缩略图是白色菱形/方形
Transformation 2D 缩略图把它拉成细长尖刺形
新的 Splatter Circular Grayscale 缩略图中是一圈放射状白色尖刺
右侧 2D View 显示完整的太阳芒/拖尾尖刺环
```

右侧当前可见 `splatter_circular - PROPERTIES` 参数：

```text
Scale = 1
Scale Random = 0
Scale by Pattern Number = 0
Invert Pattern Number = False
Scale by Ring Number = 0
Invert Ring Number = False
```

待确认点：

```text
右侧 Rotation 区域只露出了标题和旋钮，未显示最终旋转数值
因此这里只记录“通过 Splatter Circular 环绕复制出放射尖刺”，不补写具体角度参数
```

用途说明：
- 这一步是在给拖尾纹理加入最具方向感的放射尖刺层，使结果从圆环装饰进一步接近拖尾/能量爆发的视觉
- 复现时可先把基础 `Shape` 拉成长尖刺，再复制一个新的 `Splatter Circular Grayscale` 专门负责这圈放射层，最后与已有圆环、点状分支做 `Blend`

### 00:21:55-00:26:41 Color、Substance、材质

- 本段定位：Color、Substance、材质。
- 知识点：可以适当缩小radius的大小。
- 知识点：最后再加上这个品牌。
- 知识点：这样就构成了这种形式。
- 知识点：最后只需添加glow效果。
- 知识点：如果觉得glow效果有点不足的朋友们。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`材质`。

**关键画面：**

这一张进入 `Color / Substance / 材质` 小节后，开始收紧并整合之前做出的两个对称小装饰单元。当前可确认：上方已有一条月牙圆环分支，经过 `Splatter Circular Grayscale` 产生左右两个小圆形装饰；下方则把一个尖刺形源图样经过 `Splatter Circular Grayscale` 复制成轮辐状，再缩成左右两个小装饰；最后两路结果汇入右侧 `Blend`。结合正文“可以适当缩小 radius 的大小”，这张图的重点是在控制这些小单元的环绕半径和密度，让它们形成更紧凑的两枚对称标记。

节点定义集：

```text
上方分支：
1. Blend（已有月牙圆环局部结果）
2. Splatter Circular Grayscale

下方分支：
3. Transformation 2D
4. Splatter Circular Grayscale（尖刺环）
5. Splatter Circular Grayscale（缩成双单元）

合并：
6. Blend（右）
```

连线集：

```text
Blend（上方已有局部结果） -> Splatter Circular Grayscale -> Blend（右）
Transformation 2D -> Splatter Circular Grayscale（尖刺环） -> Splatter Circular Grayscale（双单元） -> Blend（右）
```

当前图中可确认的结果状态：

```text
右侧 2D View 显示左右两个对称的小装饰单元
每个单元由外圈细环和内部轮辐状结构组成
上方小单元更像圆环/月牙系装饰，下方小单元更像尖刺轮辐系装饰，最终在右侧 Blend 中汇合
```

右侧当前可见 `splatter_circular - PROPERTIES` 参数：

```text
Pattern Amount = 20
Pattern Amount Random = 0
Pattern Amount Random Min = 1
Ring Amount = 1
Non Square Expansion = True
```

用途说明：
- 这一步是在把拖尾中的局部装饰单元做成尺寸更紧凑、左右成对的结构，便于后续作为颜色/材质中的辅助图样使用
- 复现时若小装饰过散，可优先收紧 `Splatter Circular` 的分布半径或复制规模，而不是先改掉局部图样本身
这一张把前面所有局部分支拉回到了完整的 `Magic_Circle` 图总览。左侧 `Explorer` 已经不再是未保存的临时图，而是 `Prop.sbs` 包中的 `Magic_Circle`，右侧 `Output` 预览也显示出接近成品的魔法阵纹理：外圈细密花纹、内层几何框架、上下两个月牙圆环单元、左右两个轮辐状圆盘都已经就位。结合正文“最后再加上这个品牌”“这样就构成了这种形式”，这张图的作用就是确认整体结构已经闭合成一个完整纹理，而不是继续单独调某个局部分支。

当前图中可确认的图结构状态：

```text
包与图：
- Prop.sbs*
  - Magic_Circle
  - output

Graph 画布：
- 多条局部分支已全部汇合到右侧终端输出
- 画布中可见此前出现过的圆环、格形、月牙、圆点、尖刺等多类局部节点链
```

可从总览中可靠辨认的主要分支类别：

```text
1. 外圈圆环/花纹分支
2. 几何交错框架分支
3. 上下两枚月牙圆环单元分支
4. 左右两枚轮辐状圆盘单元分支
5. 多条 Blend 汇总到最终输出的合成链
```

右侧输出预览可确认的最终纹理构成：

```text
外圈是亮白发光感边缘和细密小图案
中层有多重同心圆与几何交错线框
上方和下方各有一个发亮的月牙圆环单元
左侧和右侧各有一个轮辐状圆盘单元
中央保留大面积黑色空心区
整体已经是可直接作为法阵/拖尾纹理使用的完整灰度图
```

右侧当前可见 `Magic_Circle - PROPERTIES` 基础信息：

```text
Output Format = 8 Bits per Channel
Pixel Ratio = Square
Random Seed = 0
```

待确认点：

```text
这张图是整体总览，单个局部节点名称和每条终端连接线不再全部可读
因此这里只按“分支类别 + 最终输出结构”记录，不逐个编造不可辨认的小节点名
```

用途说明：
- 这一步是在验证前面所有局部图样已经成功整合成完整的 `Magic_Circle` 纹理
- 复现时做到这一阶段后，应先从整体预览检查层次是否均衡，再回头修单个局部分支，而不是继续盲目堆节点
这一张已经从 `Magic_Circle` 切换到了同一个 `Prop.sbs` 包中的另一张图 `Ribbon`。画布里当前只有一个 `Shape` 节点，右侧 2D View 显示一条横向白色长条，字幕也明确提到“然后这里的 Parent Size 稍微调整一下”。因此这张图的重点不是复杂节点网络，而是新建一张用于 Ribbon/拖尾条带的基础纹理图，并先把最原始的横向带状形状尺寸定好。

当前图中可确认的包与图结构：

```text
Prop.sbs*
- Magic_Circle
  - output
- Ribbon
  - output

当前选中图：
Ribbon
```

节点定义集：

```text
1. Shape
   - 1024x1024 - L16
```

当前图中可确认的结果状态：

```text
2D View 中是一条横向居中的白色长矩形带
上下为黑色空白区域
说明 Ribbon 的初始思路是先从一条简单横带开始，而不是直接做复杂花纹
```

右侧当前可见 `shape - PROPERTIES` 参数：

```text
Pattern = Square
Scale = 1
Size X = 1
Size Y = 0.45
Angle = 0
Rotation 45° = False
```

待确认点：

```text
字幕提到 Parent Size 的微调，但当前截图右侧并未显示 Parent Size 数值区，只能确认作者正在以这条横带作为 Ribbon 的起始形状
因此这里不补写不可见的 Parent Size 具体值
```

用途说明：
- 这一步是在为第二张纹理 `Ribbon` 建立最基础的横向带状母形
- 复现时可先新建一个 `Shape`，用 `Square` 并把 `Size Y` 压薄，得到一条适合作为 Ribbon/拖尾条纹基础的横带，再继续追加后续细节

### 00:26:41-00:29:30 关键流程 07

- 本段定位：关键流程 07。
- 知识点：再加一个模糊效果。
- 知识点：会用来进行模糊处理。
- 知识点：在这里添加一个造波图案。
- 知识点：扣小一下scale。
- 知识点：将尺寸缩小到这个程度。

**关键画面：**

这一张是在 `Ribbon` 图最初横向带状母形的基础上，直接加一个模糊节点来软化边缘。字幕“再加一个模糊效果，这里会有一个模糊的边界”与画面完全一致：左侧的 `Shape` 先输出一条硬边白带，再送入 `Blur HQ Grayscale`，右侧 2D View 里可以看到上下边缘已经变成柔和过渡，而不是生硬切边。

节点定义集：

```text
1. Shape
   - 1024x512 - L16

2. Blur HQ Grayscale
   - 1024x512 - L16

3. Output
```

连线集：

```text
Shape -> Blur HQ Grayscale -> Output
```

当前图中可确认的结果状态：

```text
输入 Shape 是居中的横向白色长条
Blur HQ Grayscale 输出后，上下边缘出现柔和模糊带
2D View 中依然是横向白带，但边缘不再锐利
```

右侧当前可见 `blur_hq_grayscale - PROPERTIES` 参数：

```text
Pixel Size Width = 1
Pixel Size Height = 1
Pixel Ratio = Square
Tiling Mode = H and V Tiling
Random Seed = 0

Instance Parameters
- Intensity = 10
```

用途说明：
- 这一步是在给 Ribbon 条带建立柔边，为后续发光或透明过渡打基础
- 复现时可先把硬边白带做出来，再用 `Blur HQ Grayscale` 软化上下边界，而不是在材质里再临时补边缘过渡
这一张开始往 Ribbon 的基础柔边白带里加入波纹/噪声图案。上方原有的 `Blur HQ Grayscale` 结果已经接到 `Blend` 的一路输入；下方则新建了一条 `Voronoi -> Invert Grayscale -> Levels` 分支，右侧 2D View 里可以看到横向拉开的灰白波纹块状纹理。字幕“然后给它加上 Level”与当前节点链完全对应，说明这里正在用 `Levels` 压缩和重映射 Voronoi 反相后的明暗分布，把随机噪声整理成更适合作为 Ribbon 表面波纹的图案。

节点定义集：

```text
上方已存在分支：
1. Blur HQ Grayscale
2. Blend

下方当前新增分支：
3. Voronoi
4. Invert Grayscale
5. Levels
```

连线集：

```text
Blur HQ Grayscale -> Blend
Voronoi -> Invert Grayscale -> Levels

当前画面中还未显示 Levels 是否已经正式接入上方 Blend 的终端口
```

当前图中可确认的结果状态：

```text
Voronoi 缩略图中是横向拉伸的蜂窝/波纹状灰白纹理
Invert Grayscale 之后，亮暗关系反转
Levels 输出在 2D View 中表现为更清晰的横向灰白波纹块
上方 Blend 当前仍保留一条黑底白带的基础形状
```

右侧当前可见 `Levels - PROPERTIES` 关键信息：

```text
Luminance Channel
Levels Histogram = 当前可见
```

待确认点：

```text
当前截图没有展示 Levels 节点的完整输入/输出数值滑块
因此这里只记录“通过 Levels 整理 Voronoi 反相后的波纹分布”，不补写不可见的具体黑白场阈值
```

用途说明：
- 这一步是在为 Ribbon 基础白带添加横向波动的内部纹理，避免条带只是纯净的一整块白色
- 复现时可先用 `Voronoi` 生成基础块状纹理，再反相并用 `Levels` 压出更明确的亮暗层次，之后再与柔边条带做混合
这一张继续在 `Ribbon` 图里处理刚刚得到的横向波纹条带，但重点已经从“生成波纹”转向“为 Ribbon 头部找合适的图案/处理节点”。当前波纹结果已经被接入 `Transformation 2D`，右侧 2D View 中可见一条带有起伏明暗的横向灰白条带；与此同时，画面中央弹出了节点搜索框，输入了 `le`，搜索结果顶部显示 `Levels`。结合字幕“找到这个头部的部分，比较合适的图案”，可以确认作者正在围绕当前这条波纹 Ribbon 搜索下一步要加的处理节点或图样，而不是在这一帧里已经完成最终接线。

节点定义集：

```text
1. Transformation 2D
   - 当前输入是一条横向波纹条带

2. 节点搜索框
   - 当前输入关键字：le
   - 搜索结果顶部可见：Levels
```

当前图中可确认的结果状态：

```text
Transformation 2D 缩略图中是一条横向灰白波纹带
右侧 2D View 也显示同样的条带，并带有编辑框
条带整体保持横向展开，中间有轻微左右交错的波峰/波谷
```

当前界面可见的节点搜索结果示例：

```text
Levels
Blend
Grayscale Conversion
Channels Shuffle
Input Grayscale
Auto Levels
```

待确认点：

```text
这张图只显示了“正在搜索下一个节点”的状态，没有显示最终选择了哪个节点并完成连接
因此这里只能确认作者正在为 Ribbon 头部/局部图样寻找合适的后续处理，不补写未发生的接线结果
```

用途说明：
- 这一步说明 Ribbon 的制作流程不是只靠一个模糊白带和一层噪声就结束，还会继续为条带头部或局部图案补充更合适的形状控制
- 复现时在得到基础波纹后，应先观察当前条带头部形态，再有针对性地搜索并加入下一个处理节点，而不是固定套用某一种做法

## 补充视觉证据

### S01 00:02:11

这是一张补充参数截图，对应本页最早阶段的 `Substance_graph` 环形图元散布流程。当前图中只有三步主链：两个 `Shape` 先进入 `Blend` 组合成单个基础图样，再送入 `Splatter Circular Grayscale` 做环绕排布。右侧 2D View 中可见一个很小的中央环状图样，字幕“最终还是需要先放大尺寸”说明此时作者正在确认：基础构型已经对了，但当前散布结果还偏小，后续需要继续增大尺寸或缩放相关参数。

节点定义集：

```text
1. Shape
   - 1024x1024 - L16

2. Shape
   - 1024x1024 - L16

3. Blend
   - 1024x1024 - L16

4. Splatter Circular Grayscale
   - 1024x1024 - L16
```

连线集：

```text
Shape(上) -> Blend
Shape(下) -> Blend
Blend -> Splatter Circular Grayscale
```

当前图中可确认的结果状态：

```text
Blend 缩略图中是黑底上的基础单元图样
Splatter Circular Grayscale 缩略图中是位于中央的小型环形排布
2D View 中同样只显示一个很小的中央环状图形
```

右侧当前可见 `splatter_circular - PROPERTIES` 参数：

```text
Connect Patterns = False

Size
- X = 0.1
- Y = 0.1

Size Random
- X = 0
- Y = 0

Scale = 1
Scale Random = 0
```

用途说明：
- 这张补充图用于补足早期 `Splatter Circular Grayscale` 的尺寸相关参数，说明初始环形图样之所以偏小，是因为当前 pattern size 仍然很保守
- 复现时如果一开始只得到一个很小的中央花纹，可先检查 `Size X/Y`、`Scale` 这类参数，而不是误以为是前面两个 `Shape` 的构型出了问题

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

