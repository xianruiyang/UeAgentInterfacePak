# T19 PCG HJSON domain

`pcg-domain-provider` is the sole `content_graph.*` domain provider for
`/Script/PCG.PCGGraph`. The public SDK calls are
`client.pcg.node_candidates(...)` and
`client.content_graph.import_workspace(...)`; the schema is
`uai.pcg.edit/1`. Inspect the live contracts through
`client.query.command_search(...)` and `client.query.command_detail(...)`; `uai-cli exec`
forwards the same exact generated binding and is the CLI ingress.

The shared source loader owns inline, single-file, and directory carriers. T19
consumes only the normalized `source.kind=resolved` document set and does not
accept legacy top-level `carrier` or `hjson_document` fields.

T13 remains the sole common recursive initialization authority. T19 registers
only PCG root, node, endpoint, and parameter initialization contracts and
consumes that shared seam; it does not create another recursive dispatcher.

## Root lifecycle

A new PCG Graph uses `expected_revision: "missing"` and a root `create` object.
The public target owns the final package path and asset name; conflicting
declarations fail before write. Root creation delegates to the existing
`pcg.graph.asset.create` owner and cannot be combined with an edit in the same
import. Create the root first, use its independent readback revision, then issue
the edit as a second explicit public command.

An existing graph uses the exact current `content_graph` revision and one root
`operation`:

- `pcg.graph.apply` for node, pin, edge, ordering, and supported graph edits;
- `pcg.graph_parameters.apply` for graph parameter edits.

The nested `target_ref` must match the public request target. T19 forwards one
normalized request to the existing PCG mechanics owner; it does not copy graph
planning, UE node construction, compile, save, reload, or cleanup behavior.

## Candidate-to-authoring chain

`pcg.node.candidates` constructs the native PCG Editor graph context for the
target `UPCGGraph` and enumerates its background right-click menu through
`UEdGraphSchema::GetGraphContextActions`. The public result is a bounded view of
that complete native action owner, not a global `UPCGSettings` class catalog.
Each row exposes a compact `id`, the native menu `name`, presentation fields,
`action_kind`, and explicit `write_support`/`support_reason`. Search coverage
and creation coverage are separate: the complete background menu is searchable,
while only `FPCGEditorGraphSchemaAction_NewNativeElement` is currently enabled
for creation.

The minimal HJSON selector is `candidate: {id: ...}` or, when unique in the
same graph context, `candidate: {name: ...}`. If both are present they are
conjunctive. Do not copy the complete search row, a settings class path, an
internal revision, the semantic node identity, or placement into `candidate`.

```hjson
edits: [{
  depends_on: []
  element_kind: item
  identity: "pcg_node:CreateGrid"
  intent: create
  value: {
    candidate: { id: "candidate:..." }
    position: [160, 96]
  }
}]
```

Preflight re-enumerates the same native graph context and resolves one exact
action. Commit re-enumerates again and invokes that action's public
`PerformAction`; it does not map the selector to a second settings-class
constructor. The returned native node supplies the immediate committed state,
which is then checked through save, unload/reload, and independent readback.
Missing, ambiguous, wrong-context, unsupported-action, or non-conjunctive
selectors fail before the first planned write.

## Lifecycle and readback

Both root creation and mutation must return a real mutation receipt, settled
compile state, saved package, unload/reload receipt, and independent persisted
`ContentGraphRead` snapshot. Unsupported schema/root/operation combinations,
stale revisions, target mismatches, invalid candidates, and lifecycle failures
fail explicitly without a legacy fallback. `content_graph.export_workspace`
remains explicitly unavailable until a complete round-trip export contract is
registered.
