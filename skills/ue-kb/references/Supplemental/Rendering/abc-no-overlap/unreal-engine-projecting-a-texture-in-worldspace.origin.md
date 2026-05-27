# 在世界空间中投影纹理

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/nR/unreal-engine-projecting-a-texture-in-worldspace
- 原始文件：unreal-engine-projecting-a-texture-in-worldspace.origin.md
- 分段：第 1/4 段

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/nR/unreal-engine-projecting-a-texture-in-worldspace

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 8193 字符。

## 摘要

在世界空间中对 2D 纹理进行采样的操作指南，就好像它是从任意演员投射的一样。创建假阴影，或测试遮挡，或投影...

## 中文整理

### 概览

In some situations, you’ll need to look up a value on a texture (for example, from a scene capture actor) based on the world position of a material. The most common example would be using scene depth to test for visibility, but this technique can be broadly applicable. For this example, we’ll be creating a light cone for a streetlight, and using our texture projection technique to occlude the light cone when an object passes through it. First, we’ll create the blueprint for our light cone. We’ll create a new blueprint, and the parent class will be Actor. Next, we’ll add our components. For

this demonstration, we’ll need a Static Mesh Component (for the light cone), and a SceneCaptureComponent2D. We’ll set up two variables for this Blueprint. - Light Cone Material, which is of type Material Interface (the parent class of materials, and material instances). We’ll fill this out later. Light

Cone Material, which is of type Material Interface (the parent class of materials, and material instances). We’ll fill this out later. - MID, which is of type MaterialInstanceDynamic MID, which is of type MaterialInstanceDynamic While we’re thinking about it, we should make a new material, called M_LightConeProjector, and an instance of it, and assign that Material Instance to our Light Cone Material Variable. We’ll fill out the material in a bit! We’ll need to pass information about the scene capture component to the static mesh in both the construction script and on tick. We’ll make a

function for this called UpdateMaterialValues. In this function, we’ll pass information about the transforms of the actor to the material. We’ll pass in the following information the MID: Vector Parameters - ProjectorLocation - GetActorLocation ProjectorLocation - GetActorLocation - ProjectorForward -

GetActorForwardVector ProjectorForward - GetActorForwardVector - ProjectorRight - GetActorRightVector ProjectorRight - GetActorRightVector - ProjectorUp - GetActorUpVector ProjectorUp - GetActorUpVector For vector parameters, you can drag off the vector and drop it on the Value input of the Set Vector Parameter Value node and it will automatically create a convert Vector to Linear Color node and connect it. Scalar Parameters - ProjectorFOV - SceneCaptureComponent2D->GetFieldOfView ProjectorFOV - SceneCaptureComponent2D->GetFieldOfView Texture Parameters - ProjectorTexture -

SceneCaptureComponent2D->GetTextureTarget ProjectorTexture - SceneCaptureComponent2D->GetTextureTarget Next, we’ll set up our construction script to not draw this actor in the scene capture, create a render target for our scene capture, set up the dynamic material instance and assign it to the static mesh, and finally
