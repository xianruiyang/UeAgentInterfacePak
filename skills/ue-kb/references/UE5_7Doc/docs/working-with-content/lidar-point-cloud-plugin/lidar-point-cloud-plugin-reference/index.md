---
title: "LiDAR点云插件参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/lidar-point-cloud-plugin-reference"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "LiDAR点云插件", "LiDAR点云插件参考"]
---

# LiDAR点云插件参考

> 路径：虚幻引擎5.7文档 / 管理内容 / LiDAR点云插件 / LiDAR点云插件参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/lidar-point-cloud-plugin-reference

## 项目设置

要访问LiDAR点云（LiDAR Point Cloud）插件设置，请打开 **项目设置（Project Settings）** 窗口（菜单：**编辑（Edit）>项目设置（Project Settings）**）。

你可以从项目设置（Project Settings）窗口访问插件设置。

### Octree

| 设置 | 说明 |
| --- | --- |
| **副本处理** | 确定如何处理副本点（距离小于0.0001）。你可以从以下三个选项中选择： **忽略（Ignore）** ：保留找到的所有副本。 **选择第一个（Select First）** ：保留第一个点，并跳过所有其他副本。 **选择更亮（Select Brighter）** ：选择最亮的副本 |
| **副本最大距离（Max Distance for Duplicate）** | 两点被视为彼此副本时相距的最大距离。 |
| **最大桶大小（Max Bucket Size**） | 在需要转换为完整子节点前，保留在节点内的最大未分配点数。值较低时，将以系统RAM和CPU时间为代价，提供更精细的LOD控制。 |
| **节点网格分辨率（Node Grid Resolution）** | 划分节点的虚拟网格分辨率。值较低时，将以系统RAM和CPU时间为代价，提供更精细的LOD控制。 |

### 性能

| 设置 | 说明 |
| --- | --- |
| **多线程插入批处理大小（Multithreading Insertion Batch Size）** | 确定使用多线程时要在单个批处理中处理的最大点数。 |
| **使用异步导入（Use Async Import）** | 启用后，编辑器在后台导入点云，不会阻塞主线程。 |
| **优先激活视口（Prioritize Active Viewport）** | 启用后，虚幻引擎会将较大部分的可用点预算分配给当前具有焦点的视口。 |
| **缓存节点生命周期（Cached Node Lifetime）** | 节点在不再可见后保留在RAM中的时长。值较大时，更有可能避免以增加RAM使用为代价从存储中重新加载。 |
| **保存后释放资产（Release Asset After Saving）** | 如果启用，虚幻引擎将在保存该资产后自动释放该资产所使用的系统内存，并改为使用资产流送。这对于在处理大型数据集时避免内存阻塞很有用。 |
| **烘焙后释放资产（Release Asset After Cooking）** | 如果启用，虚幻引擎将在烘焙该资产后自动释放该资产所使用的系统内存，并改为使用资产流送。这对于在处理大型数据集时避免内存阻塞很有用。 |
| **使用渲染数据平滑（Use Render Data Smoothing）** | 如果启用，渲染数据生成会在多个帧扩散，避免冻结。启用此选项后，你还可以设置渲染数据平滑最大帧时间（Render Data Smoothing Max Frametime）选项，该选项控制应该在渲染数据生成上花费多少帧时间。 |
| **使用快速渲染（Use Fast Rendering）** | 启用此设置可以显著提高运行时性能（在某些情况下高达300%），但会使VRAM使用量变成原来的四倍。此设置默认启用。 在点预算非常高的离线视频录制期间，你应该禁用此选项，因为此时的运行时性能并不那么重要。增加的VRAM使用量会迅速使GPU饱和，并最终导致崩溃。 |

### 碰撞

| 设置 | 说明 |
| --- | --- |
| **网格体划分批处理大小（Meshing Batch Size）** | 确定用于网格体划分算法的每线程数据的大小。 |

### 自动化

| 设置 | 说明 |
| --- | --- |
| **导入时自动居中（Auto Center On Import）** | 如果启用，导入时自动将云居中。 如果值太大，保留原始坐标可能会导致明显的精度损失。如果出现点"带状"效果，请在启用居中的情况下重新导入云。 |
| **导入时自动计算法线（Auto Calculate Normals on Import）** | 如果启用，则在成功导入点云后自动计算法线。 |
| **导入时自动构建碰撞（Auto Build Collision on Import）** | 如果启用，则在成功导入点云后自动构建碰撞。 |

