# Update（Niagara 内置模块）

- 条目数：`109`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `BlendSpace`

- 参数名：`Age`、`AgeInterpolationMask`、`BlendedRotationDelta`、`BlendedTranslationDelta`、`InverseRotationDelta`、`InvertedSpawnInterpolationPlusMask`、`MeshOrientation`、`MeshOrientationBlend`、`NonInterpolatedPosition`、`NonInterpolatedPreviousPosition`、`OrientationRotationDelta`、`Pivot`、`Position`、`PositionDelta`、`RotationBlend`、`RotationDelta`、`ScaleDelta`、`SpawnInterpolation`、`SpawnInterpolationMask`、`SpawnInterpolationMasked`、`SpawnInterpolationMaskedInverse`、`TranslationBlend`、`TranslationDelta`、`VectorRotationDelta`、`Velocity`、`VelocityBlend`、`Mesh Orientation Blend (World <-> Local)`、`Position Blend (World <-> Local)`、`Rotation Contribution`、`Translation Contribution`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `BlendSpaceHelper`

- 参数名：`PreviousSystemLocalToWorld`、`PreviousSystemWorldToLocal`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CameraOffset`

- 参数名：`Camera Offset Amount`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MaintainInCameraParticleScale`

- 参数名：`Half FOV`、`Pixel Depth`、`Render Target Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleAttributesByCameraDistance`

- 参数名：`Camera`、`Max Distance`、`Max Scale`、`Min Distance`、`Min Scale`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ViewMask`

- 参数名：`BackwardOffset`、`ClipToTranslatedWorldTransform`、`ClipToViewTransform`、`CurrentTAAJitter`、`FieldOfViewAngle`、`FieldOfViewCompensation`、`FieldOfViewCompensation2`、`Position`、`PreviousTAAJitter`、`PreviousViewPositionWorld`、`ProjectedPosition`、`Radius`、`TranslatedWorldToClipTransform`、`TranslatedWorldToPreviousClipTransform`、`TranslatedWorldToViewTransform`、`ViewAspect`、`ViewForwardVector`、`ViewParamX`、`ViewParamY`、`ViewPositionWorld`、`ViewSizeAndInverseSize`、`ViewSizeFactor`、`ViewToTranslatedWorldTransform`、`Border Percent Max`、`Border Percent Min`、`Diameter`、`Mesh Renderer Info`、`Mesh Scale Multiplier`、`Scale`、`Sprite Size Multiplier`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ViewRecycler`

- 参数名：`BackwardOffset`、`ClipToTranslatedWorldTransform`、`ClipToViewTransform`、`CurrentTAAJitter`、`DoRecycle`、`DoTrace`、`EmitterFirstFrame`、`FarDistance`、`FieldOfViewCompensation`、`FieldOfViewCurrentFrame`、`HeightCoverageFactor`、`HeightCoverageFactorPrev`、`Hide`、`NearDistance`、`OutsideCurrentFrustum`、`OutsidePreviousFrustum`、`Position`、`PreviousTAAJitter`、`PreviousViewPositionWorld`、`ProjectedPosition`、`ProjectedPositionPreviousClip`、`Radius`、`RecycleFromPreviousFrame`、`ReferenceFieldOfViewCompensation`、`SpawnPosition`、`TraceDirection`、`TranslatedWorldToClipTransform`、`TranslatedWorldToPreviousClipTransform`、`TranslatedWorldToViewTransform`、`TravelCameraForward`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Color`

- 参数名：`Scale Alpha`、`Scale Color`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleColor`

