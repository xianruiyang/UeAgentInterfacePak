<!-- Source: leveldesign skill / levelDesignDocs/core/自动化关卡设计.md -->

# 自动化关卡设计

## 1. 目的

本文档是项目内自动化白盒与关卡设计的总纲，只保留会反复使用的共性规则。

如果你是在找“从头到尾先看哪份、后看哪份”的向导，请先看：
- [whitebox-workflow.md](whitebox-workflow.md)

它回答 4 件事：

1. 什么时候可以开始搭白盒
2. 搭白盒前必须先锁什么
3. 搭建时的默认工作流是什么
4. 什么情况下必须停下返工

涉及 `Modeling` 的具体使用，见：
- [../modeling/modeling-assisted-blockout.md](../modeling/modeling-assisted-blockout.md)

涉及跨楼层连接、竖向设施和设施贴合，见：
- [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)

涉及中型以上白盒的设计包门禁与最小设计包内容，见：
- [design-doc-spec.md](design-doc-spec.md)

涉及常见失败模式，见：
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md)

## 2. 基本原则

### 2.1 先结构，后几何

白盒不是“先摆一堆盒子再看像不像”，而是先定义：

- 关卡类型
- 主玩法
- 玩家能力模型
- 空间骨架
- 路径关系
- 验收标准

然后才进入几何生成。

### 2.2 先能力模型，再谈可达

没有玩家能力模型，就不能下“连通”结论。最多只能说：

- 几何相邻
- 候选通路
- 潜在通路

只有在当前能力模型下可进入、可使用、可离开，才叫成立。

### 2.3 先空间单元，再摆设施

门、楼梯、斜坡、电梯、`Zipline`、控制终端，都应该服务于已定义好的空间关系与路径契约。设施不是主结构的替代品。

### 2.4 默认优先清晰，而不是复杂

优先做：

- 清晰的主路径
- 可解释的支路
- 可读的高差关系
- 可验证的锁钥链

避免：

- 功能很多但结构发散
- 多层很多但类型识别失败
- 设施很多但玩法骨架不成立

## 3. 开搭前门禁

### 3.1 中型以上白盒必须先有设计包

中型以上白盒关卡，正式搭建前必须先完成最小设计包。  
具体适用范围、字段清单和禁止做法见：
- [design-doc-spec.md](design-doc-spec.md)

## 4. 白盒搭建工作流

### 4.1 锁能力模型

开搭前先锁：

- 胶囊体尺寸
- 基础移动方式与关键指标（速度、跳跃高度/距离等）
- 通行与空间指标（门净宽、走廊净宽、楼梯净宽、最小净高、最小落脚区等）
- `step height`
- 交互方式与常用交互距离
- 视角与相机边界

目标层口径见：
- [../references/level-design-methodology.md](../references/level-design-methodology.md) 的 “二、先锁指标”

### 4.2 定义空间节点与路径

至少先画清：

- 主路径
- 支路
- 回环
- 锁钥前后路径变化
- 收集品如何引导支路探索

### 4.3 定义空间边界与门户

空间成立至少需要：

- 明确的可站立面
- 明确的边界
- 明确的进入与离开方式

门户必须按区间定义，而不是靠“留一个空”。

### 4.4 定义跨层连接

跨层连接一律先按连接单元定义，再选设施。具体规则见：
- [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)

### 4.5 生成几何

生成顺序建议：

1. 完成面
2. 边界
3. 门户
4. 跨层连接单元
5. 设施
6. 收集品
7. 非关键装饰性体块

### 4.5.1 分段生成（推荐的“测量→生成”循环）

不要一次性把整张图全生成出来再开始“补丁式修几何”。中型以上白盒更推荐拆成多个**可验收的小段**（房间段/廊道段/连接单元/支路段），每一段都按固定循环推进：

