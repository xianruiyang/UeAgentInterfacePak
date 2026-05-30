# 如何让您的项目瞄准 Ogg-Vorbis

# 如何让您的项目瞄准 Ogg-Vorbis

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/eajY/unreal-engine-how-to-get-your-project-to-target-ogg-vorbis

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1456 字符。

## 摘要

如何让您的项目瞄准 Ogg-Vorbis

## 中文整理

### 概览

由 [Anna L.](https://dev.epicgames.com/community/profile/Ob2/lantz.anna) 撰写的文章 在某些情况下，特别是在控制台上，将 Ogg-Vorbis 作为音频编解码器而不是平台默认值进行调试可能很有用。本文包含有关设置的说明。注意：虽然 Unreal 已经在大多数设备上实现了 OggVorbis，但也有一些设备还没有实现。如果您想检查您的特定平台，请搜索其关联的 AudioMixerDevice 函数“CreateCompressedAudioInfo”的实现。如果它包含引用 Ogg 或 FVorbisAudioInfo() 的代码，则以下步骤足以让 OggVorbis 适用于该设备。步骤 1：添加行 static FName NAME_OGG(TEXT("OGG"));进入 F[Platform]TargetPlatform::GetWaveFormat() 函数（如果尚不存在），并将函数的返回值更改为 NAME_OGG。您可以在文件[Platform]TargetPlatform.cpp 中找到该函数。步骤 2：在平台的 Mixer Device 实现中，将 FMixerPlatform[MixerModuleName]::GetRuntimeFormat() 函数的返回值更改为 NAME_OGG，并再次添加行 static FName NAME_OGG(TEXT("OGG"));如果它尚未存在。您可以通过查看 [Platform]Engine.ini 文件中标记为“AudioMixerModuleName”的字段来找到平台的混音器设备实现的名称。第 3 步：重新制作音频内容。

