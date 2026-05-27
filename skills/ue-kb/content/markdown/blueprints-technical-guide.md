# Blueprints Technical Guide

---
title: "Blueprints Technical Guide"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/technical-guide-for-blueprints-visual-scripting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "Blueprints Technical Guide"]
---

# Blueprints Technical Guide

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / Blueprints Technical Guide

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/technical-guide-for-blueprints-visual-scripting-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Blueprints** are a powerful new feature introduced in Unreal Engine 4. Blueprints are a way to create new [UClasses](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UClass?application_version=5.5) without the need for writing or compiling code. When you create a Blueprint, you can choose to extend a C++ class or another Blueprint class. You can then add, arrange, and customize [Components](../../gameplay-systems/gameplay-framework/components/index.md), implement custom logic using a visual scripting language, respond to [Events](../specialized-blueprint-visual-scripting-node-groups/events/index.md) and interactions, define custom [Variables](../specialized-blueprint-visual-scripting-node-groups/blueprint-variables/index.md), handle [Input](../../gameplay-systems/input/index.md), and create a fully custom object type.

Each Blueprint has a [Construction Script](../specialized-blueprint-visual-scripting-node-groups/construction-script/index.md), analogous to a constructor in C++, which is run when the object is created. This script can dynamically construct the Actor instance based on any number of factors, such as a fence that automatically sizes itself to fill a gap between buildings. In this sense, a Blueprint can be thought of as a very powerful prefab system.

- [Blueprint Function Libraries](blueprint-function-libraries/index.md) - Information about Blueprint Function Libraries for C++ in Unreal Engine.
- [Blueprint Compiler Overview](compiler-overview-for-blueprints-visual-scripting/index.md) - The steps of the Blueprint compilation process
- [Exposing Gameplay Elements to Blueprints](exposing-gameplay-elements-to-blueprints-visual-74ff2735/index.md) - Technical guide for gameplay programmers exposing gameplay elements to Blueprints.
- [Exposing C++ to Blueprints](exposing-cplusplus-to-blueprints-visual-scripting/index.md) - Tips and tricks for how best to write a Blueprint-friendly API

