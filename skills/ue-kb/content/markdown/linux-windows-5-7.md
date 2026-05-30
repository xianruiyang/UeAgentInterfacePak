# Linux下为Windows构建虚幻引擎5.7蓝图项目包

# Linux下为Windows构建虚幻引擎5.7蓝图项目包

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/o9xB/building-unreal-engine-5-7-blueprint-project-package-for-windows-under-linux

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3186 字符。

## 摘要

本指南提供了在 Linux (Ubuntu 24.04) 下使用 Umu、Proton 和 msvc-wine 成功构建 Unreal Engine 5.7 蓝图项目的 Windows 包的工作流程。

## 中文整理

### 概览

**本指南提供了在 Linux (Ubuntu 24.04) 下使用 Umu、Proton 和 msvc-wine 成功构建 Unreal Engine 5.7 蓝图项目的 Windows 包的工作流程。**

### 1.设置路径并创建AutoSDK目录

```
export UE_PATH=/Path/To/UE_5.7 # Set this to your Unreal Engine dir
export MSVC_PATH=$UE_PATH/AutoSDK/HostWin64/Win64
mkdir -p $MSVC_PATH
```

### 2. 使用 msvc-wine 下载 Windows SDK 和 Visual Studio 构建工具：

```
cd $UE_PATH
git pull https://github.com/mstorsjo/msv​c-wine
cd msvc-wine
./vsdownload.py --accept-license \
    --major 17 \
    --dest $MSVC_PATH \
    --msvc-version 17.8 \
    --sdk-version 10.0.22621
    --architecture x64 \
    --host-arch x64
```

### 3. 创建必要的符号链接：

```
ln -s $MSVC_PATH/VC/Tools/MSVC $MSVC_PATH/VS2022
```

### 4. 下载GE-Proton10-34：

```
cd $UE_PATH
wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-34/GE-Proton10-34.tar.gz
tar -xzf ./GE-Proton10-34.tar.gz
```

### 5.下载Umu启动器：

```
wget https://github.com/Open-Wine-Components/umu-launcher/releases/download/1.4.0/umu-launcher-1.4.0-zipapp.tar
tar -xf  ./umu-launcher-1.4.0-zipapp.tar
sudo cp ./umu/* /usr/bin
```

### 6. 在 $UE_PATH/umu 中创建包装脚本：

```
#!/usr/bin/env bash
set -euo pipefail

nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" # prevent some crashes on RTX

# SET YOUR PATHS HERE!!!
export UE_PATH="/Your/Path/To/UE_5.7"
export UE_SDKS_ROOT="z:\\Your\\Path\\To\\UE_5.7\\AutoSDK"

export PROTONPATH="$UE_PATH/GE-Proton10-34"
```

### 7. 在 $UE_PATH/start 中创建虚幻引擎启动脚本：

```
#!/usr/bin/env bash

# We will use DX12 and no RayTracing
./umu Engine/Binaries/Win64/UnrealEditor.exe -dx12 -NoRayTracing
```

### 8. 如何在UE编辑器之外构建包？

我无法直接从编辑器构建包：

```
LogOutputDevice: Error: === Handled ensure: === 
LogOutputDevice: Error: Ensure condition failed: BuildTargetInfo [File:D:\build\++UE5\Sync\Engine\Source\Editor\TurnkeySupport\Private\TurnkeySupportModule.cpp] [Line: 447] 
LogOutputDevice: Error: CookOrPackage BuildTargetName='' IniPlatformName='Windows' Mode='1' 
BuildCookRunParams='-nop4 
-utf8output 
-nocompileeditor 
-skipbuildeditor -cook 
-project="S:/Unreal/Projects/Janek_new/Janek1.uproject" 
-unrealexe="S:\Unreal\UE_5.7\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" 
-platform=Win64
```

但可以使用 umu 包装器启动的 cmd 来完成此操作：

```
cd $UE_PATH
./umu wineconsole cmd
```

这是您可以根据需要更改的构建命令：

```
set UE_PATH=Z:\Your\Path\To\UE_5.7
cd %UE_PATH%\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -nop4 -utf8output -project="%UE_PATH%\Projects\YourProject\YourProject.uproject" -unrealexe=%UE_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Win64 -clientconfig=Development -serverconfig=Development -installed -nocompileeditor -skipbuildeditor -nobuild -cook -stage -package -pak -iostore -prereqs -archive -archivedirectory="%UE_PATH%\Projects\YourProject\Packaged\Win64"
```

这应该将打包文件生成到“Projects/YourProject/Packages/Win64”中，这些文件应该在 Windows 计算机上运行。

