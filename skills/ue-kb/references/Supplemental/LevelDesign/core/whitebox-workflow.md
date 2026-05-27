<!-- Source: leveldesign skill / levelDesignDocs/core/总体白盒搭建流程.md -->

# 总体白盒搭建流程

## 1. 目的

本文档是 `levelDesignDocs` 的流程向导。

它不重复展开所有规则，而是回答：
1. 做一个白盒关卡时，整体顺序是什么
2. 每一步该看哪份文档
3. 哪些步骤是正式开搭前的门禁
4. 什么情况下必须停下返工

## 2. 推荐顺序

### 第 1 步：明确方法层目标

先回答关卡到底要验证什么：
- 结构形态是什么
- 组织方式是什么
- 当前白盒承载哪些玩法
- 玩家主要重复什么动作链

先看：
- [../references/level-design-methodology.md](../references/level-design-methodology.md)

### 第 2 步：完成最小设计包

中型以上白盒，正式开搭前必须先完成设计包。

设计包至少覆盖：
- 玩家能力模型
- 关卡类型定义
- 当前白盒承载的玩法列表
- 空间清单与主结构骨架
- 空间形状、尺寸与原点
- 空间连接表
- 出入口表
- 竖向连接单元表
- 设施使用契约
- 收集品分布
- 验收标准

先看：
- [design-doc-spec.md](design-doc-spec.md)

### 第 3 步：锁自动化白盒总纲

设计包完成后，再按自动化白盒总纲检查：
- 是否先锁了能力模型
- 是否先定空间节点和路径
- 是否先定边界与门户
- 是否先定跨层连接
- 生成顺序是否正确

先看：
- [automated-level-design.md](automated-level-design.md)

第一次要真正执行自动化生成前（尤其是中型以上白盒），强烈建议先按“第一次必过清单”逐条过一遍；否则很容易进入“补丁式修几何”的循环：
- [../checklists/first-automation-generation-checklist.md](../checklists/first-automation-generation-checklist.md)

### 第 4 步：处理跨楼层连接与设施

如果关卡存在：
- 门
- 楼梯
- 斜坡
- 电梯
- `Zipline`
- 任何跨楼层连接

都不要直接摆 actor。应先把它们当成“跨楼层连接单元”来定义。

先看：
- [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)

### 第 5 步：需要局部几何时再进入 Modeling

只有在空间关系和结构已经定好的前提下，才进入 `Modeling`。

`Modeling` 负责：
- 生成基础元件
- 生成楼梯、斜坡等局部几何
- 做局部切割、补洞、修形

不负责：
- 替代布局规划
- 决定空间关系
- 决定路径和可达图

先看：
- [../modeling/modeling-assisted-blockout.md](../modeling/modeling-assisted-blockout.md)

### 第 6 步：按错误库做审查

开始搭建后，如果出现：
- 门方向错
- 墙有缝
- 楼梯被堵
- 电梯或 `Zipline` 悬空
- 设施被围死
- 跨层连接失败

不要只补一块几何，应回到错误库定位根因。

先看：
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md)

### 第 7 步：涉及锁钥时补专题

如果当前白盒使用门、终端、电梯、`Zipline` 等去改变可达关系，锁钥就是设计工具的一部分。

先看：
- [../references/lock-and-key-design.md](../references/lock-and-key-design.md)

### 第 8 步：参考图任务追加专题

如果任务是照参考图重建白盒，还要追加参考图规则。

先看：
- [../references/reference-image-reconstruction.md](../references/reference-image-reconstruction.md)

## 3. 最短执行链

### 通用白盒（手工/半手工）
- [../references/level-design-methodology.md](../references/level-design-methodology.md)
- [design-doc-spec.md](design-doc-spec.md)
- [automated-level-design.md](automated-level-design.md)
- [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)
- [../modeling/modeling-assisted-blockout.md](../modeling/modeling-assisted-blockout.md)
- [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md)

### 第一次自动化生成（中型以上）
在通用白盒链路基础上，**生成前**追加：
- [../checklists/first-automation-generation-checklist.md](../checklists/first-automation-generation-checklist.md)

### 带锁钥白盒
在通用白盒基础上追加：
- [../references/lock-and-key-design.md](../references/lock-and-key-design.md)

### 参考图白盒
在通用白盒链路基础上追加：
- [../references/reference-image-reconstruction.md](../references/reference-image-reconstruction.md)

## 4. 返工触发条件

出现下列情况之一，不应继续硬搭，应回到前置文档：
- 关卡类型说不清
- 玩法列表说不清
- 空间尺寸没锁
- 出入口表没写
- 竖向连接单元没写
- 第一次自动化生成必过清单不过（门/楼梯/电梯/Zipline/收集品任一类出现结构性失败）
- 设施只能靠硬调 `transform` 才成立
- 同类结构错误反复出现两次以上

## 5. 和其他文档的关系

- 入口索引： [../index.md](../index.md)
- 设计包字段： [design-doc-spec.md](design-doc-spec.md)
- 自动化总纲： [automated-level-design.md](automated-level-design.md)
- 跨层连接： [multifloor-connections-and-facilities.md](multifloor-connections-and-facilities.md)
- `Modeling`： [../modeling/modeling-assisted-blockout.md](../modeling/modeling-assisted-blockout.md)
- 错误库： [../references/whitebox-common-structural-errors.md](../references/whitebox-common-structural-errors.md)
