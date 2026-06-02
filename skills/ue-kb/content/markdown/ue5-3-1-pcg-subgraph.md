# 【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑

# 【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑

## 知识目标

- 用 SubGraph 把复杂建筑生成流程拆成可复用模块，降低主图复杂度。

## 可复现主流程

- 把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段。
- 把重复逻辑封装为 SubGraph，并定义清晰的输入输出。
- 在主图中调用 SubGraph，传入建筑尺寸、密度、构件类型等参数。
- 逐个调试 SubGraph，确保主图只是组织流程而不是堆叠所有节点。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `VolumeSampler`
- `SubGraph`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `Material`

## 操作步骤与要点

### 把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段

**内容要点：**

- 这一段对应“把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`Bridge`
- 画面线索：`BRIDGE`
- 画面线索：`Quixel`
- 画面线索：`Urban/NeoclassicalModularBuildingVol.2X`
- 画面线索：`Home`
- 画面线索：`Collections`
- 画面线索：`Environment`
- 画面线索：`Historic`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `Modular`
- `Baroque`
- `Bridge`
- `BRIDGE`
- `Quixel`
- `Urban`
- `NeoclassicalModularBuildingVol`
- `Home`
- `Collections`
- `Environment`

### 把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段（2）

**内容要点：**

- 这一段对应“把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`FileEditAsset`
- 画面线索：`ToolsHelp`
- 画面线索：`PCG_Building`
- 画面线索：`PCGSub_Wal*`
- 画面线索：`Platforms`
- 画面线索：`IIPause Regen`
- 画面线索：`Force Regen`
- 画面线索：`Cancel Execution`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `SubGraph`
- `Component`
- `Graph`
- `PCG_Building`
- `Regen`
- `Atribute`
- `FileEditAsset`
- `ToolsHelp`
- `PCGSub_Wal`

### 把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段（3）

**内容要点：**

- 这一段对应“把建筑生成拆分为输入处理、点过滤、构件生成和输出合并等阶段。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`FileEditAsset`
- 画面线索：`ToolsHelp`
- 画面线索：`PCG_Building`
- 画面线索：`PCGSub_Wal*`
- 画面线索：`Platforms`
- 画面线索：`IIPause Regen`
- 画面线索：`Force Regen`
- 画面线索：`Cancel Execution`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s03-02-S03_2_00_07_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `SubGraph`
- `Attribute`
- `Component`
- `Graph`
- `PCG_Building`
- `Offset`
- `Regen`
- `FileEditAsset`
- `ToolsHelp`

### 把重复逻辑封装为 SubGraph，并定义清晰的输入输出

**内容要点：**

- 这一段对应“把重复逻辑封装为 SubGraph，并定义清晰的输入输出。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`FileEditAsset`
- 画面线索：`ToolsHelp`
- 画面线索：`PCG_Building*`
- 画面线索：`PCGSub_Wall`
- 画面线索：`Platforms`
- 画面线索：`IPause Regen`
- 画面线索：`Force Regen`
- 画面线索：`Cancel Execution`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s04-01-S04_1_00_09_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s04-02-S04_2_00_10_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Graph`
- `Instance`
- `Regen`
- `FileEditAsset`
- `ToolsHelp`
- `PCG_Building`
- `PCGSub_Wall`
- `Platforms`

### 把重复逻辑封装为 SubGraph，并定义清晰的输入输出（2）

**内容要点：**

- 这一段对应“把重复逻辑封装为 SubGraph，并定义清晰的输入输出。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`FileEditAsset`
- 画面线索：`WindowToolsHelp`
- 画面线索：`NewMap*`
- 画面线索：`PCG_Building`
- 画面线索：`PCGSub_Wall`
- 画面线索：`Platforms`
- 画面线索：`IPause Regen`
- 画面线索：`Force Regen`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s05-01-S05_1_00_12_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s05-02-S05_2_00_13_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Point`
- `Component`
- `Spawn`
- `Graph`
- `PCG_Building`
- `Regen`
- `FileEditAsset`
- `WindowToolsHelp`

### 在主图中调用 SubGraph，传入建筑尺寸、密度、构件类型等参数

**内容要点：**

- 这一段对应“在主图中调用 SubGraph，传入建筑尺寸、密度、构件类型等参数。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`FileEditAsset`
- 画面线索：`ToolsHelp`
- 画面线索：`AA`
- 画面线索：`NewMap*`
- 画面线索：`PCG_Building*`
- 画面线索：`PCGSub_Wall`
- 画面线索：`Platforms`
- 画面线索：`IPause Regen`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s06-01-S06_1_00_15_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s06-02-S06_2_00_16_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Attribute`
- `Component`
- `Graph`
- `PCG_Building`
- `Regen`
- `FileEditAsset`
- `ToolsHelp`
- `NewMap`
- `PCGSub_Wall`

### 在主图中调用 SubGraph，传入建筑尺寸、密度、构件类型等参数（2）

**内容要点：**

- 这一段对应“在主图中调用 SubGraph，传入建筑尺寸、密度、构件类型等参数。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`Hep`
- 画面线索：`EditAsset`
- 画面线索：`NewMap*`
- 画面线索：`PCG_Building`
- 画面线索：`PCGSub_Wall`
- 画面线索：`Platforms`
- 画面线索：`IPause Regen`
- 画面线索：`Force Regen`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s07-01-S07_1_00_18_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s07-02-S07_2_00_19_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Component`
- `Spawn`
- `Graph`
- `PCG_Building`
- `Regen`
- `EditAsset`

### 逐个调试 SubGraph，确保主图只是组织流程而不是堆叠所有节点

**内容要点：**

- 这一段对应“逐个调试 SubGraph，确保主图只是组织流程而不是堆叠所有节点。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`EditAsset`
- 画面线索：`NewMap*`
- 画面线索：`PCG_Building`
- 画面线索：`PCGSub_Wall`
- 画面线索：`Platforms`
- 画面线索：`IIPause Regen`
- 画面线索：`Force Regen`
- 画面线索：`Cancel Execution`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s08-01-S08_1_00_21_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s08-02-S08_2_00_22_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Attribute`
- `Component`
- `Graph`
- `PCG_Building`
- `Regen`
- `Offset`
- `EditAsset`
- `NewMap`
- `PCGSub_Wall`

### 逐个调试 SubGraph，确保主图只是组织流程而不是堆叠所有节点（2）

**内容要点：**

- 这一段对应“逐个调试 SubGraph，确保主图只是组织流程而不是堆叠所有节点。”，主要作用是把本集主题“【UE5.3.1 PCG教程】使用子图表SubGraph工程创建程序化建筑”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`AssetView`
- 画面线索：`Debug`
- 画面线索：`NewMap*`
- 画面线索：`PCG_Building`
- 画面线索：`Bp_Building`
- 画面线索：`Parent class:Actor`
- 画面线索：`Compile:`
- 画面线索：`Diff`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p10/s09-01-S09_1_00_24_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p10/s09-02-S09_2_00_24_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Component`
- `Graph`
- `AssetView`
- `Debug`
- `NewMap`
- `PCG_Building`
- `Bp_Building`
- `Parent`

## 复现检查清单

- SubGraph 的输入输出类型要稳定。
- 调试时先固定 Seed，避免随机结果掩盖逻辑错误。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

