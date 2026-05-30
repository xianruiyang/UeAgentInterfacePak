# 技术说明：用于在 Linux 中管理分叉专用服务器的 FForkProcess 类

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/Eox6/unreal-engine-tech-note-the-fforkprocess-class-for-managing-forking-dedicated-servers-in-linux

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1818 字符。

## 摘要

2021 年 4 月 7 日。由 Alex K 撰写的知识文章。 描述：本文旨在补充您可以在此处找到的服务器托管建议文章。该文章中提到 Linux 专用服务器如何......

## 中文整理

### 概览

2021 年 4 月 7 日。由 [Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写的知识文章 **说明：** 本文旨在补充您可以在[此处找到的服务器托管建议文章。](https://forums.unrealengine.com/docs?search=Server%20Hosting%20Advice&topic=265031)该文章中提到 Linux 专用服务器如何从主进程中派生子进程以共享分配的内存。此功能最近在 4.26 中向引擎公开，但未添加与此进程相关的一个类是 FForkProcess。此类使用 ForkIfRequested() 管理专用服务器的分叉，一旦专用服务器完成启动，就可以从游戏实例中调用它。 **潜在影响：** 有限：尝试在其专用服务器内实现分叉的用户无权访问 FForkProcess。 **解决方案：** FForkProcess计划迁移到UE上。同时，您可以在下面找到该类的代码，其中删除了一些包含敏感信息的部分。 ForkProcess.h

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "Delegates/IDelegateInstance.h"

class UWorld;

/** Class to manage forking dedicated servers in Linux */
class FForkProcess
```

ForkProcess.cpp

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#include "Fork/ForkProcess.h"
#include "OnlineSubsystemUtils.h"
#include "IPlatformFilePak.h"
#include "HAL/PlatformFilemanager.h"
#include "HAL/FileManager.h"
#include "HAL/ThreadHeartBeat.h"
#include "HAL/IConsoleManager.h"
#include "HAL/PlatformMemory.h"
```
