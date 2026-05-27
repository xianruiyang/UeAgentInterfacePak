<!-- Source: leveldesign skill / levelDesignDocs/modeling/Modeling辅助搭建.md -->

# Modeling辅助搭建

## 目的

本文档说明当前项目里 `Modeling` 能做什么、不能做什么，以及在自动化关卡设计里应如何正确使用。

如果你是在按白盒流程推进，请先看：
- [../core/whitebox-workflow.md](../core/whitebox-workflow.md)

重点不是罗列所有底层按钮，而是回答 4 个问题：

- 什么时候应该进入 `Modeling`
- 当前基础元件的尺寸和朝向语义是什么
- `bounds + rotation` 这层封装现在保证了什么
- 如何避免把 `Modeling` 误用成布局系统

## 定位

`Modeling` 负责局部几何生成和局部几何修形，不负责替你决定整体空间关系。

适合交给 `Modeling` 的事情：

- 生成基础元件
- 生成楼梯、斜坡等几何体
- 做局部切割、布尔、补洞、重拓扑
- 调整 pivot、烘焙 transform、生成简单碰撞

不适合交给 `Modeling` 的事情：

- 规划整体布局
- 决定空间节点关系
- 决定主路径、支路、回环
- 决定房间尺寸是否合理
- 决定什么地方应该可达、不可达、锁定或解锁

一句话：

`Modeling` 负责做几何，不负责想关卡。

相关上游文档：
- [../core/design-doc-spec.md](../core/design-doc-spec.md)
- [../core/automated-level-design.md](../core/automated-level-design.md)
- [../core/multifloor-connections-and-facilities.md](../core/multifloor-connections-and-facilities.md)

## 进入 Modeling 前必须已知

在调用 `modeling_*` 之前，上游必须已经确定：

- 目标元件类型
- 目标尺寸
- 目标朝向
- 目标层级和落点
- 采用什么锚点口径
  - 外轮廓
  - 内腔
  - 完成面
  - 开口中线
- 它服务于哪个空间或过渡关系

如果这些还没定，说明还没到进入 `Modeling` 的时候。

## 当前基础元件

当前项目内可直接用来白盒搭建的基础元件有：

- `modeling_create_box`
- `modeling_create_cylinder`
- `modeling_create_sphere`
- `modeling_create_plane`
- `modeling_create_stairs`
- `modeling_create_ramp`
- `modeling_create_ramp_corner`

其中：

- `ramp` 是自定义三棱柱斜坡
- `rampCorner` 是自定义直角转角斜坡件，用于斜坡转角过渡

## 基础元件语义

### 通用轴向规则

对当前已封装基础元件，统一按下面的局部轴口径理解：

- `Depth -> local X`
- `Width -> local Y`
- `Height -> local Z`

如果传了 `rotation.yaw = 90`，就是把局部 `X/Y` 平面整体旋到新的世界朝向，而不是改写尺寸字段的含义。

### Box

- `Depth`：局部 `X`
- `Width`：局部 `Y`
- `Height`：局部 `Z`

适合：

- 房间壳体
- 墙体
- 楼板
- 平台
- 阻挡体

### Plane

- `Depth`：局部 `X`
- `Width`：局部 `Y`
- 无厚度

适合：

- 只需要表达平面关系时的占位
- 临时地表或参考面

不适合：

- 需要实体厚度的墙、楼板、平台

### Cylinder

- `Radius` 控制局部 `XY` 足迹
- `Height` 控制局部 `Z`

适合：

- 柱体、塔体、圆形占位

不适合：

- 用来验证朝向

### Sphere

- `Radius` 控制整体尺寸
- 旋转对称

适合：

- 球形占位
- 圆形 landmark 粗块

不适合：

- 用来验证朝向

### Stairs

线性楼梯当前应这样理解：

- `StepDepth -> local X`
- `StepWidth -> local Y`
- `StepHeight -> local Z`

也就是：

