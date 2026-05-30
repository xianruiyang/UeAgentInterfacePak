# 技术说明：在 5.6 中编译 Unreal Automation Tool 时出现错误

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/DBLR/unreal-engine-tech-note-errors-when-compiling-the-unreal-automation-tool-in-5-6

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 905 字符。

## 摘要

我们在编译 UAT 时发现了错误并找到了解决方案。

## 中文整理

### 概览

**更新[8/27]：**发现一个新漏洞，并推送了额外更新。集成了 8 月 26 日发布的原始更改的用户应参考解决方案中的新 CL 和 GitHub 链接 **描述：** 我们的一些工具使用的 Magick Nuget 包中发现了漏洞。这将生成在编译虚幻自动化工具 (UAT) 时被视为错误的警告。 **潜在影响：**[严重]：编译 UAT 将失败，并出现与 Magick 相关的错误。 **解决方案：** 集成 CL 45232827 或以下 GitHub 提交：https://github.com/EpicGames/UnrealEngine/commit/360060ea33d92fe562e256456bb51197788119f0 请注意，您必须合并 CL\commit 中列出的文件中的每个更改。不要将这些文件复制到现有的源文件上，因为这会导致编译错误。
