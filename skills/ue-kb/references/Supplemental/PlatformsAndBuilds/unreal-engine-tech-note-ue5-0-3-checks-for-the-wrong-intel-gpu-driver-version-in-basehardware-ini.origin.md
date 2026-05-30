# 技术说明：UE5.0.3 在 BaseHardware.ini 中检查错误的 Intel GPU 驱动程序版本

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/JmGa/unreal-engine-tech-note-ue5-0-3-checks-for-the-wrong-intel-gpu-driver-version-in-basehardware-ini

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1421 字符。

## 摘要

技术说明：UE5.0.3 在 BaseHardware.ini 中检查错误的 Intel GPU 驱动程序版本 Martin S 撰写的文章。 说明：版本 5.0.3 中提供的 baseHardware.ini 配置文件包含错误的版本...

## 中文整理

### 概览

*文章作者：[Martin S.](https://dev.epicgames.com/community/profile/Jonn/Svegn2)*

### 描述：

版本 5.0.3 中附带的 baseHardware.ini 配置文件包含错误的 Intel GPU 驱动程序版本号。这将导致虚幻编辑器或已发布的项目打开一个消息框，告诉用户目标 PC 的 GPU 驱动程序正在使用 Intel GPU。

### 潜在影响：

[中等]：每次启动项目时都会出现该消息框，与更新驱动程序无关。

### 解决方案：

选项 1：引擎级解决方案编辑 Engine\Config\BaseHardware.ini 并将整个 [GPU_Intel Windows] 部分替换为：

```
[GPU_Intel Windows]

SuggestedDriverVersion=“30.0.101.1340”

+DriverDenyList=(DriverVersion=“<101.1191”, Reason=“These driver versions have known stability issues and missing features”)
```

方案2：项目级解决方案在Project\Config下添加一个名为DefaultHardware.ini的文本文件，并添加以下内容：

```
[GPU_Intel Windows]

!DriverDenyList=ClearArray

+DriverDenyList=(DriverVersion=“<101.1191”, Reason=“These driver versions have known stability issues and missing features”)
```

在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案
