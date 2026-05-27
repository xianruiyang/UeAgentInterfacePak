# 基础《尼亚加拉之血》——UE5/UE4 教程

# 基础《尼亚加拉之血》——UE5/UE4 教程

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/zB1W/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 3518 字符。

## 摘要

在本教程中，您将制作一种血腥效果。

## 中文整理

### 以下是制作基本尼亚加拉血液系统的方法：

### 第 1 步：创建蒙版血液材质

- 打开材质编辑器。打开材质编辑器。 - 将混合模式设置为蒙版。将混合模式设置为蒙版。 - 节点： 纹理样本（带 alpha 的血溅纹理是最佳的，但如果您愿意，可以使用 ORM） 将 RGB 连接到基色 将 Alpha（或蓝色）连接到不透明蒙版 - 纹理样本（带 alpha 的血溅纹理是最佳的，但如果您愿意，可以使用 ORM） 纹理样本（带 alpha 的血飞溅纹理是最佳的，但如果您愿意，可以使用 ORM） - 连接 RGB 到基色 将 RGB 连接到基色 - 连接Alpha（或蓝色）到不透明蒙版 将 Alpha（或蓝色）连接到不透明蒙版

![教程图片](assets/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial/image-01.jpg)


### 第 2 步：创建 Niagara 系统

- 进入 FX > Niagara System > Create from Template 进入 FX > Niagara System > Create from Template - 选择定向爆发（不是带丝带的） 选择定向爆发（不是带丝带的） - 任意命名 随心所欲 - 自定义：生成突发瞬时：调整生成计数来控制血量（15 看起来最好，无需炸毁你的电脑） 自定义： - 生成突发瞬时：调整生成计数来控制血量（15 看起来最好，不炸你的电脑） Spawn Burst 瞬时：调整 Spawn Count 来控制血量（15 看起来最好，不炸你的电脑） - 删除不必要的模块： 删除生命中的颜色 删除刻度颜色 按速度删除刻度精灵大小 删除不必要的模块： - 删除生命中的颜色 删除生命中的颜色 - 删除刻度颜色 删除刻度颜色 - 按速度删除刻度精灵大小 删除刻度精灵大小 - 将精灵材质设置为我们之前制作的材质。将精灵材质设置为我们之前制作的材质。 - 添加碰撞、杀死粒子、生成碰撞事件。添加碰撞、杀死粒子、生成碰撞事件。 - 在“杀死粒子”下，将布尔值设置为“已碰撞？”在“杀死粒子”下，将布尔值设置为“已碰撞？” - 将碰撞半径设置为 0.12。将碰撞半径设置为 0.12。 - 启用“需要永久 ID”。启用“需要持久

  ID”。 - 将碰撞跟踪通道设置为您不常用的通道。（或者为了简单起见，创建一个新通道） 将碰撞跟踪通道设置为您不常用的通道。（或者为了简单起见，创建一个新通道）

### 第三步：创建血迹

- 在您的 Niagara 系统中，创建一个 Minimal（或空，具体取决于您所在的版本）。在您的 Niagara 系统中，创建一个 Minimal（或空，具体取决于您所在的版本）。 - 在 Sprite Renderer 中，将材质设置为血液材质。在 Sprite Renderer 中，将材质设置为血液材质。 - 在最小的发射器中，添加事件处理程序阶段。在最小的 Emitter 中，添加一个 Event Handler 阶段。 - 在事件处理程序属性中，将源设置为“Directional Burst Collision Event”，将执行模式设置为 Spawned Particles，并将生成计数设置为 1。在事件处理程序属性中，将源设置为“Directional Burst Collision Event”，将执行模式设置为 Spawned Particles，并将生成计数设置为 1。 - 在事件处理程序阶段，添加接收碰撞事件。在事件处理程序阶段，添加接收碰撞事件。 - 在“Particle Spawn”内，添加“Sprite Facing and Alignment”模块，并将 Sprite Facing 设置为 Z 轴上的 90 度。在“Particle Spawn”内，添加“Sprite

  Facing and Alignment”模块，并将 Sprite Facing 设置为 Z 轴上的 90 度。当前的设置不能很好地处理斜坡或墙壁。如果您希望斜坡和墙壁具有相应的行为，请改用贴花渲染器。

## 相关链接

- [Here is how to make a basic Niagara blood System:](https://dev.epicgames.com/community/learning/tutorials/zB1W/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial#hereishowtomakeabasicniagarabloodsystem:)
- [Step 1: Create a Masked Blood Material](https://dev.epicgames.com/community/learning/tutorials/zB1W/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial#step1:createamaskedbloodmaterial)
- [Step 2: Create a Niagara System](https://dev.epicgames.com/community/learning/tutorials/zB1W/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial#step2:createaniagarasystem)
- [Step 3: Create the blood stains](https://dev.epicgames.com/community/learning/tutorials/zB1W/unreal-engine-basic-niagara-blood-ue5-ue4-tutorial#step3:createthebloodstains)


