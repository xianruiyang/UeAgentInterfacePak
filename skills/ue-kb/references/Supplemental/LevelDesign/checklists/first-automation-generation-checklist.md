<!-- Source: leveldesign skill / levelDesignDocs/checklists/第一次自动化生成必过清单.md -->

# 第一次自动化生成必过清单

目的：把“第一次就能生成正确”的要求变成可执行的检查项，避免靠后续补丁修。

适用范围：中型以上自动化白盒（有跨层连接、门禁、电梯/Zipline、收集品）。

定位：这是一份 **生成前/第一次验收用的检查清单**，不在这里展开修复教程；修复入口统一去错误库按条目定位根因。
- 错误库：[`../references/whitebox-common-structural-errors.md`](../references/whitebox-common-structural-errors.md)
- 跨层连接与设施规则：[`../core/multifloor-connections-and-facilities.md`](../core/multifloor-connections-and-facilities.md)

## 1. 结构与可达（先验）

- 主路径必须从出生点一路可推进到目标空间；不可把“需要先交互某个门”误当成“道路不连通”。
- 每条跨楼层连接必须能回答：从哪接近、怎么用、到哪离开（`upper/lower walkable area + approach/exit`）。
- 回环/回落必须闭合：例如 drop landing（下落落点）落地后必须能无歧义回到主路，不能落地就死路。
- 顶层/终点空间不得是孤岛：必须显式提供连接（桥/缺口/平台外挑）而不是“看起来在同一层”。

## 2. 楼梯（避免“顶头/卡住”）

- 楼梯上行方向的**上层楼板必须扣洞**：洞口 footprint 至少覆盖楼梯投影范围，并预留胶囊体余量。
- 生成顺序遵守：先定义楼梯连接单元 -> 再生成上层洞口 -> 最后生成楼梯几何（禁止先铺整层 floor 再硬塞楼梯）。

验收：
- 站在楼梯末端向上看，不应看到连续楼板 underside 覆盖楼梯投影。

## 3. 门（洞口、贴合、单向）

- 门洞/通道口优先用 `level_spawn_wall_with_opening`（或等价自动拆墙方式）生成，避免“手拆墙遗漏接口导致实际不连通/大缝”。
- 门必须从“门户区间”派生：`door_width == portal_clear_width`（必要时 +1~2cm overlap 消除像素裂缝线）。
- 门厚度必须 ≥ 墙厚（必要时略厚一点，避免斜视角看到洞侧壁形成“露缝/漏光”观感）。
- 门禁阻挡面必须覆盖通道净宽：白盒阶段宁可略宽 overlap，也不要留下可绕过的侧缝。
- 门外侧必须有可站立的“贴墙落脚区”（门外平台/走廊不能离墙留缝），否则会出现“门看起来在那但交互不可达”。
- 单向门必须在 PIE 或可复现用例下验证“允许侧/禁止侧”一致（不要只看枚举名/属性回读）。

自动化验收注意：不要只看属性回读；以截图/量测为准（必要时触发一次 transform 刷新）。若局部空间关系难凭颜色判断，补一张 `screenshot_viewport_buffer(SceneDepth/WorldNormal)`。详见错误库 “21”。

## 4. 电梯（到站挡死、平台不贴合）

- **井口/洞口（support_opening_footprint）与平台 footprint 必须匹配到可接受缝隙**：
  - 洞口过大：会留下可掉落缝，视觉上像“平台没贴合”。
  - 洞口过小：到站会被边缘挡死/穿插。
- 停靠层不要在井口位置放“整块薄板 floor”；应使用外圈 rim 留出中心洞口（起点/终点都要留洞）。
- 平台尺寸变化时，同步更新触发盒（触碰电梯）覆盖范围，避免“能站上去但不触发/触发不一致”。

详见：
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md) 的 “22. 电梯到站被楼板挡死”。

## 5. Zipline（像传送点/顶死/悬空/像梯子）

白盒阶段允许“交互本质=传送”，但结构与视觉语义必须成立：

- 两端必须连接**玩家可正常行走的落脚区**（上端可接近、下端可离开），不能连到洞内空区或孤立浮空块。
- 必须有“附着语义”：贴洞边或贴平台边，不能摆在完成面中间当柱子/梯子。
- 若端点靠洞边：落脚平台应是“从洞边向洞内外挑”的 balcony/pier（伸入洞内），不要把端点落在 ring 完成面上再额外铺一块薄板，容易重复几何打架且语义像临时摆件。
- 可视体必须表达“连接上下端点”（长方体代理拉到两端），不能只是一块小方块。
- 必须有净空：不顶到天花板、不对空（需要洞口/竖井就先做洞口/净空）。

详见：
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md) 的 “23~26（Zipline 端点/可视/净空/语义）”。

## 6. 收集品（看得见但吃不到）

- 收集品必须落在可行走完成面上方（通常 `+40~60cm`），并保证接近区能站立、能触发。
- 点位应从 `walkable_area / landing_surface` 派生，不要直接写绝对坐标落在洞/井的空区。
- 同样规则适用于交互设施（终端/篝火）：必须从落脚区派生；验收时推荐用 `level_get_nearby_actor_obbs` 对每个终端/篝火/收集品做一次“附近落脚面”检查（附近应能命中对应 floor/landing surface）。

详见：
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md) 的 “27. 收集品悬空/落在不可达区域（看得见但吃不到）”。

## 7. 第一次就必须过的最小验收

- 逐条竖向连接验收：上端可接近、可用、到达后可离开、周边无不可解释缝/悬空落点。
- 门：无错向、无明显缝、无漂浮、无绕过。
- 电梯：起点/终点均无穿插、无封死、平台与周围完成面连续。
- Zipline：两端落脚区成立、可视体语义成立、无顶死/对空。
- 收集品：不悬空、不在空区、可拾取。
