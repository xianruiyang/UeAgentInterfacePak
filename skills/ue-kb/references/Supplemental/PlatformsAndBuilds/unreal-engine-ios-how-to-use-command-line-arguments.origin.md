# iOS：如何使用命令行参数

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/vzz7/unreal-engine-ios-how-to-use-command-line-arguments

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1473 字符。

## 摘要

Brantley C 撰写的文章。要运行具有特定命令行参数的应用程序，有两种方法：默认情况下，UE4 iOS 应用程序从名为 ue4commandline.txt 的文件获取其命令行参数，该文件是 p…

## 中文整理

### 概览

*由 [Brantley C.](https://dev.epicgames.com/community/profile/BxX8/FernBlades) 撰写的文章* 要使用特定命令行参数运行应用程序，有两种方法： 默认情况下，UE4 iOS 应用程序从名为 *ue4commandline.txt* 的文件获取其命令行参数，该文件打包在 IPA 文件中。您可以在打包之前手动创建它并放置在 *Project/Build/IOS* 文件夹中，或者如果您在 Project Launcher 启动配置文件中指定启动选项，它将为您生成此文件。您可以打开打包应用程序的 IPA 文件（它是一个 zip 文件），您应该能够看到默认情况下存在的文件。或者。您可以从*运行*下的*编辑方案*对话框中直接指定 Xcode 的命令行。每个安装的 iOS 应用程序都有自己的“文档”文件夹，可以从应用程序外部读取和写入该文件夹。如果您在项目设置 → iOS 下打开“*支持 iTunes 文件共享*”和“*支持文件应用程序*”选项，您将能够在 iPhone 上的 iOS 文件应用程序中看到应用程序的文档文件夹的内容。您可以将 *ue4commandline.txt* 文件放入文档文件夹中（例如，通过从“文件”应用程序中的 Dropbox 复制该文件），该文件将在您下次启动应用程序时使用。
