# 从 iOS 构建中排除块

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/vwx7/unreal-engine-excluding-chunks-from-ios-builds

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3949 字符。

## 摘要

此解决方法提供了一种在 iOS 构建上排除分块 pak 文件的方法。在 Android 上这是一个简单的方法，但在 iOS 上，需要做一些工作。

## 中文整理

### 从 iOS 构建中排除块

对于 Android 版本，默认情况下，.pak 文件包含在与项目一起生成的 OBB 文件中。要排除它们，您需要打开 DefaultEngine.ini 文件并使用 Android 运行时设置下的 OBB 过滤器过滤它们。

```cpp
[/Script/AndroidRuntimeSettings.AndroidRuntimeSettings]
	+ObbFilters="-*pakchunk1*"
	+ObbFilters="-*pakchunk2*"
	+ObbFilters="-*pakchunk3*"
	+ObbFilters="-*pakchunk4*"
	+ObbFilters="-*pakchunk5*"
	+ObbFilters="-*pakchunk6*"
	+ObbFilters="-*pakchunk7*"
	+ObbFilters="-*pakchunk8*"
	+ObbFilters="-*pakchunk9*"
```

在上面的示例中，OBB 过滤器将捕获包含所提供的任何文本的任何 .pak 文件。例如，+ObbFilters="-*pakchunk1*" 将忽略名称包含“pakchunk1”的任何 pak 文件。您可以在此[链接](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-google-play-asset-delivery-in-unreal-engine?application_version=5.3)找到更多相关信息***但是iOS版本呢？ ***

### 从 ipa 中排除分块 pak 文件

跨平台打包系统确实有一个内置机制，可以将块从包中分离出来并将其放入目录中（例如从托管服务器/CDN 在游戏中下载它）。您可以通过将以下命令行选项添加到通常用于打包的 RunUAT BuildCookRun 命令中来实现它（当您从编辑器打包时，在编辑器日志中可见）。

```cpp
-createchunkinstall -chunkinstalldirectory="/Users/Shared/Projects/ChunkTest/CDNChunks" -chunkinstallversion=1.0
```

不幸的是，这似乎并没有意识到IO Store系统为每个pak文件生成相应的utoc和ucas文件，并且不会从pak中排除这些文件。如果您在“项目设置”->“打包”下禁用 IO Store，它确实可以正常工作。

### 创建块

使用以下命令行打包后，CDNChunks 文件夹包含每个非 0 chunk pak 文件的文件夹，而 ipa 文件仅包含 pakchunk0-ios.pak。

```cpp
Engine/Build/BatchFiles/RunUAT.sh BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook  -project="/Users/Shared/Projects/ChunkTest/ChunkTest.uproject"  -unrealexe="/Users/Shared/Epic Games/UE_5.1/Engine/Binaries/Mac/UnrealEditor-Cmd" -platform=IOS -stage -archive -package -build -pak -compressed -prereqs -archivedirectory="/Users/Shared/Projects/ChunkTest" -manifests -clientconfig="Development" -nocompile -nocompileuat -createchunkinstall -chunkinstalldirectory="/Users/Shared/Projects/ChunkTest/CDNChunks" -chunkinstallversion=1.0
```

不幸的是，BuildPatchTool 在退出时挂起，因此整个打包过程在第一个块上停止。作为一个快速解决方法，我们需要对 BuildPatchTool 进行更改并编译它

### 编译BuildPatchTool

*注意：您需要自己获取[源代码](https://docs.unrealengine.com/5.3/en-US/downloading-unreal-engine-source-code/)和[编译](https://docs.unrealengine.com/5.1/en-US/building-unreal-engine-from-source/)buildpatch工具。您还需要在 Mac 上。* 获得引擎源代码后： 1. 从引擎根文件夹运行GenerateProjectFiles.command 2. 在 XCode 上打开 UE5.workspace 文件 3. 选择 BuildPatchTool 作为构建目标 4. 选择“编辑方案”命令 5. 在打开的对话框中，选择“运行”菜单并将“构建配置”更改为“运输” 6. 关闭对话框 7. 打开Engine\Source\Runtime\PakFile\Private\IPlatformFilePak.cpp 文件 8. 注释掉此行以防止关机时崩溃 //FCoreDelegates::GetRegisterEncryptionKeyMulticastDelegate().RemoveAll(this); 9. 构建项目这将构建 Engine/Binaries/Mac/BuildPatchTool.app 的版本。完成此操作后，您可以运行与上面相同的命令（在“创建块”部分中）并能够完成打包。
