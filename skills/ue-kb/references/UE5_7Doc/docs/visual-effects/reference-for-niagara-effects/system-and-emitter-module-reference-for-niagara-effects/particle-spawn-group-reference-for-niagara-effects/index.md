---
title: "粒子生成组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/particle-spawn-group-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "粒子生成组"]
---

# 粒子生成组

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 粒子生成组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/particle-spawn-group-reference-for-niagara-effects-in-unreal-engine

每创建一个粒子，都会生成一个 **粒子生成** 模块。本章节中的模块用于为各个粒子设置初始值。如果设置了 **使用内插生成(Use Interpolated Spawning)**，则某些粒子生成模块会在粒子生成阶段而非粒子更新阶段更新。模块按照从堆栈顶部到底部的顺序执行。

在本文中，每种模块都有相应的小节进行介绍，并附有列表说明其可用的默认选项。记住，你可以为Niagara发射器的任何部分创建自定义模块。此处仅列出虚幻引擎4中自带的模块。

## 光束模块

| 模块 | 说明 |
| --- | --- |
| **光束宽度（Beam Width）** | 该模块控制生成光束的宽度，并将该宽度写入 **Particles.RibbonWidth** 参数。要改变沿光束长度的宽度，使用索引到 **Particles.RibbonLinkOrder** 中的曲线，默认生成光束模块中提供该曲线。 |
| **生成光束（Spawn Beam）** | 该模块沿贝塞尔样条或直接沿两点间的直线放置粒子。该参数对面向光束式路径的sprite有用，或与经典式光束的条带渲染器一起使用。生成光束会创建不会重新计算每帧起点和终点的静态光束。 |

## 摄像机模块

| 模块 | 说明 |
| --- | --- |
| **摄像机偏移（Camera Offset）** | 该模块在粒子与摄像机之间沿向量偏移粒子。 |
| **保持摄像机粒子比例（Maintain in Camera Particle Scale）** | 通过考虑摄像机的FOV、粒子的摄像机相对深度和渲染目标的大小，此模块可保持摄像机内的粒子大小。 |

## 混沌模块

| 模块 | 说明 |
| --- | --- |
| **应用混沌数据（Apply Chaos Data）** | 此模块通过混沌解算器设置粒子的位置、速度和颜色。 |

## 颜色模块

| 模块 | 说明 |
| --- | --- |
| **颜色（Color）** | 此模块直接设置 **Particles.Color** 参数，以及Float3颜色和标量Alpha组件的比例因子。 |

## 事件模块

| 模块 | 说明 |
| --- | --- |
| **生成位置事件（Generate Location Events）** | 此模块生成包含粒子位置的事件。每个粒子的事件负载还包含粒子速度、可用于创建每个粒子条带ID的粒子ID、事件生成粒子的存在时间以及能够以各种方式使用的随机数。 此模块位于解算力和速度模块之后，因此事件可同时包含位置和速度数据。 |

## 力模块

