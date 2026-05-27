# 在世界空间中投影纹理（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/nR/unreal-engine-projecting-a-texture-in-worldspace
- 原始文件：unreal-engine-projecting-a-texture-in-worldspace.origin.md
- 分段：第 2/4 段

call the “Update Material Values” function. Let’s now turn our attention to the material. We’re going to create an unlit translucent material, and just use a red emissive color. Perhaps we’re creating a warning light! Here, we need to transform a vector from the projector to the world position of the pixel being drawn into the projector’s space using the transform data provided to the material via Blueprint. We’ll set up the vector inputs we used above using some default values to make it easier to debug the material: And plug them into the InverseTransformMatrix material function. Note! We’ll

want to invert the up axis here, and pay attention to the order of the axes. The Vector to Transform input will be WorldPosition - ProjectorPosition: If we look at the raw output of that InverseTransformMatrix, it looks an awful lot like UV coordinates, doesn’t it! What we’ve effectively created
here is a 2D coordinate system which uses the forward axis of the projector as its (0,0). We’re projecting a 2D texture out into the world, the extents of which are defined by the FOV of the projector. So what we want is to figure out how to make it so that the middle of the texture is in front of the projector, and the width and height of the texture matches the FOV. For the latter part, we can use a little trigonometry. Imagine a right triangle, where the hypotenuse extends from the projector straight forward, and one side extends from the projector out at ½ of the FOV. The opposite side of

this triangle is the theoretical surface onto which we want to project our texture. Since we already have a 2D grid on that surface, we need to get the size of this opposite side so we can get some 0 to 1 values to use to sample our texture. Since we know that the tangent of an angle (in radians) of

any given non-right corner of a right triangle is equal to the length of the opposite side divided by the length of the adjacent side, and this equation is commutative, we can derive the length of the opposite side of the triangle by multiply the tangent of the angle by the length of the adjacent side. So, with the camera’s FOV, and the magnitude of the vector from the projector to WorldPosition, we have enough information to find the length of the “Opposite” side of a right-triangle. We’ll get the distance between WorldPosition and Projector Location for our adjacent side (You can use the

same vector parameter node as we used above to get the vector): And the tangent of one-half * FOV, in Period 1.0 Radians. (The trigonometry functions in materials are in period 1, whereas the trigonometric functions on your graph calculator are in period pi). For this, we just need to divide the FOV by
