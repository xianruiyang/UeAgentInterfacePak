# LYRA：适用于不同化妆品的足迹 FX

# LYRA：适用于不同化妆品的足迹 FX

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/0Jdx/unreal-engine-lyra-footstep-fx-for-different-cosmetics

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1219 字符。

## 摘要

根据穿戴的物品或化妆品皮肤改变脚步声和视觉效果。

## 中文整理

### 概览

假设您有不同的化妆品，并且希望根据您所穿着的物品/化妆品运行不同的声音或视觉效果。就我而言，我希望在不穿鞋子或穿着板甲或链甲时播放不同的声音。弄清楚这是一个挑战，但实际上非常简单。

### 先决条件

此示例假设：您有某种向玩家角色添加标签的物品或化妆品设置。以我为例，当我装备鞋子时，我的角色会被赋予一个游戏标签*Cosmetic.Shoes*。当我装备板甲护腿时，我的角色会被赋予标签*Cosmetic.ShoesPlate*。

### 步骤

1. 打开 B_Hero_Default 2. **UpdateEffectContexts** 基于游戏标签。 3. 根据这些标签设置ContextEffects。

![1. B_Hero_Default 内的 AnimMotionEffect](assets/unreal-engine-lyra-footstep-fx-for-different-cosmetics-0jdx/image-01-jpeg.jpg)

![2. HandleEnhancedFootstepSounds 图表内部](assets/unreal-engine-lyra-footstep-fx-for-different-cosmetics-0jdx/image-02-jpeg.jpg)

在上面的示例中，我们检查玩家是否有一个标签表明他们在水中，如果没有，他们是否穿着鞋子，如果没有，我们假设他们赤脚。我们用它来更新EffectContexts，然后ContextEffects将看到它。 AnimMotionEffect 会激发每一个脚步。我们可能更愿意在外观发生变化或玩家进入水中时更新事件的背景效果，而不是每一步。但我还没有测试过。

![3. 上下文效果](assets/unreal-engine-lyra-footstep-fx-for-different-cosmetics-0jdx/image-03-jpeg.jpg)

