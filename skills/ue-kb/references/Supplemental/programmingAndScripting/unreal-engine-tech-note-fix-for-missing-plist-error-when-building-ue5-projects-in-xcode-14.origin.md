# 技术说明：修复在 Xcode 14 中构建 UE5 项目时缺少 .plist 错误

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/wzam/unreal-engine-tech-note-fix-for-missing-plist-error-when-building-ue5-projects-in-xcode-14

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1659 字符。

## 摘要

技术说明：修复在 Xcode 14 中构建 UE5 项目时缺少 .plist 错误本文由 Alex K 撰写说明：在 Xcode 14 中构建现有项目可能会遇到以下错误 - 无法编码…

## 中文整理

### 概览

*本文由 [Alex K](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写* 说明：在 Xcode 14 中构建现有项目可能会遇到以下错误 - 无法进行代码签名，因为目标没有 Info.plist 文件且未自动生成。使用 INFOPLIST_FILE 构建设置将 Info.plist 文件应用到目标，或者通过将 GENERATE_INFOPLIST_FILE 构建设置设置为 YES（推荐）来自动生成一个 Info.plist 文件。潜在影响：严重：此错误可能会阻止现有项目的构建。解决方案：请注意，此解决方法需要 [5.0.3 Mac QFE:](http://cdn.unrealengine.com/qfe/QFE-5.0-Xcode14Support-CL-22337428-PF-22380667-Job-cbd57f.zip)（在 CL 22530897 提交到 UE5/Release-5.0）要解决此问题，打开终端并运行以下命令： ./../Shared/Epic\ Games/UE_5.0/Engine/Build/BatchFiles/Mac/[GenerateProjectFiles.sh](http://generateprojectfiles.sh/) -game -project="<.uproject 文件的完整路径>" 传递到“-project”参数的值应该是 uproject 文件的完整路径，如果您的虚幻引擎安装在另一个文件夹。警告：这将丢弃任何自定义 Xcode 项目设置，因此请根据需要备份您的 .xcodeproj 文件。您的代码不会受到影响。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案
