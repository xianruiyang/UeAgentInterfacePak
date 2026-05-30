# 技术说明：工具链 14.32.31326 与 UE5 不兼容

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/q5Ml/unreal-engine-tech-note-toolchain-14-32-31326-is-not-compatible-with-ue5

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1161 字符。

## 摘要

本文由 Martin S 撰写。 说明：VS2022 v17.2 附带的 14.32.31326 工具链无法编译 UE5，因为新的 lambda 处理器存在 bug。如需参考，请参阅此链接。潜在影响：……

## 中文整理

### 概览

*本文由 [Martin S.](https://dev.epicgames.com/community/profile/Jonn/Svegn2) 撰写* **说明：** 由于新 lambda 处理器中的错误，VS2022 v17.2 附带的 14.32.31326 工具链无法编译 UE5。作为参考，[请参阅此链接。](https://developercommunity.visualstudio.com/t/In Correct-instantiation-of-a-virtual-fun/10020368) **潜在影响：** [严重]：在有效的 lambda 定义上编译 UE5 编辑器将失败。 **解决方案：** 从 Visual Studio 安装程序安装更新版本的工具链，或者在 14.29.30133 上进行回退，该版本在“单独组件”面板中被引用为“MSVC v142 - VS2019 C++ x64/x86 构建工具 (v14.29-16.11)”。 UBT 将自动选择 14.29 或最新版本（如果不存在）。确保清理您的解决方案以避免奇怪的链接问题。 **UE 版本** 5.0 在[知识库](https://forums.unrealengine.com/docs) 获取更多答案！