### 导入/导出

| 设置 | 说明 |
| --- | --- |
| **导入比例（Import Scale）** | 导入时，米会转换为虚幻单位（UU），其中1 UU = 1厘米。要使用自定义导入比例，请更改此值。 |
| **导出比例（Export Scale）** | 导出时，虚幻单位转换回米。要使用自定义导出比例，请更改此值。 |

## 细节面板

### 外观

点云的外观由Actor定义。此关系类似于静态网格体Actor表示静态网格体资产的方式。

你可以从 **细节（Details）面板** 的 **外观（Appearance）** 分段，更改关卡中点云的外观。你可以在此处调整光照、点大小、渲染、碰撞和许多其他设置。

| 设置 | 说明 |
| --- | --- |
| **点大小（Point Size）** | 更改所有点的大小。点密度较低（选择了较低的点预算）可以通过增加该值和点大小偏差（Point Size Bias）在一定程度上得到缓解。如果此选项设置为0，则每个点将使用1像素的固定大小，无论摄像机距离和数据密度波动如何。 |
| **缩放方法（Scaling Method）** | 确定点云中的点将如何缩放。你可以从以下选项中进行选择： **逐节点（Per Node）**：点将根据其包含节点的估计密度缩放。 **逐节点自适应（Per Node Adaptive）**：类似于逐节点缩放，但密度将根据当前视图自适应计算。 **逐点（Per Point）**：点将根据各自的计算深度缩放。 **固定屏幕尺寸（Fixed Screen Size）**：使用屏幕空间缩放方法渲染Sprite。 将鼠标悬停在细节（Details）面板中的每个选项上，以便获取有关其特定用例的更多信息。 |
| **填隙强度（Gap Filling Strength）** | 使用自定义材质放大点，并将点渲染为抛物面，从而最小化可见重叠。这会产生大约0.7毫秒/100万点的性能成本。 |
| **颜色源（Color Source）** | 选择是使用嵌入在点云数据中的颜色，还是根据位置（Position）、海拔（Elevation）或分类（Classification）为点云着色。 如果你选择 **海拔（Elevation）** ，你可以定义最高海拔和最低海拔应使用的颜色。其余的点将使用这两个值之间的梯度着色。 如果你选择 **分类（Classification）** ，你可以在本分段的分类颜色数组中进一步定义应使用的颜色。 |
| 点大小偏差（Point Size Bias） | 影响逐LOD执行点缩放的方式。这与r.LidarBaseLODImportance控制台变量有关。 如果资产预算较小且总组件数量较多，则点云资产可能会消失和弹入。为了防止这种情况，LOD系统会主动尝试为离摄像机远的资产至少分配最低质量的LOD。 |

### 渲染

你可以从 **细节（Details）** 面板的 **渲染（Rendering）** 分段设置许多渲染专用选项。

| 设置 | 说明 |
| --- | --- |
| **使用视锥体剔除（Use Frustum Culling）** | 启用此选项后，将不会渲染可见视锥体之外的点。拍摄过场动画时，禁用它可以降低数据流送延迟。 |

## 控制台变量

使用这些控制台变量可定义其他点云参数。

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| `r.LidarBaseLODImportance` | 0.1 | 根据与摄像机的距离，定义渲染预算中图块的重要程度。此变量将控制至少显示最低质量的图块而不是将预算用在最靠近摄像机的对象的重要程度 |
| `r.LidarPointBudget` | 1000000 | 定义视口的全局点渲染预算。此值表示屏幕上同时显示的总点数。 |
| `r.LidarTargetFPS` | 59 | 此设置将不断调整点云预算，保持指定值的总fps。如果 `r.LidarPointBudget` 设置为大于0的值，则禁用目标fps。 |
| `r.LidarIncrementalBudget` |  | 如果设置为true，只要视口保持固定，点预算就会自动增加到非常高的值。当视口移动时，预算将重置为此前设置的值。 |
| `r.LidarScreenCenterImportance` | 0 | 根据摄像机所在的位置定义图块在渲染预算中的重要程度。值越高，将强制降低摄像机视锥体侧面的LOD。 |
| `stat lidarpointcloud` |  | 显示当前渲染的点云数据的统计信息。 |