| 参数 | 说明 |
| --- | --- |
| **加速力（Acceleration Force）** | 添加到 **Physics.Force** 参数，其将在解算器中平移到加速中。 |
| **应用初始力（Apply Initial Forces）** | 此模块将旋转力和线性力（例如旋度噪点力）转换为旋转速度和线性速度。 |
| **留英力（Curl Noise Force）** | 添加到使用留英域的 **Physics.Force** 参数。通常对中等分辨率烘烤的平铺留英域进行采样，也可选择直接对perlin派生的旋度函数进行采样，但开销会更大。 |
| **拖动（Drag）** | 无视质量，将拖动直接应用于粒子速度和/或旋转速度。累加到 **Physics.Drag** 和 **Physics.RotationalDrag**中，将在 **解算力和速度（Solve Forces and Velocity）** 和 **解算旋转力和速度（Solve Rotational Forces and Velocity）** 模块中解算二者。 |
| **重力（Gravity Force）** | 将重力（以cm/s计）应用于 **Physics.Force** 参数。 |
| **限制力（Limit Force）** | 若 **Physics.Force** 参数超出力限制，则将该参数缩小到指定量级。 |
| **线吸引力（Line Attraction Force）** | 向线条段上最近位置累加拉力，并将其添加到 **Physics.Force** 参数。 |
| **线性力（Linear Force）** | 将力向量（以cm/s计）添加到特定坐标空间中的 **Physics.Force** 参数。 |
| **网格体旋转力（Mesh Rotation Force）** | 根据yaw、pitch和roll轴上应用的牛顿添加旋转力，并将该值累加到 **Physics.RotationalForce** 参数。 |
| **点吸引力（Point Attraction Force）** | 把对于 **AttractorPosition** 的拉力累加到 **Physics.Force** 参数中。 |
| **点力（Point Force）** | 使用可选衰减在空间中添加任意点内的力。使用速度原点与 **Particles.Position** 参数之间的向量来确定力向量。若尚未初始化位置（即粒子位置与速度原点相互叠加），则该模块将注入随机速度。应将此模块置于堆栈中任意位置模块之后，确保初始化粒子位置。 |
| **向量噪点力（Vector Noise Force）** | 该模块将随机噪点引入 **Physics.Force** 参数。 |
| **旋涡力（Vortex Force）** | 选取绕旋涡轴的速度（可额外选取向旋涡原点的拉力），并将其注入到 **Physics.Force** 参数。 |
| **风力（Wind Force）** | 将风力应用到粒子，同时可选 **空气阻力（Air Resistance）** 参数。若和风同向的粒子移动速度快于风速，则不施加额外的力。 |

## 初始化模块

| 模块 | 说明 |
| --- | --- |
| **初始化粒子（Initialize Particle）** | 该模块包含数个常用粒子参数，可按需启用或禁用。包含 **点属性（Point Attributes）**（例如 **生命周期**、**位置**、**质量** 和 **颜色**）、**Sprite属性（Sprite Attributes）**（例如 **Sprite大小** 和 **Sprite旋转**）和 **网格体属性（Mesh Attributes）**（例如 **网格体缩放**）。在粒子生成组中，该模块应位于堆栈顶部。 |
| **初始化条带（Initialize Ribbon）** | 该模块包含条带的数个常见参数。其与初始化粒子模块一样具有 **点属性**，但额外有 **条带属性（Ribbon Attributes）**，例如 **条带宽度** 和 **条带扭转**。在粒子生成组中，该模块应位于堆栈顶部。 |

## 去除模块

| 模块 | 说明 |
| --- | --- |
| **去除粒子（Kill Particles）** | 若设置为True（即勾选复选框），则此开关会去除所有粒子。根据这个布尔值，你可以在执行堆栈的任何位置去除粒子。 |
| **去除体积中的粒子（Kill Particles in Volume）** | 如果粒子位于一系列分析形状内，则去除这些粒子。它可以与盒体、平面、平板（两个面向内的平面）或球体进行比较。结果也可反转。 如果你在粒子更新中使用此模块，则应启用 **插值生成（Interpolated Spawn）**。否则，粒子将为某个帧生成，然后消亡。 |

## 位置模块

| 模块 | 说明 |
| --- | --- |
| **盒体位置（Box Location）** | 该模块生成矩形盒体形状的粒子。 |
| **椎体位置（Cone Location）** | 该模块生成椎体形状的粒子。 |
| **圆柱体位置（Cylinder Location）** | 该模块生成圆柱体形状的粒子，并利用Lathe式功能按钮来修改圆柱体的轮廓。 |
| **网格位置（Grid Location）** | 该模块在网格上生成均匀分布的粒子。 |
| **抖动位置（Jitter Position）** | 该模块根据延时定时器在随机方向上抖动生成粒子。 |
| **绕点旋转（Rotate Around Point）** | 该模块将在用户定义中心点周围的向前向量对齐圆上寻找位置。该圆的半径和位置将随时间发生改变。 |
| **骨架网格体位置（Skeletal Mesh Location）** | 用于将粒子放置在骨架网格体的骨骼、插槽、三角形或顶点上。 |
| **球体位置（Sphere Location）** | 该模块将生成球形粒子，同时可选择半球形状和密度。 |
| **静态网格体位置（Static Mesh Location）** | 该模块将在静态网格体的表面上生成粒子。 |
| **系统位置（System Location）** | 该模块在系统的位置中生成粒子。 |
| **圆环位置（Torus Location）** | 该模块将生成圆环形粒子。 |

