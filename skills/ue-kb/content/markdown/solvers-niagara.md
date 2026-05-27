# Solvers（Niagara 内置模块）

# Solvers（Niagara 内置模块）

- 条目数：`4`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `ApplyInitialForces`

- 参数名：`PhysicsForce`、`PhysicsRotationalForce`、`Apply Force to Position`、`Apply Force to Velocity`、`Apply Rotational Force to Rotational Velocity`、`Positional Force Warmup Time`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ApplyRotationVector`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SolveForcesAndVelocity`

- 参数名：`AdvectionVelocity`、`DeltaTime`、`DragIgnoreMass`、`DragVelocity`、`ForceRotationsInRadians`、`InverseDeltaTime`、`InverseMass`、`Mass`、`PhysicsDrag`、`PhysicsForce`、`RotationalForce`、`RotationalInertia`、`Acceleration Limit`、`Force`、`Manually Enable Drag Local Offset`、`Manually Enable Rotational Solver`、`Mesh Orientation`、`Position`、`PreviousVelocity`、`Rotational Force`、`Rotational Inertia`、`Rotational Velocity`、`Speed Limit`、`Velocity`、`PreviousVelocity needs to replace Particles.RotationalVelocity as soon as transient parameters can be used to drive module input defaults`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SolveRotationalForcesAndVelocity`

- 参数名：`DeltaTime`、`ForceRotationsInRadians`、`Mesh Orientation`、`Rotational Inertia`、`Rotational Velocity`、`PreviousVelocity needs to replace Particles.RotationalVelocity as soon as transient parameters can be used to drive module input defaults`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

