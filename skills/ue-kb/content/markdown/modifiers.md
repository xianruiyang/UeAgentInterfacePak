# Modifiers

---
title: "Modifiers"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/modifiers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "动态设计", "Operator Stack", "Modifiers"]
---

# Modifiers

> 路径：虚幻引擎5.7文档 / 动态设计 / Operator Stack / Modifiers

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/modifiers-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

修改器提供多种工具，可辅助设计 2D 与 3D 布局。 使用修改器可以：

- 使用 [布局](index.md#layout) 工具。
- 使用 [几何体](index.md#geometry) 工具。
- 使用 [渲染](index.md#rendering) 工具。
- 使用 [过渡逻辑](index.md#transition-logic) 修改器可以简化许多用例中的系统设置，因此无需检查过渡树。

可以从 [Operator Stack](../index.md) 访问修改器，也可以同时使用 [动画器](https://dev.epicgames.com/documentation/unreal-engine/animators-in-unreal-engine?application_version=5.7)。

## 添加修改器

点击 **+Add Modifiers** 会在 Operator Stack 窗口中显示当前所选形状可用的修改器面板。

有些修改器只能添加到 2D 形状，另一些可以同时添加到 2D 与 3D 形状。不兼容当前所选 Actor 的修改器会被隐藏；如果修改器与所选 Actor 类型不兼容，就无法添加到该形状上。

![Modifiers menu in the Operator Stack window.](../../../../assets/images/7f/7fc7fd377456f5ababf9e5f4e7e5a8019d8da1888fc3d5a34a038a87762ff8a7.jpg)

You can click any of these modifiers to add it to an actor you select in your **Motion Design Outliner**. If you already know the name of the modifier that you want to use, you can search for it by name in the search bar near the top.

The example below shows a case where a modifier type won’t appear. In this example, you can't add a Geometry modifier to a null actor that parents geometry actors, so Geometry modifiers do not appear in the +Add Modifiers menu:

![Adding a modifier to a null actor.](../../../../assets/images/99/991b690f7d635493b056ebab0c55bdf496cc0b605abfd961db20f5505576ddf0.jpg)

### 筛选修改器

If you have multiple modifiers of different types added to the same shape, you can filter which modifiers are visible by type using the buttons at the top of the Modifiers panel. By default, the panel shows all the modifiers. When you click a filter button, only modifiers of that category appear. You can click multiple buttons to show more than one category of modifiers.

![Filtering modifiers](../../../../assets/images/6c/6cbdc8d27f291f58272915f46818189d3e6e66853525bc5767af1849f6672d61.jpg)

## 布局

Layout modifiers provide a way for you to adjust the placement of actors on screen using straightforward tools that can achieve results without a lot of minute manual adjustments.

### 两点间对齐

You can use the **两点间对齐** modifier to maintain the position of a collection of actors between two other actors. You can use this when expanding or contracting a region in your level to ensure other actors shift horizontally to stay centered within the region.

The example below shows a group of three characters, nested inside of a null actor that has the Align Between modifier assigned to it:

![The Align Between modifier](../../../../assets/images/ab/ab14599718d4739bbfda3837aa1e9a65debd8fa1afe2d73c5f57c511cb9a8c6e.png)

#### 参考 Actor 数组

Setting up involves adding a modifier to a null actor. When you first add the modifier to a null actor, you will be presented with an empty **Reference Actors** array property:

![Align Between empty array](../../../../assets/images/0c/0c116f6638abcbd632a5885a4bf71d784cdfbd04707cfcc6cd488eb83a028593.png)

Click the **Add (+)** button to create a new array entry:

![Align Between new array entry](../../../../assets/images/15/15d682d515833eba5e724af9b6d354620541644ed83f35e61771a8100aed3a3a.png)

Click the **Add (+)** button again to create a second array entry. The properties summarized below apply to both reference actors in the array, which function as handles. You need two for the Align Between modifier to function.

#### Actor 弱引用

The **Actor 弱引用** property provides a way to choose the reference actors in the array used for the boundaries. Expanding the drop-down menu presents you with a list of all actors in the level. Select actors to act as your boundary for both reference actors in the array.

In the example shown below, setting the values in the array as shown in the image and table provides two purple rectangle actors named "Left" and "Right" to use as bounds:

![Setting the boundary actors using the Actor Weak property](../../../../assets/images/8a/8a6c52e1f84abcaaa9dedecc6cad89e04137efe0a64729a04685a846ee6f220e.png)

| 索引 | Actor 弱引用 | 权重 |
| --- | --- | --- |
| 1 | Left | 1.0 |
| 2 | Right | 1.0 |

In the example below, when you move the two purple rectangle handles, it shifts the group of characters around to center between the handles.

![Moving the boundary actors to use the Align Between modifier to reposition the image actors.](../../../../assets/images/d4/d4a44dbed273dbe987892e02f64e029848762419b64867de79475aceb929d8c3.jpg)

#### 权重

The **权重** property determines how much interpolation takes place. If the value is higher for one handle, the alignment shifts towards that handle. A value of 0 results in no effect.

#### 启用

When your actors are positioned to your liking, you can deselect the **启用**property checkbox to hide the handle actors.

| Align Between Properties | 说明 |
| --- | --- |
| **Actor 弱引用** | Provides a list of available actors to use as the interaction handle. |
| **权重** | Determines the interpolation between the handle actors. |
| **启用** | Disable this checkbox to hide the handle actor. |

### 自动跟随

You can use the **自动跟随** modifier when you have an actor that needs to follow the position of another actor. 在下面的示例中，UE 徽标跟随文本；当文本变长或变短时，徽标也会随之移动。

> 图片已省略：auto follow logo follows long text

Here it is with shorter text:

> 图片已省略：auto follow logo follows short text

To accomplish this using the Auto Follow modifier, place the modifier on the actor that is following another actor. In this example, it’s the UE logo.

> 图片已省略：auto follow set up

There are some key properties that you will need to define carefully.

#### 参考容器

This property provides a way to define how the auto follow functions. You can select a specific actor to follow using the Other option, or you can set it to follow based on the order of where the actor exists in the Motion Design Outliner hierarchy.

> 图片已省略：reference container options

- **Previous**: follows the previous actor in the Motion Design Outliner.
- **Next**: follows the next actor in the Motion Design Outliner.
- **First**: follows the first actor in the Motion Design Outliner.
- **Last**: follows the last actor in the Motion Design Outliner.
- **Other**: Define a specific actor to follow, regardless of its position in the Motion Design Outliner.

#### 参考 Actor

When the Reference Container property is set to Other, the **参考 Actor** property determines which actor the group will follow. In the example at the beginning of this section using the UE Logo actor, the group follows the 3Dtext actor.

#### 跳过隐藏对象

When the Reference Container property is not set to Other, enabling the **跳过隐藏对象** property causes the modified actor to ignore hidden actors when determining the reference actor.

#### 跟随轴

The **跟随轴** property determines the axes on which the actor follows. The most common use case is the **Y | Z** option, but you can expand the dropdown to customize the axes.

> 图片已省略：followed axis options

#### 偏移轴

The **偏移轴** property calculates the width of the following actor (in the example above, the logo) and offsets it to the right with a value of 1.0 for the Y value. If you set the value to 0.0 for X, Y, and Z, the following actor will overlap the followed actor.

#### 被跟随对象对齐与本地对齐

**Followed Alignment** and **Local Alignment** function similarly, with the difference between them being that Followed Alignment determines the alignment of the reference actor, and Local Alignment determines the alignment of the modified actor.

For the auto follow to calculate correctly, set the vertical and horizontal alignment to match the actors involved in the calculation. You can select any combination of options for your own work, but in this example, both actors are centered both vertically and horizontally.

- Alignment for the text actor:

  > 图片已省略：auto follow text actor alignment
- Alignment for the rectangle:

  > 图片已省略：auto follow rectangle alignment

#### 起始填充

This property provides you a way to set a preset gap to prevent your layout from being too densely clustered.

- Start Padding set to 0.0:

  > 图片已省略：auto follow start padding set to 0
- Start Padding set to 30.0:

  > 图片已省略：auto follow start padding set to 30

#### 结束填充

You can use End Padding in conjunction with Padding Progress to animate your distance across a fixed 0% - 100% translation, where the Start Padding value defines the 0% position, and the End Padding value defines the 100% position. The image below shows an example:

> 图片已省略：auto follow end padding

#### 填充进度

You can set the Padding Progress value to show a specific point in the translation from Start Padding to End Padding. If you set the Start Padding value to zero on all three axes (0, 0, 0) then use the End Padding and Padding Progress properties to handle the translation, a Padding Progress value of 50 produces a result like the following image:

> 图片已省略：auto follow padding progress

| Auto Follow Properties | 说明 |
| --- | --- |
| **参考容器** | Determines which actor to follow. Options are:PreviousNextFirstLastOther |
| **参考 Actor** | Defines a specific actor to follow. Only available if Reference Container is set to Other. |
| **跳过隐藏对象** | Enable to ignore hidden actors when picking the reference actor to follow. Only available if Reference Container is not set to Other. |
| **Followed Axis X / Y / Z** | Determines on which axes the actors follow. |
| **Offset Axis X / Y / Z** | Determines on a per-axis basis the offset between the followed and following actors. Setting all values to 0 overlaps the actors. |
| **Followed Alignment** | Determines the alignment for the reference actor. Alignment should match that of the modified actor. |
| **Local Alignment** | Determines the alignment for the modified actor. Alignment should match that of the reference actor. |
| **起始填充** | Determines a preset distance between actors to prevent layout cluttering. |
| **结束填充** | Determines a maximum distance when animating the following actor layout. |
| **填充进度** | Determines the progress towards reaching the maximum distance when animating the following layout. Requires a valid End Padding property value. |

### 网格排列

This modifier provides a way for you to spread out a few actors evenly according to the row and/or column count, and the spread between actors. To use the Grid Arrange modifier, you apply it to a parent null actor which has the actors you want to arrange in a grid as children.

> 图片已省略：grid arrange

#### 数量

The **数量**property handles the horizontal and vertical number of actors you want to arrange. In the example above, there are three characters spread across a single row.

#### 间距扩展

The **间距扩展**property controls the distance between the actors, which are evenly distributed. A zero (0.0) value results in the actors overlapping.

#### 起始角

The **起始角** property determines whether the actors spread from the left or from the right.

#### 起始方向

The **起始方向** property determines whether the actors are spaced vertically or horizontally.

| Grid Arrange Properties | 说明 |
| --- | --- |
| **数量** | Determines number of actors in the grid horizontally and vertically. |
| **间距扩展** | Determines the distance between actors. A 0 value results in overlapping actors. |
| **起始角** | Determines whether the actors spread from the left or from the right. |
| **起始方向** | Determines whether the actors are spaced vertically or horizontally. |

### 对齐分布

You can use the **对齐分布**modifier to force the alignment of a group of actors. To use it, multi-select a group of actors and group them using **Ctrl+G**. Add the **对齐分布**modifier on the null actor that represents the group, and the modifier will calculate the total area of all the actors’ bounding boxes. If you select **Center** under **Horizontal Alignment**, the modifier centers them in your viewport. Selecting all three helps to visualize this.

> 图片已省略：justify

Shifting over the purple rectangle with the bounding boxes visible demonstrates that the Justify is centering as expected.

> 图片已省略：justify move box

#### 对齐属性

All three of the **Alignment** properties (Horizontal, Vertical, and Depth) function in the same way. You select an option to define how the group of actors are justified, defaulting to none, with options for either boundary edge or the center of your selected alignment.

#### 锚点属性

The **Anchor** properties (Horizontal, Vertical, and Depth) are only available if the corresponding alignment property is set to a value other than None, and also all function in the same way. They provide a way to shift the anchor point for how the group of actors is justified away from the default position along the related alignment.

| Justify Properties | 说明 |
| --- | --- |
| **Horizontal Alignment** | Options are:NoneLeftCenterRight |
| **Vertical Alignment** | Options are:NoneTopCenterBottom |
| **Depth Alignment** | Options are:NoneFrontCenterBack |
| **Horizontal Anchor** | Only available if Horizontal Alignment has a value other than None. Provides a way to shift the horizontal anchor point for the justify effect on the modified group of actors. |
| **Vertical Anchor** | Only available if Vertical Alignment has a value other than None. Provides a way to shift the vertical anchor point for the justify effect on the modified group of actors. |
| **Depth Anchor** | Only available if Depth Alignment has a value other than None. Provides a way to shift the depth anchor point for the justify effect on the modified group of actors. |

### 朝向目标

You can use the **朝向目标** modifier to cause one of your actors to rotate automatically to always face another actor. In the example shown below, we added the modifier to the **Torus** actor, set the **参考容器** to **Other**, and then set the **Green Sphere** as the **参考 Actor**. The modifier scans the level for the reference actor and turns the modified actor to face it.

> 图片已省略：look at modifier set up

In the image below, when we move the Torus to the left, it continues to face the Green Sphere.

> 图片已省略：look at modifier in action

#### 参考容器

The **参考容器** property provides a way to define the actor the modified actor orients towards. You can select a specific actor to look at using the **Other** option, or you can set it to orient according to the order of where the actor exists in the **Motion Design Outline**r hierarchy.

- **Previous**: orient towards the previous actor in the Motion Design Outliner.
- **Next**: orient towards the next actor in the Motion Design Outliner.
- **First**: orient towards the first actor in the Motion Design Outliner.
- **Last**: orient towards the last actor in the Motion Design Outliner.
- **Other**: Define a specific actor to orient towards, regardless of its position in the Motion Design Outliner.

#### 参考 Actor

When the Reference Container property is set to Other, the **参考 Actor** property determines which actor the modified actor looks at.

#### 跳过隐藏对象

When the Reference Container property is not set to Other, enabling the **跳过隐藏对象** property causes the modified actor to ignore hidden actors when determining the reference actor.

#### 轴属性

You can use the **Axis** property to define which axis (X, Y, or Z) of your modified actor faces towards the reference actor, the default is the X axis. You can also enable the **Flip Axis** property to cause the modified actor to face the opposite direction along the selected axis.

| Look At Properties | 说明 |
| --- | --- |
| **参考容器** | Determines which actor to look at. Options are:PreviousNextFirstLastOther |
| **参考 Actor** | Defines a specific actor to look at. Only available if Reference Container is set to Other. |
| **跳过隐藏对象** | Enable to ignore hidden actors when picking the reference actor to look at. Only available if Reference Container is not set to Other. |
| **Axis** | Defines the axis of the modified actor along which it faces the reference actor. Options are:XYZ |
| **Flip Axis** | Reverses the facing of the modified actor towards the reference actor along the selected axis. |

### 径向排列

You can apply a Radial Arrange modifier to the null parent of a set of grouped actors. You can adjust the radial arrangement this generates using a variety of properties, as shown in the example below.

> 图片已省略：radial arrange modifier

#### 数量

You can use the **数量**property to set the number of items you want to arrange. Setting the value to -1 automatically uses all available actors in the group.

#### 环数

You can use the **环数**property to set the number of rings you want to arrange. In the above example, we set the value to 2, which creates 2 rings.

#### 内半径与外半径

The **Inner Radius** and **Outer Radius** properties define the size (radius) of the innermost ring and outermost ring created, respectively. The actors will spread out or contract within the two constraints accordingly.

#### 起始角与结束角

The **Start Angle** and **End Angle** properties combine to define the shape of the arc arrangement of your actors. The range for each setting is -180 through 180, in degrees. For a complete circle, set the Start Angle value to -180 and the End Angle value to 180.

#### 从外半径开始

The **从外半径开始** property constructs the arrangement from the outer radius moving inwards, rather than from the inner radius moving outwards. In the example, this causes the outer spheres to move to the middle of the group:

- Standard:

  > 图片已省略：radial arrange start from outer radius initial state
- Start from Outer Radius:

  > 图片已省略：radial arrange enable start from outer radius
- Increasing the values of the Outer Radius and Inner Radius properties reveals what’s happening more effectively:

  > 图片已省略：radial arrange start from outer radius increased radius

#### 朝向属性

Enabling the **朝向**property gives you control over how the radial arrangement appears in 3 dimensions, by means of 3 additional properties that only become available when you enable Orient.

- **Orientation Axis:** You can define the axis (X, Y, Z) your radial arrangement is oriented around. By default, your radial arrangement is oriented around the X axis.
- **Base Orientation:** You can apply additional rotation, in degrees along one or more axes (X, Y, Z), to the arrangement in addition to the default axis.
- **Flip Axis:** Reverses the facing of the arrangement along the selected axis.

| Radial Arrange Properties | 说明 |
| --- | --- |
| **数量** | Defines the number of items you want to arrange. Setting the value to -1 automatically uses all available actors in the group. |
| **环数** | Defines the number of rings you want to arrange. |
| **Inner Radius** | Defines the radius of the inner ring. |
| **Outer Radius** | Defines the radius of the outer ring. |
| **Start Angle** | Defines the start angle for the ring. Range is -180 through 180, in degrees. |
| **End Angle** | Defines the end angle for the ring. Range is -180 through 180, in degrees. |
| **Arrangement** | Defines how the radial arrangement elements are organized. Options are:**Equal:** All elements in all radial rings have the same spacing between them. The number of elements in the outer rings will be greater than the inner rings.**Monospace:** Each radial ring will contain the same number of elements. The spacing between elements in the outer rings will be greater than the inner rings. |
| **从外半径开始** | Enable this property to cause the radial arrangement to start from the outer radius and move inwards, instead of starting from the inner radius and moving outwards. |
| **朝向** | When enabled, the arrangement is oriented with the selected axis towards the center. |
| **Orientation Axis** | Selects the axis of orientation. Only available when Orient is enabled. Options are:XYZ |
| **基础朝向** | Applies additional rotation, in degrees, to the arrangement in addition to the default axis. Only available when Orient is enabled. Options are:X (degrees)Y (degrees)Z (degrees) |
| **Flip Axis** | Reverses the facing of the arrangement along the selected axis. Only available when Orient is enabled. |

### 样条路径

You can use the **样条路径** modifier to have your modified shape follow a spline you create using the [Draw Spline](../../../working-with-content/modeling-and-geometry-scripting/modeling-tools/draw-spline-tool/index.md) tool.

> 图片已省略：Spline Path modifier

#### 样条 Actor 弱引用

A prerequisite for using this modifier is to already have a spline actor you can select in the Spline Actor Weak property's drop-down menu. If you have multiple splines, you can choose which of them you want your modified shape to use as a path.

#### 采样模式

You have multiple options for how you track your shape's progress along the spline path, available in the **采样模式** property's drop-down menu.

- **Percentage**: Tracks progress as a percentage of the spline path. This is the default option. This option renames the context slider property to **Progress**.
- **距离**: Tracks progress in terms of the distance along the length of the spline. The values will vary according to how long your spline is. This option renames the context slider property to **距离**.
- **Time**: Tracks your progress in terms of how long it takes to progress along the spline. The time it takes to fully progress along a spline is determined by a property on the Spline actor; the default is a 1-second transit time. This option renames the context slider property to **Time**.
- **Point**: Tracks your progress along the spline in discrete hops, from point to point used to describe the spline. The values will vary according to how many points you used to create your spline. This option renames the context slider property to **Point**.

#### 上下文滑块

The context slider property is how you control the specific point where your shape is along the spline. The name of this property varies depending on the value of the Sample Mode property.

In all cases, you can type a valid value in the field to see the shape at that point on the spline. You can also drag inside the field to move your shape on the spline dynamically. The values shown vary depending on what version of the context slider (and thus which Sample Mode) you are using.

- **Progress**: Displays the value as a percentage from 0 - 100.
- **距离**: Displays the value in cm. Values longer than the full length of the spline place the shape at the end of the spline.
- **Time**: Displays the value in seconds, down to hundredths of a second. Values larger than the time taken to progress the full length of the spline place the shape at the end of the spline.
- **Point**: Displays which point of the spline the shape is on.

#### 朝向

When you enable the **朝向**property, your shape is oriented along the spline's tangent.

#### 基础朝向

When the Orient property is enabled, you can use the **基础朝向** properties to apply a rotation on your shape's default orientation. You can apply the rotation separately on each axis, X, Y, and Z.

#### 缩放

When you enable the **缩放**property, the scale of your shape is modified according to the scaling of the spline points. If you increase or decrease the scale property of the spline actor points, you increase or decrease the scale of the modified shape accordingly.

| Spline Path Properties | 说明 |
| --- | --- |
| **样条 Actor 弱引用** | Determines which spline actor to use as a path. |
| **采样模式** | Determines how to track the modified shape along the spline path. Also determines the name and functionality of the context slider property. Options are:Percentage距离TimePoint |
| **上下文滑块** | Controls where the shape is on the spline path. The property name changes depending on the value of the Sample Mode property. |
| **朝向** | When enabled, your shape orients along the spline's tangent. |
| **基础朝向** | Adds rotation to your shape's orientation. Only available when Orient is enabled. |
| **缩放** | When enabled, your shape is scaled based on the spline point scaling. |

## 几何体

You can use Geometry modifiers to build 3D designs without relying on a dedicated modeling program. There are several modifiers created for use with multiple design tasks.

> 图片已省略：geometry modifiers

> [!NOTE]
> Using these tools requires you to use the built-in **Motion Design 2D/3D primitives**, or to convert a static mesh for use by Motion Design using the **动态网格体转换器**.
>
> > 图片已省略：2D shapes for use with geometry modifiers
>
> > 图片已省略：3D shapes for use with geometry modifiers

### 自动尺寸

The **自动尺寸** modifier provides a way for you to automatically resize a modified 2D shape, to act as a background for a selected reference actor.

#### 参考容器

The Reference Container property provides a way to define how the auto size functions. You can select a specific actor to resize to match using the Other option, or you can set it to resize with respect to another actor, depending on the other's position in the Motion Design Outliner hierarchy.

- **Previous**: Resizes to match the previous actor in the Motion Design Outliner.
- **Next**: Resizes to match the next actor in the Motion Design Outliner.
- **First**: Resizes to match the first actor in the Motion Design Outliner.
- **Last**: Resizes to match the last actor in the Motion Design Outliner.
- **Other**: Define a specific actor to resize to match, regardless of its position in the Motion Design Outliner.

#### 参考 Actor

When the Reference Container property is set to Other, the **参考 Actor** property determines which actor the modified actor references to resize.

#### 垂直填充

The **垂直填充** property provides a way to make the modified actor vertically taller or shorter than the reference actor. Positive values make the modified actor larger, negative values make the modified actor shorter.

#### 水平填充

The **水平填充** property provides a way to make the modified actor horizontally wider or thinner than the reference actor. Positive values make the modified actor wider, negative values make the modified actor thinner.

#### 适配模式

You can use the **适配模式** property to determine how your modified actor is resized with respect to the reference actor.

- **Width and Height**: By default, your modified actor resize based on both width and height of the reference actor.
- **Width Only:** Your modified actor only resizes its width to match the reference actor.
- **Height Only**: Your modified actor only resizes its height to match the reference actor.

#### 包含子项

When enabled, the **包含子项** property causes your modified actor to resize to account for any children of the reference actor as well.

| Auto Size Properties | 说明 |
| --- | --- |
| **参考容器** | Determines the reference actor to compare with for resizing. Options are:PreviousNextFirstLastOther |
| **Reference****Actor** | Defines a specific actor to compare with for resizing. Only available if the reference container is set to Other. |
| **垂直填充** | Adds or removes padding to height when resizing. |
| **水平填充** | Adds or removes padding to width when resizing. |
| **适配模式** | Determines how the modified actor is resized in comparison to the reference actor. Options are:Width and HeightWidth OnlyHeight Only |
| **包含子项** | When enabled, include children of the reference actor when resizing. |

### 弯曲

This modifier provides a way for you to take a Motion Design shape like a cube and bend it using a variety of properties.

> [!NOTE]
> The Bend modifier is dependent on an associated Subdivide modifier, which is automatically added and can't be removed.

|  |  |
| --- | --- |
| [Bend modifier, simple bend on a shape](https://dev.epicgames.com/community/api/documentation/image/fa8f8a27-ca98-46e0-abe4-43631fdaf153?resizing_type=fit) | [Bend modifier properties, simple bend](https://dev.epicgames.com/community/api/documentation/image/7a395be8-82c6-457a-a5fe-4f9efa918043?resizing_type=fit) |

There are several properties for manipulating your bend.

#### 弯曲位置与弯曲旋转

The **Bend Position** and **Bend Rotation** properties give you control over the direction and location of your modified shape's bend. Bend Position provides a way for you to adjust the location of your bend relative to the origin point for your shape. Bend Rotation provides a way to twist your bend along any axis.

The example below demonstrates how you can combine Bend Position and Bend Rotation to create a twist, when you center where the bend is occurring in the shape, then add rotation along the Z axis.

|  |  |
| --- | --- |
| [Bend modifier, complex twist on a shape](https://dev.epicgames.com/community/api/documentation/image/36b71992-44e2-47d3-bfd5-c665d353d380?resizing_type=fit) | [Bend modifier properties, complex twist](https://dev.epicgames.com/community/api/documentation/image/4ee1651e-1d42-4d51-a84f-89fbe0803754?resizing_type=fit) |

#### 角度

The **角度**property determines how much your shape bends, with a larger value meaning a larger bend, up to a maximum of 180 degrees, which represents a complete fold. You can remove your bend completely by setting the Angle property to 0.0.

#### 范围

The **范围**property controls how much of your shape is affected by the bend. An extent of 1.0 meaning the entire shape is affected, while smaller values mean a proportionally smaller amount of the shape is affected, centered around the point defined by the Bend Position and Bend Rotation properties.

#### 对称范围

When manipulating the value of the Extent property, enabling the **对称范围** property causes the upper and lower bounds to be affected identically, otherwise only the upper bound will be affected by changing the value of the Extent property.

#### 双向

When enabled, the **双向** property causes changes to the value of the Extent property to transform (rotate) the mesh, so both the upper and lower bounds are affected the same way, creating a plane of mirrored symmetry.

Playing with Symmetric Extents and Bidirectional properties.

| Bend Properties | 说明 |
| --- | --- |
| **Bend Position** | Defines the bend position relative to the shape origin on the various axes. Default value is 0. Options are:X positionY positionZ position |
| **Bend Rotation** | Defines the bend rotation relative to the shape origin on the various axes. Default value is 0 degrees. Options are:X degreesY degreesZ degrees |
| **角度** | Defines how much the shape bends. Default is 25 degrees, range is from 0 to 180. |
| **范围** | Defines the proportion of the shape bent, with 0 meaning the shape is not bent at all, and 1 meaning the entire shape is bent. |
| **对称范围** | Enable to cause upper and lower extents to be affected in the same way. |
| **双向** | Enable to create a plane of symmetry when bending the modified shape. |

### 倒角

You can use the **倒角** modifier to add a bevel to your shape, and control how deeply beveled your shape is.

#### 内缩

You can control how much your shape is bevelled with the **内缩** property. The value of the property is clamped between 0 and half the size of your shape's shortest boundary, that is, the maximum bevel you can add is half the shortest dimension of your shape.

#### 迭代次数

The **迭代次数**property will set the number of subdivisions, but this can be costly when set too high on too many shapes. If you want sharp, angular bevels, you can leave this value at 1. Higher values are useful when you want to have a smooth curve for your bevel.

#### 圆滑度

The **圆滑度**property uses iterations to smooth the shape. The property has a range of values from 2 to -2, with 0 representing no roundness, a straight, angular bevel. A value of 2 means your bevel will have a concave curve that is close to an arc of a circle, while a value of -2 is an inset bevel with the opposite convex curve.

Example with Roundness set to 0.0:

> 图片已省略：Bevel, roundness set to 0

Example with Roundness set to 2:

> 图片已省略：Bevel, roundness set to 2

Roundness, positive 2 (concave) compared to negative 2 (convex):

> 图片已省略：Bevel, comparing roundness 2 to roundness -2

| Bevel Properties | 说明 |
| --- | --- |
| **内缩** | How deeply beveled your shape is, ranging from 0 (no bevel) to half the shortest dimension of your shape |
| **迭代次数** | Determines how many sections your bevel is made up of. Used mainly to create a smooth curve in combination with Roundness. |
| **圆滑度** | Determines how curved your bevel is and whether the curve is concave (positive values) or convex (negative values). The range is from 2 to -2, with 0 (no curve) as the default. |

### 布尔

The **布尔**modifier provides a way for you to use Motion Design primitives to modify other shapes. There are several modes:

- **目标**
- **相减**
- **合并**
- **相交**

These modes are also color-coded, where red (as seen in the image below) is Subtract, blue is Intersect, and green is Union.

> 图片已省略：Boolean, subtract mode

#### 模式

The **模式**property determines what function of the Boolean modifier you are using. Each is a specific version of the Boolean modifier, and they interact with each other according to specific rules, each described below.

##### 目标

使用 **目标**modifier on the shape you are modifying. In the example in the image above, this is the chopped-up sphere.

##### 相减

When you add the **相减**modifier to a shape, it checks where the Target shape's geometry is intersecting with the Subtract shape's geometry, and removes it. The remainder of the shape's geometry is retained, as shown in the image above.

##### 相交

When you add the **相交**modifier to a shape, it checks where the Target shape's geometry is intersecting the Intersect shape's geometry, and retains it. The remainder of the shape's geometry is removed.

> 图片已省略：Boolean, intersect mode

##### 合并

When applied to a shape, the **合并**modifier combines all shapes that intersect with it and are in the same channel.

> 图片已省略：Boolean, union mode

#### 通道

For boolean modifiers to interact correctly, they must be assigned to the same **通道**. In the case of these examples, all the Boolean modifiers are set to channel 0. You can use Boolean modifiers assigned to different channels to create different interactions that don't affect each other.

Using the Channel property to control Boolean interactions.

| Boolean Properties | 说明 |
| --- | --- |
| **模式** | Determines how the Boolean modifier functions affect the shape it is attached to. Options are:**目标**: The Target mode identifies a shape to be affected by the other Boolean mode options.**相减**: Checks where the Target shape's geometry overlaps with the Subtract shape's geometry, and removes it.**相交**: Checks where the Target shape's geometry overlaps the Intersect shape's geometry, and retains it.**合并**: Combines all overlapping shapes. |
| **通道** | Determines the channel. Only Boolean modifiers using the same channel can interact. |

### 挤出

You can use the **挤出**modifier to thicken a 2D object into 3D space along its depth (by default, the Z-axis). Any rotations you apply to the object affect the extrude direction, which is linked to the Z- axis of the object, not of the level.

#### 挤出深度

The **挤出深度** property controls how much your 2D shape extrudes into 3D, measured in centimeters (cm). The default value is 30 cm.

#### 闭合背面

Enabled by default, the **闭合背面** property causes your extruded shape to close, which creates a solid 3D shape. If you disable it, the extruded section remains open.

|  |  |
| --- | --- |
| [Extrude modifier closed](https://dev.epicgames.com/community/api/documentation/image/1053348d-3f39-4e02-bf9e-ac36ce8096d4?resizing_type=fit) | [Extrude modifier open](https://dev.epicgames.com/community/api/documentation/image/a39a2048-00d9-4eaa-a428-3d84bfb35299?resizing_type=fit) |

#### 挤出模式

The **挤出模式** property controls which side of your 2D shape is extruded into 3D.

- **Opposite**: The side of the shape facing away from you when you initially placed it is extruded. This is the default option.
- **Front**: The side of the shape facing towards you when you initially placed it is extruded.
- **Symmetrical**: Both sides of the shape are extruded.

| Extrude Properties | 说明 |
| --- | --- |
| **挤出深度** | Determines how far your shape extrudes. |
| **闭合背面** | Determines whether your extruded shape is closed solid or not. |
| **挤出模式** | Determines the direction your shape extrudes. Options are:Opposite (default)FrontSymmetrical |

### 镜像

You can use the **镜像**modifier to create a mirrored clone of your geometry, and control how the mirroring happens in various ways.

#### 镜像框架位置与镜像框架旋转

You can use the **Mirror Frame Position** property to offset the mirrored clone by a specified amount, controlling how far apart your original shape and the mirror clone are.

> 图片已省略：Mirror Frame Position

You can also rotate the mirrored geometry using the **Mirror Frame Rotation** property. In combination, these two properties provide you with the means to control exactly where and how your geometry is reflected by the clone.

#### 应用平面切割

You can further modify your geometry by setting up your mirrored geometry to cut into the original actor. To do this, enable the **应用平面切割** property and rotate your geometry with the Mirror Frame Rotation until it collides. You should get a result similar to the image below:

> 图片已省略：Mirror modifier, Apply Plane Cut

#### 翻转切割侧

You can invert the Apply Plane Cut effect by enabling the **翻转切割侧** property, which angles and cuts the geometry along the flipped axis at the intersection.

> 图片已省略：Mirror modifier, Flip Cut Side

| Mirror Properties | 说明 |
| --- | --- |
| **Mirror Frame Position** | Defines the position of the mirrored geometry relative to the original. |
| **Mirror Frame Rotation** | Defines the rotation of the mirrored geometry relative to the original. |
| **应用平面切割** | Defines a plane intersecting the geometry, mirroring the geometry at the plane. |
| **翻转切割侧** | Inverts the mirroring at the plane cut. Only available when using Apply Plane Cut. |

### 法线

You can use the **法线**modifier to regenerate the normal map after converting or modifying the geometry with other modifiers.

### 轮廓

You can use the **轮廓**modifier to give your 2D shape an outline, and control whether the outline is outset or inset.

> 图片已省略：Outline modifier

#### 模式

The **模式**property determines whether your outline is Outset (outside the edge of your shape) or Inset (inside the edge of your shape).

#### 距离

The **距离**property determines how far your outline extends. You can type a specific value, or drag inside the field to dynamically adjust the outline distance.

#### 移除内部

The **移除内部** property hides the part of your shape inside the outline. Enabled by default.

> [!NOTE]
> If you disable Remove Inside while using Inset Mode, the shape does not appear to change, but the polygons that make up the underlying geometry do change.

### 图案

You can use the **图案**modifier when you want to create multiple copies of your shapes arranged in a variety of ways.

The **布局**property allows you to arrange your shapes in the formation of a **线**, **网格**, and **圆形**. There are many properties for each of those Layouts, several of which are shared between layout options. Those shared properties are described below.

| Pattern Properties | 说明 |
| --- | --- |
| **布局** | Determines the layout arrangement for your actors. Options are:线网格圆形 |
| Shared Layout Properties |  |
| **Centered** | When enabled, the interaction widget for your layout is placed at the center of the layout's bounding box. |
| **Accumulate Transform** | Recursively apply your specified transforms for every actor added by the Repeat Count property. |
| **Rotation X / Y / Z** | Standard rotation transforms on the specified axes, in addition to the default transform values in the Details panel. |
| **Scale X / Y / Z** | Standard scale transforms on the specified axes, in addition to the default transform values in the Details panel. |

#### 线

The **线**Pattern Layout provides a way for you to arrange copies of your actor in a straight line along an individual axis.

- You can choose which axis using the **Axis**property, which lines them up along X, Y, or Z.
- The**Axis Inverted** property is useful when you have the Centered property disabled; when enabled, the layout line extends in the opposite direction from the default along the specified axis.
- The **Repeat Count** property determines how many instances of your actor are added along the line you define.
- The **Spacing**property determines how much of a gap there is between actors in your line.

The example below shows a line with the Centered property disabled:

> 图片已省略：Line Pattern, Centered disabled

Here's the same example with the Centered property enabled:

> 图片已省略：Line Pattern, Centered enabled

The example below shows the effects of the Accumulate Transform property for a Line pattern. The transform applied is to scale down the sphere to 0.4, which is then applied again recursively at each repetition:

> 图片已省略：Line Pattern, accumulate transforms

By adding rotation transforms 访问修改器，也可以同时使用 scaling, you can create patterns like the following image:

> 图片已省略：Line Pattern, accumulate transforms with rotation

| Additional Line Pattern Properties | 说明 |
| --- | --- |
| **Axis** | Determines the axis of the line layout before any rotation transforms. Standard X / Y / Z options. |
| **Axis Inverted** | Inverts the direction your line layout extends along the selected axis. Only functions when the Centered property is not enabled. |
| **Repeat Count** | The number of instances of the actor in your line layout. |
| **Spacing** | The spacing between actors in your line layout. |

#### 网格

> 图片已省略：Grid Pattern Layout

The **网格** Pattern Layout provides a way for you to arrange copies of your actor into a grid.

- You can use the **Plane**property to arrange your grid on the XY, XZ, or YZ planes. The example in the image above shows a grid arranged on the YZ plane.
- The **Axis Inverted** property is useful when you have the Centered property disabled. When it is enabled, it will force your grid to center itself based on its own bounding box.
- The **Repeat Count** property determines how many instances of your actor are added along the axes that define your grid, with separate values for each axis.
- The **Spacing**property determines how much of a gap there is between actors in your grid.

Much like the other Pattern modifiers, enabling the Accumulate Transform property creates effects similar to the image below, always perpendicular to the grid's plane:

> 图片已省略：Grid Pattern Layout accumulate transforms

| Layout Grid Pattern Properties | 说明 |
| --- | --- |
| **Plane** | Determines the plane for your grid layout before any rotation transforms. Options are:XYXZYZ |
| **Axis Inverted** | Inverts the direction your grid layout extends along the selected axis. You can invert each axis separately. Only functions when the Centered property is not enabled. |
| **Repeat Count** | The number of instances of the actor in your grid layout. Each axis of the grid has a separate value for this property. |
| **Spacing** | The spacing between actors in your grid layout. Each axis of the grid has a separate value for this property. |

#### 圆形

> 图片已省略：Circle Pattern Layout

The **Circle Pattern Layout** provides a way to arrange copies of your actor in a circle.

- You can use the **Plane**property to arrange your circle on the XY, XZ, or YZ plane. The example in the image above shows a circle arranged on the YZ plane.
- The **Radius**property determines the size of the circle layout, and so determines how spread out your pattern elements are.
- You can arrange the total angle that your circle group covers by setting the **Start Angle** and **Full Angle** properties. For example, to achieve a 90 degree angle, set your Start Angle to 0.0 and your Full Angle to 90 to create a result similar to the following image:

  > 图片已省略：Circle Pattern Layout, Start Angle and Full Angle

  You can set the values to create a complete circle by using a combination of Start Angle = 0 and Full Angle = 360.
- The **Repeat Count** property determines how many instances of your actor are added to your circle.

Disabling the **Centered** property aligns all content to the right of the initial actor as shown below.

Using the Centered property with the Circle Pattern Layout.

Enabling the Accumulate Transform property applies changes to the rotation and scale for every repeated actor. Here is an example of increasing the scale of the X value between 1 and 1.5:

Accumulate transform using the Scale property for the Circle Pattern Layout.

| Additional Circle Layout Properties | 说明 |
| --- | --- |
| **Plane** | Determines the plane for your circle layout before any rotation transforms. Options are:XYXZYZ |
| **Radius** | The radius of your circle layout. A larger radius value means a bigger circle, which also controls the spacing between actors. |
| **Start Angle** | The starting angle for your circle layout. The value range is from 0 to 360, in degrees. |
| **Full Angle** | The ending angle for your circle layout. The value range is from 0 to 360, in degrees. |
| **Repeat Count** | The number of instances of the actor in your circle layout. |

### 平面切割

> 图片已省略：Plane Cut modifier

The **平面切割** modifier provides a way for you to cut through Motion Design geometry using just a few properties.

#### 平面原点与平面旋转

The **Plane Origin** property provides a way to position the cut relative to the origin point of the modified geometry on the Z-axis, positive values move up, negative values move down. The **Plane Rotation** property provides a way to rotate the cut along any of the 3 axes (X, Y, Z).

Using a combination of Plane Origin and Plane Rotation to situate the cut, you can produce results like the following example.

A geometry example before using Plane Cut:

> 图片已省略：Plane Cut initial shape

A geometry example after using Plane Cut:

> 图片已省略：Plane Cut modifier applied

#### 反转切割

Enabling the **反转切割** property reverses the existing cut. Inverting the cut in the preceding example has the following result:

> 图片已省略：Plane Cut invert cut enabled

#### 填充孔洞

If you want to fill in the area that the cut created, you can use the **填充孔洞** property. Using this property with the preceding example produces a result like the following image:

> 图片已省略：Plane Cut fill holes enabled

#### 使用预览

Enabling the **使用预览** property provides a way for you to visualize the cut you are making, using a green plane.

| Plane Cut Properties | 说明 |
| --- | --- |
| **Plane Origin** | Defines the origin of the cut, relative to the origin of the geometry on the Z-axis. The default value is 0. |
| **Plane Rotation** | Defines the rotation of the cut, on all 3 axes (X, Y, Z). The default values are 90, 0, 0 (a vertical cut on the X axis). |
| **反转切割** | Enable this property to reverse the cut section of the geometry. |
| **填充孔洞** | Enable this property to fill the hole in the cut geometry. |
| **使用预览** | Enable to show the preview plane of the cut relative to the geometry. |

### 按纹理调整尺寸

### 按纹理调整尺寸

You can use the **按纹理调整尺寸** modifier to make sure that your shape matches the proportions on the texture applied to it, this avoids distortions in how the texture appears on-screen.

Usually, you use this modifier alongside a remote control setup where you can swap between textures mapped to the shape at the touch of a button, so that your shape adjusts automatically to accommodate textures of different sizes.

#### 纹理

The **纹理**property provides a way to select the texture your shape resizes to match. By setting up this property with a remote control preset and multiple textures of different sizes, you can swap which of those textures is assigned to your modified shape.

#### 规则

The Rule property gives you the choice between either:

- **Adaptive Height**, where your shape adapts its height to match the texture.
- **Adaptive Width**, where its width matches the texture.

In both cases, the texture ratio is maintained.

> [!WARNING]
> The Size to Texture modifier is intended for use with rectangular shapes. Using it with other shapes will result in unintended behavior. Use at your own risk.

| Size to Texture Properties | 说明 |
| --- | --- |
| **纹理** | Determines the texture your shape resizes to match. |
| **规则** | Determines how your texture resizes, to maintain the texture ratio. Options are:Adaptive HeightAdaptive Width |

### 样条扫掠

The **样条扫掠** modifier provides a way to sweep a 2D shape along the length of a spline, creating a 3D shape that fills space while following the spline path. The spline actor does not need to be anywhere near the modified shape. As long as your spline actor is present anywhere on the level, the modified shape will create a 3D shape following the spline's path from the modified shape's initial position.

> 图片已省略：Spline Sweep modifier

#### 样条 Actor 弱引用

A prerequisite for using this modifier is to already have a spline actor you can select in the **样条 Actor 弱引用** property's drop-down menu. If you have multiple splines, you can choose which of them you want your modified shape to use to create the sweep.

#### 采样模式

The **采样模式** property determines how often you sample the spline when generating the sweep. The options are:

- **Full Distance**: The sweep is generated by sampling the spline a number of times equal to the value of the Steps property, regardless of the length of the spline. When using the Full Distance Sample Mode, increasing the length of the spline decreases the precision of the sampling, as the samples are spread further apart along the spline.
- **Custom Distance**: The sweep is generated by sampling the spline a number of times equal to the Steps value for every multiple of the value of the Sample Distance property. When using the Custom Distance Sample Mode, increasing the length of the spline does not decrease the precision of the sampling, as the sampling is repeated for every multiple (or fraction thereof) of the Sample Distance value.

  For example, if the Sample Distance is 2000 Unreal Units, the value of the Steps property is 10, and the spline is 3000 units long, the spline is sampled 15 times. If you then lengthen the spline to 4000 units long, the spline is instead sampled 20 times.

#### 采样距离

The **采样距离** property determines how frequently your modified shape samples the spline when you are using the Custom Distance Sample Mode option. Smaller values cause the shape to sample the spline more frequently, which results in a smooth sweep.

> 图片已省略：Spline Sweep with small sample distance

#### 步数

The **步数**property determines how often your modified shape samples the spline within the distance specified by the Sample Mode and Sample Distance properties, either over the full length of the spline with the Full Distance Sample Mode, or over every iteration of the value of the Sample Distance when using the Custom Distance Sample Mode.

#### 进度属性

The three **Progress** properties provide a way to control how much of the spline is used to generate your sweep. The effects of all three properties are additive.

##### 进度偏移

The **进度偏移** property provides a way for you to start your sweep further along the length of the spline actor. When you enable the Looped property, the spline sweep connects back to the offset position you selected, and you can use a Progress Offset value greater than 1. Changing the default values of the Progress Start or Progress End properties changes the Progress Offset behavior, see Progress Start and Progress End below for more information.

The value of this property is a proportion, so a value of 0 represents the start of the spline, and a value of 1 represents the end of the spline.

Working with the Spline Sweep modifier.

##### 进度起点

The **进度起点** property provides a way for you to start your sweep further along the length of the spline actor. If you enabled the Looped property (see below), the spline sweep does not connect back to the start position you selected. The value of this property is a proportion, so a value of 0 represents the start of the spline, and a value of 1 represents the end of the spline.

##### 进度终点

The **进度终点** property provides a way for you to end your sweep before it reaches the end of the spline actor. If your spline is a loop, the sweep ends when it reaches the point along the length of the spline that matches the value of the property, so that the skipped part of the spline at the end is not included in the sweep. The value of this property is a proportion, so a value of 0 represents the start of the spline, and a value of 1 represents the end of the spline.

> 图片已省略：Spline Sweep Progress Start and Progress End

#### 起始缩放与结束缩放

The Scale Start and Scale End properties control the scaling of your modified shape along the length of the sweep. The values of these properties are proportions, the relative scaling of the shape at the start and end of the sweep compared to its unmodified size, respectively. The default values of 1.0 for both properties means the shape remains unmodified.

Changing the values causes the scaling of the shape to be interpolated from the value of the Scale Start at the beginning of the sweep, to the value of the Scale End and at the end of the sweep.

For example, changing the value of the Scale Start property to 0.5 and the value of the Scale End property to 2.0 would mean the shape begins at half its unmodified size then grows along the length of the spline sweep until it reaches twice its unmodified size at the end.

> 图片已省略：Spline Sweep Scale Start and Scale End

#### 封盖

The **封盖** property is enabled by default, and closes the ends of the sweep to create a solid shape. You can disable the property if you want the ends of the sweep to remain open.

#### 循环

By enabling the **循环** property you connect the ends of your sweep into a closed loop.

> [!WARNING]
> If Progress Start, Progress End, or both are enabled, they will override the Looped property and break the loop.

> 图片已省略：Spline Sweep Looped

| Spline Sweep Properties | 说明 |
| --- | --- |
| **样条 Actor 弱引用** | Determines which spline actor to use to create your sweep. |
| **采样模式** | Determines how the spline length is sampled. Options are:Full DistanceCustom Distance |
| **Sample Distance** | Determines the sample distance. Only available when Sample Mode is set to Custom Distance. The default value is 1000. |
| **步数** | Determines how many times the spline is sampled within the distance defined by the Sample Mode property. The default value is 10. |
| **Progress****Offset** | Determines how much offset to add to the start of the sweep, as a proportion of the spline length. Connects back when the Looped property is enabled. The default value is 0. |
| **进度起点** | Determines where along the length of the spline to start the sweep, as a proportion of the spline length. The default value is 0. |
| **进度终点** | Determines where along the length of the spline to end the sweep, as a proportion of the spline length. The default value is 1. |
| **Scale Start** | Determines the relative scaling of the modified shape at the start of the sweep. |
| **Scale End** | Determines the relative scaling of the modified shape at the end of the sweep. |
| **封盖** | When enabled, the ends of the sweep are capped. Not functional on a looped sweep. |
| **循环** | When enabled, the end of the sweep connects back to the start to form a closed loop. |

### 细分

The **细分**modifier takes your dynamic mesh and subdivides the mesh to increase or decrease the number of polygons. This modifier is automatically added as a required dependency when you add a modifier like Bend or Taper.

#### 切割数

The **切割数**property determines how much the target shape gets subdivided. Increasing the value increases the number of cuts and therefore polygons, which produces a smoother effect but requires more resources to render.

#### 类型

The **类型**property determines how the polygons are subdivided. There are several different algorithms available to calculate this, the options are:

- **Selective**: The polygons created can be different proportions, arranged in patterns.
- **Uniform**: All polygons are proportionally the same . This is the default.
- **PN**: Smooths the polygons. For the best results, enable the **Regenerate Normals** property, which is only available when you select this Type option.

Type options for the Subdivide modifier.

| Subdivide Properties | 说明 |
| --- | --- |
| **切割数** | Determines the number of cuts. The default value is 2. |
| **类型** | Options are:SelectiveUniform (default)PN |
| **Regenerate Normals** | Enable to regenerate normals. Only available when Type is set to PN. |

### 锥化

The **锥化**modifier provides a way for you to narrow your shape, at multiple points along the surface.

> [!NOTE]
> The Taper modifier is dependent on an associated Subdivide modifier, which is automatically added and can't be removed.

To create a smoother shape, you can use the Cuts property of the Subdivide modifier associated with the Taper modifier. Setting the Cuts count to 9 produces a relatively smooth curve. If you reduce the Cuts count to 3, you get a blocky curve instead of a smooth curve.

#### 数量

The **数量**property determines how much tapering to apply to your shape. The range is a proportion, where 0 means no taper, and 1 means taper to a point.

#### 范围

The **范围**property determines how much of the shape is tapered. The example below is a simple taper with the Extent value set to the default Whole Shape option.

> 图片已省略：Taper modifier extent property

Setting the value to **Custom** provides the option to control the **Upper Extent** (starting from the top and extending downwards) and **Lower Extent** (starting from the bottom and extending upwards) properties separately, in both cases with a range from 0 to 100%. You can use these to create more complex tapers.

#### 插值类型

The Interpolation Type property determines the curve applied to your shape by the modifier. The default value is **Linear**, shown in the image above. Other options change the curve, as shown below:

- **Quadratic**

  > 图片已省略：Taper modifier quadratic interpolation
- **Cubic**

  > 图片已省略：Taper modifier cubic interpolation
- **Quadratic Inverse**

  > 图片已省略：Taper modifier quadratic inverse interpolation
- **Cubic Inverse**

  > 图片已省略：Taper modifier cubic inverse interpolation

#### 参考框架

The **参考框架** property controls how the taper is applied with reference to the position of the shape. By default, the taper references the **Mesh Center**, but you can set the property to **Custom**, and apply an offset to the X and Y values. This will cause the taper to lean towards the direction of the offset.

| Taper Properties | 说明 |
| --- | --- |
| **数量** | Determines how much tapering, as a proportion. 0 is no taper, 1 is taper to a point. |
| **范围** | Determines how much of the shape is tapered. Options are:Whole ShapeCustom - use the Upper Extent and Lower Extent properties to control the custom extent. |
| **Upper Extent** | Only available when Extent is set to Custom. Determines the upper extent affected by the taper. Range is 0 - 100%. |
| **Lower Extent** | Only available when Extent is set to Custom. Determines the lower extent affected by the taper. Range is 0 - 100%. |
| **插值类型** | Determines the curve of the taper. Options are:Linear (default)QuadraticCubicQuadratic InverseCubic Inverse |
| **Resolution** | Deprecated. Use the Cuts function of the associated Subdivided modifier. |
| **参考框架** | Determines the reference frame. Options are:Mesh CenterCustom - uses the Offset property to control the reference frame. |
| **Offset** | Only available when the Reference Frame is set to Custom. Determines the offset applied to the reference frame on the X and Y axis. |

### 动态网格体转换器

The shapes that you create using Motion Design's procedural shape tools aren’t the same as a static mesh, and therefore static meshes aren’t fully compatible with geometry modifiers. For full compatibility with all geometry modifiers, you must first convert your static mesh into a **dynamic mesh**.

Static meshes are functional with some modifiers like Grid Arrange, because the geometry has several actors present. However, if you want to use a static mesh with tools such as Patterns and Mirror, you first need to convert it.

> [!NOTE]
> Only geometry modifiers require dynamic meshes. All other modifiers are functional when used with static meshes.

> 图片已省略：Dynamic Mesh Converter modifier

To convert your static mesh, select your static mesh actor and add a **动态网格体转换器**.

> 图片已省略：Selecting the Dynamic Mesh Converter modifier

> 图片已省略：Dynamic Mesh Converter properties

The default property settings are sufficient for the majority of use cases, especially when you aren’t dealing with meshes attached to a skeleton or other similarly complex use cases.

> 图片已省略：Adding a modifier to a newly-converted dynamic mesh

You now have the complete list of modifiers at your disposal. Here is an example of applying the Pattern Circle Layout and adjusting some settings:

> 图片已省略：Pattern Circle Layout applied to a converterd Dynamic Mesh

For more complex use cases, refer to the property descriptions below.

#### SourceActor

You can change the target actor for your Dynamic Mesh converter using the **SourceActor** property drop-down menu, which gives you access to all the actors in your level, and tools to search for and select the actor you want.

#### 组件类型

If your selected actor has multiple components, you can decide which to account for in the conversion using the **组件类型** property, which has a drop-down menu of selectable components types:

- Static Mesh Component
- Dynamic Mesh Component
- Skeletal Mesh Component
- Brush Component
- Procedural Mesh Component

By default, all are selected. Deselect any you don't want included in the conversion to a dynamic mesh.

> 图片已省略：Dynamic Mesh Converter component types

#### 筛选 Actor 模式

You can filter out actors to convert using the **筛选 Actor 模式** property, either by including specific actors, or excluding specific actors. You can define the actors to include or exclude using the **Filter Actor Classes** array property.

#### 包含附加 Actor

If your selected actor has other actors attached to it, the **包含附加 Actor** property means that by default, they are also converted. If you want to exclude them from the conversion, you can disable the property.

#### 隐藏转换后的网格体

When you add the modifier, by default it automatically converts your static mesh into a dynamic mesh and hides the original, due to the **隐藏转换后的网格体** property. You can disable this property if you also want to see the original static mesh alongside the dynamic mesh.

#### 更新间隔

You can determine how often your converted dynamic mesh checks the source mesh for changes using the **更新间隔** property. The default value is 1 (every second), but you can choose larger or smaller values. A value of 0 or less disables checking for updates.

| Dynamic Mesh Converter Properties | 说明 |
| --- | --- |
| **SourceActor** | Identifies the target actor. You can use the drop-down menu to select the actor. |
| **组件类型** | Determines which component types are tracked using a selectable list in a drop-down menu. |
| **筛选 Actor 模式** | Enables actor filtering. Options are:None (default)Include: only actors matching the filter are converted.Exclude: actors matching the filter are not converted. |
| **Filter Actor Classes** | Use this array property to define actors affected by the Filter Actor Mode property when it is set to Include or Exclude. |
| **包含附加 Actor** | When enabled, children of the modified mesh are also converted. |
| **隐藏转换后的网格体** | When enabled, hides the original mesh, showing only the dynamic mesh |
| **更新间隔** | Defines how often the dynamic mesh checks the original mesh for changes. Values of 0 or less mean no updates. |

## 渲染

### 材质参数

The **材质参数** modifier gives you a way to set parameter values on dynamic material instances. This means if you create a dynamic material instance from a material, you can adjust the parameters using this modifier.

Because parameters cannot be changed on regular material assets, you first need to create a dynamic material instance using a Blueprint, the Material Designer, or C++, and assign it to your geometry. Only then can you add this modifier to your shape and use it to adjust your material instance's values.

#### 参数属性

The Material Parameter modifier has 3 properties that function as Map containers:

- **Scalar Parameters** (for example, opacity)
- **Vector Parameters** (for example, color)
- **Texture Parameters** (for example, roughness)

All 3 function similarly. You can add one or more variables from your dynamic material instance to the appropriate parameter properties. You can then manually control the value of the variable from the modifier parameter, as a slider. You can add as many variables to the parameter properties as you want.

> 图片已省略：Material Parameter modifier map properties

#### 更新子项

The **更新子项** property is enabled by default. Any children of the shape you attached the Material Parameter modifier to are also affected by the changes you make to your dynamic material instance. By disabling the property, only the shape you attached the modifier to is affected by your changes to the dynamic material instance's variables.

| Material Parameter Properties | 说明 |
| --- | --- |
| **Scalar Parameters** | A map container for scalar variables from your dynamic material instance where you can modify their values. Can contain multiple variables.Example: opacity |
| **Vector Parameters** | A map container for scalar variables from your dynamic material instance where you can modify their values. Can contain multiple variables.Example: color |
| **Texture Parameters** | A map container for scalar variables from your dynamic material instance where you can modify their values. Can contain multiple variables.Example: roughness |
| **更新子项** | When enabled, children of the modified shape are also affected by changes to the dynamic material instance variables. |

### 全局不透明度

You can change the opacity on one or several nested actors using the **全局不透明度** modifier. In the example below, we built every texture under the “Translucent Textures” folder in **Material Designer** and set them to “Translucent.” This ensures they function appropriately with the Global Opacity modifier.

> 图片已省略：Global settings Blend Mode Translucent

The Global Opacity property itself has a proportion value from 0 to 1, with 0 representing completely transparent (invisible) and 1 representing completely opaque (the default).

#### 更新子项

When you enable the **更新子项** property, changing the Global Opacity setting on the modifier applied to the null actor parent updates all the children (like the Image4, Image3, Image2, and Image1 actors in the example image below) as well.

> 图片已省略：Global Opacity modifier, initial

With this setup, you can change your Global Opacity value to less than 1.0 to fade your images. Here is an example with the value set to .2:

> 图片已省略：Global Opacity modifier, opacity lowered

| Global Opacity Properties | 说明 |
| --- | --- |
| **全局不透明度** | Determine the opacity of the modified actors, with a range from 0 to 1, where 0 is fully transparent and 1 is fully opaque. |
| **更新子项** | When enabled, any change to the opacity of the parent updates the opacity of any children accordingly. |

### 半透明优先级

Sorting the visibility of your elements based on where they are in the outliner using the Translucent Priority modifier is a core feature of Motion Design. To accomplish this, you need to make sure your material setting for each actor that needs sorting is set to **Translucent**.

#### 排序模式

Using the **排序模式** property, you have multiple ways to sort your actors using Translucent Priority.

- You can use the **Outliner Top First** or **Outliner Bottom First** options to sort them based on their position in the **Outliner**.
- You can use the **相机距离** option to sort them based on their distance from the camera.
- You can use the **手动** option then set the value of the **Sort Priority** property to a higher or lower number to sort them yourself directly.

##### 大纲顶部优先与大纲底部优先

The image below shows an example using the Outliner Top First option to determine which character sits at the front. We placed the Translucent Priority modifier at the top of the level, and because the Sort Mode is set to Outliner Top First, it automatically assessed the child image actors’ priority based on the order we placed them in the Outliner panel:

> 图片已省略：Translucent Priority - Outliner Top First

Note how the Blend Mode is set to “Translucent.”

> 图片已省略：Translucent Priority - Blend Mode set to Translucent

In this example, to make the middle character appear in the foreground, you move the character's actor (Character2 in the image) above the other actor (Character1) in the Outliner.

> 图片已省略：Translucent Priority, changing Outliner order to change priority

##### 相机距离

The **相机距离** option functions similarly to the Outliner Top First and Outliner Bottom First options, but instead of operating based on the Outliner position, it uses the relative position of the modified actors with respect to the camera in your level. You can adjust the translucent priority by translating the actors inside your level to be closer or further away from the camera.

###### 相机 Actor

When using the Camera Distance option, you can use the **相机 Actor** property to select which camera is the reference for determining translucent priority, using a variety of methods including selecting it in the level editor, the viewport, or the scene.

##### 手动

When you use the **手动**option to set translucent priorities, you should set them on each actor, as opposed to using the automatic sorting seen in the above example image. Any manual assignment has priority over the automatic assignment at the top of the group, as shown in the image below:

> 图片已省略：Translucent Priority, manual option

Setting the manual sort priority of Character3 (the character with the ponytails) to 3 forces it to the foreground. Setting the manual sort priority of Character2 (the character with the ski mask) to 1 forces the character to the back.

#### 排序优先级偏移

The value of the **排序优先级偏移** property is shared across all the Translucent Priority modifiers in your level. It applies an offset to the sorting priority of all modifiers in the level. The default value is 0, no offset.

#### 排序优先级步长

The value of the **排序优先级步长** property is shared across all the Translucent Priority modifiers in your level. It determines the incremental steps for all the Translucent Priority modifiers in your level. The default value is 1.

#### 包含子项

You can enable the **包含子项** property to automatically include any children of an actor you are sorting using Translucent Priority

| Translucent Priority Properties | 说明 |
| --- | --- |
| **排序模式** | Determines the method for calculating translucent priority. Options are:Outliner Top FirstOutliner Bottom First相机距离手动 |
| **相机 Actor** | Only available when the Sort Mode is set to Camera Distance. Provides a way to select the camera actor used to orient your translucent priority sorting. |
| **Sort Priority** | Only available when the Sort Mode is set to Manual. Determines the manual translucent sort priority. |
| **排序优先级偏移** | Adds an offset to the translucent sort priority. The value of the property is shared for all Translucent Priority modifiers in your level. |
| **排序优先级步长** | Determines the incremental steps for setting Translucent Priority. The default value is 1. |
| **包含子项** | When enabled, children of the actor modified by the Translucent Priority modifier are also affected. |

### 可见性

The **可见性**modifier provides a way for you to select a group of actors and control their visibility, showing or hiding them as you choose.

> 图片已省略：Visibility modifier

#### 索引

The value of the **索引**property is the main method by which you control the visibility of your actors. The index ordering starts at zero (0), and is assigned automatically to the actors in the order they are added to the parent. If you want your index value to line up with a 1, 2, 3 actor count setup, you need to add a “dummy” null actor to occupy the 0 value position in the index.

For this example, the Visibility modifier's Index property is set to 3, so all three actors are visible.

#### 按范围处理

The default behavior of the Visibility modifier is to treat the Index as a range, showing all the actors with an index position equal to or less than the value of the Index property. If instead you only want to see actor 2 when the value in the Index is 2, then you need to disable the **按范围处理** property. If you do so, and select 2 as your Index, you will only see the actor with the index position of 2, similar to the example below:

> 图片已省略：Visibility modifier, treat as range disabled

#### 反转可见性

Conversely, if you want to show everything except the 2nd actor, then you can also enable the **反转可见性** property, which produces a result similar to the image below:

> 图片已省略：Visibility modifier, invert visibility

You can also combine Treat as Range and Invert Visibility to produce a result like the following image. With the Index value set to 1, the modifier hides the first actor due to the inversion, and reveals the two remaining actors due to the Treat as Range property.

> 图片已省略：Visibility modifier, combining properties to hide specific actors

These visibility states are all represented in your Motion Design Outliner on the left side, as shown in this close-up image of the example:

> 图片已省略：Visibility indicated in the Outliner

#### 隐藏时跳过

The **隐藏时跳过** property ensures that hiding the parent actor will hide the children as well. So, if you hide the null actor with the Visibility modifier attached to it, you hide everything. This is the default value, as it is likely to be a common use case.

| Visibility Properties | 说明 |
| --- | --- |
| **索引** | Defines which actors are shown by the Visibility modifier. Each actor is associated with an Index entry based on Outliner order, beginning with 0. |
| **按范围处理** | When enabled, the value of the Index property is treated as a range from 0 to the value. |
| **反转可见性** | When enabled, it reverses the functioning of the Visibility modifier, hiding the actors instead of showing them. |
| 隐藏时跳过 | When enabled, the children of any hidden actors are skipped by the Visibility modifier. |

### 遮罩

You can apply Masks to your shapes using a combination of two modifiers: **Mask Layer (Input)** and **Masked Layer (Output)**. The former is how you create a mask to apply, and the latter is how you apply the mask you created.

You use the Mask Layer (Input) modifier to establish the shape you want to use as a mask. In this example, we use a simple ellipse from the Motion Design shape palette.

> [!NOTE]
> This modifier can only mask shapes that have either a Translucent or Masked material type.

#### 遮罩设置

To set up a masking example, proceed as follows:

- Double-click the **ellipse** in the shape palette to place it at the center of your canvas.
- Shift the ellipse to the left of what you are trying to mask.
- Add the **Mask Layer (Input)** modifier from your palette, as shown in the image below.

> 图片已省略：Select Mask Layer (Input) modifier

The Mask Layer (Input) and Masked Layer (Output) modifiers share properties you can use to define your mask:

> 图片已省略：Shared mask properties

#### 可视化遮罩

Clicking the **可视化遮罩** button shows you a new window that displays your mask in isolation, helping you better understand the mask and how it will look in your level. The new window provides a summary of all the pertinent information about your mask.

> 图片已省略：Visualize mask

#### 写入操作（添加与相减）

You can use the Write Operation property to determine whether your masks Add or Subtract from other masks. You can use as many masks as you need to achieve the desired effect.

#### 反转

You can enable the **反转**property to reverse the function of your mask. Visible sections will become invisible, and vice versa.

#### 通道属性

You can assign your Mask to a channel using the **通道**property. This is useful when you have several masks in your level and need for them to only interact with specific actors that have different mask assignments.

When nesting your masks, you can enable the **Use Parent Channel** property to cause nested child masks in the Motion Design Outliner to use the same channel as their parent mask, but this disables manually assigning channels yourself using the Channel property.

#### 应用模糊与羽化

You can also blur and feather your mask using the Apply Blur and Apply Feather properties:

> 图片已省略：Mask Apply Blue and Apply Feather

##### 模糊强度

When you enable Apply Blur, you can use the **模糊强度** property to control how much blur is applied.

##### 外羽化半径与内羽化半径

When you enable Apply Feather, you can use the **Outer Feather Radius** and **Inner Feather Radius** properties to control the size of the effect.

#### 应用遮罩

Now that you have a shape dedicated to act as the Mask Layer (Input), you need to select some actors to mask using the Masked Layer (Output) modifier. You can do this on individual actors or on a null actor acting as a parent. When you apply the Masked Layer (Output) modifier to your actors, the mask(s) defined by your Mask Layer (Input) modifiers with the same channel are automatically applied.

| Mask Modifier Properties | 说明 |
| --- | --- |
| **Write Operation** | Determines whether masks add or subtract from other masks. Options are:Add相减 |
| **Use Parent Channel** | When enabled, nested masks use the channel of their parent. |
| **通道** | Defines the channel used for the associated mask. |
| **反转** | Inverts mask visibility, so hidden areas are visible, and visible areas are hidden. |
| **Apply Blur** | Enable to apply a blur effect. |
| **模糊强度** | Determines the strength of the blur effect. The default value is 16. |
| **Apply Feather** | Enable to apply a feather effect. |
| **Outer Feather Radius** | Determines the outer radius of the feather effect. The default value is 16. |
| **Inner Feather Radius** | Determines the inner radius of the feather effect. The default value is 16. |

## 过渡逻辑

You can use the **子层** modifier to identify the groups in your level to associate with a specific 过渡逻辑 Sub Layer.

> 图片已省略：过渡逻辑 Sub Layer modifier

### 子层

After adding a Sub Layer modifier to your actor, you can select animations for the **Change In** and **Change Out** properties. Your selection options populate based on the animations you create and add to [Sequencer](../../../animating-characters-and-objects/cinematics-and-movie-making/index.md).

> 图片已省略：Sub Layer selection options

To use the 过渡逻辑 Sub Layer modifier, you must first create animations in Sequencer. The sequences in the previous image's modifier dropdown list match those in the image below:

> 图片已省略：Sequencer animations for Sub Layer example

#### 进入变化与退出变化

The **Change In** and **Change Out** properties function similarly. Change In determines the animation used to transition to your modified actor, and Change Out determines the animation used to transition away from your modified actor.

| Sub Layer Properties | 说明 |
| --- | --- |
| **Change In** | Determines the animation used to transition to your modified actor. |
| **Change Out** | Determines the animation used to transition away from your modified actor. |

