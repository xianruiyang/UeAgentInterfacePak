# 材质与着色

## 覆盖范围

- Material、Material Function、Material Instance。
- Expression 节点、Root input、参数、静态开关。
- Shader 编译、Substrate、Lumen 相关材质约束。
- UV、Normal、Tangent Space、World Space、Screen Space。

## 阅读时机

- 需要创建或修改材质图、材质函数、材质实例参数。
- 出现材质编译错误、黑色/白色输出、透明/不透明混淆、空间方向错误。
- 需要解释材质节点来源、输入输出语义或 shader 编译结果。

## 通用经验

### 材质采样与过滤

所有贴图和程序化图案都必须考虑屏幕采样与过滤层级。贴图应使用合适的 mipmap、采样过滤和 UV 频率；程序化图案没有自动 mipmap 时，应使用 `fwidth` / `ddx` / `ddy`、`smoothstep`、预滤波、距离淡出或降低频率等方式做等效过滤。否则在远距离、小尺寸、斜视角、细 Ribbon / Beam / Sprite 或高频发光图案上，容易出现摩尔纹、闪烁、虚线、亮点和时域抖动。

### UV 方向、密度与信息分工

UV 畸变小、格子方正，不等于铺装方向符合构造。屋面各坡面、转角和过渡段应按各自的目标方向理解图案；带字母或箭头的参照能暴露无方向棋盘格不易表达的倒置。方向与纹理密度是不同属性，全局旋转或统一密度不能保证所有面同时适用。共享 UV 的模块族还要包含当前实际需要的过渡变体：直段形体与贴图成立，不代表改形后的坡口仍能使用同一布局；既有布局排满是返工成本，不是不能调整的技术约束。

[不同 UV channel](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-uv-channels-with-static-meshes?application_version=5.7)可承担不同采样用途，例如独有烘焙或蒙版信息与重复平铺细节。是否需要多套 UV 取决于信息分布，不固定编号或套数；材质实际使用的通道也要与用途一致。平铺颗粒清晰，不能证明独有雕刻或蒙版分界清晰；后者受其 UV 面积分配和纹素覆盖影响，仅提高平铺频率不能补回独有信息。

### 材质层的坐标与变化粒度

