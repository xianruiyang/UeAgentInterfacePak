# 二次曲面细分CAD几何体

---
title: "二次曲面细分CAD几何体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/retessellating-cad-geometry-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith文件格式互操作指南", "CAD文件格式", "二次曲面细分CAD几何体"]
---

# 二次曲面细分CAD几何体

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith文件格式互操作指南 / CAD文件格式 / 二次曲面细分CAD几何体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/retessellating-cad-geometry-in-unreal-engine

利用Datasmith导入器将场景从支持的CAD文件（其包含由参数曲线定义的表面）导入虚幻编辑器时，Datasmith会将场景对象曲面细分成三角形网格体。导入文件时需要提供设置，控制生成三角形网格体相对于原始参数表面的保真度。可在[使用Datasmith和CAD文件格式](../index.md#%E6%9B%B2%E9%9D%A2%E7%BB%86%E5%88%86)下阅读有关此类设置的更多信息。Datasmith用导入CAD文件时提供的导入设置来曲面细分场景中的所有几何体。

此外，初始导入后，还可覆盖所选各个静态网格体资源的曲面细分质量设置值。因而可在一个细节层级导入整个场景，通常较低的细节层级可相对较快地曲面细分场景中的所有对象。导入后，可用不同质量设置对所选资源进行二次曲面细分。通常而言，细节层级越高，为重要场景对象提供的视觉效果就越好。这样就可以在导入速度、模型复杂性与视觉质量之间实现平衡，满足各个项目内容的独特需求。

效果非常类似于在Datasmith场景中重新导入各个静态网格体资源的功能，此功能已在[关于Datasmith重新导入过程](../../../datasmith-reimport-workflow/index.md)中介绍。但不同的是，*重新导入* 场景元素时，Datasmith会打开原始CAD场景文件，从此文件中重新读取所选对象的几何数据，然后曲面细分新导入的几何体。*二次曲面细分* 几何体时，Datasmith不会再打开原始场景文件。它会将新的曲面细分设置应用于所选静态网格体资源最后导入的几何体。因此，二次曲面细分往往比重新导入快，即便没有原始CAD源文件也可以做到。

要二次曲面细分各个静态网格体资源，请执行以下操作：

1. 在 **内容浏览器** 中，在 **Geometries** 文件夹中Datasmith场景资源旁，选择要二次曲面细分的静态网格体资源。
2. 右键点击所选的任意资源，并从快捷菜单中选择 **Datasmith > 二次曲面细分（Retessellate）** 选项。
3. 为曲面细分设置新值，此类设置已在[使用Datasmith和CAD文件格式](../index.md#%E6%9B%B2%E9%9D%A2%E7%BB%86%E5%88%86)页面介绍。

   ![二次曲面细分选项](../../../../../../assets/images/e2/e2ac6a67a55bf15c14adf29f166a34f46577410f2356c89d1c55b3b2ac230433.png)

   > [!NOTE]
   > 此窗口仅包含控制几何体曲面细分的设置，而无导入数据Datasmith文件时通常设置的其他设置。若要更改其他导入设置，使用 **重新导入（Reimport）** 选项从原始CAD场景文件重新导入所选资源。
4. 点击 **导入（Import）**。

二次曲面细分过程运用新值重新计算所选静态网格体的三角形网格体，但Datasmith场景中的所有其他资源保持不变。

![二次曲面细分之前：高容差、三角形更少](../../../../../../assets/images/1c/1c6e5dcbcfa0f3d993aa279ce07960933e8c00be7a0a9899801fb0afab486882.jpg)

![二次曲面细分之后：低容差、三角形更多](../../../../../../assets/images/4d/4d5974bcc13287ec04e01a9342014ab2e540e8923641fdf404984aeda4ab27a5.jpg)

二次曲面细分之前：高容差、三角形更少

二次曲面细分之后：低容差、三角形更多

> [!TIP]
> 若在快捷菜单中未看到 **二次曲面细分（Retessellate）** 选项，则说明所选的一个或多个资源在最初导入时未进行曲面细分。这通常意味着CAD文件已包含此资源的三角形网格体，而非参数曲面。Datasmith导入器只是导入了现有三角形网格体，而没有用作二次曲面细分基础的原始参数表面原始数据。
>
> 若如此，如要 *简化* 静态网格体的几何体，可利用虚幻编辑器提供的其他工具进行简化：[代理几何体工具](../../../../static-meshes/proxy-geometry-tool/index.md)、[细节层级](../../../../static-meshes/creating-and-using-lods/index.md) 等。但无法 *增加* 静态网格体几何体的细节。

## 曲面细分规则

经过建模操作后，NURBS表面可能：

- 无损（Intact）

  ：这意味着经过曲面细分后，没有从表面移除三角形。
- 已修改（Altered）

  ：这意味着移除了部分三角形。
- 已删除（Deleted）

  ：这意味着所有三角形都被移除了。

记住，你可以使用 **二次曲面细分规则（Retessellation Rule）** 选项控制哪些表面需要被二次曲面细分。可用的选项有：

- 全部（All）

  ：选择对所有表面进行二次曲面细分。
- 跳过删除的表面（Skip Deleted Surfaces）

  ：排除已被删除了所有三角形的表面。

