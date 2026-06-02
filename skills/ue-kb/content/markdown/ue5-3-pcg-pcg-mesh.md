# 【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值

# 【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值

## 知识目标

- 把 PCG 生成中使用的 Static Mesh 从图表里的固定值改成蓝图变量，让同一个 PCG Actor 可以通过 Details 面板切换网格资源。

## 可复现主流程

- 确认场景中有承载 PCG Component 的 Blueprint Actor，并在 Details 面板里暴露用于替换网格的变量。
- 在 PCG Graph 中保留输入点或采样点的生成逻辑，只把最终 Static Mesh Spawner 的网格选择改为外部变量驱动。
- 通过 Actor/Component 或参数覆盖把蓝图变量传入 PCG，避免把 Mesh 写死在节点里。
- 切换变量值后重新 Generate，检查实例化结果是否跟随变量变化。

## 关键术语

- `PCG`
- `Blueprint`
- `蓝图`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `Material`
- `Instance`

## 操作步骤与要点

### 确认场景中有承载 PCG Component 的 Blueprint Actor，并在 Details 面板里暴露用于替换网格的变量

**内容要点：**

- 这一段对应“确认场景中有承载 PCG Component 的 Blueprint Actor，并在 Details 面板里暴露用于替换网格的变量。”，主要作用是把本集主题“【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`BP_PCGTutorial`
- 画面线索：`Platforms`
- 画面线索：`BP_PCGTutorial2`
- 画面线索：`+Add`
- 画面线索：`*ItemLabel`
- 画面线索：`Type`
- 画面线索：`BP_PCGTutorial2(Self)`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p01/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p01/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `BP_PCGTutorial2`
- `MyEnvironment`
- `BP_PCGTutorial`
- `Platforms`
- `ItemLabel`
- `Type`
- `Self`

### 在 PCG Graph 中保留输入点或采样点的生成逻辑，只把最终 Static Mesh Spawner 的网格选择改为外部变量驱动

**内容要点：**

- 这一段对应“在 PCG Graph 中保留输入点或采样点的生成逻辑，只把最终 Static Mesh Spawner 的网格选择改为外部变量驱动。”，主要作用是把本集主题“【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`BP_PCGTutorial`
- 画面线索：`Platforms`
- 画面线索：`LitShow`
- 画面线索：`+Add`
- 画面线索：`*ItemLabel`
- 画面线索：`Type`
- 画面线索：`BP_PCGTutorial(Self)`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p01/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p01/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `BP_PCGTutorial`
- `MyEnvironment`
- `Platforms`
- `LitShow`
- `ItemLabel`
- `Type`

### 通过 Actor/Component 或参数覆盖把蓝图变量传入 PCG，避免把 Mesh 写死在节点里

**内容要点：**

- 这一段对应“通过 Actor/Component 或参数覆盖把蓝图变量传入 PCG，避免把 Mesh 写死在节点里。”，主要作用是把本集主题“【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`BP_PCGTutorial`
- 画面线索：`Platforms`
- 画面线索：`+Add`
- 画面线索：`*ItemLabel`
- 画面线索：`Type`
- 画面线索：`BP_PCGTutorial(Self)`
- 画面线索：`Untitled (Editr)`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p01/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p01/s03-02-S03_2_00_07_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `BP_PCGTutorial`
- `MyEnvironment`
- `Platforms`
- `ItemLabel`
- `Type`
- `Self`

### 切换变量值后重新 Generate，检查实例化结果是否跟随变量变化

**内容要点：**

- 这一段对应“切换变量值后重新 Generate，检查实例化结果是否跟随变量变化。”，主要作用是把本集主题“【UE5.3 PCG教程】用蓝图变量替换PCG中Mesh网格的值”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`BP_PCGTutorial`
- 画面线索：`Platforms`
- 画面线索：`+Add`
- 画面线索：`*ItemLabel`
- 画面线索：`Type`
- 画面线索：`BP_PCGTutorial(Self)`
- 画面线索：`Untitled (Editor)`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p01/s04-01-S04_1_00_09_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p01/s04-02-S04_2_00_10_09.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `BP_PCGTutorial`
- `MyEnvironment`
- `Platforms`
- `ItemLabel`
- `Type`
- `Self`

## 复现检查清单

- 变量类型应指向 Static Mesh 或可被 Mesh Spawner 消费的资源。
- 替换 Mesh 后要检查碰撞、缩放和实例化密度是否需要同步调整。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

