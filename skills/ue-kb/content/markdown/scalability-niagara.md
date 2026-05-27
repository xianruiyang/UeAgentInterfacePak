# Scalability（Niagara 内置模块）

# Scalability（Niagara 内置模块）

- 条目数：`3`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `EmitterScalability`

- 参数名：`bApplySpawnCountScale`、`bApplySpawnCountScaleByDistanceFraction`、`bUseMaxDistance`、`bUseMinDistance`、`MaxCulledState`、`MaxDistance`、`MinCulledState`、`MinDistance`、`SpawnCountScale`、`SpawnCountScaleByDistanceFraction`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `NumInstancesCull`

- 参数名：`CulledState`、`MaxInstances`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SystemScalability`

- 参数名：`CulledState`、`Enable Visibility Culling`、`Visibility Cull Delay`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