- 参数名：`Color Value To Scale`、`Curve Index`、`Linear Color Curve`、`Scale Alpha`、`Scale RGB`、`Scale RGBA`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleColorBySpeed`

- 参数名：`SpeedScaleFactor`、`A Scale Max`、`A Scale Min`、`Max Speed Threshold`、`Min Speed Threshold`、`RGB Scale Max`、`RGB Scale Min`、`Source Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleColorByVelocity`

- 参数名：`VelocityScaleFactor`、`A Scale Max`、`A Scale Min`、`Max Velocity Threshold`、`Min Velocity Threshold`、`RGB Scale Max`、`RGB Scale Min`、`Source Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateDecalOrientation`

- 参数名：`Facing Interpolation Rate`、`FinalDecalOrientation`、`PreAppliedOrientation`、`Facing Coordinate Space`、`Facing Direction`、`Reference Axis Vector`、`Side Coordinate Space`、`Side Direction`、`Up Coordinate Space`、`Up Direction`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AccelerationForce`

- 参数名：`Acceleration`、`Coordinate Space`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AerodynamicDrag`

- 参数名：`AdvectionVelocity`、`AngleOfAttack`、`Drag`、`DragCoefficient`、`FacingRatio`、`InverseMass`、`LiftCoefficient`、`LiftDirection`、`LiftVelocity`、`Mass`、`MeshOrientation`、`RelativeSpeed`、`RotationalInertia`、`SurfaceNormal`、`TravelDirection`、`Velocity`、`Aerodynamic Drag`、`Aerodynamic Rotational Drag`、`Debug`、`Drag Shape Curve`、`Drag Shape Exponent`、`Drag Shape Maximum`、`Drag Shape Minimum`、`Ignore Mass`、`Lift Contribution`、`Lift Shape Curve`、`Lift Smoothing`、`Mesh Orientation`、`Pivot Offset`、`Pivot Offset Maximum`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateMassByVolume`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CurlNoiseForce`

- 参数名：`AgeAdvancement`、`DeterministicOffset`、`Falloff`、`Sampled Noise`、`SamplePosition`、`VectorField`、`Curl Noise Cone Mask Angle`、`Curl Noise Cone Mask Axis`、`Curl Noise Cone Mask Falloff Angle`、`CurlNoise`、`Noise Frequency`、`Noise Strength`、`Pan Noise Field`、`Random Seed`、`Sample Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Drag`

- 参数名：`Ignore Mass`、`Rotational Drag`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DragForce`

- 参数名：`Drag`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ENiagaraMassByVolume`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ENiagaraMassCalculationForRendererTypes`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ENiagaraMinOrMax`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FindKineticAndPotentialEnergy`

- 参数名：`Energy Max Cap`、`Particle Mass`、`PhysicsPotentialEnergy`、`Remapped Energy Max`、`Remapped Energy Min`、`Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `GravityForce`

- 参数名：`Gravity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `LimitForce`

- 参数名：`Force Limit`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `LineAttractionForce`

- 参数名：`Attraction Force`、`Attraction Falloff`、`Attraction Strength`、`Line End`、`Line Start`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PointAttractionForce`

- 参数名：`PointOriginVec`、`PointOriginVecLength`、`Attraction Radius`、`AttractionStrength`、`AttractorPosition`、`Falloff Exponent`、`Kill Radius`、`Kill Within Radius`、`Use Falloff`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpringForce`

