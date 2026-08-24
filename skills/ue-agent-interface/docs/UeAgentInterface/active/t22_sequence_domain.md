# T22 Sequence HJSON domain

Use command discovery only through the default SDK:

```python
candidate = client.query.command_search(
    "edit one Level Sequence setting without replacing tracks",
    limit=3,
).payload["candidates"][0]
detail = client.query.command_detail(
    candidate["command_id"],
    candidate["contract_hash"],
)
```

The model-facing authoring flow starts with
`client.content_graph.authoring_schema(target)`. For an explicitly supported
Level Sequence target, `payload["query_result"]` returns the exact schema ID,
field owner and field set, allowed intents, current values, a sparse editable
template, and the current content-graph revision. This command is the public
field schema authority: callers copy those identities and values rather than
guessing field names or reading old examples as a second schema.

```python
import json

authoring = client.content_graph.authoring_schema(target).payload["query_result"]
document = authoring["template"]
field = document["root"]["fields"][chosen_field]
field["value"] = desired_value
edited_hjson = json.dumps(
    document,
    ensure_ascii=False,
    separators=(",", ":"),
)

result = client.content_graph.import_workspace(
    target,
    {"kind": "inline", "document": edited_hjson},
    authoring["revision"],
    authorization_id,
)
state = client.content_graph.structure(target)
```

`authorization_id` must be the exact ID obtained from the authorized workflow;
examples do not mint or guess one. Missing fields preserve current state. The
returned field contract decides whether `set`, `remove`, `null`, or
`default` is supported. Unsupported intents fail before native mutation with
the owning field and JSON pointer. The current Sequence schema exposes a
non-destructive sparse settings surface; it does not imply that every Sequence
field or every HJSON domain supports the same intents.

`content_graph.import_workspace` remains the only public HJSON write contract.
Its source may be inline, single-file, or directory; all three carriers resolve
to the same document semantics. The Sequence provider delegates sparse settings
to `client.timeline.sequence_settings_update(...)` and full structure
replacement to `client.timeline.sequence_structure_replace(...)`. Direct
native callers discover both contracts with
`client.query.command_search(...)` and
`client.query.command_detail(...)`; a content-graph revision and a native
Timeline revision are different contracts and must not be interchanged.

T13 is the initialization mechanics owner for common source resolution,
validation, planning, rollback, and cleanup. The Sequence domain provider owns
its HJSON schema and field semantics. T55 owns native Level Sequence mutation,
compile/settle, save, unload/reload, and independent readback. These roles form
one delegation chain, not competing public implementations.

The shared SDK also exposes
`client.content_graph.export_workspace(target, workspace_path)`. For a Level
Sequence, the active Sequence provider publishes a directly re-importable
`uai.sequence.edit/1` entry and a verified
`uai.content_graph.workspace/1` manifest. The current export is deliberately a
`sequence.timeline.settings/1` projection, not a lossless export of the whole
asset: require `scope.field_set_complete=true`,
`scope.asset_structure_complete=false`, and
`scope.omitted_structure_preserved=true` in the result. Edit only fields owned
by that field set, keep the exported `base_revision`, and update the manifest
content hash before directory import. Use
`client.timeline.sequence_read(...)` for independent persisted readback; never
infer track, section, or key coverage from this partial export.

The exact CLI surface is available through `uai-cli exec <command-id>` with
the current command hash and one JSON parameter object. No task-specific
generated binding or Python-side Sequence/HJSON business logic is active.
