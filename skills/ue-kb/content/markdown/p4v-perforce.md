# 使用 P4V 添加其他项目到 Perforce（尽可能简单）

# 使用 P4V 添加其他项目到 Perforce（尽可能简单）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/BEqk/unreal-engine-adding-additional-projects-to-perforce-using-p4v-as-simply-as-possible

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4911 字符。

## 摘要

将多个项目添加到 Perforce 源代码管理的相对简单的指南（使用 P4V）

## 中文整理

### 简介：

有几本关于让 Perforce 做各种奇特事情的史诗指南...流仓库、分支/合并、巫术...本指南不是其中之一。这是有关如何向 Perforce 添加其他项目的快速指南。对于已经安装和集成 Perforce 但准备添加一个或多个项目的独立开发人员或小型团队，我们尝试使其尽可能简单。有多种方法可以实现此任务，以下只是其中一种选择。此方法使用 P4V（无命令行），并假设您可以为每个项目拥有单独的仓库和工作区。还没有设置 Perforce 吗？寻找更高级的主题？查看本教程底部的链接！

### 第 1 步：创建工作区文件夹和新项目

1. 在计算机上创建一个新文件夹作为工作空间文件夹（例如 Users\dingus\WorstGameEvr_Workspace\） 2. 在刚刚创建的文件夹中创建一个新的 UE4/UE5 项目 3. 如果创建一个完全空白的项目，请向您的内容文件夹中添加一些内容（实际上可以是任何内容）

### 第 2 步：添加仓库

1. 登录 P4Admin 2. 转到 Depots 选项卡 3. 添加新的 depot（可以通过按 ctrl+N 来执行此操作） 4. 为其命名（例如 WorstGameEvr） 5. 将类型保留为“local”

### 第 3 步：添加工作区

1. 登录 P4V 2. 转到“工作空间树”选项卡 3. 添加新工作空间（您可以选择“连接”->“新建工作空间...”或单击工作空间树顶部的下拉菜单并选择“新建工作空间...”） 4. 为您的工作空间命名一个比默认名称更好的名称（例如 Dingus_WorstGameEvr） 5. 将工作空间根目录设置为您在步骤 1 中创建的文件夹 6. 您可以在“工作空间”下更改映射Mappings”，只是注意不要删除刚刚创建的depot 7.点击OK

### 第4步：首次提交内容

1. 在 P4V 中，确保在工作区树中打开新工作区，然后选择要标记为“添加”的项目（通常是“Content”和“Config”文件夹以及 .uproject 文件，以及您要添加的其他任何内容） 2. 单击顶部菜单中的“添加”图标，或右键单击要添加的项目之一，然后单击“标记为添加...” 3. 在工作区树中选择根文件夹，然后单击顶部的“提交”图标菜单 4. 转到您的 Depot 选项卡，然后单击顶部菜单中的“刷新”，以确保您的文件已传输完毕！注意：如果您尝试标记为添加的文件夹未提交，请确保它不为空。如果是，该文件夹将不会添加到库中。注意：如果您尝试在项目文件夹之外添加文件（例如...WorstGameEvr_Workspace\WorstGameEvr\，默认情况下，您可能会收到错误“不在客户端视图中”。解决此问题的一个简单方法是将所有文件保留在项目文件夹内。

### 第 5 步：从虚幻引擎内部连接到源代码管理

1. 打开您的 .uproject 文件 2. 转到屏幕右下角并单击“版本控制” 3. 在打开的窗口中，输入您的信息以连接到源代码管理 4. 尝试添加新资源或更改现有资源，然后单击“版本控制”和“提交更改”进行保存并提交 注意：如果使用 UE4，您仍应连接到源代码管理，但打开源代码管理窗口的位置有所不同

### 第 6 步：为第二台计算机添加工作区

1. 在第二台计算机上创建工作区文件夹（例如 Users\dumbdumb\WorstGameEvr_Workspace\） 2. 在第二台计算机上登录 P4V 3. 使用与步骤 3 相同的方法创建工作区

### 第 7 步：将项目文件下载到第二台计算机

1. 单击 P4V 中的“Depot”选项卡 2. 单击您在步骤 2 中创建的 depot 3. 单击上面菜单中的“获取最新”图标

### 第 8 步：在第二台计算机上打开项目

1. 打开 %LOCALAPPDATA%\EpicGamesLauncher\Saved\Config\Windows\GameUserSettings.ini 2. 在任何现有的“CreatedProjectPaths”参数下，为新工作区文件夹添加一个参数（例如 CreatedProjectPaths=C:\Users\dumbdumb\WorstGameEvr_Workspace） 3. 保存文件 4. 打开 Epic Games Launcher。你的项目应该在那里！注意：当您在第二台计算机上打开项目时，请务必连接到第二台计算机上的源代码管理

### 更多资源：

需要一些帮助甚至达到 Perforce *功能*的地步吗？我推荐 [此视频（虚幻引擎中的协作和团队合作）](https://youtu.be/ywu4l1RTFPU)、[此视频（版本控制基础知识）](https://youtu.be/JxXydvG4mlI) 或 [本指南（Oracle 上的 Perforce 设置）云）]（https://dev.epicgames.com/community/learning/tutorials/1lV4/unreal-engine-perforce-setup-on-oracle-cloud-free-tier）。或者更好的是，三个都可以。您是更高级的用户吗？准备好接受流仓库和所有这些弱酱汁之外的东西了吗？尝试一下[本指南（使用和设置 Perforce 存储库）](https://dev.epicgames.com/community/learning/tutorials/Gxoj/unreal-engine-using-and-setting-up-perforce-repository) 我希望本教程可以帮助某些人避免一些头痛。祝您的项目顺利！

