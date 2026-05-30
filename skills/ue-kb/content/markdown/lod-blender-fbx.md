# 如何将多个 LOD 从 Blender 导出到虚幻引擎（单个 FBX）

# 如何将多个 LOD 从 Blender 导出到虚幻引擎（单个 FBX）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/zqoq/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3226 字符。

## 摘要

在本教程中，我将演示一个完整且可靠的工作流程，将多个细节层次 (LOD) 从 Blender 导出到单个 FBX 文件中，准备导入到虚幻引擎中。目标是解释如何正确准备网格、正确命名 LOD 以及配置 Blender 的导出设置，以便虚幻引擎在导入过程中自动识别并分配每个 LOD，而无需在引擎内进行手动设置。此工作流程适用于骨架网格物体（包括元人类）和静态网格物体，使其可在不同项目中重复使用。学完本教程后，您将能够： 在 Blender 中组织和管理多个 LOD 网格 将所有 LOD 导出到单个 FBX 文件 将 FBX 通过自动 LOD 检测导入到虚幻引擎中 维护优化且可扩展的资源工作流程

## 中文整理

### 1. 简介 – LOD 和网格兼容性

**此方法不限于 MetaHumans。** 尽管 MetaHumans 是常见用例，但 **此工作流程适用于任何支持细节级别的网格体**，无论是：只要对象包含正确准备的 LOD，虚幻引擎就可以从单个 FBX 文件自动识别并导入它们。

### 2. 检索网格

### 选项 A – 手动创建网格

如果您已经自己创建了网格体和 LOD（在 Blender 或其他工具中），则可以将它们直接导入到 Blender 中并跳过虚幻引擎导出步骤。

### 选项 B – 从虚幻引擎导出网格体

如果您的网格存在于**虚幻引擎**中：其他设置可以保留默认值。

### 3. 具有变形目标的骨架网格物体

对于**具有变形目标的骨架网格物体**（例如，MetaHuman 脸部）：

![教程图片](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-01.jpg)

没有变形目标的网格可以跳过此步骤。

### 4. 在 Blender 中导入和准备网格

您现在应该在 **Outliner** 中看到网格及其 LOD。

### 5. 清理和层次结构准备

导入的骨架网格物体通常具有以下层次结构：

![MetaHuman 脸部网格轮廓](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-02.jpg)

静态网格体也可以遵循类似的结构。目标是达到**最终、干净的层次结构**。

### 6. 骨架网格体层次结构（推荐）

保持与虚幻引擎相似的结构以避免导入问题。

### 7. 比例修复

重新排列可能会改变网格比例：

### 8. 设置 LOD 组

![教程图片](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-03.jpg)

### 9. 重新创建 LOD 顺序

⚠️ 虚幻引擎根据名称合并材质槽——一致性是关键。

### 10.最终旋转修复（仅适用于MetaHuman面部网格）

如果跳过此步骤，面网格将面向虚幻中的地面或天空。

### 11. 静态网格体细节

### 12. 可选材质和着色器清理

一致性确保导入期间**正确的材料合并**。

![教程图片](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-04.jpg)

### 13. 从 Blender 导出最终 FBX

### 对象选择

### 导出设置

**路径模式：** 自动 | **批处理模式：**关闭 **限制为：**所选对象 ✅ 可见对象 ❌ 活动集合 ❌ **对象类型：** 空、骨架、网格自定义属性 ✅ **变换：** **几何：** 应用修改器 ✅ 其他默认 **顶点颜色：** sRGB 优先活动颜色 ❌ **骨架：** 主要 = Y，次要 = X，FBX 节点类型 = 仅空变形骨骼❌ 添加叶骨骼 ❌ **烘焙动画：** 可选 保存 **操作员预设** 以供将来导出。最后，选择文件名→文件夹→**导出FBX**。

![教程图片](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-05.jpg)

### 14. 导入虚幻引擎

![教程图片](assets/metahuman-how-to-export-multiple-lods-from-blender-to-unreal-engine-single-fbx/image-06.jpg)

### 结论

您现在拥有一个**完整的工作流程**，用于从 Blender 导出多个 LOD 并将其导入到虚幻引擎中：

