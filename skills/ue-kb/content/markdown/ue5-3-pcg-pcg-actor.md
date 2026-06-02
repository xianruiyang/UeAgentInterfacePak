# 【UE5.3 PCG教程】PCG生成结合蓝图保存为模型或Actor

# 【UE5.3 PCG教程】PCG生成结合蓝图保存为模型或Actor

## 知识目标

- 把 PCG 生成结果和蓝图结合，整理成可保存、复用或转成 Actor/模型的资产流程。

## 可复现主流程

- 使用蓝图 Actor 管理 PCG Component 和生成参数。
- 生成目标结果后检查实例、组件层级和资源引用。
- 根据需要把结果保存为 Actor、实例组件或可复用资产。
- 重新加载或复制蓝图，确认生成结果和参数仍然可控。

## 关键术语

- `PCG`
- `Blueprint`
- `蓝图`
- `Static Mesh`
- `Mesh`
- `SubGraph`
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

### 使用蓝图 Actor 管理 PCG Component 和生成参数

**内容要点：**

- 这一段对应“使用蓝图 Actor 管理 PCG Component 和生成参数。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG生成结合蓝图保存为模型或Actor”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`Test*`
- 画面线索：`Platforms`
- 画面线索：`PerspectiveLitShow`
- 画面线索：`+2用50410`
- 画面线索：`DetailsxLevels`
- 画面线索：`World Se...`
- 画面线索：`QSearch.`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p08/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p08/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Instance`
- `HISM`
- `Test`
- `PCGStamp_4`
- `MyEnvironment`
- `Platforms`
- `PerspectiveLitShow`
- `DetailsxLevels`
- `ItemLabel`

### 生成目标结果后检查实例、组件层级和资源引用

**内容要点：**

- 这一段对应“生成目标结果后检查实例、组件层级和资源引用。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG生成结合蓝图保存为模型或Actor”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`Test*`
- 画面线索：`PCG_AttachToMesh*`
- 画面线索：`BP_AttachToMesh`
- 画面线索：`Selection Mode`
- 画面线索：`NIAI`
- 画面线索：`Platforms`
- 画面线索：`FindI Pause Regen`
- 画面线索：`ForceRegen`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p08/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p08/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `Graph`
- `PCG_AttachToMesh`
- `BP_AttachToMesh`
- `Test`
- `Selection`
- `Mode`
- `NIAI`

### 根据需要把结果保存为 Actor、实例组件或可复用资产

**内容要点：**

- 这一段对应“根据需要把结果保存为 Actor、实例组件或可复用资产。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG生成结合蓝图保存为模型或Actor”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`Asset`
- 画面线索：`Test*`
- 画面线索：`PCG_AttachToMesh*`
- 画面线索：`BP_AttachToMesh`
- 画面线索：`Platforms`
- 画面线索：`FindIPauseRegen`
- 画面线索：`ForceRegen`
- 画面线索：`Cancel Execution`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p08/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p08/s03-02-S03_2_00_07_07.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Point`
- `Graph`
- `PCG_AttachToMesh`
- `BP_AttachToMesh`
- `Asset`
- `Test`
- `Platforms`
- `FindIPauseRegen`

## 复现检查清单

- 保存前要区分程序化结果和源 PCG 逻辑。
- 转为静态结果后通常会失去部分实时可调能力。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