1. 先锁定上一段的连接口/落脚区（必要时先放一个 `TargetPoint` 作为 probe）
2. 用相机确认连接处周围语义（洞口/平台边/净空是否成立）
   - 经验：`viewport_frame_actor(s)` 只会平移相机，不会改 `rotation/fov`，很容易“挪过去但镜头朝向不对/拍到空墙”
     - 需要构图时优先：`viewport_focus_actor` 或直接 `viewport_set_camera`
   - 室内/贴墙取景容易卡墙：优先用 `viewport_frame_folder(collision_aware=true)` 或手动 `viewport_set_camera` 做安全位移
   - 脚本里要“点选识别对象”时，优先 `viewport_trace_screen_point`（`hit=false` 也不会报错）；`viewport_pick_actor_at_screen` 未命中会报 `actor_not_hit`，在批处理中容易导致整体失败
3. 用 `level_get_nearby_actor_obbs` 读取 probe 附近 OBB，确认附近确实存在：落脚面、边界、门户或阻挡体；并快速发现“孤立浮空块/明显穿插/贴合不成立”
4. 对关键方向补一轮最小量测：
   - `level_trace_world_ray`：确认落脚面高度、洞口位置、坡向是否反了
   - `level_sweep_capsule`：确认门洞/走廊/到站净空是否可通行
   - `level_check_overlaps`：确认洞口、门、设施周围是否存在穿插与挡死
   - `navmesh_build` + `navmesh_find_path`：关键节点连通性（**只在“同一可站立层面”上才可信**）
     - Probe 点位必须落在“真实可站立面”的空地上：避免把 probe 放在楼梯/坡道 OBB 内或贴边缘
     - 推荐做法：先 `trace_down` 得到“期望落脚面”高度，再跑 `navmesh_find_path(project_to_nav=true)`，对比 `start_projected.z` 与期望高度
       - 若 `start_projected.z` 明显偏离（例如 >50cm），说明 Nav 投影到了别的层面（常见：楼梯台阶/上层平台），这类点位用于“连通性验收”会产生假阳性/假阴性，必须移动 probe 或改用其它验收
5. 再生成下一小段几何或设施，并立刻回到第 2 步

好处：把“摆放逻辑/连通失败/贴合缝隙”在局部就止血，避免错误滚到全局后难以定位根因。

### 4.5.2 跳跃/跑酷段验收（NavMesh 无法覆盖）

对白盒里的跳跃台阶/跳台链路，`NavMesh` 基本只能验证“落脚面是否有导航”，不能验证“是否跳得上去/跳得过去”。因此必须补独立验收：

1. **落脚面落地**：对每个平台中心点 `trace_down`，确保命中可站立面（避免悬空或落在洞/井的 footprint 内）
2. **头顶净空**：对每个平台从 `top + 5cm` 向上 `trace_up`，确保在角色最小净高内无命中（避免平台在目标楼板/平台投影下方导致“能看见但站不住”）
3. **跳跃包络**：记录每段跳跃的 `ΔZ`（上升高度）与水平距离，并对照能力模型的 `max_jump_up / max_gap`（没有能力模型就禁止下“可达”结论）
4. **平台不应位于目标平台正下方**：跳台链路应从目标平台边缘外侧接近，而不是把跳台塞到目标平台 OBB 投影下方（典型症状：最后几级跳台“贴着天花板”或“站立就顶头”）

### 4.6 设施与收集品

默认原则：

- 设施必须服务路径，不得反过来主导结构
- 收集品必须有位置理由
- 支路必须有价值，不得只增加路程

## 5. 可达与连通

### 5.1 连通的定义

连通不是“看起来通”，而是：

在当前玩家能力模型下，角色能从一个可站立区域进入另一个可站立区域，并能继续离开。

### 5.2 必须区分的 3 层概念

1. 几何相邻
2. 候选通路
3. 真实可达

只有第 3 层成立，才允许叫“连通”。

### 5.3 高处边界默认封口

高处平台默认应封边。只有当局部开口服务于明确的向下玩法路径，并且：

- 下方有有效落点
- 落下后可继续推进
- 落下后可离开

