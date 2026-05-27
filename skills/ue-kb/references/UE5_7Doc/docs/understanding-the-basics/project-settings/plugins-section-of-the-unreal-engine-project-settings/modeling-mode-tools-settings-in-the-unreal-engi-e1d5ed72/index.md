---
title: "建模模式工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/modeling-mode-tools-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "建模模式工具"]
---

# 建模模式工具

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / 建模模式工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/modeling-mode-tools-settings-in-the-unreal-engine-project-settings

## 建模模式工具

### 建模工具

| **设置** | **说明** |
| --- | --- |
| **渲染（Rendering）** |  |
| **在编辑时启用光线追踪（Enable Ray Tracing While Editing）** | 为网格体编辑工具启用实时光线追踪支持。 这将影响带有3D塑造等实时反馈的工具的性能。 |
| **新网格体对象（New Mesh Objects）** |  |
| **启用光线追踪（Enable Ray Tracing）** | 如果光线追踪支持可选，为建模工具创建的新网格体对象启用光线追踪支持（例如， `DynamicMeshActors` ）。 |
| **启用碰撞（Enable Collision）** | 为建模工具创建的新网格体对象启用碰撞支持。 |
| **碰撞模式（Collision Mode）** | 建模工具创建的新网格体对象上设置的默认碰撞模式。 你可以从以下选项中选择： **项目默认值（Project Default）** ：使用项目物理设置（ `DefaultShapeComplexity` ）。 **简单和复杂（Simple And Complex）** ：创建简单和复杂的形状。简单形状用于常规场景查询和碰撞测试。复杂形状（按多边形）用于复杂场景查询。 **将简单碰撞形状用作复杂形状（Use Simple Collision As Complex）** ：仅创建简单形状。将简单形状用于所有场景查询和碰撞测试。 **将复杂碰撞形状用作简单形状（Use Complex Collision As Simple）** ：仅创建复杂形状（按多边形）。将复杂形状用于所有场景查询和碰撞测试。只能用于静态形状的模拟（即，可以与之碰撞，但不会通过速度力移动）。 |
