# Events（Niagara 内置模块）

- 条目数：`6`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `GenerateCollisionEvent`

- 参数名：`EventCondition`、`Boolean to Send as Localspace Flag`、`Color to Send as Linear Color (ParticleColor)`、`Delay Between Collision Events`、`Event Condition`、`Event Generation Enabled`、`EventDelay`、`Float to Send as Float 1 (NormalizedAge)`、`Float to Send as Float 2 (RandomNormalizedFloat)`、`Integer to send as Int32 (Number of Collisions)`、`Niagara ID to Send as Particle ID  (Ribbon ID)`、`Random Value`、`Use Time Between Events`、`Use Velocity Threshold`、`Vector to Send as Vector 1 (Position)`、`Vector to Send as Vector 2 (Velocity)`、`Vector to Send as Vector 3 (Collision Normal)`、`Velocity Threshold`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `GenerateDeathEvent`

- 参数名：`EventCondition`、`Acceleration To Send`、`Boolean to Send as Localspace Flag`、`Color to Send as Linear Color (ParticleColor`、`Event Condition`、`Event Generation Enabled`、`Event Probability`、`Float to Send as Float 1 (NormalizedAge)`、`Float to Send as Float 2 (RandomNormalizedFloat)`、`Float to Send as Float 3 (DistanceTraveled)`、`Float to Send as Particle Age`、`Float to Send as Random Float`、`Gap Correction Amount`、`Niagara ID to Send as Particle ID  (Ribbon ID)`、`Particle ID to Send`、`Position To Send`、`Vector to Send as Vector 1 (Position)`、`Vector to Send as Vector 2 (Velocity)`、`Vector to Send as Vector 3 (Acceleration)`、`Velocity To Send`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `GenerateLocationEvent`

- 参数名：`EventCondition`、`InterpStartDt`、`MovementThresholdVectorLength`、`SpawnSpacing`、`Acceleration To Send`、`Boolean to Send as Localspace Flag`、`Color to Send as Linear Color (ParticleColor`、`Delay Age Attribute`、`Delay Before Sending Events`、`Event Generation Enabled`、`Event Probability`、`Event Send Rate`、`Float to Send as Float 1 (NormalizedAge)`、`Float to Send as Float 2 (RandomNormalizedFloat)`、`Float to Send as Float 3 (DistanceTraveled)`、`Float to Send as Normalized Particle Age`、`Float to Send as Random Float`、`Gap Correction Amount`、`Movement Tolerance`、`Niagara ID to Send as Particle ID  (Ribbon ID)`、`Particle ID to Send as Ribbon ID`、`Per Unit Delta Time`、`Per Unit Velocity Vector`、`Position To Send`、`Unit Spacing`、`Use Event Send Rate`、`Use Movement Tolerance`、`Vector to Send as Vector 1 (Position)`、`Vector to Send as Vector 2 (Velocity)`、`Vector to Send as Vector 3 (Acceleration)`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ReceiveCollisionEvent`

- 参数名：`Angle`、`DecalDirection`、`DecalNormal`、`DecalOrientation`、`EventAcceleration`、`EventBool`、`EventLinearColor`、`EventNormal`、`EventNormalizedAge`、`EventNumCollisions`、`EventPosition`、`EventRandomNormalizedFloat`、`EventRibbonID`、`EventVelocity`、`FallBackRandom`、`FirstFallBackAngle`、`FirstFallBackDirection`、`Forward`、`IncomingCollisionVelocity`、`InheritedVelocity`、`Random01`、`RandomNormalizedFloat`、`Right`、`SecondFallBackAngle`、`SecondFallBackDirection`、`SpacingInterval`、`Up`、`Add Velocity Along Collision Normal`、`Apply Alpha`、`Apply RGB`、以及另外 `1` 个参数
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ReceiveDeathEvent`

- 参数名：`EventAcceleration`、`EventBool`、`EventDistanceTraveled`、`EventLinearColor`、`EventNormalizedAge`、`EventPosition`、`EventRandomNormalizedFloat`、`EventRibbonID`、`EventVelocity`、`SpacingInterval`、`Apply Alpha`、`Apply RGB`、`Inherit Velocity`、`Inherited Velocity Scale`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ReceiveLocationEvent`

- 参数名：`EventAcceleration`、`EventBool`、`EventDistanceTraveled`、`EventLinearColor`、`EventNormalizedAge`、`EventPosition`、`EventRandomNormalizedFloat`、`EventRibbonID`、`EventVelocity`、`InheritedVelocity`、`RandomNormalizedFloat`、`SpacingInterval`、`Apply Alpha`、`Apply RGB`、`Inherit Parent Normalized Age`、`Inherit Velocity`、`Inherited Velocity Scale`、`SpawnCount`、`Use Acceleration`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。
