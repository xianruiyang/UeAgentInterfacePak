---
title: "顶视 2D 游戏设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper-2d-example-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D指南", "顶视 2D 游戏设置"]
---

# 顶视 2D 游戏设置

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D指南 / 顶视 2D 游戏设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper-2d-example-in-unreal-engine

此页面讲述如何对现有的 **第三人称模板（Third Person Template）** 项目进行修改，创建一个 **顶视 2D** 游戏。

可在此教程中使用自己的 2D 角色，也可从以下链接下载一个样本角色：

- 样本资源

## 项目设置

我们将进行此教程的项目设置，您可导入自己的资源，也可使用样本资源。

1. 新建一个 **Third Person Blueprint** 模板项目。
2. 在项目中 **右键单击** **内容浏览器** 中的 **Content** 文件夹，然后创建一个 **新文件夹**。

   将文件夹命名为 **TopDown** 或其他任意命名。
3. 找到下载的样本资源并将 **SoldierSprites.paper2dsprites** 资源拖入 **内容浏览器**。

   此操作将自动创建一个 **SolderSprites** Sprite 表单资源以及包含 **Frames** 和 **Textures** 的文件夹。

   > [!NOTE]
   > 如需了解设置资源进行导入的更多内容，请查阅 [Paper 2D 导入选项](../../import-sprites/index.md) 文档。
4. 在 **SoldierSprites** 资源上 **单击右键** 并选择 **create Flipbooks**。

   此操作将基于 sprite 表单创建两个 Flipbook。
5. （任选）打开 **Idle** Flipbook，在 details 面板中将 **Frames Per Second** 设为 **3.0**。

   再将 **Run** Flipbook 的 **Frames Per Second** 设为 **8.0**。

   此操作将降低两个 Flipbook 动画的播放速度。

项目现已设置完成，即可开始设置顶视角色。

## 角色设置

我们将新建一个 Paper 2D 角色蓝图并设置角色。

1. 在 **内容浏览器** 中 **单击右键**，选择新建一个 **Blueprint Class**。
2. 在 **Pick Parent Class** 窗口中点击 **All Classes** 下拉菜单，搜索并添加 **PaperCharacter**。

   为新蓝图命名，如 **TopDownCharacter**。
3. 在 **TopDownCharacter** 蓝图中的 **Components** 窗口内点击 **Sprite** 组件。
4. 在 **Details** 的 **Sprite** 下点击 **Source Flipbook** 下拉菜单并选择 **Idle** Flipbook。

   角色将被添加到胶囊体组件中的 **视口**。
5. 返回 **Details** 面板，在 **Transform** 下将 XYZ 轴的 **Rotation** 设为 **-90,0,90**，**Scale** 设为 **0.75**。

   此操作将把 Flipbook 旋转入位并将其缩小，便于放入碰撞胶囊体。
6. 在 **Components** 窗口中点击 **CapsuleComponent**，然后在 **Details** 面板中调整 **Shape** 设置。

   基于使用角色的不同，设置将存在差异，我们将 **Half Height** 和 **Radius** 设为 **45.0**。
7. 在 **Components** 窗口中点击 **TopDownCharacter(self)**，然后在 **Details** 面板中取消勾选 **Use Controller Rotation Yaw**。

   在此示例中，我们要让角色自动朝向他们要移动的方向，不使用控制器旋转。
8. 在 **Components** 窗口中点击 **CharacterMovement** 组件。
9. 在 **CharacterMovement** 的 **Details** 面板中将 **Max Walk Speed** 更新到 **400**，然后勾选 **Orient Rotation to Movement**。

   此操作将减慢角色移动速度，并基于运动自动旋转角色。
10. 在 **Components** 窗口中点击 **Add Component** 并搜索添加一个 **弹簧臂（Spring Arm）** 组件。
11. 再次点击 **Add Component** 并添加一个 **摄像机（Camera）** 组件，然后将摄像机拖到弹簧臂上完成附加。
12. 选择 **摄像机** 组件，然后在 **Details** 面板中将 **Location** 设置归零。
13. 选中 **弹簧臂**，然后在 **Details** 面板中进行以下更新。

    我们将弹簧臂（同时也延伸到摄像机）的 **Rotation** 设为 **180, -90, 180**，将摄像机直接放置在角色上方。然后将 **Target Arm Length** 改为 **600**，将摄像机和角色之间的距离调远。最后取消勾选 **Pitch、Yaw 和 Roll** 的 **Inherit** 选项，因为不需要继承摄像机的设置。
14. 点击 **编译** 和 **保存**，然后最小化蓝图（稍后再返回）。

角色便设置完成，然后尚未对其应用移动脚本，需要从 **Third Person Character** 蓝图中抓取。

## 完成

无需进行重复工作，因为此模板的角色自带移动的脚本功能，我们可将该功能复制到 Paper Character，使其可移动。

> [!NOTE]
> 如需了解角色动作设置和在空白项目中设置角色动作的详细内容，请查阅 [在蓝图中设置角色动作](https://dev.epicgames.com/documentation/unreal-engine/setting-up-character-movement) 文档。

1. 在 **Content Browser** 的 **ThirdPersonBP** 文件夹中打开 **Blueprints** 文件夹，然后打开 **ThirdPersonCharacter** 蓝图。
2. 在 **事件图表** 中 **鼠标左键** 拖动选择框，然后按下 **Ctrl+C** 组合键复制 **Movement Input** 部分。

   此处包含其他 3D 游戏性脚本，如操纵摄像机、控制器输入和跳跃。此教程只讲述整体动作。
3. 返回 **Paper Character** 蓝图，在 **事件图表** 中按下 **Ctrl+V** 进行粘贴。
4. 在 **ThirdPersonBP** 和 **Blueprints** 文件夹中打开 **ThirdPersonGameMode** 蓝图。
5. 在 **Classes** 下将 **Default Pawn Class** 改为使用的 **Paper Character**（*TopDownCharacter*）。

   此操作将把 Paper Character 设为游戏中使用的默认角色。
6. 删除关卡中的蓝色角色，在运行游戏时不对其进行控制。
7. 点击主工具栏中的 **Play** 按钮在编辑器中进行游戏。

   虽然 2D 角色为待机状态，但您仍可使用 **WASD** 键四处移动默认地图。

此教程说明如何创建可操作的 2D 角色，完成顶视游戏的基础设置；其他教程将继续深入挖掘该范例，如 **设置动画状态机**（为角色设置各种 Flipbook 动画状态进行使用），以及 **Paper 2D 图块地图** 中 2D 地图的创建部分。需要为顶视游戏设置固定摄像机位而非跟随摄像机？**如何在蓝图中使用摄像机** 页面将为您指点迷津。
