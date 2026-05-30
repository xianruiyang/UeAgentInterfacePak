# 技术说明：由于无法加载动画压缩设置，熟游戏启动时崩溃

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/6PP1/unreal-engine-tech-note-crash-on-startup-of-cooked-game-due-to-failure-to-load-animation-compression-settings

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1044 字符。

## 摘要

文章由 Euan C 撰写。 描述：禁用事件驱动加载器时，动画压缩设置可能无法加载，从而导致熟游戏启动时崩溃。坠机事故是由于故障引起的……

## 中文整理

### 概览

*文章由 [Euan C.](https://dev.epicgames.com/community/profile/lxJJ/euancarmichael) 撰写* **说明：** 当禁用事件驱动加载器时，动画压缩设置可能无法加载，从而导致熟游戏启动时崩溃。崩溃是由于 AnimationCompressionTypes.cpp 中以下检查的调用失败而导致的： checkf(!Obj->HasAnyFlags(RF_NeedLoad), TEXT(“Failed to load %s in %s”), *Obj->GetFullName(), *Source->GetFullName()); **潜在影响：** **中等：** 此问题只会影响使用非事件驱动加载器代码路径（现已弃用）来加载资源的项目。 **解决方案：** 由于非事件驱动加载器代码路径现已被弃用，任何项目都应确保在项目设置中启用“使用事件驱动加载器”选项。 UE版本
