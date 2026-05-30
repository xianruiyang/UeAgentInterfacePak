# 在虚幻引擎中为《Chivalry 2》制作景观

# 在虚幻引擎中为《Chivalry 2》制作景观

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/z4Bm/producing-landscapes-for-chivalry-2-in-unreal-engine

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 7028 字符。

## 摘要

Torn Banner Studios 的 3D 环境艺术家 Justin Myles 解释了为《Chivalry 2》的 The Raid on Aberfell 地图创建复杂的多层景观和布景的过程。

## 中文整理

### 概览

***此内容由 80 Level 与虚幻引擎合作为您带来。*** 大家好，我叫 Justin Myles，一位环境艺术家，自 2019 年以来一直在游戏行业工作。我学习 3D 艺术已有 12 年多了，毕业于英国布拉德福德大学。 Bulkhead Interactive 是我合作的第一个游戏工作室，后来我转到 Torn Banner Studios 开发游戏《Chivalry 2》。在 TBS，我的主要任务是帮助制作游戏环境，这些可以是： - 为游戏建模资产，这些可以是烘焙资产或使用装饰板制作的资产。 - 世界构建，例如地形雕刻/绘画、放置树叶和碎片等。 - 设置装扮环境，例如放置结构和道具。 - 基于物理的材料的创建。 - 修复 QA 团队可能发现的任何问题，例如人工智能的碰撞或导航问题。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-01.jpg)

### 团队为何选择虚幻引擎进行制作？

在我看来，[虚幻引擎](https://www.unrealengine.com/en-US/download) 的主要好处是它为几乎每个人提供了行业领先的软件，这意味着我们团队中的许多人都是使用该软件长大的。我相信我们的环境艺术团队喜欢虚幻引擎，因为它为我们提供了一款不需要美术师成为经验丰富的程序员的软件。这使我们能够实现我们的创意，因为总有一个节点或蓝图可以帮助我们实现我们的想法。在虚幻引擎中有很多创造性的方法可以实现相同的视觉效果，每天，您都会学到一些疯狂的新方法。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-02.jpg)

### 设置复杂的多层景观

我们将从 UE 创建的基本地形开始，尚未为其设置任何材质。在开发的早期阶段，这只是为了测试我们的关卡，直到后来我们才会实现高度混合材质，我们可以在上面进行绘制以分解更大的表面。通过高度混合，在材质之间转换时一切看起来都更加自然。我们还会使用 [Megascans](https://www.unrealengine.com/marketplace/en-US/content-cat/assets/megascans) 来设置山脉、植物、岩石等。Megascans 拥有出色的扫描数据库，如果您愿意花一点时间让它们为游戏做好准备，那么这是一项很棒的投资！

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-03.jpg)

### 套装敷料

关于设置较大的岩石，请始终记住它们如何融入您的地形。你想让它看起来尽可能自然，并且这些较大的岩石周围没有任何东西会让它们脱颖而出。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-04.jpg)

在开发过程中，有时有些东西看起来很漂亮，但不幸的是，玩家很难爬上去。在关卡设计接近尾声之前，不要花时间在艺术细节上。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-05.jpg)

在上图中，您可以看到我的一般工作流程，我从较大的形状开始，一直到较小的岩石和树叶。我总是发现树叶会产生一些漂亮的阴影。为了保持游戏体验，我们总是关闭较小岩石上的碰撞，因为我们不希望玩家被每一个小资产抓住。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-06.jpg)

### 与其他艺术家合作

