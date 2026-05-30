# 技术说明：4.26.0 中的 Visual Studio 2017 安装生成生成失败

# 技术说明：4.26.0 中的 Visual Studio 2017 安装生成生成失败

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/q5P5/unreal-engine-tech-note-installed-build-generation-fails-with-visual-studio-2017-in-4-26-0

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1145 字符。

## 摘要

文章由 Branden T 撰写。 描述：如果您仅安装了 VS2017，则 4.26.0 版本无法正确创建已安装的版本。这是由于 VS2017 中出现警告，但 VS2019 中没有，这是…

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* **说明：** 如果您仅安装了 VS2017，4.26.0 版本将无法正确创建已安装的版本。这是由于 VS2017 中出现警告，而不是 VS2019，该警告被视为已安装构建生成中的错误，从而导致失败。该警告是由于某些编译器（IE：VS2017）无法正确获取 EditorEngine.h 和其他一些文件中的 PRAGMA_... 定义，除非它们位于文件范围内。 **潜在影响：** **中等：** 这将影响 4.26.0 上尝试通过 BuildGraph 生成仅安装 VS2017 及其工具链的已安装版本的任何人。 **解决方案：** 这应该从 4.26.1 开始修复，但如果您在此之前需要它，修复程序位于 //UE4/Release-4.26/ 流中。将 CL 15004310 与 15015879 集成可以解决生成的警告。 UE版本4.26

