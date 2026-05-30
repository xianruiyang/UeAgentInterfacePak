# 访问 Meta Quest 3 上的 UE 开发日志

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/1Jj4/unreal-engine-access-ue-development-logs-on-meta-quest-3

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3016 字符。

## 摘要

日志文件对于开发和调试通常非常重要。不幸的是，在 Meta Quest 上，系统文件夹被锁定，包括带有日志的应用程序文件夹。这是一个解决方案。

## 中文整理

### 概览

开发打包模式下的虚幻引擎应用程序将日志文件保存在 [项目名称文件夹]/Saved/Logs 目录下。在 Androd 上，它位于 [内部存储]/Android/data/app.yourcompany.yourapp/[项目名称文件夹]/Saved/Logs。问题是，系统文件夹在 Meta Quest 3 上被阻止访问。这是我在[此处](https://questandroidfolderaccess.tiiny.site/)找到并更新的解决方案，因为原始指令对我不起作用。首先，我假设您的 Quest 3 已经处于开发者模式，因为您使用它来测试虚幻 VR 应用程序。您还需要一个官方的 [Meta Quest Developer Hub](https://developer.oculus.com/meta-quest-developer-hub/) (MQDH) 应用程序，安装在您的 PC 上并与耳机绑定。 Quest 3 需要安装第三方APK 文件并运行ADB 命令。我不会提供 APK 文件的链接，因为它们可能会发生变化，并且您可以轻松地在 Google 中找到它们。 1. 下载 Shizuku 应用程序 apk 并使用 MQDH 安装在 Quest 上。 2.同时安装MT Manager（文件管理器）apk文件。它已经可以工作，但不幸的是无法从 Android/data 文件夹中读取文件。 3. 现在我们需要 - 在 Quest 上设置 Android 为开发者模式； - 为 Shizuku 应用程序提供 root 权限； - 通过 Shizuku 向 MT Manager 提供所需的权限。 Quest 3 应通过 USB 连接到 PC。在 MQDH 中添加 ADB 命令 adb shell am start -n com.android.settings/.Settings 然后运行它。它应该在耳机上启动默认的 Android 设置应用程序（不是 Quest 设置），该应用程序是隐藏的，但仍然存在于 Quest 上。在“设置”应用程序中，转到“关于”-->“版本号”行，然后点击最多 10 次，直到解锁 Android 开发者模式。启动 Shizuku 并确保它在辅助窗口中打开。您可能需要重新运行 ADB 命令才能打开“设置”。在“设置”应用程序中，选择“系统”-->“开发人员选项”。向下滚动到“无线调试”并启用它，确认网络，然后再次点击“无线调试”行（位于切换器左侧）以打开子菜单。在 Shizuku 应用程序中，选择“与代码配对”，然后在“设置”应用程序中单击“将设备与代码配对”。将相同的代码放入 Shizuku 中，就完成了。您现在可以关闭“设置”。 4. 启动 MT 管理器应用程序。 Shizuku 会识别它并显示在已识别的应用程序列表中。在 Shizuku 中，允许 MT Manager 访问系统文件。 5. 这样就完成了。现在您可以读取日志文件并将其从系统文件夹复制到任何其他文件夹。这可能不是最好的解决方案，但我还在我的 Quest 上安装了 Telegram Messenger 应用程序（也通过 apk）。现在我可以将日志文件复制到“下载”文件夹，该文件夹对所有应用程序开放，然后我使用 Telegram 将文件从 Quest 的“下载”文件夹发送到 PC。 **注意！** 从未知位置下载 apk 文件时要非常小心。始终寻找官方网站/git（尤其是开源应用程序）或安全的应用程序商店。
