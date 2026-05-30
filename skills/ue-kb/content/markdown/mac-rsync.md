# 如何修复 Mac 上的 rsync 错误/权限被拒绝

# 如何修复 Mac 上的 rsync 错误/权限被拒绝

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/vvDb/unreal-engine-how-to-fix-rsync-error-permission-denied-on-mac

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2632 字符。

## 摘要

我将快速教程介绍为什么不应在 Mac 上以 root 身份运行 UE，以及如果这样做该怎么办。

## 中文整理

### 概览

不要尝试以 root 身份运行 XCode 或 UE (sudo XCode)。如果这样做，您可能会在打包过程中遇到权限被拒绝的错误。为什么？因为 XCode 和 UE 可能会在没有管理员权限的情况下启动额外的脚本/应用程序/服务。这可能会阻止主应用程序修改必要的文件。 IE。尝试从 sudo XCode 启动 UE 时，您可能会看到此错误：

```
Could not launch “UnrealEditor” 
Domain: IDELaunchErrorDomain 
Code: 20 
Recovery Suggestion: The LaunchServices launcher has returned an error. Please check the system logs for the underlying cause of the error.

[...]

-- 
Launchd job spawn failed 
Domain: NSPOSIXErrorDomain
```

这同样适用于 UE Src 设置 - 不要尝试 sudoGenerateProjectFiles，因为它会以 root 身份生成文件，并且每次 XCode 或 UE 想要更改它们时都需要 root 访问权限。如果你已经这样做了怎么办？您仍然可以通过更改 UE 和项目文件夹中所有文件的所有者和权限来挽救生命：

```
sudo chown -R $(whoami) <folder_name>
sudo chmod -R u+w <folder_name>
```

有了这个，您应该能够以普通用户身份运行 XCode 和 UE、打包游戏或从 XCode 运行 UE，不会出现任何问题。但是，如果您尝试以管理员身份打包游戏，并且看到以下错误：

```
rsync error: some files could not be transferred (code 23) at /AppleInternal/Library/BuildRoots/d9889869-120b-11ee-b796-7a03568b17ac/Library/Caches/com.apple.xbs/Sources/rsync/rsync/main.c(996) [sender=2.6.9]
BUILD FAILED: AddBuildProductsFromManifest: <project_dir>/Binaries/Mac/Game.app/Contents/Info.plist was in manifest "UnrealEngine/Engine/Intermediate/Build/Manifest.xml" but could not be found.
```

这是因为UE没有权限修改你的Game.app。就我而言，以 root 身份运行 UE 并不能解决问题，因为 rsync 是作为单独的脚本执行的，没有管理员权限。您可以通过手动将所需的 Info.plist 和 PkgInfo 文件复制到 Game.app 来解决此问题： 1. 在项目目录中搜索 .plist 文件并找到 Game-Info.plist（将“Game”替换为您的项目名称）。选择 Development 文件夹下的 .plist 进行开发构建。 2. 将文件重命名为“Info.plist”。 3. 将文件复制到 Game.app/Content/（右键单击 Game.app -> 显示包内容）。在上面的日志中找到 Game.app 的路径。 4. 创建一个空文件 PkgInfo.txt请注意，该文件没有扩展名。 5. 将 PkgInfo 复制到您的 Game.app/Content/ 中。 6. 再次尝试构建。 UE 应将已构建的 Game.app 与您的文件一起使用，并应继续进行内容烹饪。

