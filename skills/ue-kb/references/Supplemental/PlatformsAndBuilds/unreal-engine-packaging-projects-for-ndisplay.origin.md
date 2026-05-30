# nDisplay 的打包项目

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/OpYG/unreal-engine-packaging-projects-for-ndisplay

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2125 字符。

## 摘要

如何打包和运行使用 nDisplay 运行的独立项目。

## 中文整理

### 如何通过 Switchboard 将 nDisplay 作为独立的打包应用程序运行

### 介绍

要通过交换机在多台计算机上将 nDisplay 作为独立的打包游戏运行，请使用以下步骤： 1. 确保您的 nDisplay 配置放置在您希望运行的关卡中，并且已在每个 nDisplay 节点上进行设置。 2. 确保 nDisplay 插件已启用 **并且** nDisplay 在项目设置中已启用（请参阅项目设置 > 插件 > nDisplay）。我们建议从 nDisplay 模板项目之一开始。 3. 确保 nDisplay 配置中使用的网格启用了“允许 CPU 访问”。转到每个网格的静态网格编辑器，启用“允许 CPU 访问”。这对于打包游戏中可用的网格体至关重要。 4. 将项目打包为 Windows（64 位）- 发布或开发。 1. 在“项目设置”>“游戏默认地图”中定义默认地图 2. 确保您的地图包含在打包版本中，转至：打包设置 > 高级 > 地图列表，然后将您的地图添加到列表中。 5. 在每个 nDisplay 节点上启动并运行总机侦听器。 1. 这可以通过从编辑器启动 switchboard 时创建的桌面快捷方式来完成。 2. 或者，如果您希望在不安装编辑器的情况下运行，则需要从 Engine\Binaries\Win64\SwitchboardListener.exe 获取侦听器并复制到所有 nDisplay 节点。 3. 或者通过编辑器中的 Switchboard 工具栏 6. 从您想要启动的计算机运行 Switchboard。创建一个新的交换机配置并**将 uProject 和 Engine Dir 保留为空**。 7. 添加设备 > nDisplay > 浏览至 nDisplay 配置。这可以在项目的内容文件夹中找到。如有必要，您可以将配置 actor 资源复制到打包的游戏内容文件夹并从那里引用它。 1. 要仔细检查有效性，请确保**总机设置 > nDisplay 设置 > nDisplay 配置文件**中的路径是绝对路径并且对所有计算机都有效。 8. 在交换机设置中，在“nDisplay Executable Filename”下浏览到打包的游戏 exe 9. 连接设备 10. 启动 nDisplay
