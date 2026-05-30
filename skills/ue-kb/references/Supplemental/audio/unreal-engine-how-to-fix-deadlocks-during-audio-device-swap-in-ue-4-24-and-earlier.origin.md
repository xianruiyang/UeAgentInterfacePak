# 如何修复 UE 4.24 及更早版本中音频设备交换期间的死锁

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/l7Ky/unreal-engine-how-to-fix-deadlocks-during-audio-device-swap-in-ue-4-24-and-earlier

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1906 字符。

## 摘要

2021 年 2 月 26 日。Anna L 撰写的知识文章。UE 4.24 以及之前的版本中存在一个已知问题，由于低级别的限制，导致在不同音频设备之间切换时出现死锁……

## 中文整理

### 概览

2021 年 2 月 26 日。[Anna L.] 撰写的知识文章(https://dev.epicgames.com/community/profile/Ob2/lantz.anna) UE 4.24 以及之前的版本中存在一个已知问题，由于低级 API XAudio2.7 的限制，导致在不同音频设备之间切换时出现死锁。如果您的程序在执行诸如在耳机和扬声器之间切换之类的操作时冻结或出现不合理的长时间延迟，则可能会发生这种情况。通过在 4.25 及更高版本中升级到 XAudio2.9，此问题在后续版本中得到修复。然而，当项目已经在开发中时，同步到全新的 UE 版本可能不切实际。因此，本文档包含获取 XAudio2.9 所需的具体更改。升级到 XAudio2.9 所需的主要更改可以在 [在此 GitHub CL 中找到。](https://github.com/EpicGames/UnrealEngine/commit/cab16c13594f23b3bed87ca0702bee7a31cafb71#diff-6a6cd82969c7feb6126a394d2cb601f4) 还有一些后续的错误修复可以在[这些](https://github.com/EpicGames/UnrealEngine/commit/58b3e53aabc76707e76af1f64d2b819913e04778)中找到[GitHub](https://github.com/EpicGames/UnrealEngine/commit/f6998fc4515e248bc9d7b1460f c7f4e4a07ae3b8#diff-fc5e2539e414ea7dbc4d14cbdc9328de1acf4cee067a227b2e6be8ac962335ef )[链接](https://github.com/EpicGames/UnrealEngine/commit/fee2177ef6656d35d0181d9363 3b14134d385357#diff-fc5e2539e414ea7dbc4d14cbdc9328de1acf4cee067a227b2e6be8ac962335ef)以及。此外，您可能还需要重新生成项目文件。您可以通过验证是否在路径 Engine/Source/ThirdParty/Windows/XAudio2_9/Bin/x64/ 中看到标题为 xaudio2_redist.dll 的文件来判断项目文件是否已正确生成。
