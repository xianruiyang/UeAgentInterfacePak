# T24 Animation Rig Graph HJSON Domain

`animation-rig-graph-domain-owner` is the only public owner for
`animation_rig_graph.candidates` and the T24 HJSON domain projection. The
public SDK calls are `client.animation_rig_graph.candidates(...)` and
`client.content_graph.import_workspace(...)`. Use `client.command_search(...)`
and `client.command_detail(...)` to inspect their live contracts; `uai-cli`
exposes the same discovery path. No task-specific helper or tutorial-owned
registry is authoritative.

`animation_rig_graph.candidates` is read-only and target-sensitive for exact
persisted ControlRigBlueprint, IKRigDefinition, IKRetargeter, and Skeleton
targets. It returns concrete native RigUnit struct identities with opaque
binding revisions, explicit placement-space requirements, and truthful bounded
paging. For candidate-backed Control Rig edits, copy the complete candidate,
including `target_ref`, `target_revision`, supported operations, input and
placement contracts, required context, and binding revision. The adapter
normalizes that transport binding into the native identity; callers must not
guess a RigUnit struct or reuse a stale candidate.

The `uai.animation_rig_graph.edit/1` provider is a thin adapter over the shared
HJSON import lifecycle. It owns only classification, initialization-contract
selection, schema-to-command routing, and domain completion checks. T13 is the
sole common recursive initialization authority; T24 registers only the
Rig/IK/Skeleton root, control, bone, constraint, and space contracts and
consumes that seam. T13 alone loads inline, single-file, and directory carriers
and owns directory recursion; T24 consumes only the normalized
`source.kind=resolved` document set, selects exactly the declared `entry_file`,
and rejects legacy top-level `carrier` and `hjson_document` fields.

Writes delegate unchanged to the AnimationRig command owner for Control Rig
hierarchy and shape-library application, IK Rig definition and auto-generation,
IK Retargeter definition and settings, and Skeleton definition, compatibility,
and virtual-bone application. RigVM unit placement is a two-dimensional graph
position and does not require a three-dimensional hierarchy-space contract.
Creating or updating Control Rig hierarchy controls does require the explicit
parent-space contract and transform required by the native command. The domain
does not add a second asset factory, recursive initializer, RigVM writer,
compiler, persistence path, readback authority, or cleanup path.

Missing-root creation is supported for
`/Script/ControlRigDeveloper.ControlRigBlueprint`,
`/Script/IKRig.IKRigDefinition`, and `/Script/IKRig.IKRetargeter` through their
existing native asset owners. `/Script/Engine.Skeleton` is an editable existing
root but is not created by this provider. Creation and definition editing are
separate revision-guarded imports.

IK Rig readback exposes skeletal-mesh binding, retarget root, goals, solvers,
and exact retarget-chain names. IK Retargeter readback exposes source and target
rig bindings, chain mappings, and settings. These projections and Control Rig
controls/RigVM units share one native structure-capture owner, so candidate,
mutation, HJSON readback, and generic ContentGraph readback do not maintain
separate topology models. Retarget definition imports require at least one
explicit mapping; obtain source and target chain names from the two IK Rig
readbacks instead of guessing them.

Successful import compiles or validates through the native owner, saves,
reloads, and returns independent `content_graph.*` readback. Missing roots,
stale revisions, target mismatch, invalid candidates or spaces, unsupported
root creation, or unregistered operations fail before write or roll back
without residue. Native input-contract failures retain their actionable typed
error code at the HJSON boundary instead of being collapsed into a generic
domain failure.
