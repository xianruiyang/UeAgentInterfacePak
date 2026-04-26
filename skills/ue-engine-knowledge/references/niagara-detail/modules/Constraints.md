# Constraints（Niagara 内置模块）

- 条目数：`4`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `CalculateLinkConstraint`

- 参数名：未从资产元数据中提取到显式参数。
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MaintainA_SetDistanceBetweenPoints`

- 参数名：`TempPosition`、`Ideal Distance`、`Influence`、`Position`、`Target Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PendulumConstraint`

- 参数名：`IsUnderGoalLength`、`Angle Constraint (Degrees)`、`Calculate and Output Potential Energy`、`Use Angle Constraint`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PendulumSetup`

- 参数名：`Enable Spring Driver`、`Pendulum Length`、`Pendulum Pivot`、`Pendulum Pivot Offset`、`Pendulum Pivot Offset Coordinate Space`、`Pendulum Rest Axis`、`Rigid Pendulum`、`Spring Driven Constraint (Tightness)`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。
