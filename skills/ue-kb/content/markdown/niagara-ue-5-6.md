# Niagara 内置模块索引（UE 5.6 本地扫描）

# Niagara 内置模块索引（UE 5.6 本地扫描）

本文件用于确认内置模块是否存在，并定位到 `modules/` 下的分类文件。模块名保持 UE 原始英文。

- 模块总数：`269`

## Arrays
- `FillBoolArray`
- `FillColorArray`
- `FillFloatArray`
- `FillIntArray`
- `FillPositionArray`
- `FillQuaternionArray`
- `FillVector2DArray`
- `FillVector4Array`
- `FillVectorArray`

## AttributeReader
- `SampleParticlesFromOtherEmitter`
- `SpawnParticlesFromOtherEmitter`
- `UpdateParticlesFromOtherEmitter`

## Audio
- `EInitialAudioParamType`
- `InitializeAudioPlayer`
- `PlayAudio`
- `PlayLoopingAudio`
- `PlayPersistentAudio`
- `SetInitialAudioParameter`
- `UpdatePersistentAudio`

## Beams
- `BeamEmitterSetup`
- `BeamWidth`
- `BeamWidthScale`
- `ScaleBeamWidth`
- `SpawnBeam`
- `UpdateBeam`

## CascadeConversion
- `CascadeConversion_InitialMeshRotation`
- `CascadeConversion_LightProperties`
- `CascadeConversion_Orbit`
- `CascadeConversion_SolveOrbit`

## Collision
- `AddRotationalVelocity`
- `AlignParticlesWithCollisionPlane`
- `AnalyticalCollisionQuery`
- `CalculateLinePlaneInt`
- `Collision`
- `CollisionLinearImpulse`
- `CollisionQuery`
- `CollisionQueryAndResponse`
- `CollisionRest`
- `DebugCollisionEvents`
- `FindTangentialVelocityOnSphere`
- `InitializeNeighborGrid`
- `InitialRotationalVelocity`
- `NiagaraDistanceFieldCollisions`
- `PBD_IntraParticleCollision`
- `PopulateNeighborGrid`
- `RayTrace`
- `SceneDepthTest`
- `SetupRigidBodyDI`

## Constraints
- `CalculateLinkConstraint`
- `MaintainA_SetDistanceBetweenPoints`
- `PendulumConstraint`
- `PendulumSetup`

## Debug
- `SpriteBasedLine`

## Decal
- `Decal_Attributes`

## Emitter
- `EmitterLifeCycle`
- `EmitterState`
- `SpawnBurst_Instantaneous`
- `SpawnPerFrame`
- `SpawnPerUnit`
- `SpawnRate`

## Events
- `GenerateCollisionEvent`
- `GenerateDeathEvent`
- `GenerateLocationEvent`
- `ReceiveCollisionEvent`
- `ReceiveDeathEvent`
- `ReceiveLocationEvent`

## ExportParticleData
- `ExportParticleDataToBlueprint`

## Landscape
- `SampleLandscape`

## Light
- `Light_Attributes`

## Masks
- `ConeMask`
- `ConeMask`
- `RegionMask`

## Math
- `AvoidCone`
- `AvoidDistanceFieldSurfaces_GPU`
- `ConeSphereIntersection`
- `ConstrainVectorToCone`
- `FadeOverTime`
- `FindClosestPointOnLineSegment`
- `FindClosestPointOnTriangle`
- `FindScreenSpaceBoundingBox`
- `Flight_Orientation`
- `MatchVelocity_ViaForce`
- `MinMaxOpWithValidChecks`
- `MoveToNearestDistanceFieldSurface_GPU`
- `PlaceParticlesOnA_Rectangle`
- `PlaceParticlesOnDepthBuffer_GPU`
- `PureRoll_Orientation`
- `RayTraceDistanceField_GPU`
- `ReadDistanceField_GPU`
- `SlerpVector`
- `SolveFloatSpringConstraint`
- `SpherePlaneIntersection`
- `SpherePlaneIntersection_System`
- `TrackDistanceTraveled`
- `WedgeLocation`

## Mesh
- `ApplyTraverseSkeletalMeshUpdate`
- `InitializeTraverseSkeletalMesh`
- `PrepareTraverseSkeletalMesh`
- `TraverseSkeletalMesh`

## PostSolvers
- `CalculateAccurateVelocity`

## Ribbons
- `FN_InitializeRibbonAttributes`
- `RibbonWidth`
- `RibbonWidthScale`
- `ScaleRibbonWidth`

## RVT
- `SampleRuntimeVirtualTexture`

## Scalability
- `EmitterScalability`
- `NumInstancesCull`
- `SystemScalability`

## Solvers
- `ApplyInitialForces`
- `ApplyRotationVector`
- `SolveForcesAndVelocity`
- `SolveRotationalForcesAndVelocity`

