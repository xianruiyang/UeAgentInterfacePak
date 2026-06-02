# 1-1 - Introduction

# 1-1 - Introduction

## 知识目标

- 本文整理“1-1 - Introduction”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 确认完整课程产出：黑云杉树、可绘制 Landscape 材质、带位移的道路/溪流样条、草地植被、PCG 环境、浅水材质、电影镜头和 OCIO/DaVinci 输出。
- 把课程拆成资产制作、材质系统、Spline 系统、Foliage/PCG、最终渲染五条主线，后续每个分 P 都要回到这几条主线定位。
- 先记录软件链路和依赖：建模/DCC、Substance Painter、GAEA、Unreal Engine 5、Movie Render Queue 与 DaVinci。
- 建立项目目录、命名规则和版本记录，避免长课程中树、草、路、Landscape 材质与渲染配置混在一起。

## 关键术语

- `PCG`
- `Spline`
- `Graph`
- `Material`
- `Landscape`
- `Unreal`
- `Engine`
- `cinematic`
- `road`
- `Blender`
- `Substance`
- `Painter`
- `Nanite`
- `grass`
- `parallax`
- `occlusion`
- `landscape`
- `material`

## 操作步骤与要点

### 确认完整课程产出：黑云杉树、可绘制 Landscape 材质、带位移的道路/溪流样条、草地植被、PCG 环境、浅水材质、电影镜头和 OCIO/DaVinci 输出。；把课程拆成资产制作、材质系统、Spline 系统、Foliage/PCG、最终渲染五条主线，后续每个分 P 都要回到这几条主线定位。；先记录软件链路和依赖：建模/DCC、Substance Painter、GAEA、Unreal Engine 5、Movie Render Queue 与 DaVinci。；建立项目目录、命名规则和版本记录，避免长课程中树、草、路、Landscape 材质与渲染配置混在一起

**内容要点：**

- 确认完整课程产出：黑云杉树、可绘制 Landscape 材质、带位移的道路/溪流样条、草地植被、PCG 环境、浅水材质、电影镜头和 OCIO/DaVinci 输出。；把课程拆成资产制作、材质系统、Spline 系统、Foliage/PCG、最终渲染五条主线，后续每个分 P 都要回到这几条主线定位。；先记录软件链路和依赖：建模/DCC、Substance Painter、GAEA、Unreal Engine 5、Movie Render Queue 与 DaVinci。；建立项目目录、命名规则和版本记录，避免长课程中树、草、路、Landscape 材质与渲染配置混在一起。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p01/s01-01-S01_1_00_00_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p01/s01-02-S01_2_00_01_03.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Graph`
- `Material`
- `Landscape`
- `Unreal`
- `Engine`
- `cinematic`
- `road`
- `Blender`

## 复现检查清单

- 导览本身操作少，正文应作为整个系列的路线图，而不是展开单个节点参数。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

