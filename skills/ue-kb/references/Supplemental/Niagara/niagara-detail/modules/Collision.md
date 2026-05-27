# Collision（Niagara 内置模块）

- 条目数：`19`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `AddRotationalVelocity`

- 参数名：`Rotation Rate`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AlignParticlesWithCollisionPlane`

- 参数名：`Aligned Axis Selector`、`MeshBasisX`、`MeshBasisY`、`MeshBasisZ`、`MostAlignedVectorsDotProductIsZero`、`X Mesh_Surface Normal Alignment Sign`、`Y Mesh_Surface Normal Alignment Sign`、`Z Mesh_Surface Normal Alignment Sign`、`Allow Alignment on X`、`Allow Alignment on Y`、`Allow Alignment on Z`、`Calming Rate When Bouncing`、`Calming Rate When Resting`、`Colliding`、`Colliding With Surface`、`Collision Normal's Convergence Rate`、`Collision Normal's Interpolation Rate`、`Collision Surface Normal`、`Combined Collision Normal`、`Force Alignment`、`Resting`、`Resting on Surface`、`Rotational Dampening Power`、`Sprite Relative Alignment Vector`、`Sprite Relative Facing Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AnalyticalCollisionQuery`

- 参数名：`ForceContribution`、`MovementThisUpdate`、`PhysicsDeltaTime`、`RemoveRestitution`、`Trace Origin`、`Collision Enabled`、`Particle Friction`、`Particle Radius`、`Particle Restitution`、`Plane Normal`、`Plane Pivot Point`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CalculateLinePlaneInt`

- 参数名：`Plane Normal`、`Plane Pivot Point`、`Trace Origin`、`Trace Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Collision`

- 参数名：`DebugCollided1`、`DebugCollided2`、`DebugCollisionNormal1`、`DebugCollisionNormal2`、`DebugCollisionPosition1`、`DebugCollisionPosition2`、`InputForcePassthrough_NeededForSimStageExecution`、`InputPositionPassthrough_NeededForSimStageExecution`、`InputVelocityPassthrough_NeededForSimStageExecution`、`Kill On Collision`、`Manually Enter Rest`、`ModuleParticle Radius`、`ModuleReturnedCollisionWorldPosition`、`ModuleTraceWorldEnd1`、`ModuleTraceWorldEnd2`、`ModuleTraceWorldStart1`、`ModuleTraceWorldStart2`、`Update Mesh Rotation`、`Advanced Aging Rate`、`Allow Offscreen Depth Buffer Collision Particles To Live After a Bounce`、`Analytical Collision Normal 1`、`Analytical Collision Normal 2`、`Analytical Collision Plane Position 1`、`Analytical Collision Plane Position 2`、`Analytical Collision Plane Space`、`Collision Enabled`、`CollisionQueryAndResponse.AllowOffscreenDepthBufferParticlesToLive`、`CollisionQueryAndResponse.AnalyticalCollisionNormal`、`CollisionQueryAndResponse.AnalyticalCollisionPlanePosition`、`CollisionQueryAndResponse.AsyncGpuQuery`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CollisionLinearImpulse`

- 参数名：`ReflectedVelocity`、`ReflectedVelocityWithFrictionApplied`、`Dampen Velocity`、`Randomize Collision Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CollisionQuery`

- 参数名：`MovementThisUpdate`、`RemoveRestitution`、`TraceVectorTimesRadius`、`Bypass Physical Material Properties`、`Collision Enabled`、`Collision Size`、`DeltaTime`、`Depth Bounds`、`Line Trace Origin`、`Particle Friction`、`Particle Restitution`、`Query`、`Trace Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CollisionQueryAndResponse`

- 参数名：`ModuleAttemptedMovementThisUpdate`、`ModuleForceContribution`、`ModuleFrictionForceVectorInNewtons`、`ModuleFrictionForceVelocityVector`、`ModuleInitialDataInstanceAlive`、`ModuleInitialForceDividedByMass`、`ModuleNormalForceInNewtons`、`ModulePercentageOfTickDedicatedToUpdatingPosition`、`ModulePhysicsDeltaTime`、`ModulePlane Normal`、`ModulePlane Pivot Point`、`ModuleReflectedVelocity`、`ModuleReflectedVelocityWithFrictionApplied`、`ModuleRemoveRestitution`、`ModuleReturnedCollisionNormal`、`ModuleReturnedCollisionValidBool`、`ModuleReturnedCollisionWorldPosition`、`ModuleReturnedFriction`、`ModuleReturnedRestitution`、`ModuleTickDeltaForThisCollisionUpdate`、`ModuleTrace Origin`、`ModuleTraceDirection`、`ModuleTraceVector`、`ModuleTraceWorldEnd`、`ModuleTraceWorldStart`、`AllowOffscreenDepthBufferParticlesToLive`、`AnalyticalCollisionNormal`、`AnalyticalCollisionPlanePosition`、`AsyncGpuQuery`、`BounceCollisionFriction`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `CollisionRest`

- 参数名：`Minimum Rest Speed`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `DebugCollisionEvents`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FindTangentialVelocityOnSphere`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InitializeNeighborGrid`

- 参数名：`Coordinate Space For Rotation and Offset`、`DebugDraw`、`Grid Extents`、`Local Pivot`、`MaxNeighborsPerCell`、`New Neighbor Grid3D`、`NumCellsX`、`NumCellsY`、`NumCellsZ`、`Offset`、`Rotation`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `InitialRotationalVelocity`

- 参数名：`Rotate in Mesh Space?`、`X`、`Y`、`Z`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `NiagaraDistanceFieldCollisions`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PBD_IntraParticleCollision`

- 参数名：`Collision Query`、`CollisionRadius`、`FirstFrame`、`KineticFriction`、`Mass`、`NeighborGrid`、`ParticleAttributeReader`、`Position`、`Reduce unyeilding particle velocities`、`RelaxationAmount`、`Simulate`、`SimulationToUnit`、`StaticFriction`、`Unyielding`、`Unyielding Percentage`、`Use Persistent IDs`、`Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PopulateNeighborGrid`

- 参数名：`OutPosition`、`NeighborGrid`、`Position`、`Simulation To Grid Unit Transform`、`Use Persistent IDs`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `RayTrace`

- 参数名：`EndPosition`、`End Position`、`Max Trace Length`、`Minimum Step Size`、`Number Of Iterations`、`Ray Trace Vector`、`Start Position`、`Trace Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SceneDepthTest`

- 参数名：`Camera Query`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SetupRigidBodyDI`

- 参数名：`Overlap Extent`、`Overlap Orientation`、`Overlap Origin`、`Debug Actor Search Bounds`、`Rigid Body Trace Channel`、`Rigid Mesh Collision Query`、`Rotation`、`Skip Overlap Search`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。
