# T21 Audio HJSON Domain

`audio-graph-domain-owner` is the only public owner for
`audio.graph.candidates` and the T21 HJSON domain projection. The public SDK
calls are `client.audio.graph_candidates(...)` and
`client.content_graph.import_workspace(...)`. Use `client.command_search(...)`
and `client.command_detail(...)` to inspect their live contracts; `uai-cli`
exposes the same discovery path. No task-specific helper or tutorial-owned
registry is authoritative.

`audio.graph.candidates` is read-only and target-sensitive. For a SoundCue it
returns concrete node classes; for a MetaSoundSource it returns registered
frontend class names and versions. Candidate name, kind, version, binding
revision, target revision, and placement contract are exact opaque identities.
Copy the complete selected candidate into the HJSON operation, including its
`target_ref`, `target_revision`, supported operations, input and placement
contracts, required context, binding revision, and MetaSound version fields.
Do not reconstruct a candidate from a display label or class name.

The `uai.audio_graph.edit/1` provider is a thin adapter over the shared HJSON
import lifecycle. It owns only classification, initialization-contract
selection, schema-to-command routing, and domain completion checks. T13 is the
sole common recursive initialization authority; T21 registers only the audio
root, node, endpoint, connection, parameter, and external-reference contracts
and consumes that seam. T13 alone loads inline, single-file, and directory
carriers and owns directory recursion; T21 consumes only the normalized
`source.kind=resolved` document set, selects exactly the declared `entry_file`,
and rejects legacy top-level `carrier` and `hjson_document` fields.

Writes delegate unchanged to `metasound.graph.interface.mutate`,
`metasound.graph.node.mutate`, `metasound.graph.link.mutate`,
`metasound.graph.default.mutate`, `metasound.graph.compile_settle`,
`sound_cue.graph.node.mutate`, `sound_cue.graph.relation.mutate`,
`sound_cue.graph.root.mutate`, and `sound_cue.graph.compile_settle`. The domain
does not introduce a second asset factory, recursive initializer, graph
compiler, persistence path, readback authority, or cleanup path.

The provider supports both missing-root creation and existing-root editing for
`/Script/Engine.SoundCue` and
`/Script/MetasoundEngine.MetaSoundSource`. Missing-root creation uses
`expected_revision: "missing"` and a root `create` object; creation and graph
editing are separate imports. Existing-root import requires the exact current
content-graph revision and must not carry `create`.

Successful import compiles or validates through the domain owner, saves,
reloads, and returns independent `content_graph.*` readback with a native
lifecycle receipt. Stale revisions, target mismatch, invalid or stale
candidates, unsupported operations, and native contract failures are returned
as actionable typed errors before write or after rollback without residue.
Export remains unsupported until a complete-workspace contract is registered.
