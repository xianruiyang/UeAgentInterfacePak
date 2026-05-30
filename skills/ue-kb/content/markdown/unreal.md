# 关于对Unreal和第三方音频中间件的支持

# 关于对Unreal和第三方音频中间件的支持

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/MLWx/unreal-engine-on-support-for-unreal-and-third-party-audio-middleware

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1696 字符。

## 摘要

关于支持虚幻和第三方音频中间件的文章，作者：Anna L。包含我们建议人们在提交涉及与音频中间件（例如 Wwise 等）交互的问题之前查看的信息。

## 中文整理

### 概览

*由 [Anna L.](https://dev.epicgames.com/community/profile/Ob2/lantz.anna) 撰写的文章* 包含我们建议人们在提交涉及与音频中间件（例如 Wwise 和 FMod）交互的问题之前查看的信息。多个品牌的第三方音频中间件（例如 Wwise 和 FMod）已经创建了虚幻引擎集成。如果您决定在游戏中使用其中一种音频，值得注意的是，某些平台无法同时运行第三方音频中间件和原生虚幻音频。一般来说，如果您在使用第三方音频中间件时遇到困难，建议通过在相关平台的 ini 文件中添加以下内容来禁用 Unreal 的本机音频引擎：

```cpp
[Audio]
 AudioDeviceModuleName=
 AudioMixerModuleName=
```

请注意，媒体播放器等系统也在幕后使用虚幻的原生音频，因此如果您选择禁用虚幻的原生音频，它们也会受到影响。另请注意，由于 Wwise 和 FMod 等第三方创建并拥有自己的 Unreal 插件，因此我们无法针对其插件的特定问题在 UDN 上提供支持。这包括有关通过第三方中间件播放的声音未按预期播放、中间件代码内挂起和崩溃的问题，以及有关如何利用第三方中间件引入的功能的请求。对于此类问题，最好直接询问中间件公司。

