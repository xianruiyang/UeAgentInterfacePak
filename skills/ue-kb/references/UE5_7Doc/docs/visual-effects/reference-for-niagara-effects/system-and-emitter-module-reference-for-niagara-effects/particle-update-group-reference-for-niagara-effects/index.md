---
title: "粒子更新组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/particle-update-group-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "粒子更新组"]
---

# 粒子更新组

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 粒子更新组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/particle-update-group-reference-for-niagara-effects-in-unreal-engine

每个粒子每帧都会调用 **粒子更新（Particle Update）** 模块。本文中的模块会在每一帧中更新新的数值。模块在更新时会按照从堆栈顶部到底部的顺序执行。

在本文中，每种模块都有相应的小节进行介绍，并附有表格说明模块的默认可用选项。记住，你可以为Niagara系统或发射器的任意部分创建自定义模块。本文中仅列出虚幻引擎自带的模块/

## 光束模块

| 模块 | 说明 |
| --- | --- |
| **光束宽度缩放（Beam Width Scale）** | 该模块根据用户定义缩放因子缩放初始光束宽度。 |
| **更新光束（Update Beam）** | 该模块沿贝塞尔样条或直接沿两点间的直线放置粒子。对面向光束式路径的sprite有用，或与经典式光束的条带渲染器一起使用。**更新光束（Update Beam）** 重新计算各帧中的样条位置，以允许光束拥有动态变化的起点和终点。 |

## 摄像机模块

| 模块 | 说明 |
| --- | --- |
| **摄像机偏移（Camera Offset）** | 该模块在粒子与摄像机之间沿向量偏移粒子。 |
| **保持摄像机粒子比例（Maintain in Camera Particle Scale）** | 通过考虑摄像机的FOV、粒子的摄像机相对深度和渲染目标的大小，此模块可保持摄像机内的粒子大小。 |

## 碰撞模块

| 模块 | 说明 |
| --- | --- |
| **粒子与碰撞平面对齐（Align Particles with Collision Plane）** | 该模块随时间将sprite与平面对齐。平面默认由碰撞模块的返回碰撞平面定义。使用该模块时，Sprite渲染器中的 **对齐（Alignment）** 设置必须设定为 **自定义对齐（Custom Alignment）**；**朝向模式（Facing Mode）** 必须设定为 **自定义朝向向量（Custom Facing Vector）**；**自定义朝向向量遮罩（Custom Facing Vector Mask）** 必须设定为 **1**、**1**、**1**。 |
| **碰撞（Collision）** | 该模块必须刚好放在解算器模块前面。在CPU发射器中使用时，该模块将发射光线来计算其与场景的碰撞。在GPU发射器中使用时，该模块将使用场景深度或全局距离场来查找碰撞表面。 |

## 颜色模块

| 模块 | 说明 |
| --- | --- |
| **颜色（Color）** | 该模块直接设置 **Particles.Color** 参数，并提供Float3颜色和标量透明度组件的比例因子。 |
| **缩放颜色（Scale Color）** | 该模块默认接受初始颜色（粒子生成组中决定），并分别缩放RGB和Alpha组件。 |
| **按速度缩放颜色（Scale Color by Speed）** | 该模块根据粒子速度向量的量级来缩放粒子颜色，此速度向量设有最小和最大速度阈值。 |

## 约束模块

| 参数 | 说明 |
| --- | --- |
| **两点之间维持设定距离（Maintain a Set Distance Between Two Points）** | 该模块获取两个不同位置：粒子位置和目标位置。该模块将空间中点投射远离初始位置处，即两个位置间向量上的位置。该向量的长度在 **理想距离（Ideal Distance）** 中设置。对于某些情况，可能需切换目标位置和粒子位置变量。 |
| **钟摆约束（Pendulum Constraint）** | 该模块引入非物理性正确的钟摆约束，该约束与力交互。添加 **重力（Gravity Force）** 模块，使其与重力交互；添加 **加速力（Acceleration Force）** 模块，使其与重力以外的加速力交互用；添加 **拖动力（Drag Force）** 模块，使其与粘性摩擦阻力交互。 你必须拥有 **钟摆设置（Pendulum Setup）** 模块才能使用 **钟摆约束（Pendulum Constraint）** 模块。 |
| **钟摆设置（Pendulum Setup）** | 该模块引入非物理性正确的钟摆约束，该约束与力交互。添加 **重力（Gravity Force）** 模块，使其与重力交互；添加 **加速力（Acceleration Force）** 模块，使其与重力以外的加速力交互用；添加 **拖动力（Drag Force）** 模块，使其与粘性摩擦阻力交互。 |

