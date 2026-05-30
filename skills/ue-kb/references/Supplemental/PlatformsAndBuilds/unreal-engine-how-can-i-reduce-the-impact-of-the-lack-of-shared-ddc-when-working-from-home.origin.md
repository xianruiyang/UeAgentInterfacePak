# 在家工作时如何减少缺乏共享 DDC 的影响？

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/ePPY/unreal-engine-how-can-i-reduce-the-impact-of-the-lack-of-shared-ddc-when-working-from-home

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2720 字符。

## 摘要

文章由 Branden T 撰写。派生数据缓存是您项目的重要组成部分。它包含资产的运行时版本，例如编译的着色器和压缩纹理。将此数据存储在缓存中...

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* 派生数据缓存是您项目的重要组成部分。它包含资产的运行时版本，例如编译的着色器和压缩纹理。将此数据存储在缓存中而不是 Uassets 中可以减少源代码控制系统中的存储要求。根据引擎的类型（安装或编译），本地缓存最终将位于不同的位置。 （请参阅 BaseEngine.ini）首次启动项目时，必须根据 uasset 文件中包含的信息构建缓存。项目越大，生成本地缓存的时间就越长。这就是编辑器长时间停留在启动屏幕上的原因。团队通常会设置一个共享的DDC来降低生成本地缓存的成本。远程工作时，共享缓存的效率会根据连接质量而降低。在这些情况下最好关闭共享缓存。一个好的解决方法是将本地缓存从一台 PC 复制到另一台 PC 以充当基本缓存。这只需要完成一次，因为编辑器将在添加新资产或对资产配置进行更改时负责保持缓存最新。本地缓存由大量文件夹和小文件组成，因此您需要生成 zip 文件以实现更高效的传输。一个人可以生成一个缓存并与整个项目共享。 **安装的版本**：C:\Users\<UserName>\AppData\Local\UnrealEngine\Common\DerivedDataCache **自定义版本**：ENGINEDIR\DerivedDataCache 还可以通过在 DefaultEngine.ini 中添加一个部分来更改本地缓存位置。以下示例将本地缓存移动到 Project\DerivedDataCache 下，而不是默认位置。当共享项目而不进行源代码控制时，这非常有用。 **安装的版本：**

```cpp
[InstalledDerivedDataBackendGraph] 
Local=(Type=FileSystem, ReadOnly=false, Clean=false, Flush=false, PurgeTransient=true, DeleteUnused=true, UnusedFileAge=34, FoldersToClean=-1, Path="%GAMEDIR%DerivedDataCache")
```

**编译\自定义构建：**

```cpp
[DerivedDataBackendGraph] 
Local=(Type=FileSystem, ReadOnly=false, Clean=false, Flush=false, PurgeTransient=true, DeleteUnused=true, UnusedFileAge=34, FoldersToClean=-1, Path="%GAMEDIR%DerivedDataCache")
```

参考：【派生数据缓存|虚幻引擎 5.0 文档](https://docs.unrealengine.com/en-US/Engine/Basics/DerivedDataCache/index.html)
