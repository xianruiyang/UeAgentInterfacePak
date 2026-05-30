# 将 Editor_Widget 按钮添加到编辑器工具栏

# 将 Editor_Widget 按钮添加到编辑器工具栏

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/0yoy/unreal-engine-add-editor_widget-buttons-to-editor-tool-bar

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 682 字符。

## 摘要

如何将 Editor_Widget 按钮添加到编辑器工具栏

## 中文整理

### 为您的编辑器小部件创建编辑器按钮

### 1-使用以下代码创建一个python文件

**如何将 Editor_Widget 按钮添加到编辑器工具栏**

```
import unreal  

# Define the owning menu where the button will be added
menu_owner = "editorUtilities"  
tool_menus = unreal.ToolMenus.get()  
owning_menu_name = "LevelEditor.LevelEditorToolBar.AssetsToolBar"  

# Define a custom Python class for the toolbar button
@unreal.uclass()
class CreateEntryExample(unreal.ToolMenuEntryScript):
```

将 Game/UMGWidgetPath 替换为您的小部件路径，您可以在这个令人惊叹的 Github 资源中查找内置图标的引擎 [EpicKiwi/unreal-engine-editor-icons：虚幻引擎编辑器 Slate 样式中可用的图标列表](https://github.com/EpicKiwi/unreal-engine-editor-icons)

### 2-在启动时应用代码

为此，只需转到项目设置 -> 插件 -> Python A- 在附加路径中添加文件路径 B- 在启动脚本中输入脚本名称


