---
title: "Slate设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/slate-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "Slate设置"]
---

# Slate设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / Slate设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/slate-settings-in-the-unreal-engine-project-settings

## Slate设置

### 约束画布

| **分段** | **说明** |
| --- | --- |
| **显式画布子ZOrder（Explicit Canvas Child ZOrder）** | 允许 `SConstraintCanvas` 的子节点共享渲染层。 子节点必须在其插槽上设置显式ZOrder来控制渲染顺序。 推荐为移动平台启用该设置。 |