- 参数名：`Particle Equilibrium Position`、`Attachment Point Velocity`、`Dampening Coefficient`、`Desired Minimum Separation Distance`、`Force Strength`、`Particle Position`、`Particle Velocity`、`Spring Tightness`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CurlNoiseForce`

- 参数名：`AgeAdvancement`、`Bias`、`DebugDraw`、`Falloff`、`NoiseFrequencyScaled`、`Randomization Offset`、`Sampled Noise`、`SamplePosition`、`VectorField`、`Bias Noise Field`、`Curl Noise Cone Mask Angle`、`Curl Noise Cone Mask Axis`、`Curl Noise Cone Mask Falloff Angle`、`CurlNoise`、`Debug Every N Particles`、`Debug Force Line Length`、`Noise Frequency`、`Noise Strength`、`Pan Noise Field`、`Random Seed`、`Randomization Vector`、`Sample Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PointAttractionForce`

- 参数名：`AttractedPosition`、`AttractionForce`、`AttractorOrigin`、`DebugDraw`、`IsWithinAttractor`、`PointOriginVec`、`PointOriginVecLength`、`Attraction Radius`、`Attraction Strength`、`Attractor Position`、`Attractor Position Offset`、`Attractor Position Offset Coordinate Space`、`Debug Attractor Radius Color`、`Debug Every N Particles`、`Debug Force Line Color`、`Debug Force Line Length`、`Falloff Exponent`、`Kill Radius`、`Kill Radius Overshoot Correction`、`Position To Attract`、`Use Falloff`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `VectorNoiseForce`

- 参数名：`ForceAmount`、`Force Amount`、`Random Noise Time Interval`、`Use Random Noise Time Interval`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `VortexForce`

- 参数名：`DebugDraw`、`ForceAmount`、`InfluenceAmount`、`Inverse Normalized Range`、`NormalizedRange`、`OriginVector`、`ParticlesPosition`、`VortexAxis`、`VortexForceAmount`、`VortexOrigin`、`VortexOriginOffset`、`VortexVector`、`WithinFalloffRange`、`Debug Every N Particles`、`Debug Force Line Color`、`Debug Force Line Length`、`Debug Influence Falloff Color`、`Influence Falloff Exponent`、`Influence Falloff Radius`、`Invert Influence Falloff`、`Origin Pull Amount`、`Vortex Axis`、`Vortex Axis Coordinate Space`、`Vortex Force Amount`、`Vortex Influence Position`、`Vortex Origin`、`Vortex Origin Offset`、`Vortex Origin Offset Coordinate Space`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `WindForce`

- 参数名：`AdvectionVelocity`、`CameraPosWorld`、`Curl Noise`、`CurlDirection`、`CurlLength`、`DistanceToGround`、`FlowMapBlend`、`FrictionStrength`、`GroundElevation`、`IsInsideView`、`LandScapeHeight`、`LandscapeIsValid`、`LandscapeNormal`、`LowHighOctaveBlend`、`Mask`、`MaxFreq`、`PhysicsLinearVelocity`、`Position`、`RawWindForce`、`ResetOffset`、`ResetOffset2`、`SamplePosWorld`、`SampleVector`、`SampleVector2`、`SampleVector2High`、`SampleVectorHigh`、`SampleWorldNormal`、`SDFDistance`、`SDFGradient`、`TimeUntilReset`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `KillParticles`

- 参数名：`Kill Particles`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `KillParticlesInVolume`

- 参数名：`IsInside`、`Box Size`、`Cone Angle`、`Cone Axis`、`Cone Length`、`Invert Volume`、`Kill Volume Enabled`、`Origin Offset`、`Plane Normal`、`Position`、`Slab Axis`、`Slab Width`、`Sphere Radius`、`Volume Origin`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ParticleState`

- 参数名：`DeltaTime`、`Let Infinitely Lived Particles Die When Emitter Deactivates`、`Lifetime`、`Loop Particles Lifetime`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateAge`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateMassAndRotationalInertiaByVolume`

- 参数名：`CurrentDensity`、`MeshVolume`、`ParticleVolume`、`RibbonVolume`、`SpriteVolume`、`Density by Material Type`、`Manually Enter Density`、`Mass Modulation`、`Mesh Bounds`、`Renderer Type`、`Ribbon Segment Length`、`Ribbon Width`、`Sprite Size`、`Use Minimum Sprite Volume`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateMassByVolume`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateSizeAndRotationalInertiaByMass`

- 参数名：`CurrentDensity`、`ParticleVolume`、`UserMeshDimensionPreference`、`UserSpriteDimensionPreference`、`Calculate Mesh Scale`、`Density by Material Type`、`Depth`、`Height`、`Initial Model Dimensions`、`Manually Enter Density`、`Mass Modulation`、`Model Proportions`、`Sprite Size Modulation`、`Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateSizeByMass`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateVelocityOnMassChange`

- 参数名：`PreviousMass`、`PreviousMomentOfInertia`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DynamicMaterialParameters`

