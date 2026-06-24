# Space Contract

任何涉及位置、旋转、缩放、布局、图节点坐标、控件 slot、socket、IK goal、ControlRig control、LevelContent transform 的 authoring 字段，都必须携带 `space_contract` 或由上级结构提供等价合同。

## 必填字段

```json
{
  "space_contract": {
    "subject": "exact object being edited",
    "dimension": "2d or 3d",
    "Fsemantic": "user intent frame and basis evidence",
    "Fwrite": "UAI/UE write frame",
    "Fread": "readback frame",
    "Fverify": "verification frame",
    "conversion_chain": "authoring -> write -> read -> verify conversion"
  }
}
```

## 字段含义

| 字段 | 含义 |
| --- | --- |
| `subject` | 被编辑的精确主体，例如某个 graph node、widget slot、socket、control、actor component。 |
| `dimension` | `2d` 或 `3d`。不要把 2D graph 坐标和 3D world transform 混用。 |
| `Fsemantic` | 用户语义坐标系。例如 UI layout、graph canvas、bone local、component relative、world。 |
| `Fwrite` | UAI/UE 实际写入坐标系。 |
| `Fread` | 读回字段所在坐标系。 |
| `Fverify` | 验证使用的坐标系。 |
| `conversion_chain` | 从 authoring 值到写入、读回、验证的转换链。 |

## 常见合同

Graph 节点布局：

```json
{
  "layout": {
    "position": { "x": 320, "y": 160 },
    "space_contract": {
      "subject": "Material node NoiseA",
      "dimension": "2d",
      "Fsemantic": "material graph canvas pixels",
      "Fwrite": "UEdGraphNode NodePosX/NodePosY",
      "Fread": "exported graph node position",
      "Fverify": "same graph canvas after export",
      "conversion_chain": "authoring.position -> NodePosX/NodePosY -> export position"
    }
  }
}
```

Component relative transform：

```json
{
  "relative_transform": {
    "translation": { "x": 0, "y": 0, "z": 120 },
    "rotation": { "pitch": 0, "yaw": 90, "roll": 0 },
    "scale": { "x": 1, "y": 1, "z": 1 },
    "space_contract": {
      "subject": "StaticMeshComponent Mesh",
      "dimension": "3d",
      "Fsemantic": "component transform relative to parent component",
      "Fwrite": "USceneComponent relative transform",
      "Fread": "exported relative transform",
      "Fverify": "same parent component relative frame",
      "conversion_chain": "authoring relative_transform -> SetRelativeTransform -> export relative_transform"
    }
  }
}
```

## 禁止事项

- 不要把世界轴、屏幕轴、局部轴、父级轴、graph canvas、slot layout 混为一谈。
- 不要直接比较不同主体、不同坐标系或不同时间状态的 transform。
- 不要只因为字段名叫 `location` 就假设它是 world space。
- 合同不完整时，adapter 应拒绝输出 apply folder。

