---
name: leveldesign
description: 白盒（Whitebox）/Blockout 关卡设计指导，用于规划、审查与迭代可玩关卡结构（关键路径、引导、内容分布、节奏、回环、枢纽、地标等），适用于 Unreal Engine 或类似引擎的白盒工作流。
---

# LevelDesign（关卡白盒设计）

## 简介

- 本 skill 负责“白盒方法论 + 项目内规则入口”，用于规划/审查/迭代白盒关卡结构。
- `SKILL.md` **只保留简介与目录**；具体规则请按下方链接阅读。

## 目录

### A. 项目内规则（优先）

如果当前项目提供了自己的关卡白盒规则集，必须先读并遵守，再补充本 skill 的通用方法论（避免“通用建议”覆盖项目硬约束）。

本项目族（存在对应文件时）建议阅读顺序：

1. `docs/levelDesignDocs/README.md`
2. `docs/levelDesignDocs/core/总体白盒搭建流程.md`
3. `docs/levelDesignDocs/core/设计文档规范.md`
4. `docs/levelDesignDocs/core/自动化关卡设计.md`
5. `docs/levelDesignDocs/core/跨楼层连接与设施规则.md`

### B. 通用方法论（本 skill）

- 通用白盒方法论（工作流/规则/产出物/失败模式）：[guide.md](guide.md)

### C. 项目规则快照（本 skill 内置）

本 skill 内置了一份同结构的文档快照，路径为：

- [levelDesignDocs/](levelDesignDocs/)
  - [levelDesignDocs/core/](levelDesignDocs/core/)
  - [levelDesignDocs/checklists/](levelDesignDocs/checklists/)
  - [levelDesignDocs/modeling/](levelDesignDocs/modeling/)
  - [levelDesignDocs/references/](levelDesignDocs/references/)

当“项目内文档”和“skill 内置快照”同时存在时：

- 优先以 **项目内** `docs/levelDesignDocs/` 为准（源真相）
- `levelDesignDocs/` 仅作为 fallback，或在需要“自包含读取”的场景使用

内置快照阅读顺序（与项目内一致）：

1. [levelDesignDocs/README.md](levelDesignDocs/README.md)
2. [levelDesignDocs/core/总体白盒搭建流程.md](levelDesignDocs/core/总体白盒搭建流程.md)
3. [levelDesignDocs/core/设计文档规范.md](levelDesignDocs/core/设计文档规范.md)
4. [levelDesignDocs/core/自动化关卡设计.md](levelDesignDocs/core/自动化关卡设计.md)
5. [levelDesignDocs/core/跨楼层连接与设施规则.md](levelDesignDocs/core/跨楼层连接与设施规则.md)

对中型及以上白盒，把“最小设计包”当作门禁：

- 最小设计包未完成前，不进入正式白盒搭建施工
- 设计包是“施工前源真相”，不是“事后补笔记”
- 若项目定义了更严格的审查（例如：逐连接验收、语义截图验收），必须在本 skill 之外额外执行