- 参数名：`Index 0 Linear Color`、`Index 0 Param 1`、`Index 0 Param 2`、`Index 0 Param 3`、`Index 0 Param 4`、`Index 0 Vector 1`、`Index 0 Vector 4`、`Index 0 Vector2D 1`、`Index 0 Vector2D 2`、`Index 1 Linear Color`、`Index 1 Param 1`、`Index 1 Param 2`、`Index 1 Param 3`、`Index 1 Param 4`、`Index 1 Vector 1`、`Index 1 Vector 4`、`Index 1 Vector2D 1`、`Index 1 Vector2D 2`、`Index 2 Linear Color`、`Index 2 Param 1`、`Index 2 Param 2`、`Index 2 Param 3`、`Index 2 Param 4`、`Index 2 Vector 1`、`Index 2 Vector 4`、`Index 2 Vector2D 1`、`Index 2 Vector2D 2`、`Index 3 Linear Color`、`Index 3 Param 1`、`Index 3 Param 2`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DynamicMatParams`

- 参数名：`Param0Value`、`Param0WriteEnabled`、`Param1Value`、`Param1WriteEnabled`、`Param2Value`、`Param2WriteEnabled`、`Param3Value`、`Param3WriteEnabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DynamicMatParams1`

- 参数名：`Param0Value`、`Param0WriteEnabled`、`Param1Value`、`Param1WriteEnabled`、`Param2Value`、`Param2WriteEnabled`、`Param3Value`、`Param3WriteEnabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DynamicMatParams2`

- 参数名：`Param0Value`、`Param0WriteEnabled`、`Param1Value`、`Param1WriteEnabled`、`Param2Value`、`Param2WriteEnabled`、`Param3Value`、`Param3WriteEnabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DynamicMatParams3`

- 参数名：`Param0Value`、`Param0WriteEnabled`、`Param1Value`、`Param1WriteEnabled`、`Param2Value`、`Param2WriteEnabled`、`Param3Value`、`Param3WriteEnabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ParticleColorParams`

- 参数名：`Alpha Channel Value`、`Alpha Channel Write Enabled`、`Blue Channel Value`、`Blue Channel Write Enabled`、`Green Channel Value`、`Green Channel Write Enabled`、`Red Channel Value`、`Red Channel Write Enabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SampleSkeletalMesh`

- 参数名：`RandomInfo`、`SampledBitangent`、`SampledBoneIndex`、`SampledMeshTriCoord`、`SampledMeshUV`、`SampledMeshVertexID`、`SampledNormal`、`SampledPosition`、`SampledRotation`、`SampledTangent`、`SampledVelocity`、`SampledVertexColor`、`SkeletalMesh`、`Offset Position Along Sampled Normal`、`Random Seed`、`Sampled Position Offset`、`Sampled UV Index`、`Skeletal Mesh`、`Triangle Coordinate`、`Triangle ID`、`Vertex ID`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Update_MeshReproductionSprite`

- 参数名：`Mesh`、`Mesh Tri Coordinate`、`Overwrite Intrinsic Variables`、`Sprite Size`、`UV Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateNeighbors`

- 参数名：`AttributeReader`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AlignSpriteToMeshOrientation`

- 参数名：`Mesh Orientation Relative Sprite Alignment Vector`、`Mesh Orientation Relative Sprite Facing Vector`、`Orientation Quaternion`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `GenerateMeshTorque`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `GenerateTorque`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InitialMeshRotationRate`

- 参数名：`Coordinate Space`、`Initial Rotation Rate Scale`、`Pitch`、`Roll`、`Yaw`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MeshLookAt`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MeshRotationForce`

