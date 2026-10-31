# 场景制作

本页维护通过 UAI 将场景设计落实到 UE 对象、组织和公开操作的方式。布局、构造和可见关系通常在 Editor 状态下处理；
需要运行证据时仍遵守 [PIE 启动边界](../SKILL.md#先选择工作路径)，静态复核不自动授权试玩。

## 与 UE 基础知识的分工

完整设计链、SVG多层图、原画、阶段职责、尺度材质及UE/外部软件的边界，统一见[场景三阶段](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md)；
不要另从当前网格组织反推阶段定义。尺度、路线引导、机关空间、光照和视口问题从
[关卡知识入口](../../ue-essential-knowledge/references/07-world-level-rendering/index.md)按需选读；角色控制、检查点与存档的职责见
[游戏框架与状态](../../ue-essential-knowledge/references/10-gameplay-framework/index.md)。
空间坐标、脚点、边界和净空的推理按需使用当前环境可用的 `understand-space`。
这里只维护实际执行方式，不复制设计原理，也不把知识阅读或新文档设为每次操作的前置阶段。

## 从空间设计到UE搭建

先确定本轮阶段、功能空间、所需变化及相邻关系，消费[设计链](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#从背景到具体场景的设计链)中当前决定需要的信息。具体场景搭建承接美术白盒已确定的关系；按[阶段衔接](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#阶段衔接与回流)区分表现适配、设计调整和未决部分，不把旧transform当成冻结条件，也不另猜布局。将SVG单位、原点/轴向、标高与连接转换为UE坐标；调整方案时更新对应来源，不用原画透视或截图像素猜真实比例。

### 选择制作单位并保留阶段身份

按[阶段归属与制作单位](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#阶段内容的归属与替代)确定对象边界。Actor `folder_path` 统一采用“场景内容根/阶段/可选多级子目录”；每个场景内容Actor都须在一个阶段文件夹下面，阶段内层级按实际需要安排。导入到工具默认位置的正式内容归入此结构；标签仅辅助查询，不替代文件夹归属。灯光、机关及共享玩法也在所属阶段内分组，不在场景根下另设绕过阶段的分类。需要独立替换的墙、地坪、屋面或陈设保留分别定位的对象身份，组件跟随所属Actor，不能等退场时再从整区网格猜归属。阶段切换用下节现有入口组合，不为分类先启动Data Layer或子关卡开发。

按[制作单位](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#制作单位与ue外部软件的分工)选择实际写入对象：布局编辑Level Actor及组件，部件内容编辑网格或材质资产，整体行为或复用组合编辑相应Blueprint/组件。需要随角色或机构运动的装备沿真实组件、父对象和socket建立挂接，使用当前导出及所属公开入口；文件夹分组不承担装配关系。

从当前场景、选择、阶段文件夹和必要查询确定本次替换范围，最终落到具体导出对象身份；名称token可以辅助查找，不能证明完整退场集合。包含邻区或其他容器中实际被替代的内容，保留仍有用途的基础与独立玩法。按[资产替换与引用承接](#资产替换与引用承接)完成退场后再审阅新状态；尚不能定位的旧面保持未知。仅在跨轮、协作或复杂任务确需恢复时沿已有记录保留必要信息，不把另写替换表、账本或审批作为普通操作前提。

处理历史混合聚合时，先判断能否按完整职责退出、将需保留构件接收到当前阶段，或使用已有局部编辑能力；不要默认连续布尔切除。每步写入的partial、未知结果或语义不一致先按公开恢复与诊断处理，再判断依赖动作，不从顶层ok推定已完成全部意图。只有当前替换确需的部分进入处理范围，不能为追求规整自动拆改全场。

### 阶段隐藏、停用与恢复

复用Level的HJSON workspace，不新增阶段指令、统一停用字段或整区容器。按当前区域的替换关系定位Actor及组件；留作旧阶段备份的对象保留原归属，继续使用的玩法或构件则保持实例身份、修改 `folder_path` 迁入接收阶段，保留恢复所需原归属后再处理旧阶段，不动未涉及的集合行。迁移文件夹不改变显示、碰撞或行为。只作临时显示对照可用 `scene_editing`；涉及碰撞、导航或其他完整属性时使用 `llm_authoring`，不能向精简profile硬补字段。

1. 从当前导出保留实际要改的Actor/组件身份、字段原值及预期退场值，供本次操作与恢复使用；需要跨轮或协作恢复时才写入已有记录。碰撞保留原配置，包含继承标志、profile、启用状态、对象类型和通道响应，承接原生归一化可能联动的值。无需复制全图或另建通用状态系统。新阶段创建需要先刷新时，保留这个中间状态，不把重叠画面作为完成证据。
2. 静态白盒退出显示用Actor `bHidden` 和各相关组件 `bVisible` / `bHiddenInGame`；退出碰撞用原生 `BodyInstance` 的无碰撞配置。StaticMeshComponent还须在同批明确 `bUseDefaultCollision=false`，否则网格资产默认碰撞仍可能覆盖实例设置。重叠与阴影分别处理；旧照明、导航贡献及烘焙残留按其实际owner处理，不由隐藏网格推定已清除。字段、碰撞profile及恢复方式见CMD `t26_level_world_domain.md` 的阶段操作节，保留原导出的类型与无关值。
3. 行为型Actor按其现有Blueprint/组件/玩法生命周期停用；`bStartWithTickEnabled`、`bAutoActivate`只是初始化配置，不能证明当前行为已停止。没有已支持的停用方式时明确该对象仍活动，不能将静态白盒配方外推到AI、音频、Niagara、机关或计时器，也不使用休眠旧指令绕过。
4. 同范围改动合批导入，消费警告、`workspace_refresh` 与必要读回；顶层成功但存在相关 `readback_mismatch` 时，按实际值定位原因，不能宣布已停用。状态字段证明配置，针对旧专用碰撞的静态查询证明该查询范围已退出；运行行为和实际画面各需对应证据，不因此自动启动PIE或全面重测。
5. 恢复时用已刷新或重新导出的当前workspace，对仍是同一身份的对象恢复此前保留的原值，并处理同范围当前替代件；保留期间新增Actor和无关编辑。当前值已被其他工作修改时，按实际意图合并，不回灌旧整图workspace、不一律恢复为可见/有碰撞。删除后重建会产生新身份，应走资产替换及引用处理，不能称为原实例恢复。

以上保留对象的方式不卸载地图、不释放资源或排除打包。实际区域加载沿下文公开入口处理，其阶段分工见[加载边界与性能组织](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#加载边界与性能组织)；不把旧阶段隐藏配置当成运行时流送实现。

### 把设计约束落到对象和 workspace

动手前，将会改变本次搭建的设计决定转成实际对象与输入。沿现有设计、布局或workspace定位，不要求每件物品新建表格：

| 当前设计关系 | 创建或修改时的落点 |
| --- | --- |
| 容量、标高、连接与使用范围 | 对应Actor/Component的尺寸、完成面、开口及内容占用；相邻构件共同使用实际基准 |
| 用途、构造与邻接 | 对象边界、支承面、朝向与留空，以及需要共用的构造输入；例如吊挂长度取所在位置的真实支撑面，避免套用整栋最高点 |
| 来向、可观察信息与行动条件 | 入口、落脚面、遮挡、线索和目标的实际位置，结合当前能力、敌人及机关配置表达可采取的行动；不能只在俯视路线图中成立 |
| 行动结果、奖励使用与回返目标 | 由交互或玩法对象承接状态变化、受影响的连接/人物/资源及玩家可察觉的反馈；区分设计计划、已实现配置、运行结果和玩家理解，不以摆放模型代替这些关系 |
| 动作叙事、人物调度与停留 | 将所需站位、朝向、声源、动作及到位、回应、停留和退出条件落实到对应对象与现有玩法入口；以[最低必要表现](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#关键声音与动作的最低必要表现)参与当前组合，动画/音频资产沿各自公开入口处理 |

只补齐影响下一次放置的未知，随后让依赖对象消费同一有依据的尺寸与边界。共享部件的共同部分和各实例的邻接差异分别处理；同源问题改共同输入，局部问题保留局部范围，避免逐件偏移掩盖原因。

按[代表性整体与逐步扩展](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#代表性整体与逐步扩展)确定本轮组合范围，再依据对象依赖安排写入批次。先把主要形体、占用、入口、路线、关键内容及本阶段所需状态关系落入UE；已有玩法沿真实对象和配置接通，新行为按所属玩法职责与当前授权实现，临时占位明确标注，不能把示意当作运行结果。移动、旋转或换网格时，同时处理受影响的占用、接触、使用与通路对象，不只更新被选中物件的transform。正式资产组合的旧内容按上述替换归属退出；细化与反馈针对当前未决关系，不等整间精修完才看，也不为每个道具固定拍图或完整读回。

白盒按[白盒尺度与材质](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#白盒尺度与材质)绑定颜色和尺寸刻度材料，将刻度单位与UE实际尺寸对应。对象缩放或投射改变后，不能沿用失真的格线判断大小。原画/叠绘使用已知白盒视角和空间关系作为输入；它决定当前视觉目标，不代替真实几何和关卡绑定。

UAI primitive 新建和新 voxel-grid 首次 apply 默认使用插件自带尺寸材质；可用 `color=[r,g,b]` 指定线性 RGB，或用 `material_ref` 显式选择其他材质。颜色和首次网格原点随组件保存，不为每件白盒生成一个材质资产。曲面格线是投影尺度参照，不作为沿曲面的长度尺；后续改颜色、覆盖材质和 Modeling Mode 新建结果的适用边界见 Plugin `docs/active/t38_modeling_geometry_operation.md` 的 Bundled metric material。

### 使用公开入口搭建

资产/候选查询按 [CLI](cli.md) 定位，选型依据沿[选型与组合反馈](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#选型与组合反馈)。先消费已有的有效预览；尚未认识的候选用[文件夹资产总览](asset-preview.md#文件夹资产总览)批量查看，需要辨认本体或细节时再用该页资产预览入口，不先批量摆入场景试猜。当前地图按[公共 HJSON 流程](hjson-workspace.md)导出 workspace、直接编辑并导入。
基础摆放、网格/材质槽、原生灯光强度/衰减半径和 PostProcessVolume Settings 可在该流程显式选 `scene_editing` profile；其他完整 Actor/组件参数用 `llm_authoring`。具体原生类/字段范围、Settings 保留及刷新行为沿上述公共流程，不手工删除导出字段来模拟精简 profile。
需要在应用前协调本批编辑与邻近内容时，沿[工作区只读分析](hjson-workspace.md)取得拟状态的对象/组件/实例上下文及几何事实，再用同一分析版本导入。范围取实际变化与旧、新邻域，不能只按名称、文件夹或碰撞开关筛邻居；结果中未覆盖的构造、变形与加载范围保留为未知。分析帮助落实当前构造、用途和通路关系，不替代设计，也不要求每个小改动建立报告或全场检查。
沿导出的对象身份定位，不以命名相似猜 selector。独立部件用目标World的 `world.actor.candidates` 选Actor候选并写入 `actors` 集合；网格候选由原生放置建立默认组件。给已有Level Actor添加组件时，用 `content_graph.items` 返回的Actor `object_ref` 查询 `world.component.candidates`，按需 `describe` 所需少量属性，再在该Actor的 `level_components` 结构内给 `components` 增添可读键、候选 `name/select` 和首批 `properties`。删除实例新增组件则移除对应已捕获键；类或蓝图构造拥有的组件应改其源。保留其他行，不手写内部owner/GUID、operation或新造组件文件。`blueprint.component.candidates` 仍属于Blueprint/SCS。新Actor先创建并消费刷新再加组件；既有组件属性继续编辑其 `properties.hjson`，attachment取Level当前导出形状。
内容资产具备当前组合所需的形态和接口即可摆放，材质与光照在实际关系中继续调整；不把整套资产精修设为首次落图的前置。共用生成或材质方法先用真实消费者取得能判别其效果的反馈，再复用到有依据的同类对象；同源错误修正式源并更新真正受影响的消费者。
Level/Actor/Component 合同见项目 `Plugins/UeAgentInterface/docs/active/t26_level_world_domain.md`，
SDK 编辑示例见 `UeAgentInterfaceCMD/docs/active/t26_level_world_domain.md`。
网格/材质替换、一对多组合、旧内容退场与引用处理按下节执行；具体公开字段与例子沿上述T26文档，不在skill复制整套schema。
地图根 target 的 `properties.hjson` 按原生类别导出 WorldSettings 属性（包括 GameMode）；按当前字段和类型修改，
仍通过同一 workspace 导入，未改字段保留。玩家入口按目标选择，不为已有可用入口另建 GameMode。

白盒搭建消费[加载边界与性能组织](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#加载边界与性能组织)的阶段职责，将候选区域和跨区关系沿用到独立Actor及既有布局来源；仅预留边界时不要求配置整套流送。实际场景搭建时，按该知识来源的默认选型与实际需求使用下述公开入口，落实对象的加载归属、常驻内容与跨区依赖。阶段 `folder_path` 与加载配置分别维护；建立子关卡或分区不替代阶段分类，移动文件夹也不改变加载归属。性能预算同时参与资产与灯光配置；复用已有性能证据，缺少运行验证时明确限制，并遵守既有PIE授权边界。

流式子关卡关联与 Actor 归属使用同一 Level HJSON 的 `level_world` 和 Actor `level` 字段；按当前导出声明编辑。显式 `null` 解除关联并保留子地图，遗漏字段不代表删除。Editor 可见、已加载状态与运行时初始标志分开读回，隐藏不等于卸载；配置初始标志不等于完成玩家移动时的加载触发逻辑。
普通已保存 Level 转为 World Partition 使用 `job.compile_build` 的 `policy:world-build:partition-convert/v1`，默认原生转换配置输出独立 `_WP` 地图并保留源；新建空白 WP 是另一入口，Enable Streaming 不是转换操作。World Partition 的流送开关、Actor 空间加载和 HLOD 引用从当前 workspace 编辑；HLOD Layer 和 DataLayerAsset 资产走 Reflection，地图 `level_world.data_layers` 编辑实例初始配置，Actor 原生 `DataLayerAssets` 属性编辑成员归属。`world.partition` 可选 `include_actor_descriptors` 无加载查询未加载 Actor。配置保存后，HLOD 原生生成另走公开 job policy；区域加载与 Data Layer 临时 Editor 加载/可见状态使用有明确生命周期的 `editor.session` handle，后者 close 恢复原状态。具体参数、转换限制与等待条件见 CMD `t59_world_command_migration.md`，不把配置成功当成生成或运行时流送通过。原理见[流式关卡、World Partition 与 HLOD](../../ue-essential-knowledge/references/07-world-level-rendering/streaming-partition-hlod.md)。

同一空间内已明确、可共同表达且没有生成结果依赖的改动合并导入，复用仍有效的候选和读回；批处理与生成器执行已经确定的布局和构造输入，既有入口只维护本次变化，不为每轮小调整重建整套组合或脚本。`workspace_refresh.status=refreshed` 后只重读受影响文件，不重复完整Level导出；其他目录不会随之刷新。缺少刷新承诺、刷新失败或过期冲突按[HJSON workspace](hjson-workspace.md)恢复，不原样重放。重复构件确需ISM/HISM时，沿制作单位边界按独立编辑、实例定位、替换与性能成本选择。

白盒在UE中按目标形体与编辑边界选择公开支持的基础形体、建模或可调整构件。单个职责内连续的平台、台阶、坡道及带切口体块可用 [CubeGrid](cubegrid.md) 续编，仍保留后续独立替换边界，不因可连续增删就把多栋建筑、道路和基础合为一体。具体形体与内部布置消费[美术白盒完成度](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#形体与内容的完成程度)；外部软件的范围按[部件分工](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#制作单位与ue外部软件的分工)，不另维护整区搭建源。

能力缺口或反复失败出现时，先核对现有公开入口、实际输入和结果语义；能用已支持的方法完成当前内容时沿用。确需修工具则按现有授权和项目维护流程处理，明确工具改动与地图实际变化，不能把普通场景任务自动扩成命令开发或无界排障。工具准备、选型及恢复记录不算新增场景进度。

### 资产替换与引用承接

先区分同实例换表现、改变构件数量，还是改变玩法职责。明确本次旧Actor/组件、新部件、承接的关系、保留引用及旧内容去向，已有场景和操作上下文足够时直接执行；引用交给实际承担相应职责的对象，不能把一个单值引用直接扩成整个多部件组合。

同Actor换网格/材质，定位原组件的 `properties.hjson`，只改已声明 `StaticMesh` / `OverrideMaterials.value` 并保留类型定义及实例身份，不重建同名Actor、不修改共享资产冒充实例替换。按[替换与衔接](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#替换与衔接)判断材质覆盖的保留范围，再按新网格槽位映射，只清除已失效的覆盖；pivot、尺寸、socket和碰撞差异按实际用途处理。普通静态组件的原引用继续指向同一对象；Blueprint构造可能重建组件，不能据此保证所有组件引用均保留。

一对多替换仍用同一 `actors` 集合。已知摆放且不依赖新对象引用时可合批增删；需要新组件属性或真实引用时，先创建独立新件并消费刷新，取得实际Actor/Component `object_ref`，再合批配置、转接已知支持的引用和退掉旧表现。永久退出只删除明确旧键；可恢复内容按[阶段操作](#阶段隐藏停用与恢复)保留停用，同时保留恢复所需的被转移引用原值。保留无关行和共享玩法，不把新旧同时存在的中间状态当作完成。

引用发现与编辑使用完整 `llm_authoring` 工作区；`scene_editing` 未包含多数引用属性。对当前公开内容精确搜索旧对象路径、定位实际属性，已知消费者可用 `content_graph.properties` 定向读取；只改所属属性值，不批量替换名称或改依赖报告。`asset.relations` 是磁盘资产依赖，Level的 `content_graph.relations` 是成员/所属关系，均不能充当全场景字段入引用扫描。跨地图、图节点、Sequence绑定、构造逻辑和名字查找依实际消费者走各自入口，未覆盖的范围明确保留。

不要假定新Actor继承旧身份或原生删除会自动重映射。缺少可用转接入口的关系，保留仍承担职责的逻辑对象并仅退出旧表现，或说明该项迁移未完成；不能为删旧件清空引用或复制玩法。Actor挂接与普通属性引用是不同合同，新父对象不可把 `object_ref` 填入 `parent_managed_id`；沿T26的当前边界处理，不猜内部标识。

导入后消费刷新、警告和必要定向读回，明确旧内容实际退出方式、引用接收者及未覆盖消费者。同实例引用与属性保留、静态碰撞退出、画面和运行行为分别按已有证据判断；不为引用检查自动启动PIE，也不每换一个部件重新导出全图。

## 制作中按问题取得反馈

围绕当前未决关系选证据：容量、支撑和衔接看实际UE体积、transform与几何来源，必要时作局部查询；可见信息和受光看对应视角；条件和状态沿玩法配置定位。设计假设、配置读回与实际运行结果分开，静态画面不能代证交互或玩家理解。画面按[实际查看与有效画面](verification-and-knowledge.md#运行与视觉任务)打开判断。

引导疑点明确来向、当前目标、相机以及有关门、机关、奖励、人物事件和威胁状态，选择真正改变判断的访问顺序、遭遇后位置或回返出口。通行目标与额外收益分别定位；先前经历和结束位置不能仅由设计预设为事实。一处入口或总览图不代表其他差异视角，不机械采集全部入口与状态组合；具体设计原则由[路线与玩法选择](../../ue-essential-knowledge/references/07-world-level-rendering/level-layout-and-player-guidance.md)维护。

已有有效信息足够就继续搭建，仅补改变后的关系或尚存疑点。新旧叠置的诊断图不作新组合完成证据，退场后只重取受影响画面；不为每件物体固定拍摄，也不以密集查询或全场巡检代替设计。反复微调仍无法解释问题时，返回设计、对象归属或实际绑定。

### 有需要时使用空间查询

空间查询按问题逐步收窄：`nearby_shapes`的组件Bounds只作候选定位，`overlap`/射线/形状查询回答各自碰撞表示下的问题。命中聚合组件时不能编造内部墙、屋顶或道具身份；转到当前workspace及部件来源判断，仍无法定位时明确未知，不用名称猜HJSON selector。
只消费下一决定需要的目标引用、位置、计数或属性，完整回执按任务需要保留，不默认展开全部通道或组件字段。

`world.capsule_path`默认只给阻挡段数；下一步需要定位障碍时，在该次调用显式请求`include_first_hit=true`，
直接消费首阻挡，避免为同一命中机械追加sweep。首命中的native组件引用不是HJSON selector；初始穿透的位置不证明精确接触面。
`trace_complex`只选择原生碰撞查询表示，仍受资产设置影响，不能用复杂查询通过替代Pawn实际表示下的通行结论。
输入与返回细节按CMD `docs/active/t06_non_hjson_query_migration.md`及当前`describe`读取，不默认展开全部命中或组件属性。

### 形成目标画面

制作或调整目标画面时，主动使用 Editor 场景视口及适用的公开截图入口并查看结果。多个视口并存或投影类型影响判断时，
从 `viewport.instance.list` 选择目标 world 对应的 `viewport_ref` 和 `viewport_type`，后续配置、取景与截图使用同一视口。
材质、照明、曝光和构图的判断回到 UE 基础知识；实际参数以当前对象与公开合同为准。
摆放辅助显示只回答形体、位置或遮挡问题；转入照明评价时，核对当前 Lit、曝光和后期是否仍带有该辅助设置，按任务恢复正式评价状态，不沿用临时提亮来证明场景照明。无需为此固定重设全部视口参数。
临时调整视口时保留 `viewport.state_read` 的完整 `payload`，恢复时原样交给 `state_restore`，不重建字段白名单。
视口选择、配置与有效状态的区别及支持的显示标志见 CMD `docs/active/t45_viewport_graph_control.md`；参数取当前 `describe`。

静态画面可省略 `policy_id`，对 `capture-subject:viewport:active` 默认使用 `viewport/v1`；观察场景中的动态效果显式使用
`policy:image-capture:viewport-sequence/v1`，同一操作内按真实 Editor engine frame 连续采集。
两者 subject 都是 `capture-subject:viewport:active`；序列的 `frame_count`（2..16）与 `interval_frames`
按要观察的变化选择，精确参数查当前 `describe`。普通单图的 `warmup_frames` 不证明 Editor World 已持续推进。
帧表、逐帧原图与实际采样时间的读取见[预览截图与时间轴](preview-capture.md)。
单图的冷启动零尺寸初始化可保持宿主窗口最小化；只有该初始化路径会先跨真实 Editor 帧建立首个可采集画面，已有正视口尺寸仍即时采集。尺寸来源、初始化帧和固定尺寸约束恢复信息见回执及上述截图指引。

本体形态、材质或动画疑点可用[资产预览](asset-preview.md)隔离观察；实际受光、遮挡、尺度和组合关系用场景视口。按问题选择，不固定先后双轮；一幅有效画面已回答本体与组合问题时直接复用。不能确定可见表面归属时，先结合 `viewport.ray_trace` 的命中主体定位；最小化视口的显式冷尺寸用法见上述 T45 文档，采用截图回执尺寸，并区分碰撞命中与可见面的差异。目标被遮挡或裁切时先修正取景；为辨认暗部形体使用的辅助显示应说明用途。评价照明时保留真实暗部，不用临时曝光或补光掩盖问题；截图与用户画面明暗不一致时先核对同机位显示与捕获条件，不调整正式灯光补偿。取景回执正确不等于目标可见。
玩家输入、碰撞交互或游戏逻辑确需运行证据，且满足入口的授权边界时，才进入[运行时 PIE](pie.md)。
无需为静态场景制作额外建立运行时测试。

## 保存与交付边界

后续编辑留下 dirty 地图时，按[仅保存既有资源](hjson-workspace.md#仅保存既有资源)只保存该地图。
设计被实际关系推翻时，按[阶段衔接与回流](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#阶段衔接与回流)在已授权范围返回所属设计或构造输入；保留仍有效的结果，收窄已被推翻的结论，不自动重做全场。
交付按[目标质量与组合反馈](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#选型与组合反馈)说明搭建落地、局部正确和目标质量各自的证据范围，以及未完成项。只完成资产/源码/工具准备、资产数、实例数、保存回执或局部修补不代替场景质量；维护输入改变但未绑定关卡的内容不算场景完成，局部结果不外推为整体。用户停止检查时保留未覆盖边界，不追加PIE或门禁。通用证据复用、后续修改的影响和收尾由[验证与知识](verification-and-knowledge.md)维护。
