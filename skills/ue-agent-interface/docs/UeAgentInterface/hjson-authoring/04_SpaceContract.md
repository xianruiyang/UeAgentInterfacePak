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

`level_apply_folder` 的 3D transform 使用固定合同：Actor 为 `subject: actor.transform` 与 `Fwrite/Fread/Fverify: ue_actor_world_transform`；SceneComponent attachment 为 `subject: component.relative_transform` 与 `Fwrite/Fread/Fverify: ue_scene_component_parent_relative_transform`。每个 SceneComponent 的 Export attachment 都显式包含 `parent_component`、`socket_name` 和完整 `transform`；detached/root component 用空字符串表达无 parent/socket，不得通过缺字段暗示。Apply source 一旦提供 attachment，就必须同时提供 `parent_component` 和 `socket_name`，部分 attachment patch 以 `level_component_attachment_patch_incomplete` 拒绝。`dimension` 必须是字符串 `3d`，`conversion_chain` 必须是非空字符串。旧的数字 `dimension`、`semantic_frame/write_frame/read_frame/verify_frame`、`units` 和数组形式 `conversion_chain` 不再接受。

## Transform Owner 选择

`space_contract` 只定义坐标系与转换责任，不取代领域的值 schema。模型先按正在编辑的 authoring surface 选择 owner：

- 通用 UObject/FProperty descriptor 使用 [`uai.uobject_properties.v2`](02_CommonInputValue.md) 的 Transform value codec。
- World HJSON 的 `actor_upsert.transform` 使用当前 `content_graph.authoring_schema` 返回的动态字段合同；命名轴别名、components object 和规范化范围以该 schema 为准。
- Level Authoring 的 Actor/SceneComponent 持久化形态使用本页下方的 Level contract。

这些合同可以表达相同的空间语义，但输入形态不能互换。领域动态 schema 是该领域的字段权威；本页只要求其写入、读回和验证坐标系闭合。

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
    "translation": { "components": [0, 0, 120] },
    "rotation": { "components": [0, 90, 0] },
    "scale": { "components": [1, 1, 1] },
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

这是 Level Authoring 持久化层的 canonical 形态。上层 World HJSON adapter 使用其当前
`content_graph.authoring_schema`；直接进入 Level Authoring 的值不能把 World adapter 接受的
别名或其他领域形态当作 canonical。

## 禁止事项

- 不要把世界轴、屏幕轴、局部轴、父级轴、graph canvas、slot layout 混为一谈。
- 不要直接比较不同主体、不同坐标系或不同时间状态的 transform。
- 不要只因为字段名叫 `location` 就假设它是 world space。
- 合同不完整时，adapter 应拒绝输出 apply folder。