- 参数名：`Lever Radius (cm)`、`Rotate in Mesh Space?`、`X`、`Y`、`Z`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MeshRotationRate`

- 参数名：`Coordinate Space`、`Delta Time`、`Pitch`、`Roll`、`Rotation Rate`、`Yaw`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `OrientMeshToVector`

- 参数名：`Look At Direction`、`Override Incoming Orientation`、`Override Quaternion`、`Reference Axis Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpriteRotationRate`

- 参数名：`Delta Time`、`Rotation Rate`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MeshRotationForce`

- 参数名：`Lever Radius (cm)`、`Rotation`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `OrientMeshToCamera`

- 参数名：`Camera Foward Vector`、`Camera Position`、`Camera Query`、`Camera Right Vector`、`Camera Up Vector`、`Locked Axis Vector`、`Locked Axis Vector Coordinate Space`、`Override Incoming Orientation`、`Override Quaternion`、`Vector To Camera Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `OrientMeshToVector`

- 参数名：`Look At Direction`、`Override Incoming Orientation`、`Override Quaternion`、`Reference Axis Vector`、`Side Axis Direction`、`Up Axis Direction`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateMeshOrientation`

- 参数名：`Delta Time`、`Rotation Rate`、`Rotation Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateMeshOrientation`

- 参数名：`AppliedOrientation`、`BasisVectorsAreUpsideDown`、`CurrentBankingQuat`、`Debug Draw`、`Facing Interpolation Rate`、`FinalMeshOrientation`、`FirstFrame`、`Model Y Axis`、`Particle Radius`、`PreAppliedOrientation`、`PureRollAxisAngle`、`SmoothZVectorValue`、`TransformedUpVector`、`VelocityMagnitude`、`Bank Rate`、`Debug Coordinate System Scale`、`Delta Time`、`Enabled`、`Facing Coordinate Space`、`Facing Direction`、`Facing Origin`、`Facing Origin Coordinate Space`、`Facing Position`、`Facing Position Coordinate Space`、`First Frame`、`Foward Vector (Mesh Space)`、`Initial Forward Vector`、`Mesh Renderer`、`Mesh Renderer Index`、`21`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ConstrainPositionToPlane`

- 参数名：`InputPosition`、`Plane Normal`、`Plane Position`、`PlaneNormal`、`PlanePosition`、`Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InheritSourceMovement`

- 参数名：`SourceVelocity`、`Applied Force Falloff Curve`、`Applied Force Falloff Distance`、`Applied Force Falloff Origin`、`Applied Force Falloff Position`、`Applied Force Scale`、`Applied Force Speed Limit`、`Applied Position Falloff Curve`、`Applied Position Falloff Distance`、`Applied Position Falloff Origin`、`Applied Position Scale`、`LimitForceSpeed`、`Source Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `JitterPosition`

- 参数名：`ModuleJitterOffset`、`Jitter Amount`、`Jitter Delay`、`Jitter Offset`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `RecreateCameraProjection`

- 参数名：`Depth Value`、`Forward Vector`、`Fov`、`Projection Space UV Location`、`Projector Location`、`Render Target Resolution`、`Right Vector`、`Up Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Update_MS_VertexAnimationTools_MorphTargets`

- 参数名：`Normal 1`、`Normal 2`、`UV1`、`UV2`、`World Position 1`、`World Position 2`、`Morph Target Phase`、`Normal Map Texture`、`Normalized Phase?`、`Persistent Particle ID`、`Vertex Position Texture`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SetAlternateRendererBindings`

- 参数名：`Alpha Scale Range`、`Color`、`Color Maximum`、`Color Minimum`、`Hue Shift Range`、`Mass`、`Mass Max`、`Mass Min`、`Maximum`、`Mesh Scale`、`Mesh Scale Max`、`Mesh Scale Min`、`Mesh Uniform Scale`、`Mesh Uniform Scale Max`、`Mesh Uniform Scale Min`、`Minimum`、`Position`、`Position Offset`、`Position Offset Coordinate Space`、`Saturation Range`、`Sprite Rotation Angle`、`Sprite Rotation Angle Max`、`Sprite Rotation Angle Min`、`Sprite Size`、`Sprite Size Max`、`Sprite Size Min`、`Sprite UV Scale`、`Uniform Sprite Size`、`Uniform Sprite Size Max`、`Uniform Sprite Size Min`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpriteFacingAndAlignment`

