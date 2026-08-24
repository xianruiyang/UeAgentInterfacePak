# T23 Animation/Curve HJSON Domain

The sole Animation/Curve **HJSON** authoring ingress is
`client.content_graph.import_workspace(...)`; independent readback uses
`client.content_graph.structure(...)`. The shared SDK also exposes
`client.content_graph.export_workspace(...)`, but T23 does not claim a
lossless Animation/Curve export projection and returns
`animation_curve_domain_export_not_registered` instead of a false-success read
payload. `command_search`, `command_detail`, and `uai-cli` expose the same
current contracts. There is no task-local generated authority.

T13 owns initialization, recursive traversal, default resolution, binding,
failure, rollback, and cleanup. The T23 provider consumes that common contract
and registers `/Script/Engine.AnimSequence` and
`/Script/Engine.BlendSpace`; it has no private recursive or initialization
path.

Native skeleton references, curves, channels, keys, notifies, compression,
refresh, save/reload, and independent readback remain delegated to T56.

Missing-root creation is supported for BlendSpace only. Its `create` object
must identify a skeleton and dimension `1` or `2`; creation and axis/sample
editing are separate imports. Existing BlendSpace edits require the current
persisted-package revision plus explicit `axes` and `samples`. Independent
readback is structural even when the BlendSpace has no samples; it does not
misroute an empty asset through the sampling command.

AnimSequence HJSON editing requires an existing target and the exact current
revision; missing AnimSequence creation is rejected with
`animation_curve_domain_sequence_creation_not_supported`. Montage creation and
structure replacement belong to the direct `animation.montage.*` native public
commands and are not falsely claimed by this HJSON provider. Unregistered
creation, stale revisions, or native contract failures produce typed errors
without a false-success readback.
