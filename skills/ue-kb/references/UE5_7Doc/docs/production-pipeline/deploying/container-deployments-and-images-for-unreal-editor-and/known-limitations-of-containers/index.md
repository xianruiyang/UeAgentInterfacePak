---
title: "已知限制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/known-limitations-of-containers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "容器", "已知限制"]
---

# 已知限制

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / 容器 / 已知限制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/known-limitations-of-containers-in-unreal-engine

> [!WARNING]
> 对虚幻引擎容器的官方支持仍处于测试阶段，并存在诸多限制。

## Windows开发镜像

虚幻引擎随附的容器镜像目前仅包含Linux开发镜像，无Windows开发镜像。不过由于技术和法律限制，我们无法发布Windows开发镜像。

有关Windows开发镜像相关技术问题的讨论，请参阅由Adam Rehn的博客[展望ue4-docker项目的未来](https://adamrehn.com/articles/preview-the-future-of-ue4-docker/)。

## 关于在基于容器的像素流中为AMD GPU提供支持

所有支持[像素流](../../../../sharing-and-releasing-projects/pixel-streaming/index.md)的Windows运行时镜像都支持基于NVIDIA和AMD显卡的GPU加速。Linux镜像只支持NVIDIA显卡，对AMD显卡的支持将在未来推出。
