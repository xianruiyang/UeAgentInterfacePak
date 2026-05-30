# 跨平台归档：在虚幻引擎中压缩和解压缩（Zip、Ooodle、Tar、LZ4、GZip）

# 跨平台归档：在虚幻引擎中压缩和解压缩（Zip、Ooodle、Tar、LZ4、GZip）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/GjYl/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2533 字符。

## 摘要

了解如何使用运行时归档器插件在虚幻引擎项目中实现文件归档和提取。本教程涵盖了跨所有主要平台（Windows、Mac、Linux、iOS、Android）压缩和解压缩文件的手动和异步操作。您将了解如何压缩文件和文件夹、从档案中提取内容以及使用原始数据压缩。非常适合需要高效文件管理解决方案来保存系统、内容交付或数据优化的游戏开发人员。该插件支持多种格式，包括 Zip、Ooodle、Tar、LZ4 和 GZip。

## 中文整理

### 介绍

本教程演示如何使用 **[Runtime Archiver](https://www.fab.com/listings/9bc46d5b-b9e1-4b93-aede-194619108265)** 插件在虚幻引擎中实现文件**归档（压缩）**和**解档（提取）**。无论您需要 **创建 zip 文件**、**从档案中提取内容**，还是 **压缩原始数据**，此插件都提供了一个**可跨所有平台使用的简单解决方案**。

### 支持的平台

Runtime Archiver 插件完全跨平台，适用于： 1. **Windows** 2. **Mac** 3. **Linux** 4. **iOS** 5. **Android**（包括 **Meta Quest**） 6. **控制台平台**

### 支持的存档格式

1. **Zip** 2. **Oodle** 3. **Tar** 4. **LZ4** 5. **GZip**

### 手动归档操作

### 创建档案

创建归档的过程涉及几个步骤： 1. 首先，创建一个 Runtime Archiver 对象：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-01.jpg)

2. 在存储或内存中创建存档：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-02.jpg)

3. 将文件或目录添加到存档中：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-03.jpg)

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-04.jpg)

4. 完成后，关闭存档：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-05.jpg)

### 打开档案并从中提取

要从现有存档中提取内容： 1. 创建运行时存档器对象：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-06.jpg)

2. 从存储或内存中打开存档：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-07.jpg)

3. 获取您要提取的特定条目：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-08.jpg)

4. 将条​​目提取到存储或内存中：

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-09.jpg)

![教程图片](assets/cross-platform-archiving-zipping-and-unzipping-in-unreal-engine-zip-oodle-tar-lz4-gzip/image-10.jpg)

5. 完成后关闭存档：

### 异步操作

为了简化实施，该插件提供了异步操作，可以在单个节点中处理整个归档/取消归档过程，从而简化您的蓝图逻辑。

### 异步归档

异步归档文件或目录：

### 异步解档

异步提取文件或目录：

### 压缩和解压缩原始数据

对于处理原始二进制数据：

### 结论

借助 Runtime Archiver，您可以在虚幻引擎项目中轻松实现跨平台文件压缩和提取。如需其他帮助或自定义开发解决方案，请联系 [solutions@georgy.dev](mailto:solutions@georgy.dev) 或加入 [Discord 支持服务器](https://georgy.dev/discord)。