## 质量模块

| 模块 | 说明 |
| --- | --- |
| **按体积计算质量和旋转惯性（Calculate Mass and Rotational Inertia by Volume）** | 该参数根据粒子的边界和密度值计算质量和旋转惯性。密度单位为千克/立方米。 |
| **按质量计算尺度和旋转惯性（Calculate Size and Rotational Inertia by Mass）** | 根据用户驱动质量和密度值计算粒子的缩放和旋转惯性。密度单位为千克/立方米。 |

## 材质模块

| 模块 | 说明 |
| --- | --- |
| **动态材质参数（Dynamic Material Parameters）** | 此类参数写入材质编辑器中的动态参数顶点内插器（Dynamic Parameter Vertex Interpolator）节点。要使用索引1-3，请在材质编辑器中将节点自身的 **参数索引（Parameter Index）** 更改为相应编号。利用此参数，可在给定材质中使用最多四个唯一动态参数节点。 |

## 数学/混合模块

| 模块 | 说明 |
| --- | --- |
| **椎体遮罩（Cone Mask）** | 该模块在三维空间中定义椎体，并检查位置输入是否位于椎体内。若位置位于椎体内，其将返回 **1**；否则返回 **0**。 |
| **插值粒子属性（Lerp Particle Attributes）** | 该模块支持所有默认粒子参数的线性内插（lerp）。可选择特定参数来对各默认粒子参数内插，还可选择内插因子对各默认粒子参数内插。 |
| **重新创建摄像机投射（Recreate Camera Projection）** | 该模块会重新创建2D场景采集像素的相对于摄像机的场景位置。利用投影变换，你可以重新定位和旋转投射位置。 |
| **临时插值浮点（Temporal Lerp Float）** | 该模块根据用户指定 **当前值** 随时间执行缓慢线性插值。通过 **变化率（Rate of Change）** 输入指定收敛速率。 |
| **临时插值向量（Temporal Lerp Vector）** | 该模块根据用户指定 **当前值** 随时间执行缓慢线性内插（lerp）。通过 **变化率（Rate of Change）** 输入指定收敛速率。 |

## 网格体模块

| 模块 | 说明 |
| --- | --- |
| **初始化网格体复制Sprite（Initialize Mesh Reproduction Sprite）** | 该模块首先在骨架网格体上随机选择位置。然后使用选定三角形来计算所需粒子大小、UV缩放、sprite对齐等。为使粒子与网格体表面正确对齐，应将sprite的 **渲染对齐（Render Alignment）** 设为 **自定义对齐（Custom Alignment）**，并将 **朝向模式（Facing Mode）** 设为 **自定义朝向（Custom Facing）**。然后将 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设为 **1，1，1**。 若网格体未设置动画，可勾选 **覆盖固有变量（Overwrite Intrinsic Variables）** 复选框来设置粒子系统的所有固有参数。若要在效果期间更新朝向模式（Facing Mode），切勿勾选 **覆盖固有变量（Overwrite Intrinsic Variables）** 复选框。换为将 **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** 模块添加到粒子更新组中。在材质中，使用 **Niagara_MeshReproductionSpriteUVs** 对网格体的UV进行采样。 **初始化网格体复制Sprite（Initialize Mesh Reproduction Sprite）** 模块和 **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** 模块均假设骨架网格体UV为平方，且未在轴上压缩。 |
| **采样骨架网格体骨架（Sample Skeletal Mesh Skeleton）** | 该模块对骨架网格体的骨骼或插槽采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **采样骨架格体表面（Sample Skeletal Mesh Surface）** | 该模块对骨架网格体的表面采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **采样静态网格体（Sample Static Mesh）** | 该模块对静态网格体行采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** | 该模块与初始化网格体复制Sprite模块一起使用。要在Niagara关卡的内容范例中重新创建该效果，请执行以下步骤： 将 **初始化网格体复制Sprite（Initialize Mesh Reproduction Sprite）** 模块放置在 **粒子生成（Particle Spawn）** 组中。 将 **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** 模块放置在 **粒子更新（Particle Update）** 组中。 在Sprite渲染器中，将 **对齐（Alignment）** 设为 **自定义对齐（Custom Alignment）**；将 **朝向模式（Facing Mode）** 设为 **自定义朝向向量（Custom Facing Vector）**；将 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设为 **1，1，1**。 在材质中，使用 **Niagara网格体复制Sprite UV** 对网格体的UV进行采样。 若 **Module.OverwriteIntrinsicVariables** 设为 **False**，确保该模块的输出变量驱动粒子的属性（例如位置、对齐等）。 |

