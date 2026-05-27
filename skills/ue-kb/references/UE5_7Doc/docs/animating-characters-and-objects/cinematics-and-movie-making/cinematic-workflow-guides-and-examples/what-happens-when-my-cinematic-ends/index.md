---
title: "保留或存储通过 Sequencer 进行的修改"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/what-happens-when-my-cinematic-ends-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "过场动画流程指南和示例", "保留或存储通过 Sequencer 进行的修改"]
---

# 保留或存储通过 Sequencer 进行的修改

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 过场动画流程指南和示例 / 保留或存储通过 Sequencer 进行的修改

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/what-happens-when-my-cinematic-ends-in-unreal-engine

在 Sequencer 中进行操作时，用户可修改 Actor 状态，并在过场动画结束后将状态保留。举例而言，创建一个过场动画，角色解锁并打开一扇门，之后这扇门仍然保持打开状态。然而在影片制作环境中，用户可能需要在镜头中设置动画数值，使其及时返回设置动画之前的状态，避免渗入到下个镜头中。用户可通过 **When Finished** 属性以每个轨道为基础来确定轨道应返回设置动画之前的状态，或在序列播放完成后保留修改。

在此指南中，您将使用 When Finished 属性保留一个光照的颜色变化，同时保留对门运动所进行的修改。

## 步骤

> [!NOTE]
> 在此指南中，我们使用的是启用了 **Starter Content** 的 **Blueprint Third Person Template** 项目。

1. 从 **Content/StarterContent/Props** 文件夹将一个 **SM_Door** 和 **SM_DoorFrame** 拖入 **关卡视口**，并将门放置在门框中。

   按下 **W** 键进入平移模式，如有必要可禁用网格对齐（下图所示），在门框中对门的位置进行微调。
2. 在 **放置Actor（Place Actors）** 面板的 **Lights** 选项卡中，将一个 **Point Light** 拖入 **关卡视口** 并将其放置在门前。
3. 在 **关卡视口** 中将 **ThirdPersonCharacter** 放置到门前。
4. 点击 **主工具栏** 中的 **Cinematics** 按钮并选择 **Add Level Sequence**。
5. 在 **Save Asset As** 窗口中选择一个 **命名** 和保存路径，然后点击 **Save**。
6. 在 **Sequencer** 窗口中，点击 **Add** 按钮并选择 **Shot Track**。

   此操作将创建一个 [镜头轨道（Shot Track）](../../unreal-engine-sequencer-movie-tool-overview/sequences-shots-and-takes/index.md)，用于将过场动画切分为自含式的"镜头"，以便进行整理和二次整理。
7. 在 **镜头轨道** 上，点击 **+ Shot** 按钮和 **Insert Shot**，弹出提示后使用默认命名规则。
8. 选取镜头末尾，将其拉回至 **第 75 帧**，使镜头的长度是整个序列的一半。

   我们将使用镜头来影响场景中的光照，并在镜头结束后保留这些修改。
9. 将 **时间轴** 调至 **第 0 帧**、并在关卡中选择 **SM_Door**，然后通过 **+ Add** 按钮添加 **Actor To Sequencer**。

   我们将对主关卡中的门产生影响，并保留即将应用的修改。
10. 点击 **SM_Door** **Transform** 轨道上的 **+** 按钮。
11. 将 **时间轴** 标记移动至 **第 150 帧**，然后旋转关卡中的门（**E** 键）将其打开，然后按下 **S** 键添加其打开时的变形。

    完成此设置后，过场动画播放完成后门将从关闭状态变为打开。
12. 双击 **镜头轨道** 中的镜头将其打开，然后在关卡中选择 **Point Light** 并将其添加至镜头。
13. 在 **Light Color** 轨道上点击 **+** 符号指定镜头 **第 0 帧** 处使用的默认颜色。
14. 将 **时间轴** 标记移至 **第 75 帧** 并将 **Light Color** 改为 **Green**（或其他任意颜色），为新值添加键。
15. 在轨道窗口中右键点击 **Light Color** 轨道，并选择 **Properties** 查看 **When Finished** 状态。

    **When Finished** 默认状态是分段动画完成后此轨道将 **Restore State**（恢复其原始状态）。
16. 退出 **镜头** 并点击 **Sequencer** 窗口右上角的导览列按钮返回 **Master Sequence** 关卡。
17. 右键点击 **SM_Door** 的 **Transform** 轨道并选择 **Properties**，然后将 **When Finished** 属性改为 **Keep State**。

    此操作将宣称要 **保留状态（Keep State）**，代表动画结束时我们将保留通过 Sequencer 进行的修改。
18. 在关卡中选择 **Level Sequence** Actor，然后在 **Details** 面板中将 **Auto Play** 选项设为 **True**。
19. 在 **Main Toolbar** 中点击 **Build** 按钮并选择 **Build Lighting Only**，然后（在构建光照后）点击 **Play** 按钮。

## 最终结果

在关卡中进行游戏时，光线将改变颜色，然后重新变为白色。而门此时仍为开启状态。

对于镜头中的光照，我们使用的是 **Restore State** 默认的 **When Finished** 属性值，将在镜头播放完毕后返回其原始状态。 而对于门来说，我们将 When Finished 属性改为了 **Keep State**，动画播放完毕后将保留修改，使门保持为开启状态。

需要考虑的一点是，Keep State 是本地效果，**Level Sequence** actor 中有一个全局 **Restore State** 选项：

Level Sequence actor 的 **Details** 面板中的 Restore State 选项将在关卡序列停止播放时保存所有状态。如要在序列完全结束后保持轨道的状态，则需要将动画分段设为 Keep State，且 Level Sequence actor **并非** 设为 Restore State，否则全局值将覆盖本地设置。