才允许保留受控下落边。

## 6. 尺寸与贴合

### 6.1 空间尺寸必须先锁

每个空间的长宽高、通道净宽净高、落脚区尺寸，必须在真正搭建前先定好。不能先随意搭，再靠截图倒推。

### 6.2 设施不能靠中心点手摆

门、楼梯、斜坡、电梯、`Zipline` 都必须从连接边界派生，不得只靠 actor 中心点和肉眼对位。

### 6.3 障碍物必须绑定所属空间

任何内部方块、掩体、柱体、柜台、祭台，都必须先绑定所属空间，再从该空间完成面推导位置。不得直接写绝对高度。

## 7. 锁钥与设施

### 7.1 锁钥关系必须显式

锁钥关系必须写进可达图。至少要写清：

- 锁点在哪里
- 钥或控制条件在哪里
- 解锁前后的可达变化

### 7.2 设施是锁钥结构的一部分

门、电梯、`Zipline`、控制终端都可以参与锁钥，但它们首先必须作为空间与路径成立。不能为了做锁钥而牺牲设施可用性和空间可读性。

## 8. 验收

### 8.1 先验结构，再验外观

优先验证：

- 类型识别是否正确
- 主路径是否成立
- 跨层连接是否成立
- 锁钥链是否成立
- 收集品是否有分布逻辑

### 8.2 中型以上关卡的最低验收项

- 关卡类型能否一眼识别
- 主玩法是否是主骨架，而不是附属体验
- 跨层连接是否与能力模型一致
- 关键设施是否真的可接近、可使用、可离开
- 终端/篝火/收集品等点位是否从落脚区派生（或至少通过“附近落脚面检查”，例如 `level_get_nearby_actor_obbs` 能命中对应 floor/landing surface）
- 门是否无错向、无缝、无漂浮
- 玩家是否不会被带出地图或软锁

第一次自动化生成时，强烈建议按“必过清单”逐条过一遍（否则很容易进入补丁地狱）：
- [../checklists/first-automation-generation-checklist.md](../checklists/first-automation-generation-checklist.md)

## 9. 什么时候必须停下返工

出现下列情况之一，必须先回退到设计包或结构真源：

- 关卡类型识别失败
- 主玩法被设施清单替代
- 跨层连接只能靠硬摆 actor 成立
- 门和设施持续出现错向、缝隙、悬空、穿模
- 结构表和生成结果反复不一致
- 同类错误反复出现两次以上

## 10. 文档边界

本文档只保留共性总纲。具体专题放到其他文档：

- 流程向导： [whitebox-workflow.md](whitebox-workflow.md)
- 设计包规范： [design-doc-spec.md](design-doc-spec.md)
- `Modeling`： [../modeling/modeling-assisted-blockout.md](../modeling/modeling-assisted-blockout.md)
- 跨层连接与设施： [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)
- 参考图任务： [../references/reference-image-reconstruction.md](../references/reference-image-reconstruction.md)
- 锁钥专题： [../references/lock-and-key-design.md](../references/lock-and-key-design.md)
- 高频错误： [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md)

## 11. 看图语义验收

截图验收不能只回答：

- 元素是否齐全
- 层数是否够多
- 设施是否都摆上了
- 批次是否成功

还必须回答：

- 当前视图里，关卡类型是否一眼可识别
- 当前视图里，局部空间是否成立
- 当前视图里，设施是否像附着在空间里的连接单元，而不是测试残留或临时摆件
- 当前视图里，是否存在明显像补板、漂浮块、调试块、残留块的几何
- 当前视图里，竖向连接点是否能读出“从哪接近、怎么用、到哪离开”

中型以上白盒至少同时通过两层验收：

1. 施工验收  
   设计包、结构表、批次、属性、连接契约是否完成
2. 看图语义验收  
   从当前视图看，关卡类型、空间语义、设施语义是否成立

如果第二层不过，即使第一层全过，也不能判定为合格白盒。
