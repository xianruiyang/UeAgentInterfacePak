# AttributeReader（Niagara 内置模块）

# AttributeReader（Niagara 内置模块）

- 条目数：`3`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `SampleParticlesFromOtherEmitter`

- 参数名：`SampledIndex`、`SampledPosition`、`SpawnParticlesSpace`、`Applied Alpha Scale`、`Applied Position Offset`、`Applied RGB Scale`、`Applied Velocity Scale`、`Maximum Sampled Particle Age`、`MaxSampledAgeCutoff`、`Minimum Sampled Particle Age`、`MinSampledAgeCutoff`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpawnParticlesFromOtherEmitter`

- 参数名：`EmitterHasZeroParticles`、`InterpStartDT`、`IntervalDT`、`SpawnCount`、`SpawningIsEnabled`、`SpawnRate`、`Attribute Reader`、`Maximum Age Spawn Threshold`、`Minimum Age Spawn Threshold`、`Spawn Group`、`Spawn Rate`、`Spawn Rate Per Particle Cap`、`Spawning Enabled`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `UpdateParticlesFromOtherEmitter`

- 参数名：`SampledPosition`、`SpawnParticlesSpace`、`TargetID`、`Applied Alpha Scale`、`Applied Position Offset`、`Applied RGB Scale`、`Applied Velocity Scale`、`Attribute Reader`、`Target Particle ID`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

