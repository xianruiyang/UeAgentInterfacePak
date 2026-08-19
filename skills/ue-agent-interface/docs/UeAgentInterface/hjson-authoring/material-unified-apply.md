# Material Unified Apply

## Scope

Material authoring uses two operation contracts under the shared Apply workspace coordinator:

- `uai.apply_input.material.asset`: create, update, upsert, clone, remove, root properties, function settings, and full graph replacement for `UMaterial` and `UMaterialFunction`.
- `uai.apply_input.material.graph_mutation`: incremental expression create/update/remove, expression-to-expression connection, and expression-to-material-root connection.

Both contracts run full preflight before persistent mutation, capture rollback state, apply lifecycle hooks, optionally compile/save, and compare expected/actual state snapshots before commit.

## Asset Apply

Asset identity is `target.asset_path`. Create requires `target.asset_kind` with `material` or `material_function`; update preserves omitted fields; create obtains omitted values from the registered UE factory default provider. Graph input is `provider_extension.graph`, function metadata is `provider_extension.function_settings`, and ordinary UObject fields use `properties[]` with the shared `property_path + value` contract.

Full graph replacement resolves every expression from the supplied class path, catalog identity, or material function path. Multiple supplied identities must resolve to the same class/function. Expression GUIDs are validated before mutation and remain stable through apply/readback. Node properties use shared Object Apply and PropertyValueCodec; the Material domain does not implement scalar, struct, container, or reference codecs.

Expression properties emitted by Export may contain readback annotations in addition to the writable descriptor core. Before full-graph replay, Material projects each exported descriptor through the shared `ProjectDescriptorForApply` contract and applies only the canonical writable fields. Projection or property-apply failures preserve the original structured error detail, so an Export workspace cannot fail opaquely after its descriptor has already passed shared parsing.

## Graph Mutation Apply

`provider_extension.mutation_kind` selects one of:

- `expression`: `create`, `update`, or `remove`.
- `connection`: `create`, `update`, or `upsert` using `from_expression_*` and `to_expression_*` selectors.
- `root_input`: `create`, `update`, or `upsert` using `expression_*` and `material_property`.

Expression selectors may use GUID, name, or index. If multiple selectors are supplied, all must identify the same expression; ambiguity or conflict fails preflight. `expression` create builds a scratch node from the actual UE expression class and applies optional structured properties to that seed, so omitted values retain UE class defaults.

The deprecated fine-grained HTTP commands now adapt their inputs to this contract. New authoring should use `material_apply_folder` or `material_function_apply_folder`; `material_set_expression_property` accepts the shared structured `value`, while `value_text` remains only as a deprecated command-boundary adapter.

## Transaction And Removal

Graph replacement and incremental mutations retain prior graph/input state until snapshot verification succeeds. Removed expressions are detached first and marked for garbage collection only at commit.

Asset removal uses the shared `FAssetRemovalStage`: the existing UObject is temporarily renamed inside its original package so the requested identity is absent during verification. Commit performs the physical delete; rollback restores the same UObject and original identity. Material and Niagara share this mechanism, avoiding same-name object recreation over a still-referenced deleted object.

## Verification

Relevant automated coverage:

- `GptProjectTest.UeAgentInterface.MaterialAuthoring.Apply`
- `GptProjectTest.UeAgentInterface.Smoke.MaterialExpressionLifecycleWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.MaterialWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.MaterialFolderWorkflow`
- `GptProjectTest.UeAgentInterface.Smoke.MaterialFunctionFolderWorkflow`

The domain test covers UE expression class defaults, invalid class preflight without mutation, structured property readback, conflicting selectors, expression removal, asset removal stage/rollback, and final asset removal.