- 参数名：`Sprite Alignment`、`Sprite Facing`、`Alignment Coordinate Space`、`Facing Coordinate Space`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MeshSizeScale`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleMeshSize`

- 参数名：`Initial Mesh Scale`、`Scale Factor`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleMeshSizeBySpeed`

- 参数名：`NormalizedVelocityRange`、`Initial Mesh Scale`、`Max Scale Factor`、`Min Scale Factor`、`Sample Scale Factor By Curve`、`Scale Factor Curve`、`Source Velocity`、`Speed Threshold`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleSpriteSize`

- 参数名：`Initial Sprite Size`、`Non-Uniform Curve Index`、`Non-Uniform Curve Scale`、`Non-Uniform Curve Sprite Scale`、`Scale Factor`、`Uniform Curve Index`、`Uniform Curve Scale`、`Uniform Curve Sprite Scale`、`Uniform Scale Factor`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleSpriteSizeBySpeed`

- 参数名：`NormalizedVelocityRange`、`Initial Sprite Size`、`Max Scale Factor`、`Min Scale Factor`、`Sample Scale Factor By Curve`、`Scale Factor Curve`、`Source Velocity`、`Velocity Threshold`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpriteSizeScale`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpriteSizeScaleBySpeed`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpriteSizeScaleByVelocity`

- 参数名：`NormalizedVelocityRange`、`Max Scale Factor`、`Min Scale Factor`、`Sample Scale Factor By Curve`、`Scale Factor Curve`、`Source Velocity`、`Velocity Threshold`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SampleBezierSpline`

- 参数名：`P0 - Start Handle`、`P1 - Start Point`、`P2 - End Point`、`P3 - End Handle`、`T - Position Along Spline`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SampleBezierSplineLocationAndTangent`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `TimeBasedStateMachine`

- 参数名：`Initial Start Time`、`Invert On Off Percentage`、`Is Initialization Frame`、`Lerp Time To Off`、`Lerp Time To ON`、`Off Duration`、`On Duration`、`Tick Delta`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SubUVAnimation`

- 参数名：`Max Random Frame`、`Min Random Frame`、`Number Of Frames`、`Random SubUV Lookup Index`、`SubUV Lookup Index`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SubUVAnimation`

- 参数名：`BlendEnabled`、`Discard`、`End FrameINT`、`EndFrame`、`FractionalFrame`、`FrameCount`、`LocalIndex`、`MaxFrameStartEnd`、`MinFrameStartEnd`、`RandomNormalizedStartFrame`、`Start FrameINT`、`StartFrame`、`SubImageIndex`、`SubUVSize`、`Direct Frame Index`、`End Frame`、`End Frame Range Override`、`Frames Per Second`、`Is SubUV Blending Enabled On Renderer`、`Manual SubImage Size`、`Mesh Renderer`、`Play Rate`、`Playback Scale Curve`、`Playback Scale Curve Index`、`Playback Time`、`Random Change Interval`、`Random Change Interval Time`、`Random Seed`、`Sprite Renderer`、`14`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SamplePseudoVolumeTexture`

- 参数名：`MipLevel`、`Number of Frames XY`、`Texture`、`Total Number of Frames`、`UVW Coordinates`、`UVW Offset`、`UVW Scale`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SampleTexture`

