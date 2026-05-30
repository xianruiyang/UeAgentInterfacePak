# 使用批处理文件清理项目目录

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/l7rR/unreal-engine-clean-project-directory-using-batch-file

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2812 字符。

## 摘要

在本教程中，我将向您展示如何创建一个简单的批处理文件来清理您的项目（将其重置为基本结构），如果出现问题的话。通过这种方式，可能会修复一些错误。当我将项目来回移动到另一台电脑时，我个人会使用它，因为由于某种原因，当我在新机器上重新编译它时，我总是会遇到一些错误。

## 中文整理

### 概览

1. 您需要做的就是在任何文本编辑器中创建一个批处理文件，甚至是记事本，只需确保最后以这种方式放置 .bat，Windows 会将其识别为可执行的 bat 文件 2. 使用以下命令创建 .bat 文件后，只需将其放置在项目目录中，即与 .uproject 文件所在的目录相同，这样脚本就会找到正确的目录和文件 2.1。然后只需双击新创建的 .bat 文件即可。 3. 到目前为止，我还没有看到任何问题，如果我将 .bat 文件保留在项目目录中，那么您可以将其保留在那里，如果您需要再次清理项目，只需双击 .bat 文件，它就会神奇地删除脚本中指定的目录和文件。使用以下命令：

```
@echo off
cd %~dp0
rmdir /s /q ".idea", ".vs", "Binaries", "DerivedDataCache", "Intermediate", "Saved/Autosaves", "Saved/Collections", "Saved/Crashes", "Saved/Logs", "Saved/UnrealBuildTool", "Saved\Config\CrashReportClient"
del /q /f .vsconfig, MySolution.sln
echo All files are deleted successfully.
pause
```

以下是命令的详细说明： - @echo off：在批处理文件运行时禁用批处理文件中每个命令的显示。 - cd %~dp0：使用 %~dp0 变量将当前目录更改为批处理文件的位置。 - rmdir /s /q ".MyGames"：删除“.MyGames”文件夹及其内容。 /s 选项会删除所有文件和子目录，而 /q 选项会悄悄地执行此操作，而不提示确认。 - del /q /f *.txt：删除当前目录中所有扩展名为“.txt”的文件。 /q 选项使其安静，而 /f 选项强制删除只读文件。 - echo 文件夹“.MyGames”删除成功。：显示一条消息，指示该文件夹已被删除。 - 暂停：执行后保持命令提示符窗口打开，以便您可以看到结果。如果您不希望窗口保持打开状态，可以删除此行。从上面的解释中可以看出： **rmdir **命令删除目录，有嵌套目录“Saved/Autosaves”的示例 **del** 命令删除文件 这就是全部！您可以按照您想要的方式随意修改它。还有一点要提的是：无论您做什么，**不要删除** **配置、内容、源文件夹**和.**uproject 文件** -> 这些是强制性的！或者，您不想删除插件文件夹，安装插件设置等只是一件令人头疼的事情。我希望这篇文章对你们中的一些人有所帮助！