## 事件模块

| 模块 | 说明 |
| --- | --- |
| **生成碰撞事件（Generate Collision Event）** | 该模块在发射器中生成碰撞事件。另一发射器中的[事件处理函数](../../../getting-started-in-niagara-effects/events-and-event-handlers-in-niagara-effects/index.md)稍后可使用此模块，以在系统中产生操作。 |
| **生成死亡事件（Generate Death Event）** | 该模块在发射器中生成死亡事件。另一发射器中的[事件处理函数](https://dev.epicgames.com/documentation/404)稍后可使用此模块，以在系统中产生操作。 |
| **生成位置事件（Generate Location Event）** | 该模块在发射器中生成位置事件。另一发射器中的[事件处理函数](https://dev.epicgames.com/documentation/404)稍后可使用此模块，以在系统中产生操作。 |

## 力模块

| 模块 | 说明 |
| --- | --- |
| **加速力（Acceleration Force）** | 添加到 **Physics.Force** 参数，其将在解算器中平移到加速中。 |
| **施加初始力（Apply Initial Forces）** | 该模块会将旋转力和线性力（例如留英力）转换为旋转速度和线性速度。 |
| **留英力（Curl Noise Force）** | 添加到使用留英域的 **Physics.Force** 参数。通常对中等分辨率烘烤的平铺留英域进行采样，也可选择直接对perlin派生的旋度函数进行采样，但开销会更大。 |
| **拖动（Drag）** | 无视质量，将拖动直接应用于粒子速度和/或旋转速度。累加到 **Physics.Drag** 和 **Physics.RotationalDrag**中，将在 **解算力和速度（Solve Forces and Velocity）** 和 **解算旋转力和速度（Solve Rotational Forces and Velocity）** 模块中解算二者。 |
| **重力（Gravity Force）** | 将重力（以cm/s计）应用于 **Physics.Force** 参数。 |
| **限制力（Limit Force）** | 若 **Physics.Force** 参数超出力限制，则将该参数缩小到指定量级。 |
| **线吸引力（Line Attraction Force）** | 向线条段上最近位置累加拉力，并将其添加到 **Physics.Force** 参数。 |
| **线性力（Linear Force）** | 将力向量（以cm/s计）添加到特定坐标空间中的 **Physics.Force** 参数。 |
| **网格体旋转力（Mesh Rotation Force）** | 根据yaw、pitch和roll轴上应用的牛顿添加旋转力，并将该值累加到 **Physics.RotationalForce** 参数。 |
| **点吸引力（Point Attraction Force）** | 向 **AttractorPosition** 的累加拉力，以拉入 **Physics.Force** 参数中。 |
| **点力（Point Force）** | 使用可选衰减在空间中添加任意点内的力。使用速度原点与 **Particles.Position** 参数之间的向量来确定力向量。若尚未初始化位置（即粒子位置与速度原点相互叠加），则该模块将注入随机速度。应将此模块置于堆栈中任意位置模块之后，确保初始化粒子位置。 |
| **向量噪点力（Vector Noise Force）** | 该模块将随机噪点引入 **Physics.Force** 参数。 |
| **旋涡力（Vortex Force）** | 选取绕旋涡轴的速度（可额外选取向旋涡原点的拉力），并将其注入到 **Physics.Force** 参数。 |
| **风力（Wind Force）** | 将风力应用到粒子，同时可选空气阻力参数。若和风同向的粒子移动速度快于风速，则不施加额外的力。 |

## 去除模块

| 模块 | 说明 |
| --- | --- |
| **去除粒子（Kill Particles）** | 若设置为True（复选框处于勾选状态），则此切换将去除所有粒子。它允许在执行堆栈中的任何位置基于此布尔值动态地去除粒子。 |
| **去除体积中的粒子（Kill Particles in Volume）** | 若粒子位于分析形状中，则该模块将去除粒子。该形状可为盒体、平面、平板（两个朝内的平面）或者球体。结果也可反转。使用该模块时必须启用内插生成，否则生成粒子将在一帧中出现，然后销毁。 |

## 生命周期模块

| 模块 | 说明 |
| --- | --- |
| **粒子状态（Particle State）** | 当粒子的生命周期结束时，该模块负责杀死模拟中的粒子。 |

## 位置模块

| 模块 | 说明 |
| --- | --- |
| **盒体位置（Box Location）** | 该模块生成矩形盒体形状的粒子。 |
| **椎体位置（Cone Location）** | 该模块生成椎体形状的粒子。 |
| **圆柱体位置（Cylinder Location）** | 该模块生成圆柱体形状的粒子，并利用Lathe式功能按钮来修改圆柱体的轮廓。 |
| **网格位置（Grid Location）** | 该模块在网格上生成均匀分布的粒子。 |
| **抖动位置（Jitter Position）** | 该模块根据延时定时器在随机方向上抖动生成粒子。 |
| **绕点旋转（Rotate Around Point）** | 该模块将在用户定义中心点周围的向前向量对齐圆上寻找位置。该圆的半径和位置将随时间发生改变。 |
| **骨架网格体位置（Skeletal Mesh Skeleton Location** | 该模块将在骨架网格体的骨骼、插槽、三角形或顶点位置生成粒子。 |
| **球体位置（Sphere Location）** | 该模块将生成球形粒子，同时可选择半球形状和密度。 |
| **静态网格体位置（Static Mesh Location）** | 该模块将在静态网格体的表面上生成粒子。 |
| **系统位置（System Location）** | 该模块在系统的位置中生成粒子。 |
| **圆环位置（Torus Location）** | 该模块将生成圆环形粒子。 |

## 质量模块

| 模块 | 说明 |
| --- | --- |
| **按体积计算质量和旋转惯性（Calculate Mass and Rotational Inertia by Volume）** | 该参数根据粒子的边界和密度值计算质量和旋转惯性。密度单位为千克/立方米。 |
| **按质量计算尺度和旋转惯性（Calculate Size and Rotational Inertia by Mass）** | 根据用户驱动质量和密度值计算粒子的缩放和旋转惯性。密度单位为千克/立方米。 |
| **质量变化时更新速度（Update Velocity on Mass Change）** | 该模块根据质量差量改变粒子的角速度和线性速度。换言之，若粒子质量增加，粒子将减速；若粒子质量减小，粒子则加速。 |

## 材质模块

| 模块 | 说明 |
| --- | --- |
| **动态材质参数（Dynamic Material Parameters）** | 此类参数写入材质编辑器中的动态参数顶点内插器（Dynamic Parameter Vertex Interpolator）节点。要使用索引1-3，请在材质编辑器中将节点自身的 **参数索引** 更改为相应编号。利用此参数，可在给定材质中使用最多四个唯一动态参数节点。 |

## 数学/混合模块

| 模块 | 说明 |
| --- | --- |
| **椎体遮罩（Cone Mask）** | 该模块在三维空间中定义椎体，并检查位置输入是否位于椎体内。若位置位于椎体内，其将返回 **1**；否则返回 **0**。 |
| **插值粒子属性（Lerp Particle Attributes）** | 该模块支持所有默认粒子参数的线性内插（lerp）。可选择特定参数来对各默认粒子参数内插，还可选择内插因子对各默认粒子参数内插。 |
| **重新创建摄像机投射（Recreate Camera Projection）** | 该模块重新创建场景采集2D像素的摄像机相对场景位置。利用投影仪变换域，可重新定位和旋转投射位置。 |
| **临时插值浮点（Temporal Lerp Float）** | 该模块根据用户指定 **当前值** 随时间执行缓慢线性内插（lerp）。通过 **变化率（Rate of Change）** 输入指定收敛速率。 |
| **临时插值向量（Temporal Lerp Vector）** | 该模块根据用户指定 **当前值** 随时间执行缓慢线性内插（lerp）。通过 **变化率（Rate of Change）** 输入指定收敛速率。 |

## 网格体模块

| 模块 | 说明 |
| --- | --- |
| **采样骨架网格体骨架（Sample Skeletal Mesh Skeleton）** | 该模块对骨架网格体的骨骼或插槽采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **采样骨架格体表面（Sample Skeletal Mesh Surface）** | 该模块对骨架网格体的表面采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **采样静态网格体（Sample Static Mesh）** | 该模块对静态网格体行采样，然后将采样值写入粒子参数。稍后可在堆栈中使用此类粒子参数。 |
| **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** | 该模块与初始化网格体复制Sprite模块一起使用。要在Niagara关卡的内容范例中重新创建该效果，请执行以下步骤： 将 **初始化网格体复制Sprite（Initialize Mesh Reproduction Sprite）** 模块放置在 **粒子生成（Particle Spawn）** 组中。 将 **更新网格体复制Sprite（Update Mesh Reproduction Sprite）** 模块放置到 **粒子更新（Particle Update）** 组中。 在Sprite渲染器中，将 **对齐（Alignment）** 设为 **自定义对齐（Custom Alignment）**；将 **朝向模式（Facing Mode）** 设为 **自定义朝向向量（Custom Facing Vector）**；将 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设为 **1，1，1**。 在材质中，使用 **Niagara网格体复制Sprite UV** 对网格体的UV进行采样。 若 **Module.OverwriteIntrinsicVariables** 设为 **False**，确保该模块的输出变量驱动粒子的属性（例如位置、对齐等）。 |

## 朝向模块

| 模块 | 说明 |
| --- | --- |
| **将Sprite与网格体朝向对齐（Align Sprite to Mesh Orientation）** | 该模块将sprite与网格体粒子的朝向对齐。利用此参数可使用 **网格体旋转（Mesh Rotation）** 和 **旋转速度（Rotational Velocity）** 模块来控制sprite的对齐和场景的关系。确保Sprite渲染器中的 **对齐（Alignment）** 和 **朝向模式（Facing Mode）** 设置分别设为 **自定义对齐（Custom Alignment）** 和 **自定义朝向（Custom Facing）**。将 **自定义朝向向量遮罩（Custom Facing Vector Mask）** 设为 **1，1，1**。 |
| **将网格体朝向向量（Orient Mesh to Vector）** | 该模块将网格体与输入向量对齐。 |
| **Sprite旋转率（Sprite Rotation Rate）** | 该模块随时间旋转sprite。默认输入以度计。若需要输入范围为0-1，可添加动态输入 **将角度标准化为度（Normalized Angle to Degrees）**。 |
| **更新网格体朝向（Update Mesh Orientation）** | 该模块随时间旋转网格体朝向参数。 |

## 物理模块

| 模块 | 说明 |
| --- | --- |
| **添加旋转速度（Add Rotational Velocity）** | 该模块添加到用户定义空间中的 **旋转速度（Rotational Velocity）** 值。 |
| **查找动能和势能（Find Kinetic and Potential Energy）** | 该模块返回以下内容： 基于粒子速度的粒子动能。 粒子的势能，即写入 **Physics.PotentialEnergy** 的所有力模块的总和。 1和2的总和。 |

## 后期解算模块

| 模块 | 说明 |
| --- | --- |
| **计算准确速度（Calculate Accurate Velocity）** | 该模块计算上一位置到当前位置的准确速度。应用约束若改变粒子在解算器框架外的预期位置，此模块将十分有用。 |

## 条带模块

| 模块 | 说明 |
| --- | --- |
| **条带宽度（Ribbon Width）** | 此参数控制生成条带的宽度，并将写入 **Particles.RibbonWidth**。 |

## 大小模块

| 参数 | 说明 |
| --- | --- |
| **缩放网格体尺寸（Scale Mesh Size）** | 此模块采用粒子生成组中设置的初始网格体尺寸比例，并通过用户设置的因子提升比例。 |
| **按速度缩放网格体尺寸（Scale Mesh Size by Speed）** | 此模块按速度向量的大小缩放初始网格体大小比例。 |
| **缩放Sprite尺寸（Scale Sprite Size）** | 此模块采用粒子生成组中设置的初始Sprite尺寸比例，并通过用户设置的因子提升比例。 |
| **按速度缩放Sprite尺寸（Scale Sprite Size by Speed）** | 此模块按速度向量的大小缩放 **Particles.SpriteSize** 参数。 |

## 子UV模块

| 模块 | 说明 |
| --- | --- |
| **子UV动画（SubUVAnimation）** | 部分sprite在网格中创建，每个sprite各代表一个动画帧。该模块接收待设置动画的sprite总数，并沿曲线标出此类sprite，以便平滑设置动画。 |

## 纹理模块

| 模块 | 说明 |
| --- | --- |
| **采样伪体积纹理（Sample Pseudo Volume Texture）** | 该模块基于UVW坐标对伪体积纹理的颜色采样。 |
| **采样纹理（Sample Texture）** | 此模块将对特定UV位置的纹理采样，并返回纹理该部分的颜色。 仅在GPU模拟中支持该模块。 |
| **子UV纹理采样（Sub UV Texture Sample）** | 该模块以子UV方式对单个纹理像素采样。 |
| **世界对齐纹理采样（World Aligned Texture Sample）** | 该模块基于粒子位置对纹理的颜色采样，类似场景对齐纹理在材质编辑器中操作。 |

## 工具模块

| 模块 | 说明 |
| --- | --- |
| **仅一次（Do Once）** | 该模块追踪其触发条件在前一帧是否为true。若否，**Particles.Module.Execute** 返回true。若触发条件在前一帧返回了true，则 **Particles.Module.Execute** 返回false。 |
| **生成网格条带ID（Generate Grid Ribbon IDs）** | 可用该模块生成输出粒子参数，此类参数用于生成具有3个条带发射器的3D网格。在条带渲染器中，用 **Particles.RibbonID1**、**Particles.RibbonID2** 和 **Particles.RibbonID3** 替代 **RibbonID**。将 **Ribbon Link Order** 设为 **1**、**2**、**3**。对于2D网格，执行上述操作，但只具有2个条带发射器。 |
| **随时间增量（Increment Over Time）** | 该模块将每帧增大值。该计数器变量使用tick差量值进行增量，并将其乘以用户指定率。 |
| **基于时间状态机（Time Based State Machine）** | 该模块输出浮点参数（**Particles.Module.OnOffPercentage**），该参数表明粒子处于开启状态（1）还是关闭状态（2）。 |
| **更新MS顶点动画工具变形目标（Update MS Vertex Animation Tools Morph Targets）** | 该模块读取变形目标纹理数据，并输出给定逐粒子像素索引的位置和法线向量。将模块的场景空间法线输出连接到资源的材质中，同时在该材质中禁用切线空间法线，以复制网格体表面。 欲了解生成变形目标纹理的详情，参见[顶点动画工具](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/vertex-animation-tool/index.md)。 该模块可直接设置粒子的位置。若如此使用，切勿使用另一直接设置粒子位置的模块。 |

## 向量域模块

| 模块 | 说明 |
| --- | --- |
| **应用向量域（Apply Vector Field）** | 该模块通过向量域采样器对向量采样，并将其作为力或速度应用。 |
| **采样向量域（Sample Vector Field）** | 该模块对向量域进行采样，应用逐粒子强度因子和可选衰减因子，该衰减因子将消退向量域对边界框边缘的影响。此操作可选择应用本地平移、旋转或缩放变换。 |

## 速度模块

| 模块 | 说明 |
| --- | --- |
| **添加速度（Add Velocity）** | 该模块向生成粒子指定速度。可添加各种动态输入来修改在该模块中输入的值。 |
| **添加点中速度（Add Velocity from Point）** | 该模块添加空间中任意点内的速度，可选衰减。其使用速度原点和粒子位置间的向量决定速度向量。若未初始化粒子位置（导致粒子位置与速度原点过于接近），则该模块将注入随机速度。为获得最精确的结果，请将该模块置于堆栈中位置模块下。此操作可确保已初始化粒子位置。 |
| **在椎体中添加速度（Add Velocity in Cone）** | 该模块以椎体形状向 **Particles.Velocity** 参数添加速度，同时提供椎体角度及沿椎体轴分布速度的参数。 |
| **将速度对齐随机轴（Align Velocity to Random Axis）** | 该模块获取速度向量并保持其量级，同时选取随机轴将其对齐，并可选择在两次更新间添加时间间隔（以秒计）。 |
| **继承速度（Inherit Velocity）** | 该模块添加另一源中继承的速度。此参数默认为拥有当前发射器的系统的位置。 |
| **缩放速度（Scale Velocity）** | 该模块将 **Particles.Velocity** 乘以特定坐标空间中的单独向量。 |
| **静态网格体速度（Static Mesh Velocity）** | 该模块根据静态网格中的法线添加速度，同时添加静态网格的继承速度。 |
| **旋涡速度（Vortex Velocity）** | 该模块计算绕旋涡轴的角速度，并将其注入 **Particles.Velocity** 参数。该模块将被添加到粒子生成时的初速度。 |

## 新建暂存区模块

在 **添加（Add）**（加号）菜单中选择此项目将打开 **暂存区（Scratch Pad）** 面板（默认情况下，此面板位于 **系统概览（System Overview）** 旁），然后在 **选择（Selection）** 面板中放置 **暂存区模块**。您还可使用 **Windows > 暂存区（Windows > Scratch Pad）** 来打开暂存区面板。但是，在堆栈中放置暂存区模块之后，您在暂存区中创建的所有模块或动态输入都将自动连接到脚本。如果您使用Windows菜单打开了暂存区面板，则您在其中创建的所有项目都必须手动添加到脚本。

## 直接设置新值或现有值

从 **添加（Add）**（加号）菜单中选择此项目将在 **选择（Selection）** 面板中放置 **设置参数（Set Parameter）** 模块。单击 **加号（Plus sign）**（**+**）图标，以选择 **添加参数（Add Parameter）** 或 **新建参数（Create New Parameter）**。

### 添加参数

选择 **添加参数（Add Parameter）** 后，您可以在列出的参数中进行选择。此操作会将该参数添加到粒子更新组中的 **设置参数（Set Parameter）** 模块中。

> [!NOTE]
> 其中部分参数可在其他模块中进行设置或修改。部分参数则只能使用设置参数模块进行设置。

| 参数 | 说明 |
| --- | --- |
| **DataInstance.Alive** | 此参数用于确定此粒子实例是否仍然有效，或者是否可删除。 |
| **Particles.Age** | 此参数定义粒子的存在时间。 |
| **Particles.CameraOffset** | 此参数设置粒子的摄像机偏移。摄像机偏移确定粒子与摄像机之间的距离。 |
| **Particles.Color** | 此参数直接设置粒子的颜色。 |
| **Particles.DynamicMaterialParameter** | 此参数是一个四浮点向量，用于将数据发送到渲染器。 |
| **Particles.DynamicMaterialParameter1** | 此参数是一个四浮点向量，用于将数据发送到渲染器。 |
| **Particles.DynamicMaterialParameter2** | 此参数是一个四浮点向量，用于将数据发送到渲染器。 |
| **Particles.DynamicMaterialParameter3** | 此参数是一个四浮点向量，用于将数据发送到渲染器。 |
| **Particles.ID** | 此参数是一个引擎管理属性，可为每个已生成粒子提供持久性ID。 |
| **Particles.Initial.Color** | 此参数设置粒子所使用Sprite的初始颜色。 |
| **Particles.Lifetime** | 此参数为已生成粒子的生命周期（以秒为单位）。 |
| **Particles.LightRadius** | 当您使用光源渲染器时，此参数确定发射光线的半径。 |
| **Particles.Mass** | 此参数确定已生成粒子的质量。 |
| **Particles.MaterialRandom** | 此参数用于驱动材质编辑器中的 **Particle Random** 节点。未设置此参数时，任何粒子随机数都将为 **0.0**。 |
| **Particles.MeshOrientation** | 此参数确定应用于已生成网格体粒子的轴角旋转。 |
| **Particles.NormalizedAge** | 此参数为 **Particles.Age** （以秒为单位）值除以 **Particles.Lifetime** （以秒为单位）值所得之结果。此参数对于动画很有用，因为生成的值在 **0** 和 **1** 之间。 |
| **Particles.Position** | 此参数设置已生成粒子的位置。 |
| **Particles.PreviousVelocity** | 此参数与 **解算力和速度（Solve Forces And Velocity）** 模块一起使用，以根据力和速度计算粒子的位置。解算加速度需要使用先前速度。 |
| **Particles.RibbonFacing** | 此参数设置条带在条带粒子位置的面向向量，或条带宽度扩展的边向量，具体取决于选择的 **面向模式（Facing Mode）**。 |
| **Particles.RibbonID** | 此参数指定条带粒子的 **条带ID（Ribbon ID）**。具有相同条带ID的粒子将连接到一个条带中。 |
| **Particles.RibbonLinkOrder** | 此参数设置连接条带中粒子的显式顺序。具有相同条带ID的粒子将根据此值以递增顺序连接到条带中。 |
| **Particles.RibbonTwist** | 此参数设置条带粒子的扭转量（以度为单位）。 |
| **Particles.RibbonWidth** | 此参数设置条带粒子的宽度（采用UE4单位）。 |
| **Particles.Scale** | 此参数设置非Sprite粒子的XYZ比例。 |
| **Particles.SpriteAlignment** | 此参数使纹理指向Sprite的选定对齐轴。使用此参数时，必须将Sprite渲染器的 **对齐方式（Alignment）** 设置为 **自定义对齐（Custom Alignment）**。 |
| **Particles.SpriteFacing** | 此参数使Sprite的表面朝向自定义向量。若要使用此参数，必须将Sprite渲染器的 **面向模式（Facing Mode）** 设置为 **自定义面向向量（Custom Facing Vector）**，并且必须在Sprite渲染器的 **自定义面向向量遮罩（Custom Facing Vector Mask）** 设置中提供值。 |
| **Particles.SpriteRotation** | 此参数设置粒子的屏幕对齐旋转（以度为单位）。 |
| **Particles.SpriteSize** | 此参数确定Sprite粒子四边形的大小。 |
| **Particles.SubImageIndex** | 此参数设置介于0到等于SubUV图像表中条目数的值。 |
| **Particles.UniqueID** | 此参数为引擎管理属性，用作每个已生成粒子的唯一ID。每生成一个新粒子，该ID就会递增。 |
| **Particles.UVScale** | 此参数用于与为Sprite渲染器生成的UV相乘。 |
| **Particles.Velocity** | 此参数确定粒子速度（以厘米/秒（cm/s）为单位）。 |

## 新建参数

选择 **新建参数（Create New Parameter）** 后，您可以在列出的参数中进行选择。此操作会将该参数添加到粒子更新组中的 **设置参数（Set Parameter）** 模块中。

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
| **向量2D曲线（Curve for Vector 2Ds）** | **数据接口（Data Interface）** | 此参数为模拟添加双通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值对。 |  |
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
| **简单计数器（Simple Counter）** | **数据接口（Data Interface）** | 此参数将向发射器添加新的简单计数器数据接口模块。此数据接口将使您能够指令线程安全计数器递增计数。 它只能与CPU发射器一起使用。 |  |
| **骨架网格体（Skeletal Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与骨架网格体的骨骼/套接字和蒙皮几何体交互。 |  |
| **生成信息（Spawn Info）** | **结构体（Struct）** | 此参数是生成所用的结构体，以指定要创建的粒子 **数量（Count）**、从当前帧开始时间到开始生成之间的 **InterpStartDt** 或偏移、定义粒子生成时间间隔的 **IntervalDt**，以及可将生成粒子归属于不同类别的 **SpawnGroup**。 |  |
| **样条（Spline）** | **数据接口（Data interface）** | 这是一个数据接口，能够与样条资源交互。 |  |
| **静态网格体（Static Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与静态网格体的表面交互。 |  |
| **纹理取样（Texture Sample）** | **数据接口（Data interface）** | 这是一个数据接口，能够与GPU上的纹理交互。 |  |
| **向量（Vector）** | **基元（Primitive）** | 此参数创建三通道浮点值集。 |  |
| **向量2D（Vector 2D）** | **基元（Primitive）** | 此参数创建双通道浮点值集。 |  |
| **向量4（Vector 4）** | **基元（Primitive）** | 此参数创建四通道浮点值集。 |  |
| **向量场（Vector Field）** | **数据接口（Data interface）** | 这是一个数据接口，能够查询向量场。 |  |
| **体积纹理取样（Volume Texture Sample）** | **数据接口（Data Interface）** | 此参数向发射器添加新的体积纹理数据接口模块。 您可以使用此参数来进行体积纹理取样。 |  |