## 朝向模块

| 模块 | 说明 |
| --- | --- |
| **将Sprite与网格体朝向对齐（Align Sprite to Mesh Orientation）** | 该模块将sprite与网格体粒子的朝向对齐。利用此参数可使用 **网格体旋转（Mesh Rotation）** 和 **旋转速度（Rotational Velocity）** 模块来控制sprite的对齐和场景的关系。确保Sprite渲染器中的 **对齐（Alignment）** 和 **朝向模式（Facing Mode）** 设置分别设为 **自定义对齐（Custom Alignment）** 和 **自定义朝向（Custom Facing）**。将 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设为 **1，1，1**。 |
| **初始网格体朝向（Initial Mesh Orientation）** | 该模块将网格体与向量对齐，或使用旋转向量将其旋转到位。 |
| **将网格体朝向向量（Orient Mesh to Vector）** | 该模块将网格体与输入向量对齐。 |

## 物理模块

| 模块 | 说明 |
| --- | --- |
| **添加旋转速度（Add Rotational Velocity）** | 该模块添加到用户定义空间中的 **旋转速度（Rotational Velocity）** 值。 |
| **查找动能和势能（Find Kinetic and Potential Energy）** | 该模块返回以下内容： 基于粒子速度的粒子动能。 粒子的势能，即写入 **Physics.PotentialEnergy** 的所有力模块的总和。 1和2的总和。 |

## SubUV模块

| 模块 | 说明 |
| --- | --- |
| **SubUVAnimation** | 某些Sprite在网格中制作，每个单独的Sprite代表一个动画帧。此模块接受要进行动画处理的Sprite的总数，并沿着曲线绘制这些Sprite，以便Sprite顺利完成动画处理。 |

## 纹理模块

| 模块 | 说明 |
| --- | --- |
| **取样伪体积纹理（Sample Pseudo Volume Texture）** | 此模块根据UVW坐标取样伪体积纹理的颜色。 |
| **取样纹理（Sample Texture）** | 此模块在特定的UV位置取样纹理，然后返回该纹理部分的颜色。 此模块仅在GPU模拟中受支持。 |
| **子UV纹理取样（Sub UV Texture Sample）** | 此模块以行列方式取样单个纹理像素。此模块采用阶段 0-1，并从中找到行列索引，然后在具有该UV索引的纹理中取样像素。 |
| **场景对齐纹理取样（World Aligned Texture Sample）** | 此模块根据粒子位置取样纹理的颜色，与材质编辑器中的世界对齐纹理的行为方式非常类似。 |

## 工具模块