- 参数名：`Camera`、`ImportanceValid`、`SampledA`、`SampledB`、`SampledColor`、`SampledG`、`SampledR`、`SamplerUV`、`SamplerUV_Centered`、`TransformedUVW`、`UI_Passthrough`、`Comparison Value (B)`、`Importance Falloff`、`Importance Render Target`、`Importance RGBA Channel`、`Importance Texture`、`Invert Rotation Quaternion`、`Mip Level`、`Premultiply Importance Alpha`、`Rotation Angle`、`Rotation Axis`、`Rotation Coordinate Space`、`Rotation Matrix`、`Rotation Quaternion`、`Sampled RGBA Mask`、`Texture`、`UV`、`UV Origin`、`UV Scale`、`1`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SubUV_TextureSample`

- 参数名：`Phase`、`Texture`、`X Count`、`Y Count`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `WorldAlignedTextureSample`

- 参数名：`Unscaled UV Coordinates`、`Center Position`、`Sample Position`、`Texture`、`Texture Scale`、`X Axis Vector`、`XY Vector Source Space`、`XY Vector Target Space`、`Y Axis Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ApplyOwnerScaleToAttributes`

- 参数名：`ScaleFactor`、`ScaleFactorLongestComponentLength`、`Camera Offset Scale Amount`、`Drag Scale Amount`、`Forces Scale Amount`、`Initial Velocity Scale Amount`、`Mesh Particle Scale Amount`、`Owner Scale`、`Ribbon Width Scale Amount`、`Scale Factor`、`Sprite Size Scale Amount`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AsyncGPUTrace`

- 参数名：`Async Gpu Trace`、`CollisionDistanceWorld`、`CollisionNormalWorld`、`CollisionPosWorld`、`CollisionValid`、`Debug Hit Color`、`Debug Miss Color`、`Debug Normal Color`、`DebugDraw`、`TraceEnd`、`TraceEndWorld`、`TraceStart`、`TraceStartWorld`、`Collision Group`、`Debug Draw`、`Hit Normal Display Length`、`Trace Bias`、`Trace Directon`、`Trace Max Distance`、`Trace Start Offset`、`Trace Start Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CurlNoise`

- 参数名：`AgeAdvancement`、`Clamp Range`、`Clamp Remap`、`DebugDraw`、`NoiseFrequencyScaled`、`Randomization Offset`、`Remap Range`、`Remap Range Input`、`Remap Range Output`、`Sampled Noise`、`SamplePosition`、`VectorField`、`Debug Every N Particles`、`Debug Force Line Length`、`Noise Frequency`、`Pan Noise Field`、`Random Seed`、`Randomization Vector`、`Remap Range Input Max`、`Remap Range Input Min`、`Remap Range Output Max`、`Remap Range Output Min`、`Sample Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DebugDraw`

- 参数名：`Enable`、`Center`、`Color`、`Debug Draw`、`Debug Draw Mode`、`Direction`、`End Position`、`Length`、`Line Mode`、`Num Segments`、`Orientation`、`Radius`、`Scale`、`Size`、`Skip`、`SkipID`、`Start Position`、`Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DoOnce`

- 参数名：`Reset`、`Trigger Condition`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `EmitterFrameCounter`

- 参数名：`Increment Counter`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FrameCounter`

- 参数名：`Increment Counter`、`Reset Counter`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `IncrementOverTime`

- 参数名：`Enabled`、`Rate of Change`、`Tick Delta`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InterpolateOverTime`

- 参数名：`Delta Time`、`FirstFrame`、`Initial 2D Value`、`Initial Color Value`、`Initial Float Value`、`Initial Position Value`、`Initial Quat Value`、`Initial Vector 4 Value`、`Initial Vector Value`、`Rate Of Change`、`Target 2D Value`、`Target Color Value`、`Target Float Value`、`Target Position Value`、`Target Quat Value`、`Target V4 Value`、`Target Vector Value`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `LerpParticleAttributes`