## Spawn
- `InitialDecalOrientation`
- `InitializeParticle`
- `InitializeRibbon`
- `InitializeParticle`
- `BoxLocation`
- `ConeLocation`
- `CurlNoiseLocation`
- `CylinderLocation`
- `CylinderLocation_System`
- `ENiagaraGridPlacementType`
- `GenerateGridRibbonIDs`
- `GridLocation`
- `RotateAroundPoint`
- `SkeletalMeshLocation`
- `SkeletalMeshSkeletonLocation`
- `SkeletalMeshSurfaceLocation`
- `SocketLocation`
- `Spawn_MS_VertexAnimationTools_MorphTarget_Particles`
- `SpawnParticlesInGrid`
- `SphereLocation`
- `SphereLocation_System`
- `StaticMeshLocation`
- `SystemLocation`
- `TorusLocation`
- `GridLocation`
- `RotateAroundPoint`
- `ShapeLocation`
- `SkeletalMeshLocation`
- `SphereLocation`
- `Initialize_MeshReproductionSprite`
- `SampleSkeletalMeshSkeleton`
- `SampleSkeletalMeshSurface`
- `SampleStaticMesh`
- `SampleStaticMesh_PositionOnly`
- `SampleSkeletalMeshSurface`
- `InitialMeshRotation`
- `InitialMeshOrientation`
- `InitialMeshOrientation`
- `AddVelocity`
- `AddVelocityFromPoint`
- `AddVelocityInCone`
- `LinearForce`
- `PointForce`
- `ScaleVelocity`
- `StaticMeshVelocity`

## System
- `CompleteIfUnused`
- `SystemLifeCycle`
- `SystemState`

## Update
- `BlendSpace`
- `BlendSpaceHelper`
- `CameraOffset`
- `MaintainInCameraParticleScale`
- `ScaleAttributesByCameraDistance`
- `ViewMask`
- `ViewRecycler`
- `Color`
- `ScaleColor`
- `ScaleColorBySpeed`
- `ScaleColorByVelocity`
- `UpdateDecalOrientation`
- `AccelerationForce`
- `AerodynamicDrag`
- `CalculateMassByVolume`
- `CurlNoiseForce`
- `Drag`
- `DragForce`
- `ENiagaraMassByVolume`
- `ENiagaraMassCalculationForRendererTypes`
- `ENiagaraMinOrMax`
- `FindKineticAndPotentialEnergy`
- `GravityForce`
- `LimitForce`
- `LineAttractionForce`
- `PointAttractionForce`
- `SpringForce`
- `CurlNoiseForce`
- `PointAttractionForce`
- `VectorNoiseForce`
- `VortexForce`
- `WindForce`
- `KillParticles`
- `KillParticlesInVolume`
- `ParticleState`
- `UpdateAge`
- `CalculateMassAndRotationalInertiaByVolume`
- `CalculateMassByVolume`
- `CalculateSizeAndRotationalInertiaByMass`
- `CalculateSizeByMass`
- `UpdateVelocityOnMassChange`
- `DynamicMaterialParameters`
- `DynamicMatParams`
- `DynamicMatParams1`
- `DynamicMatParams2`
- `DynamicMatParams3`
- `ParticleColorParams`
- `SampleSkeletalMesh`
- `Update_MeshReproductionSprite`
- `CalculateNeighbors`
- `AlignSpriteToMeshOrientation`
- `GenerateMeshTorque`
- `GenerateTorque`
- `InitialMeshRotationRate`
- `MeshLookAt`
- `MeshRotationForce`
- `MeshRotationRate`
- `OrientMeshToVector`
- `SpriteRotationRate`
- `MeshRotationForce`
- `OrientMeshToCamera`
- `OrientMeshToVector`
- `UpdateMeshOrientation`
- `UpdateMeshOrientation`
- `ConstrainPositionToPlane`
- `InheritSourceMovement`
- `JitterPosition`
- `RecreateCameraProjection`
- `Update_MS_VertexAnimationTools_MorphTargets`
- `SetAlternateRendererBindings`
- `SpriteFacingAndAlignment`
- `MeshSizeScale`
- `ScaleMeshSize`
- `ScaleMeshSizeBySpeed`
- `ScaleSpriteSize`
- `ScaleSpriteSizeBySpeed`
- `SpriteSizeScale`
- `SpriteSizeScaleBySpeed`
- `SpriteSizeScaleByVelocity`
- `SampleBezierSpline`
- `SampleBezierSplineLocationAndTangent`
- `TimeBasedStateMachine`
- `SubUVAnimation`
- `SubUVAnimation`
- `SamplePseudoVolumeTexture`
- `SampleTexture`
- `SubUV_TextureSample`
- `WorldAlignedTextureSample`
- `ApplyOwnerScaleToAttributes`
- `AsyncGPUTrace`
- `CurlNoise`
- `DebugDraw`
- `DoOnce`
- `EmitterFrameCounter`
- `FrameCounter`
- `IncrementOverTime`
- `InterpolateOverTime`
- `LerpParticleAttributes`
- `PartitionParticles`
- `QueryGBuffer`
- `SampleGBuffer`
- `TemporalLerp_Float`
- `TemporalLerp_Vector`
- `Timeline`
- `VectorNoiseValue`
- `AlignVelocityToRandomAxis`
- `InheritVelocity`
- `ScaleVelocity`
- `VortexVelocity`

## 使用规则

- 只用本文件确认模块名和分类；参数名看对应 `modules/<分类>.md`。
- 完整效果制作优先通过 Niagara folder JSON 导出真实模块，再改参数并 apply。