| 模块 | 说明 |
| --- | --- |
| **执行一次（Do Once）** | 此模块跟踪其触发条件在上一帧中是否为True。若为否，则 **Particles.Module.Execute** 将返回True。若触发条件已在上一帧中返回True，则 **Particles.Module.Execute** 将返回False。 |
| **随时间递增（Increment Over Time）** | 此模块按每帧增加数值。计数器变量通过使用标记增量值并将其乘以用户指定比率来递增。 |
| **更新MS顶点动画工具变换目标（Update MS Vertex Animation Tools Morph Targets）** | 此模块读取变换目标的纹理数据，然后针对给定的每粒子像素索引输出位置和法线向量。将模块的场景空间法线输出输入到资产的材质中，并且在材质中禁用切线空间法线，以便复制网格体的表面。 有关生成变换目标纹理的更多信息，请参见[顶点动画工具](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/vertex-animation-tool/index.md)。 此模块可直接设置粒子的位置。如果你以这种方式使用它，请勿使用直接设置粒子位置的其他模块。 |

## 向量场模块

| 模块 | 说明 |
| --- | --- |
| **应用向量场（Apply Vector Field）** | 此模块通过向量场取样器获取向量样本，并将其作为力或速度应用。 |
| **取样向量场（Sample Vector Field）** | 此模块取样向量场，并应用逐粒子强度因子和可选衰减因子，该衰减因子将弱化向量场对边界框边缘的影响。这样可以选择性地应用局部平移、旋转或缩放变换。 |

## 速度模块

| 模块 | 说明 |
| --- | --- |
| **添加速度（Add Velocity）** | 此模块向已生成粒子分配速度。你可以添加各种动态输入，以修改在此模块中输入的值。 |
| **添加点中速度（Add Velocity from Point）** | 此模块可从空间中的任意点添加速度，并具有可选衰减。此模块使用速度原点和粒子位置之间的向量以确定速度向量。若尚未初始化粒子位置（导致粒子位置和速度原点过于靠近），则此模块将注入随机速度。为了获取最准确的结果，请将此模块放置在堆栈中位置模块的下方。这样可确保粒子位置已初始化。 |
| **在椎体中添加速度（Add Velocity in Cone）** | 该模块将速度添加到椎体形状中的 **Particles.Velocity** 参数，并具有椎体角度参数和沿椎体轴的速度分布的参数。 |
| **继承速度（Inherit Velocity）** | 此模块添加来自另一个源的继承速度。该源默认为拥有当前发射器的系统的位置。 |
| **缩放速度（Scale Velocity）** | 此模块将 **Particles.Velocity** 与特定坐标空间中的单独向量相乘。 |
| **静态网格体速度（Static Mesh Velocity）** | 此模块根据来自静态网格体的法线添加速度，此外还可以添加静态网格体的继承速度。 |
| **涡旋速度（Vortex Velocity）** | 此模块计算绕涡轴的角速度，并将其注入到 **Particles.Velocity** 参数中。这会添加到粒子在生成时所具有的初始速度。 |

## 新建暂存区模块

在 **添加（Add）**（加号）菜单中选择此项目将打开 **暂存区（Scratch Pad）** 面板（默认情况下，此面板位于 **系统概览（System Overview）** 旁），然后在 **选择（Selection）** 面板中放置 **暂存区模块**。你还可使用 **Windows > 暂存区（Windows > Scratch Pad）** 来打开暂存区面板。但是，在堆栈中放置暂存区模块之后，你在暂存区中创建的所有模块或动态输入都将自动连接到脚本。如果你使用Windows菜单打开了暂存区面板，则你在其中创建的所有项目都必须手动添加到脚本。

## 直接设置新值或现有值

从 **添加（Add）**（加号）菜单中选择此项目将在 **选择（Selection）** 面板中放置 **设置参数（Set Parameter）** 模块。单击 **加号（Plus sign）**（**+**）图标，以选择 **添加参数（Add Parameter）** 或 **新建参数（Create New Parameter）**。

### 添加参数

选择 **添加参数（Add Parameter）** 后，你可以在列出的参数中进行选择。此操作会将参数添加到粒子生成（Particle Spawn）组中的 **设置参数（Set Parameter）** 模块中。

> [!NOTE]
> 部分参数可在其他模块中设置或修改。其余仅可使用设置变量（Set Variable）模块设置。

