# PCG 隧道系统 01：BP_Tunnel 与样条输入

# PCG 隧道系统 01：BP_Tunnel 与样条输入

## 知识目标

- 围绕“PCG 隧道系统 01：BP_Tunnel 与样条输入”整理 UE PCG 隧道系统的制作流程：用蓝图 Spline 定义隧道路线，用 PCG/Geometry Script 读取路径并生成隧道模块，最终形成可复用、可调参、可在关卡中重生成的隧道工具。

## 可复现主流程

- 启用 PCG、Geometry Script 等必要插件并重启项目，确认 PCG Graph 与几何脚本互操作节点可用。
- 创建空 PCG 图表作为隧道系统主图，并创建 `BP_Tunnel` 这类 Actor 蓝图作为样条线载体。
- 在蓝图中添加 Spline Component，用它定义隧道路径的空间走向、长度和控制点。
- 把隧道蓝图放入关卡，调整 spline 点位，确认 PCG 能读取到目标 Actor 或 spline 数据。

## 关键术语

- `PCG`
- `Blueprint`
- `蓝图`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Actor`
- `Graph`
- `样条`
- `网格`
- `属性`
- `过滤`
- `采样`
- `节点`
- `生成`
- `Solidify`
- `JaysongShao`

## 操作步骤与要点

### 启用 PCG、Geometry Script 等必要插件并重启项目，确认 PCG Graph 与几何脚本互操作节点可用

**内容要点：**

- 启用 PCG、Geometry Script 等必要插件并重启项目，确认 PCG Graph 与几何脚本互操作节点可用。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p01/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p01/s01-02-S01_2_00_02_02.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Graph`
- `样条`
- `网格`
- `过滤`

### 创建空 PCG 图表作为隧道系统主图，并创建 `BP_Tunnel` 这类 Actor 蓝图作为样条线载体

**内容要点：**

- 创建空 PCG 图表作为隧道系统主图，并创建 `BP_Tunnel` 这类 Actor 蓝图作为样条线载体。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p01/s02-01-S02_1_00_04_18.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p01/s02-02-S02_2_00_06_35.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Graph`
- `样条`
- `网格`
- `属性`

### 在蓝图中添加 Spline Component，用它定义隧道路径的空间走向、长度和控制点

**内容要点：**

- 在蓝图中添加 Spline Component，用它定义隧道路径的空间走向、长度和控制点。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p01/s03-01-S03_1_00_09_14.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p01/s03-02-S03_2_00_09_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `样条`
- `网格`
- `采样`
- `节点`
- `生成`
- `Atlas`
- `JaysongShao`
- `bilbili`

## 复现检查清单

- Spline 点位、隧道模块长度和采样间距必须一起检查，否则容易出现重叠、缝隙或端点错位。
- 模块朝向要跟随 spline tangent 或路径方向，不能只依赖默认世界朝向。
- 每次修改 PCG 图表后先看 Debug 点，再看最终 mesh，避免把点位问题误判为模型问题。
- 蓝图 Actor、PCG Component、PCG Graph 和几何脚本节点的引用关系要稳定，重启或重生成后仍应可复现。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

