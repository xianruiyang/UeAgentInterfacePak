# 技术说明：在 4.26.0 中无法从内容浏览器中删除 MaterialFunction 资源

# 技术说明：在 4.26.0 中无法从内容浏览器中删除 MaterialFunction 资源

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/mo91/unreal-engine-tech-note-cannot-delete-materialfunction-assets-from-the-content-browser-in-4-26-0

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1282 字符。

## 摘要

文章作者：Martin S. 描述：版本 4.26.0 包含一个错误，该错误可能会阻止通过内容浏览器删除 MaterialFunction 资源（uasset 文件）。该问题与优化有关......

## 中文整理

### 概览

*文章由 [Martin S.](https://dev.epicgames.com/community/profile/Jonn/Svegn2) 撰写* **描述：** 版本 4.26.0 包含一个错误，该错误可能会阻止通过内容浏览器删除 MaterialFunction 资源（uasset 文件）。该问题与缩短参考收集时间的优化有关。 **潜在影响：** 删除后，MaterialFunction 资源将从内容浏览器中消失，但当重新启动编辑器时它会回来，因为该文件仍然存在于磁盘上。这也将阻止使用相同名称创建新资产。 **Solution:** Editor.UseLegacyGetReferencersForDeletion is a CVar that, when set, will revert to the old reference gathering code.从控制台或通过在 DefaultEngine.ini 中添加以下部分设置为 1： [SystemSettings] Editor.UseLegacyGetReferencersForDeletion=1 版本 4.26.1 预计会有永久修复。升级到 4.26.1 后，请确保从 ini 中删除上述部分，以受益于改进的删除时间。 UE版本：4.26