- 参数名：`Camera Offset A`、`Camera Offset B`、`Color A`、`Color B`、`Dynamic Material Parameter 1 A`、`Dynamic Material Parameter 1 B`、`Dynamic Material Parameter 2 A`、`Dynamic Material Parameter 2 B`、`Dynamic Material Parameter 3 A`、`Dynamic Material Parameter 3 B`、`Dynamic Material Parameter A`、`Dynamic Material Parameter B`、`Lerp Alpha`、`Lerp Camera Offset`、`Lerp Color`、`Lerp Dynamic Material Parameter`、`Lerp Dynamic Material Parameter 1`、`Lerp Dynamic Material Parameter 2`、`Lerp Dynamic Material Parameter 3`、`Lerp Material Random`、`Lerp Position`、`Lerp Sprite Alignment`、`Lerp Sprite Facing`、`Lerp Sprite Rotation`、`Lerp Sprite Size`、`Lerp SubImageIndex`、`Lerp UV Scale`、`Lerp Velocity`、`Material Random A`、`Material Random B`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PartitionParticles`

- 参数名：`ID to Partition`、`Index In Partition`、`Normalized Index In Partition`、`NormalizedPartition`、`Number Of Partitions`、`Partition`、`A`、`B`、`Color A`、`Color B`、`Color Tolerance`、`Direction A`、`Direction B`、`Direction Tolerance`、`Distance`、`Distance Falloff Exponent`、`End Position`、`Minimum Saturation`、`Particles Per Partition`、`Partition Duration`、`Start Position`、`Time`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `QueryGBuffer`

- 参数名：`ApplyViewportOffset`、`Screen UV`、`GBuffer`、`Ignore Alpha`、`Query Position`、`Query UV`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SampleGBuffer`

- 参数名：`ApplyViewportOffset`、`Depth`、`Screen UV`、`GBuffer`、`Ignore Alpha`、`Max Z Depth`、`Query Position`、`Query UV`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `TemporalLerp_Float`

- 参数名：`Current Value`、`Rate Of Change`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `TemporalLerp_Vector`

- 参数名：`Current Value`、`Rate Of Change`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Timeline`

- 参数名：`IsRewinding`、`NormalizedTimelineValue`、`TimelineValue`、`Float Array`、`Float Curve`、`Initial Start Time`、`Instantaneous Rewind`、`Integer Array`、`Linear Color Array`、`Linear Color Curve`、`Loop While Playing`、`Loop While Rewinding`、`Play`、`Play Rate`、`Rewind`、`Rewind Rate`、`Time Increment`、`Timeline Beginning`、`Timeline End`、`Vector Array`、`Vector Curve`、`Vector2D Array`、`Vector2D Curve`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `VectorNoiseValue`

- 参数名：`AgeAdvancement`、`DebugDraw`、`NoiseFrequencyScaled`、`Randomization Offset`、`Sampled Noise`、`SamplePosition`、`VectorField`、`Clamp Remap`、`CurlNoise`、`Debug Every N Particles`、`Debug Force Line Length`、`Noise Frequency`、`Pan Noise Field`、`Random Seed`、`Randomization Vector`、`Remap Range Input`、`Remap Range Input Max`、`Remap Range Input Min`、`Remap Range Output`、`Remap Range Output Max`、`Remap Range Output Min`、`Sample Position`、`Vector Field`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AlignVelocityToRandomAxis`

- 参数名：`TimeDelay`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InheritVelocity`

- 参数名：`Inherited Velocity Amount Scale`、`Inherited Velocity Speed Limit`、`Limit Speed`、`Source Speed Threshold`、`Velocity Destination Space`、`Velocity Limit`、`Velocity Scale`、`Velocity Source`、`Velocity Source Space`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ScaleVelocity`

- 参数名：`Coordinate Space`、`Velocity Scale`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `VortexVelocity`

- 参数名：`Inverse Normalized Range`、`NormalizedRange`、`OriginVector`、`VortexVector`、`Delta Time`、`Influence Falloff Exponent`、`Influence Falloff Radius`、`Invert Influence Falloff`、`Use Influence Falloff`、`Velocity Amount`、`Vortex Axis`、`Vortex Axis Coordinate Space`、`Vortex Origin`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。