结构 trim 的局部定位与附加粗糙度等变化层不必共用映射。逐件重置的变化出现明显接缝或重复时，可单独改变该层的采样依据，保留结构层；[世界空间投射](https://dev.epicgames.com/documentation/en-us/unreal-engine/texturing-material-functions-in-unreal-engine?application_version=5.7)可让静态相邻表面共享连续坐标，但不会修复几何错缝，也不保证完全消缝。其纹理留在世界空间，对象移动或旋转时可能出现滑动，因此静态组合的效果不能直接代表移动资产。

合并网格或改变组件、实例表示，可能改变材质变化所依据的数据粒度。以[对象位置](https://dev.epicgames.com/documentation/en-us/unreal-engine/coordinates-material-expressions-in-unreal-engine?application_version=5.7)或[实例随机值](https://dev.epicgames.com/documentation/en-us/unreal-engine/constant-material-expressions-in-unreal-engine?application_version=5.7)驱动的变化，应按实际对象或实例理解，不能把 Blueprint 封装等同于几何合并或整组同色。组间差异与组内单件差异分别服务布景目标；预置内部色差加整组色调可满足静态外观，却不等于逐件独立随机或控制。按所需粒度选择表示与数据来源，不为色差一律拆散组合。

### 法线、表面凹凸与几何位移

[Normal 输入](https://dev.epicgames.com/documentation/unreal-engine/material-inputs-in-unreal-engine)改变着色法线与受光细节，不因此增加几何轮廓或实体起伏；WPO 移动已有顶点。[Nanite Tessellation](https://dev.epicgames.com/documentation/unreal-engine/nanite-tessellation)则在适用版本、平台与网格/材质条件满足时细分并位移几何，不能从单个材质开关推定最终已生效，位移也不自动提供匹配的着色法线。按问题属于表面受光、轮廓、接合还是运动来选机制；这些渲染结果不能代替[独立的碰撞表示与响应](../07-world-level-rendering/blockout-and-traversal.md)。

植被的着色法线取舍同时影响叶片间的局部过渡和整团树冠的明暗组织。局部更柔和可能抹平需要的片区变化，只看远处整体又可能漏掉近处卡片感。结合实际形态、目标风格和观看距离保留所需变化；树冠与灌木可采用不同处理，但不能仅按大小规定平滑或球面投射方案，也不把着色变化当成投影阴影几何改变。

### 表面混合与局部覆盖

多层材质的纹理重复尺度、混合权重的空间分布与各层表面属性分别判断。使用[顶点颜色混合](https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-texture-blended-material-for-vertex-weights-painting-in-unreal-engine)时，各通道代表什么、数值增减怎样改变覆盖，取决于材质实际接线；通道本身没有固定的水洼或旧化含义。纹理颗粒过大、覆盖边缘过粗和水洼过亮，需要找到各自的控制来源。

顶点颜色由网格顶点承载，可绘制分布的细节受顶点数量与空间分布限制，提高贴图清晰度或平铺频率不会增加这些采样点。覆盖边缘或拼块接续不符合目标时，先辨明承载数据、材质解释与相邻块分布，再按所需细节和成本选择局部细化或其他遮罩；不把教程细分数当通则。[网格拓扑改变](https://dev.epicgames.com/documentation/unreal-engine/vertex-color-matching-in-unreal-engine)还可能使原有绘制数据失配，换网格或重新导入后不能推定它已正确承接。

若把局部绘制改由纹理蒙版承载，控制能力转而受 UV 分布、目标部位的纹素覆盖、分辨率与过滤影响。需要独立控制的表面不能无意共享同一采样区域；UV 岛留白与边缘处理还会影响相邻区域的串色。相同纹理尺寸不代表各部位有相同控制精度，低顶点密度也不自动使蒙版更便宜或更合适。UE 的[纹理绘制](https://dev.epicgames.com/documentation/en-us/unreal-engine/setting-up-a-material-and-mesh-for-texture-color-painting-in-unreal-engine)还要求绘制与材质采样使用相匹配的 UV；具体绘制机制按版本选择，不照搬旧案例的分辨率或设置。

投射贴花的可见图案与投影范围分别判断。[Decal Actor](https://dev.epicgames.com/documentation/unreal-engine/decals-in-unreal-engine)的朝向、尺寸与投射深度共同限定影响区域；图案在目标墙面上看似合适，附近柱体、地面等接收表面仍可能受到不需要的投影。按实际接收面与目标来向调整，不能只看正面的图案轮廓。

### 局部半透明效果的范围与内部变化

用半透明平面表现局部雾时，平面的位置、朝向与尺寸限定承载范围，外缘遮罩、与场景交界处的淡出及内部图案与运动可分别控制。辨别当前问题属于空间覆盖与遮挡、硬边还是内部变化，避免用更多噪声或运动代替对范围与边界的处理。

例如，[DepthFade](https://dev.epicgames.com/documentation/unreal-engine/depth-material-expressions-in-unreal-engine)用于缓和半透明表面与不透明几何的交界，[Panner](https://dev.epicgames.com/documentation/unreal-engine/animating-uv-coordinates-in-unreal-engine)平移纹理采样的UV；实际影响哪些图案或遮罩由接线决定。柔和的平面轮廓不等于三维雾密度，平面方案的适用性仍需结合目标观察来向与相机变化判断。

### 材质实例的有效参数

[材质实例](https://dev.epicgames.com/documentation/unreal-engine/creating-and-using-material-instances-in-unreal-engine)的有效参数由实际 Parent 继承链、父材质公开的参数、本实例的覆盖状态与取值共同决定。未启用参数覆盖时继续继承父级值，这与将布尔参数设为 False 不同；启用覆盖也不自动把布尔值设为 True。实例参数覆盖与场景组件选择哪份材质是不同职责，不能用其中一层的正确性推定另一层已生效。

### 既有材质的属性承接与状态响应

跨软件导入不保证源着色网络等价迁移。例如[FBX 材质管线](https://dev.epicgames.com/documentation/en-us/unreal-engine/fbx-material-pipeline-in-unreal-engine?application_version=5.7)转换受支持的基础材质和部分贴图语义，并非任意DCC材质网络与设置。材质资产已生成、槽位存在或Base Color可见，均不能证明所需的其他表面属性已承接；按源材质意图与UE中实际输入、最终输出恢复需要的响应。

把天气等表面变化接入已有材质时，按实际函数接口和数据流识别输入、输出、默认值及需要保留的基础属性。属性拆分后再重组，或只连接部分通道，都不能仅凭高层连线认定原有结果已被承接；以最终输出中的实际属性为准。打包贴图的通道含义与采样设置取实际资产来源，不凭名称缩写推断。材质属性的组织方式参见 [Epic：Material Attributes Expressions](https://dev.epicgames.com/documentation/unreal-engine/material-attributes-expressions-in-unreal-engine)。

状态控制、降水表现与表面响应是不同职责。雨雪已经可见，不代表网格材质与贴花均已响应；相邻表面按实际材料、遮蔽与场所意图形成相容的变化，不要求响应强度相同。必要信息的辨认范围由该天气状态下的观看与玩法目标决定。

## 后续填充位置

- 常用材质空间与坐标转换。
- Root input 与 Blend Mode 的关系。
- Material Function 复用规则。
- 编译错误和 preview 误差排查清单。
