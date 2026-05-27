---
title: "关卡可视性轨道"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematic-level-visibility-track-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "轨道", "关卡可视性轨道"]
---

# 关卡可视性轨道

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / 轨道 / 关卡可视性轨道

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematic-level-visibility-track-in-unreal-engine

在序列中有时您可能希望切换整个 [**关卡**](https://dev.epicgames.com/documentation/404) 的可见性。您可以通过在 Sequencer 中使用 **关卡可见性轨道** 将关卡设置为 **可见** 或 **隐藏** 来实现这一点。 此操作不会流式切入/切出关卡，而会将关卡中的所有内容设置为可见或隐藏。

在本示例中我们创建两个含有独特内容的非常小的关卡，然后在我们的过场动画中切换这些关卡的可见性。

## 步骤

> [!NOTE]
> 在本操作指南中，我们使用 **Blueprint Third Person Template**，并启用了 **起步内容**。

1. 在 **内容浏览器** 中，在您的项目中 **右键单击**，然后创建两个 **关卡**，分别名为 **Level01** 和 **Level02**。
2. 打开 **Level01**，然后在视口中单击 **查看模式（View Mode）**下拉菜单，选择 **不照亮（Unlit）**

   因为没有光照，所以更便于看到我们放在关卡中的项目。
3. 在 **内容浏览器** 中的 **Content/StarterContent/Architecture** 下，将 **SM_AssetPlatform** 拖动到关卡中。
4. 在 **内容浏览器** 中的 **Content/StarterContent/Props** 下，将 **SM_Chair** 拖动到关卡中。
5. **保存（Save）**关卡，然后打开 **Level02**，将 **Wall_Door_400x300** 拖动到关卡中。
6. 将 **Floor_400x400**（或其他任何资产）拖动到关卡中，如下图所示。

   我们添加的内容仅用作示例，旨在区分关卡 01 与关卡 02。您可随意添加自己的内容！
7. 在 **内容浏览器** 中的 **Content/ThirdPersonBP/Maps** 下，打开 **ThirdPersonExampleMap** 并将视口设置为 **照亮（Lit）**。
8. 从菜单栏选择 **窗口（Window）**，然后选择 **关卡（Levels）**。
9. 单击 **关卡（Levels）**下拉菜单，然后选择 **添加现有项...（Add Exisiting...）**。

   我们需要添加要让关卡可见性轨道影响的关卡。
10. 在 **打开的关卡（Open Level）**窗口中指向您的 **Level01**，然后重复以上过程并添加 **Level02**。
11. 按住 **Shift** 并单击每个关卡，然后 **右键单击**，将 **流式方法（Streaming Method）**改为 **总是加载（Always Loaded）**。

    这样我们就可以通过 Sequencer 的可见性轨道选择性地打开/关闭每个关卡。
12. **右键单击** **持久关卡（Persistent Level）**，选择 **设为当前关卡（Make Current）**。

    现在我们的关卡已经设置好了，我们可以跳转到 Sequencer 中，使用我们的关卡可见性轨道来影响它们。

    > [!NOTE]
    > 请参见 [关卡流送](../../../../../building-virtual-worlds/level-streaming/index.md) 了解更多关于关卡流式播放的信息。
13. 在工具栏中单击 **过场动画（Cinematics）**，再选择 **添加关卡序列（Add Level Sequence）**。
14. 在 Sequencer 中单击 **添加（Add）**按钮并添加 **关卡可见性轨道（Level Visibility Track）**。
15. 在关卡可见性轨道上，单击 **可见性触发器（Visibility Trigger）**按钮，然后添加两条 **可见（Visible）**轨道和两条 **隐藏（Hidden）**轨道。
16. **右键单击** 最上面的可见轨道，然后在 **属性（Properties）**下面单击 **关卡名称（Level Names）**旁的 **+**，输入 **Level01**。

    **关卡名称（Level Names）**字段是我们定义要影响哪些关卡的地方，我们为此轨道将其设置为 **Level01**。
17. 对第二条 **可见** 轨道重复上一步，但使用 **Level02** 代之。
18. 对于两条 **隐藏** 轨道，将其中一条的 **关卡名称（Level Names）** 设置为 **Level01**，另一条的设置为 **Level 02**，然后按下图所示排列。

    在上图中，上面的两条轨道与 **Level01** 相关，该关卡将从可见变为隐藏。下面的两条轨道与 **Level02** 相关，该关卡将先 **隐藏**，然后变为 **可见**。

    您可能看不到放在关卡中的项目，请使用 **WASD** 键并从关卡下方检查。

    流式切入时它们的显示位置基于它们在其相应关卡中的放置位置。您可以像选择任何其他 Actor 一样选择关卡流式切入 Actor，并可使用 [**转换工具**](../../../../../understanding-the-basics/actors-and-geometry/transforming-actors/index.md) 对其进行操纵。
19. 使用序列编辑器的预览 **播放（Play）**按钮来播放关卡序列。

## 最终结果

放在 Level 01 中的项目将在持久关卡中先出现，然后消失，同时放在 Level 02 关卡中的项目会出现。

我们还将关卡序列资产拖动到关卡中，并启用了 **自动播放（Auto Play）**选项，这样就能使用 **在编辑器中播放（Play in Editor）**选项。

> [!NOTE]
> 使用关卡可见性轨道时有一点必须牢记，虽然可以将关卡及其资产切换为隐藏或可见，但这并不会卸载或加载关卡，每个关卡仍然驻留在内存中，并根据您选择的设置渲染或不渲染。
