---
title: "屏幕空间反射"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/screen-space-reflections-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "反射环境", "屏幕空间反射"]
---

# 屏幕空间反射

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 反射环境 / 屏幕空间反射

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/screen-space-reflections-in-unreal-engine

**屏幕空间反射（Screen Space Reflection）** 是一种默认启用的效果，可改变 **材质** 表面的对象的外观。它的相关选项不多，如下所示。

| 属性 | 描述 |
| --- | --- |
| **强度（Intensity）** | 按百分比启用/渐变/禁用屏幕空间反射功能（为保持一致性，请不要使用 0 到 1 之间的数字）。 |
| **品质（Quality）** | 0 为最低精度，100 为最高精度（50 为默认精度，性能较好）。 |
| **最大粗糙度（Max Roughness）** | 用于确定屏幕空间反射淡出的平整度（0.8 效果较好，数值越小，运算越快）。 |