使用虚幻编辑器的[源代码控制功能](https://docs.unrealengine.com/4.27/en-US/Basics/SourceControl/)，我们可以更新所有地图，让团队中的每位美术人员了解正在处理的文件、已过期的文件或最近添加的文件。这对于不踩对方的脚趾来说非常有用。当我需要在第 4 阶段调整地形时，团队的其他成员可以看到一个勾号，表明我已经检查过它，现在只有我可以对其进行更新。我们始终知道可以实时处理哪些文件，不能实时处理哪些文件，因此过程非常简单。我们不会保存彼此的工作，并且当我们需要自己的特定文件时，我们总是进行沟通。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-07.jpg)

### 克服技术挑战

就我个人而言，地图中对技术要求最高的部分是确保玩家能够顺利上山。有很多地形块，当然，随之而来的是很多碰撞，需要玩家和 AI 保持平滑。我记得一个具体的例子，我被告知我们希望玩家有能力爬上最后阶段被推倒的石头。我喜欢这个想法，但让人工智能导航真正运行它们是具有挑战性的。我们花了几次尝试让它看起来自然并且功能正常，但我们最终做到了！

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-08.jpg)

### 结论

在我看来，最大的教训是你必须均匀地在地图上投入时间。当你在地图的一小块区域上花费太多时间时，你必须保持警惕，并问自己*“地图的这一部分值得吗？”*和*“玩家会来这里吗？”*你可能会做出一些看起来很漂亮的东西，但从整体来看，它只是一个很小的部分。您还必须小心地将时间投入到细节上。如果你开始得太早并且需要进行巨大的改变，那么你就浪费了每个人的时间，包括你自己的时间。然而，如果时机正确，看到地图从停电中恢复过来，您确实可以激励团队的其他成员。另外，不要忘记与您的上级和领导沟通。

![教程图片](assets/producing-landscapes-for-chivalry-2-in-unreal-engine/image-09.jpg)

我要感谢 80 Level 给我这个机会来讲述我和 Torn Banner Studios 团队的其他成员如何在制作地图 The Raid on Aberfell 时获得很多乐趣。这是一个巨大的团队努力，而我只是其中的一小部分，你可以在 ArtStation 上找到我和我的同事。我希望你们喜欢《Chivalry 2》，并且不要忘记，Torn Banner Studios [一直在寻找潜在人才加入我们出色的团队](http://tornbanner.com/careers/)！

### Justin Myles，Torn Banner Studios 的 3D 环境艺术家

- [关于高度混合材质的综合教程](https://dev.epicgames.com/community/learning/tutorials/KYY/ue4-height-blending-materials-3-part-series) - [关于虚幻环境艺术的精彩课程引擎](https://dev.epicgames.com/community/learning/courses/Qwa/advanced-skill-sets-for-environment-art/ReZm/advanced-skill-sets-for-environment-art-introduction) - [深入了解虚幻中的源代码控制Engine](https://dev.epicgames.com/community/learning/talks-and-demos/WBX/dive-into-source-control-in-unreal-engine-webinar) - [详细了解 Chivalry 背后的开发流程2](https://unrealengine.com/en-US/developer-interviews/chivalry-2-is-Design-to-make-you-feel-like-you-re-in-a-medieval-war) - [Justin Myles ArtStation](https://artstation.com/justinmyles) - [Torn Banner Studios 网站](http://tornbanner.com) - [Chivalry 2 on Steam](https://store.steampowered.com/app/1824220/Chivalry_2)

## 相关链接

- [A comprehensive tutorial on Height Blended Materials](https://dev.epicgames.com/community/learning/tutorials/KYY/ue4-height-blended-materials-3-part-series)
- [A great course on environment art in Unreal Engine](https://dev.epicgames.com/community/learning/courses/Qwa/advanced-skill-sets-for-environment-art/ReZm/advanced-skill-sets-for-environment-art-introduction)
- [Dive into Source Control in Unreal Engine](https://dev.epicgames.com/community/learning/talks-and-demos/WBX/dive-into-source-control-in-unreal-engine-webinar)
- [Learn more about the development process behind Chivalry 2](https://unrealengine.com/en-US/developer-interviews/chivalry-2-is-designed-to-make-you-feel-like-you-re-in-a-medieval-war)
- [Justin Myles ArtStation](https://artstation.com/justinmyles)
- [Torn Banner Studios Website](http://tornbanner.com)
- [Chivalry 2 on Steam](https://store.steampowered.com/app/1824220/Chivalry_2)