| 参数 | 说明 |
| --- | --- |
| **DataInstance.Alive** | 此参数用于决定该粒子实例是否有效或可否删除。 |
| **Particles.Age** | 此参数定义粒子的年龄。 |
| **Particles.CameraOffset** | 此参数设置粒子的摄像机偏移（Camera Offset）。摄像机偏移决定粒子与摄像机之间的距离。 |
| **Particles.Color** | 此参数直接设置粒子的颜色。 |
| **Particles.DynamicMaterialParameter** | 此为用于向渲染器发送数据的四浮点向量。 |
| **Particles.DynamicMaterialParameter1** | 此为用于向渲染器发送数据的四浮点向量。 |
| **Particles.DynamicMaterialParameter2** | 此为用于向渲染器发送数据的四浮点向量。 |
| **Particles.DynamicMaterialParameter3** | 此为用于向渲染器发送数据的四浮点向量。 |
| **Particles.ID** | 此为向各生成粒子提供固定ID的引擎管理属性。 |
| **Particles.Initial.Color** | 此参数设置粒子的初始颜色。 |
| **Particles.Lifetime** | 此参数是生成粒子的生命周期（以秒计）。 |
| **Particles.LightRadius** | 此参数决定使用光源渲染器时发射光线的半径。 |
| **Particles.Mass** | 此参数决定生成粒子的质量。 |
| **Particles.MaterialRandom** | 此参数用于在材质编辑器中驱动 **粒子随机值（Particle Random）** 节点。如未设置此参数，粒子随机值将获得 **0.0**。 |
| **Particles.MeshOrientation** | 此参数决定应用于生成网格体粒子的轴-角旋转。 |
| **Particles.NormalizedAge** | 此参数是 **Particles.Age**（以秒计）除以 **Particles.Lifetime** 值（以秒为单位）所得的值。由于生成值在 **0** 与 **1** 之间，因此该参数适用于动画。 |
| **Particles.Position** | 此参数设置生成粒子的位置。 |
| **Particles.PreviousVelocity** | 此参数与 **解算力和速度（Solve Forces And Velocity）** 模块一起用于计算粒子位置以响应力和速度。解算加速需要之前的速度。 |
| **Particles.RibbonFacing** | 此参数将根据选择的 **朝向模式（Facing Mode）**，设置条带粒子位置处条带的朝向向量，或条带宽度延伸的边向量。 |
| **Particles.RibbonID** | 此参数向条带粒子指定 **条带ID（Ribbon ID）**。具有相同条带ID的粒子连接到条带中。 |
| **Particles.RibbonLinkOrder** | 此参数设置用于在条带中关联粒子的显式顺序。具有相同条带ID的粒子按照该值的递增顺序连接到条带中。 |
| **Particles.RibbonTwist** | 此参数设置条带粒子拥有的扭转量（以度计）。 |
| **Particles.RibbonWidth** | 此参数设置条带粒子的宽度（以UE4单位计）。 |
| **Particles.Position** | 此参数设置非sprite粒子的XYZ缩放。 |
| **Particles.SpriteAlignment** | 此参数将纹理点朝向sprite的选定对齐轴。使用此参数时，Sprite渲染器的 **对齐（Alignment）** 必须设为 **自定义对齐（Custom Alignment）**。 |
| **Particles.SpriteFacing** | 此参数将sprite的表面朝向自定义向量。要使用此参数，Sprite渲染器的 **朝向模式（Facing Mode）** 必须设为 **自定义朝向向量（Custom Facing Vector）**，同时必须在Sprite渲染器的 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设置中提供值。 |
| **Particles.SpriteRotation** | 此参数设置粒子的屏幕对齐roll（以度计）。 |
| **Particles.SpriteSize** | 此参数决定sprite粒子的四边形大小。 |
| **Particles.SubImageIndex** | 此参数设置介于0到SubUV图像表中条目数之间的值。 |
| **Particles.UniqueID** | 此参数为用作各生成粒子唯一ID的引擎管理属性。各新生成粒子的ID将递增。 |
| **Particles.UVScale** | 此参数用于增量Sprite渲染器的生成UV。 |
| **Particles.Velocity** | 此参数决定粒子的速度（以厘米/秒（cm/s）计）。 |

