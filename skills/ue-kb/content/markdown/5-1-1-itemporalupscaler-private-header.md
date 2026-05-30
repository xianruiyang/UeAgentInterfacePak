# 技术说明：报告在版本 5.1.1 (ITemporalUpscaler) 中引用 Private header 的插件崩溃

# 技术说明：报告在版本 5.1.1 (ITemporalUpscaler) 中引用 Private header 的插件崩溃

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/9yVb/unreal-engine-tech-note-reported-crash-for-plugins-referencing-private-header-in-version-5-1-1-itemporalupscaler

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1168 字符。

## 摘要

本文由 Martin S 撰写。 描述：我们发现与 3rd 方插件相关的崩溃，这些插件在与 5.1.1 版本一起使用时包含引擎的私有标头。我们无意中对 ITe 进行了更改……

## 中文整理

### 概览

*本文由 [Martin S.](https://dev.epicgames.com/community/profile/Jonn/Svegn2) 撰写* **描述：** 我们知道与 5.1.1 版本一起使用时包含引擎私有标头的第 3 方插件相关的崩溃。我们无意中对 ITemporalUpscaler 接口进行了更改，破坏了与某些第三方插件的二进制兼容性。任何使用 ITemporalUpscaler 接口的插件都需要重新编译才能兼容。 **潜在影响：** 有限：针对 5.1.0 版本打包的引用引擎专用标头的插件在与 UE5.1.1 的 Epic Game Launcher 版本一起使用时可能会崩溃。 **解决方案：** 如果您在更新到 5.1.1 后遇到通过外部链接分发的插件崩溃的情况，请联系供应商并要求他们针对最新版本重新编译插件。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

