# T15 UMG/Widget Domain

`client.content_graph.import_workspace(...)` is the only public Widget
Blueprint HJSON mutation ingress. Its `source` union accepts `inline`,
`single_file`, and `directory` carriers; no UMG-specific apply command is
public. `client.umg.widget_candidates(...)` is the public read-only creation
query for one target Widget Blueprint. Shared `content_graph.*` reads and
export are the public persisted inspection paths. Discover either live
contract with `command_search` and `command_detail`; `uai-cli` exposes the
same discovery path. Existing non-HJSON UMG asset creation and widget-event
discovery commands keep their separate owners.

The accepted entry document is `uai.umg.edit/1` with exact root type
`/Script/UMGEditor.WidgetBlueprint`. The provider owns Widget Blueprint
settings and members, widget tree, native slot layout, bindings, animations,
recursive properties, and managed Blueprint graphs. Its content-graph readback
identifies widgets, slots, bindings, animations, hierarchy relations,
recursive properties, compile diagnostics, and persisted revision.

## Contextual widget creation

`umg.widget.candidates` binds its compact identities to the exact target
Widget Blueprint and target revision. Search may expose ordinary loaded
`UWidget` classes and Widget Blueprint asset entries, but only candidates with
`supported: true` may be used for creation. The current writable slice is
loaded non-`UUserWidget` native widget classes. Both `coverage_complete` and
`creation_coverage_complete` are `false`: this is not a claim of complete
Designer Palette equivalence.

The minimum HJSON selector is `candidate: {id: "candidate:..."}` or
`candidate: {name: Button}`. If both are present they must resolve to the same
candidate. A caller that already knows the class may retain `class` only as an
assertion; class is not required to create the widget. Instance identity,
parent and slot order remain outside the candidate:

```hjson
provider_extension: {
  widget_tree: {
    widgets: {
      "widget:ActionButton": {
        operation: create
        candidate: { id: "candidate:..." }
        parent: RootCanvas
        index: 0
      }
    }
  }
}
```

Before the first WidgetTree mutation, the server re-enumerates the same target
context and resolves the selector again. Creation then uses the public
`FWidgetTemplateClass` creation mechanics, including unique naming and
`CreatedFromPalette()`. The existing UMG authoring owner remains responsible
for parent/slot insertion, compile, save, unload/reload and independent
readback; search results do not carry those placement responsibilities.

`DCR-UAI-UMG-PALETTE-CATALOG-OWNER` blocks only the strict complete Designer
Palette catalog, filtering/category equivalence, UserWidget/asset/special
template creation, and an overall UMG-coverage claim. UE 5.6 assembles that
catalog in a private, active-editor-dependent ViewModel, so UAI does not copy
the private algorithm or open a visible Designer window to simulate it.

T13 is the sole carrier-loading and common recursive initialization authority.
It validates and recursively loads the public source, resolves one entry file,
binds the exact target identity, and passes a normalized `kind: "resolved"`
source containing the workspace documents to T15. T15 rejects legacy top-level
carrier or document fields, selects exactly one document matching `entry_file`,
parses only that entry, and registers only the Widget Blueprint root plus its
owned widget, slot, binding, and animation initialization contracts. It does
not implement a second parser, directory walker, recursion engine, reference
binder, rollback path, or carrier cleanup path.

Create uses `expected_revision: "missing"`; update and upsert use the exact
latest public content-graph revision. Success is terminal only after normal
Widget Blueprint compile and save, package unload, reload, and independent
readback. Unsupported roots or creation roles, source identity or entry
mismatch, stale revisions, unresolved widget/slot classes, invalid hierarchy
or bindings, and compile or lifecycle failures are typed terminal failures
without a retired-owner fallback or residue.