### 新建参数

选择 **新建参数（Create New Parameter）** 后，你可以在列出的参数中进行选择。此操作会将参数添加到粒子生成（Particle Spawn）组中的 **设置参数（Set Parameter）** 模块中。

| 参数 | 类型 | 说明 |  |
| --- | --- | --- | --- |
| **音频示波器（Audio Oscilloscope）** | **数据接口（Data Interface）** | 此参数向发射器添加新的音频示波器数据接口模块。此音频示波器模块可直接访问音频信号的波形数据。 |  |
| **音频频谱（Audio Spectrum）** | **数据接口（Data Interface）** | 此参数向发射器添加新的音频频谱数据接口模块。此音频频谱模块可以根据音频在特定频率下的响度来驱动可视化。 |  |
| **布尔（Bool）** | **基元（Primitive）** | 此参数添加具有true/false复选框的 **设置变量（Set Variable）** 模块。 |  |
| **摄像机查询（Camera Query）** | **数据接口（Data Interface）** | 此参数向发射器添加新的摄像机查询数据接口模块。此数据接口可以用于检索指定控制器索引的摄像机信息（例如摄像机位置、旋转、或FOV）。 |  |
| **碰撞查询（Collision Query）** | **数据接口（Data Interface）** | 此参数向发射器堆栈添加碰撞数据接口。此参数常与碰撞模块配合使用。 |  |
| **旋度噪点（Curl Noise）** | **数据接口（Data Interface）** | 此参数向发射器堆栈添加旋度噪点数据接口。若将此参数与旋度噪点力模块配合使用，此数据接口会将不同类型的噪点注入模拟。 |  |
| **彩色曲线（Curve for Colors）** | **数据接口（Data Interface）** | 此参数为模拟添加四通道彩色曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的颜色。 |  |
| **浮点曲线（Curve for Floats）** | **数据接口（Data Interface）** | 此参数为模拟添加单通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值。 |  |
| **向量2D曲线（Curve for Vector 2Ds）** | **数据接口（Data Interface）** | 此参数为模拟添加双通道曲线数据接口。你可以通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值对。 |  |
| **向量三通道曲线（Curve for Vector 3s）** | **数据接口（Data Interface）** | 此参数为模拟添加三通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值集。 |  |
| **向量四通道曲线（Curve for Vector 4s）** | **数据接口（Data Interface）** | 此参数为模拟添加四通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值集。 |  |
| **ENiagaraBooleanLogicOps** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于通过以下布尔逻辑进行测试： **大于** **大于或等于** **等于** **不等于** |  |
| **ENiagaraCoordinateSpace** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于区分坐标空间： **模拟（Simulation）**：如果已将发射器设置为本地，则请使用本地。否则使用世界。 **世界（World）**：在游戏的世界空间内。 **本地（Local）**：在所属组件的坐标空间内。 |  |
| **ENiagaraExecutionState** | **枚举（Enum）** | 管理系统或发射器执行状态的参数（例如Emitter.ExecutionState或System.ExecutionState）将使用此列举类型。 |  |
| **ENiagaraExecutionStateSource** | **列举（Enum）** | 指示执行状态设置的源。它用于允许可延展性更改状态，但只有在状态尚未被具有更高优先权的对象所定义时才有效。 |  |
| **ENiagaraExpansionMode** | **枚举（Enum）** | 此枚举供位置模块使用，用于确定扩展的起始点所在： **内部（Inside）** **居中（Centered）** **外部（Outside）** |  |
| **ENiagaraOrientationAxis** | **枚举（Enum）** | 此枚举供数个模块使用，用于确定使用哪个轴进行计算： **X轴（X Axis）** **Y轴（Y Axis）** **Z轴（Z Axis）** |  |
| **ENiagaraRandomnessMode** | **枚举（Enum）** | 设置此发射器使用的随机数生成类型。有效选择有： **模拟默认值（Simulation Defaults）** **确定性（Deterministic）** **非确定性（Non-Deterministic）** |  |
| **浮点（Float）** | **基元（Primitive）** | 此参数创建浮点值变量。 |  |
| **网格2D收集（Grid 2D Collection）** | **数据接口（Data Interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入2D数据数组，然后在模拟阶段期间迭代网格中的每个像素。 |  |
| **Int32** | **基元（Primitive）** | 此参数创建整数变量。 |  |
| **线性颜色（Linear Color）** | **基元（Primitive）** | 此参数创建以取色器形式表示的RGBA颜色变量。 |  |
| **矩阵（Matrix）** | **基元（Primitive）** | 此参数创建4x4矩阵变量。 |  |
| **网格体三坐标（Mesh Tri Coordinate）** | **结构体（Struct）** | 这是一个简单的结构体，它包含了三角形指数以及该三角形面上的重心坐标。 |  |
| **相邻网格3D（Neighbor Grid3D）** | **数据接口（Data Interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入3D数据数组，然后在模拟阶段期间迭代体积中的每个像素。 |  |
| **Niagara ID** | **结构体（Struct）** | 此参数是用于追踪粒子的两部分结构体。用于快速访问该粒子的数据。该粒子在现存粒子中始终具有唯一性，但该粒子消逝后会被重用。**AcquireTag** 是获取此ID时的唯一标签。当一个粒子消亡且另一个粒子重新使用消亡粒子的索引时，利用该标签可对这两个粒子进行区分。 |  |
| **遮挡查询（Occlusion Query）** | **数据接口（Data Interface）** | 此参数将向发射器添加新的遮挡查询数据接口模块。此数据接口用于读取深度缓冲遮挡信息。 它只能与GPU发射器一起使用。 |  |
| **粒子属性读取器（Particle Attribute Reader）** | **数据接口（Data Interface）** | 此参数向发射器添加新的粒子属性读取器数据接口。此数据接口不仅可用于查询来自其他发射器的粒子有效荷载值，而且有时比事件更易于使用。 |  |
| **四元数（Quat）** | **基元（Primitive）** | 此参数创建四元数变量，用于代表旋转。 |  |
| **简单计数器（Simple Counter）** | **数据接口（Data Interface）** | 此参数将向发射器添加新的简单计数器数据接口模块。此数据接口将使你能够指令线程安全计数器递增计数。 它只能与CPU发射器一起使用。 |  |
| **骨架网格体（Skeletal Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与骨架网格体的骨骼/套接字和蒙皮几何体交互。 |  |
| **生成信息（Spawn Info）** | **结构体（Struct）** | 此参数是生成所用的结构体，以指定要创建的粒子 **数量（Count）**、从当前帧开始时间到开始生成之间的 **InterpStartDt** 或偏移、定义粒子生成时间间隔的 **IntervalDt**，以及可将生成粒子归属于不同类别的 **SpawnGroup**。 |  |
| **样条（Spline）** | **数据接口（Data interface）** | 这是一个数据接口，能够与样条资源交互。 |  |
| **静态网格体（Static Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与静态网格体的表面交互。 |  |
| **纹理取样（Texture Sample）** | **数据接口（Data interface）** | 这是一个数据接口，能够与GPU上的纹理交互。 |  |
| **向量（Vector）** | **基元（Primitive）** | 此参数创建三通道浮点值集。 |  |
| **向量2D（Vector 2D）** | **基元（Primitive）** | 此参数创建双通道浮点值集。 |  |
| **向量4（Vector 4）** | **基元（Primitive）** | 此参数创建四通道浮点值集。 |  |
| **向量场（Vector Field）** | **数据接口（Data interface）** | 这是一个数据接口，能够查询向量场。 |  |
| **体积纹理取样（Volume Texture Sample）** | **数据接口（Data Interface）** | 此参数向发射器添加新的体积纹理数据接口模块。 你可以使用此参数来进行体积纹理取样。 |  |
