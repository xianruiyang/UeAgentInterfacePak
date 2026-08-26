# T24 Animation Rig Graph HJSON Domain

`animation-rig-graph-domain-owner` is the only public owner of
`animation_rig_graph.candidates` and the T24 HJSON domain projection. The
public SDK calls are `client.animation_rig_graph.candidates(...)` and
`client.content_graph.import_workspace(...)`. Use
`client.query.command_search(...)` and `client.query.command_detail(...)` for the live
input, result, failure, and tutorial contract; Markdown is supporting guidance,
not a second command registry. `uai-cli` exposes the same discovery path.

## Candidate search boundary

`animation_rig_graph.candidates` currently accepts a ControlRigBlueprint and
enumerates the native `FRigVMActionMenuBuilder` menu for its default RigVM
graph in blank context. It initializes the public model-to-editor-graph delegate
used by the editor, but does not open an asset window. The search result reports
the exact target revision, graph name, native action count, executable action
count, paging state, and two separate coverage claims:

- `coverage_complete=true` means the returned catalog covers that default-graph
  blank context.
- `creation_coverage_complete=false` means some searchable native action kinds
  are intentionally search-only. The verified write surface currently consists
  of `URigVMEdGraphUnitNodeSpawner` actions.

This is not a claim about pin-drag, selected-node, selected-asset, or every other
Control Rig editor context. IKRigDefinition, IKRetargeter, and Skeleton remain
valid T24 HJSON/readback roots, but they are not targets of this RigVM candidate
command.

Each candidate exposes compact selection and support fields such as `id`,
`name`, `label`, `action_kind`, `category`, `summary`,
`write_support`, `support_reason`, and `supported_operations`. Do not copy
the search row, target revision, label, category, tooltip, or an old
`binding_revision` into HJSON.

## Minimal HJSON creation

A RigVM create edit selects what to create with only `candidate.name` or
`candidate.id`. If both are present, both must resolve to the same current
native action. Instance identity and graph placement remain outside the
candidate:

```hjson
edits: [{
  intent: create
  semantic_id: "rigvm_node:AddSpaces"
  value: {
    candidate: { id: "candidate:..." }
    position: { x: 240, y: 144 }
  }
}]
```

When the model already knows more, `script_struct_ref` and `method` may be
provided beside `candidate` as assertions. They do not replace `name/id`.
Hierarchy parent, transform/space contracts, graph context, instance identity,
placement, pins, links, defaults, and properties never become candidate
identity.

Preflight re-enumerates the current native blank-context menu, resolves the
selector, and rejects search-only action kinds before the first write. Commit
re-enumerates again and invokes the selected action's own `PerformAction`.
The owner may rename the resulting model node to the `semantic_id` suffix,
then records the actual native struct, method, and position for independent
readback. It does not fall back to `AddUnitNodeFromStructPath` or a copied
class/struct catalog.

Update and delete remain existing-node operations and do not pretend to be
candidate creation.

## Domain lifecycle and other roots

The `uai.animation_rig_graph.edit/1` provider consumes the shared resolved
workspace lifecycle. T13 alone is the recursive initialization authority and
owns inline, single-file, and directory loading; T24 selects the declared
`entry_file`, routes the registered
root and operation, and rejects legacy top-level `carrier` and
`hjson_document` fields.

The same domain continues to route Control Rig hierarchy and shape-library
operations, IK Rig definition and auto-generation, IK Retargeter definition and
settings, and Skeleton definition, compatibility, and virtual-bone operations.
Their own explicit parent, transform, chain, and space contracts still apply;
the compact RigVM candidate rule must not be generalized into those unrelated
identities.

Successful import compiles or validates through the native owner, saves,
unloads/reloads, and returns independent content-graph readback. Missing roots,
stale revisions, target mismatch, ambiguous or unsupported candidates, invalid
assertions/spaces, unsupported root creation, or unregistered operations fail
before write or roll back without residue.
