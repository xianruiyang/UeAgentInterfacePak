# Rigging Structured Authoring

## Scope

The `rigging` authoring domain owns the unified structured workflow for:

- `control_rig` (`UControlRigBlueprint`)
- `ik_rig` (`UIKRigDefinition`)
- `ik_retargeter` (`UIKRetargeter`)

Each asset type uses one `index.hjson`. Directory Apply rejects unknown files. Export builds the complete one-file plan and publishes it through the owned staging publisher; it does not reset final before staging and writes only `index.hjson`.

Export and Apply are independent contracts. Export exposes only identity and editing-relevant state. Apply may accept operation controls and recursively structured input that Export does not emit.

## Root Document

```hjson
operation: update
target: { asset_path: "/Game/Rigs/Example", asset_kind: control_rig }
properties: []
provider_extension: {
  compile: true
  save: false
}
```

`operation` is one of `create`, `update`, `upsert`, `clone`, or `remove`. `clone` also requires `target.source_asset_path`.

Create begins with the native UE factory seed. Omitted fields retain UE factory defaults. Update and clone begin with a duplicate of the existing or source object, so omitted fields preserve source state. Apply never invents missing engine-owned defaults.

Root `properties` uses the shared recursive UObject/UStruct property descriptor contract. Properties already owned by `provider_extension`, such as preview meshes, shape libraries, and Retargeter rig references, are excluded from the root list so every field has one writer. The domain document uses UE controllers for hierarchy, RigVM, solver, chain, mapping, and pose mutation. Both sections participate in the same preflight, transaction, rollback, compile/save hooks, and state-snapshot verification.

## Control Rig

`provider_extension` accepts:

- `rig_type`: Control Rig type.
- `preview_mesh`: skeletal mesh asset path.
- `shape_libraries`: ordered `array<ue_asset_path>`.
- `hierarchy`: element map keyed by `kind:name`.
- `graphs`: graph map; each graph contains a node map and `links: array<[source_pin, target_pin]>`.
- `variables`: descriptor object containing `schema`, `variable_count`, and an ordered `variables` array.

Hierarchy transforms are authoring initial transforms in `parent_local_initial` space. Transient current transforms are not exported. Control settings are recursively encoded as deltas from a UE-initialized native struct. Omitted fields retain native defaults, and disabled limits omit their irrelevant minimum and maximum values. Control initial values retain their native scalar/vector/rotator/transform shape.

RigVM node positions use `rigvm_graph_canvas_2d`; they are not world or hierarchy coordinates. Node `pin_defaults` contains only non-empty top-level input/IO defaults keyed by relative pin name. Link endpoint pairs avoid repeating each endpoint as both a map key and a value. Update preserves existing nodes that are absent from the document, which allows unsupported engine node kinds to survive an otherwise structured round trip.

Blueprint variable names are preserved exactly, including meaningful whitespace. Variable defaults are associated through the UE variable GUID and the shared canonical property descriptor; Apply does not trim names or invent a second property-path rule.

创建 hierarchy curve 时，`value` 不只用于建立 curve storage：Apply 在 `AddCurve` 后通过 Rig Hierarchy API 显式写入请求值，因此第一次 Export→Apply→readback 就必须得到该值。更新已有 curve 使用同一写入语义。

## IK Rig

`provider_extension` accepts:

- `preview_mesh`: skeletal mesh asset path.
- `retarget_root`: bone name.
- `goals`: `map<goal_name, goal>`.
- `solvers`: `map<solver_id, instanced_struct>` plus `solver_order: array<string>`.
- `chains`: `map<chain_name, retarget_chain>`.

Goal `current_transform` is explicitly `character_global`. Goal-specific editable UObject properties use the shared property codec.

Goal 的 bone 绑定只在请求值与当前值不同时调用 `SetGoalBone`。等价重放保持 no-op；无效 bone 不能借由重复写入破坏已经正确的绑定。

A chain emits a non-empty `goal` only when that goal exists in the IK Rig. Dangling engine-side goal names are normalized to an empty optional reference instead of being presented as an applicable edit.

Each solver carries `struct_path` and a recursive typed `value` containing only fields that differ from a UE-initialized native struct. Apply resolves the actual `UScriptStruct`, initializes it through UE, decodes the supplied partial value, and rebuilds the controller-owned stack in `solver_order`. This supports engine and plugin solver structs without per-solver conversion code.

## IK Retargeter

`provider_extension` accepts:

- `rigs`: `source` and `target` IK Rig asset references.
- `preview_meshes`: `source` and `target` skeletal mesh asset references.
- `ops`: `map<op_id, instanced_struct>` plus `op_order: array<string>`.
- `mappings`: map keyed by `op:target_chain`.
- `poses`: explicit `source` and `target` pose collections.

Retarget ops use the same native-default `UScriptStruct` delta codec as IK solvers. Apply first validates the complete parent graph, materializes parents before children, and then restores the explicit execution `op_order`. An omitted or empty parent means no parent.

Pose root translation is `retarget_root_global_translation_delta`. Bone rotation offsets are `bone_local_rotation_delta`. Source and target are never inferred from an unlabeled transform.

## Export Profiles

- `llm_authoring`: identity and authoring state; default.
- `readback`: adds readback fields and may retain `value_text`.
- `debug`: adds diagnostics and may retain `value_text`.
- `validation`: minimal identity and contract-required state for validation.

The Rigging token budgets are `262144` for `llm_authoring`, `327680` for `readback`, `524288` for `debug`, and `32768` for `validation`. The authoring budget is based on a measured complex mannequin Control Rig export of about `206347` proxy tokens after semantic compaction, leaving bounded headroom without disabling the gate.

Known vector, rotator, quaternion, color, and transform values use numeric component arrays. Transform keeps named `translation`, `rotation`, and `scale` members whose values are arrays. Generic structs recurse through known basic types. Containers declare and preserve their element, key, and mapped types.

All floating-point encoding canonicalizes negative zero to `0`. This does not change UE numeric meaning and prevents `-0`/`0` churn across Apply round trips.

`operations`, `control_type`, `value_kind`, `property_path`, and `category_path` are not emitted unless required by the applicable shared contract. `value_text` is omitted from `llm_authoring` unless no reliable structured `value` exists.

## Verification

Apply preflights the complete workspace without mutating the target. Successful execution compares expected and actual shared state snapshots. Create, update, clone, remove, compile, save, and verification failures share one rollback path. Reapplying an equivalent update with `compile: false` and `save: false` is reported as a no-op.