- `X = run`
- `Y = width`
- `Z = rise`

适合：

- 层间连接
- 平台高差转换

前提：

- 起点完成面已知
- 终点完成面已知
- 顶口走出方向已知
- 上下口落脚区已知

### Ramp

`modeling_create_ramp` 是自定义三棱柱斜坡。

应按下面的口径理解：

- `Depth`：斜坡沿局部 `X` 的推进长度
- `Width`：斜坡沿局部 `Y` 的横向宽度
- `Height`：高端与低端之间的局部 `Z` 高差

它最适合表达：

- 缓坡上升
- 小型地形抬升
- 平台过渡

不应把它当成：

- 自动可达的“通路结论”

是否真的可走，仍要回到角色能力模型判断。

### RampCorner

`modeling_create_ramp_corner` 是自定义直角转角斜坡件。

几何意图是：

- 在一个直角底面上提供斜坡与转角的复合过渡
- 适合做转角坡面、转角抬升或局部地形切角

当前口径：

- `Depth`：局部 `X`
- `Width`：局部 `Y`
- `Height`：局部 `Z`

它适合：

- 斜坡转向
- 转角抬升
- 非正交直跑斜坡不方便表达的局部转角过渡

它不适合：

- 替代普通房间或普通平台
- 直接承担复杂路径逻辑

## bounds + rotation 封装保证

当前项目中，这些基础元件支持一层更高的输入方式：

- `bounds.center + bounds.extent`
- 或 `bounds.min + bounds.max`
- 再配合 `rotation` / `orientation`

当前这层封装保证的是：

1. 会先把目标尺寸翻译成对应 `ShapeSettings`
2. 会把 `TargetSurface` 固定到可预测口径
3. 会把 pivot 固定到 `Centered`
4. 会在接受工具后把 Actor 放到 `bounds.center + rotation`
5. 可直接在创建时写 `folder_path`

这意味着：

- 你可以把它当成“按包围盒生成基础元件”的确定性接口
- 不需要再靠后续 scale 去补尺寸

但这不意味着：

- 任何自定义 `tool_properties` 都不会改变结果

如果你显式覆盖了 `ShapeSettings`，最终结果就以覆盖后的参数为准。

## 推荐工作流

### 1. 生成新基础元件

1. 上游先确定尺寸、朝向、落点、能力模型和用途
2. `modeling_activate_mode`
3. 调用 `modeling_create_*`
4. 如有必要，用 `tool_properties` 覆盖 UE 原生 `ShapeSettings`
5. 工具接受后回读结果

### 2. 对已有几何做局部修形

1. `modeling_activate_mode`
2. `modeling_set_selection`
3. 启动 `plane_cut / boolean / trim / remesh / set_pivot` 等工具
4. 写属性
5. `modeling_accept_tool`
6. 回读结果

## 最小验收要求

不能把“命令成功”当成“几何正确”。

至少要验：

- 元件类型是否正确
- 尺寸是否正确
- 朝向是否正确
- 是否落在预期位置
- 是否与周围结构冲突
- 是否满足上游定义的空间或过渡职责

对楼梯和斜坡还要额外验：

- 上升方向
- 高差
- 顶口或高端是否接上目标完成面
- 底口或低端是否接上起始完成面

## 常见错误

- 还没定空间关系就直接进 `Modeling`
- 把 `Modeling` 当布局系统
- 只看 transform，不看真实几何包络
- 用 `cylinder / sphere` 去判断朝向
- 先摆出几何，再倒推它想表达什么
- 把“看起来像路”误判成“在能力模型下可达”

## 与其他文档的关系

- [../core/automated-level-design.md](../core/automated-level-design.md)
  - 定义上游规则、空间、可达与验收基线
- [../references/reference-image-reconstruction.md](../references/reference-image-reconstruction.md)
  - 参考图任务的额外约束
- [../references/level-design-methodology.md](../references/level-design-methodology.md)
  - 更高层的玩法、节奏、引导与锁钥方法
