# 增加连接调试器时加载的模块数量

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/l740/unreal-engine-increase-the-number-of-modules-loaded-when-attaching-the-debugger

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1169 字符。

## 摘要

增加附加调试器时加载的模块数量 Martin S 撰写的文章 Windows 上的调试器在附加到正在运行的进程时只能加载 500 个模块的符号。基于虚幻的项目…

## 中文整理

### 概览

*文章由 [Martin S](https://dev.epicgames.com/community/profile/Jonn/Svegn2) 撰写* Windows 上的调试器在附加到正在运行的进程时仅限加载 500 个模块的符号。基于虚幻的项目可能会超过该限制，具体取决于版本和插件配置。该问题通常表现为在附加后无法向项目或引擎代码添加断点。可以通过添加以下注册表项并重新启动 PC 来增加限制： HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager DWORD DebuggerMaxModuleMsgs = 2048 [本文来自Microsoft](https://support.microsoft.com/en-us/topic/how-to-add-modify-or-delete-registry-subkeys-and-values-by-using-a-reg-file-9c7f37cf-a5e9-e1cd-c4fa-2a26218a1a23) 解释了如何创建 .reg 文件以便在团队中更轻松地分发。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案
