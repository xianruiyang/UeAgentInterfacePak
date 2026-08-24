# T31 destructive content operation authority

The default SDK methods are `client.asset.delete`,
`client.asset.fixup_redirectors`, `client.asset.move`,
`client.asset.object_clone`, `client.modeling.actor_mesh_replace`,
`client.modeling.asset_material_slot_remove`,
`client.modeling.voxel_bounds_remove`,
`client.skeletal_mesh.remove_morph_target`,
`client.skeletal_mesh.remove_skin_weight_profile`,
`client.world.data_layer_delete`, `client.world.level_content_delete_scope`,
`client.world.level_streaming_move_actors`,
`client.world.level_streaming_remove`, and `client.world.pcg_cleanup`.
Callers discover current fields and hashes with `command_search` and
`command_detail`; `uai-cli` exposes the same exact contracts. No task-local
binding is active.

## Stable tutorial references

`query.command.detail` projects tutorial references from the frozen command
registry. Every T31 command includes
`uai-docs:t31-destructive-content-ops#destructive-plan-authorize-commit`.
`world.data_layer.delete` additionally includes
`uai-docs:t31-destructive-content-ops#world-data-layer-delete`. The two generic
command-discovery references remain bootstrap navigation; they do not replace
this domain workflow.

## Destructive plan, authorize, and commit

The destructive-content owner performs complete preflight and, when required,
issues a bounded authorization identity before mutation. Execution rejects a
missing, stale, mismatched, or replayed authorization before write. A success
is terminal only after native mechanics, persistence, independent readback,
and cleanup are complete. The SDK and CLI contain no selection, authorization,
Unreal mutation, rollback, retry, or cleanup business logic.

Call the generated method once without `destructive_authorization_id`. Review
the returned `impact_scope`, `revision_snapshot`, and `plan_fingerprint`; this
first call must return `terminal_status=planned` and must not mutate content.
If the scope is exact, repeat the same parameters once with the returned
authorization identity. Treat only `terminal_status=committed` together with
`persisted=true` and an independent domain readback as success. A rejected plan
may be rebuilt after reconciliation. `state_unknown` must not be replayed
automatically; recover through the durable journal workflow.

## `world.data_layer.delete`

Use `client.world.data_layer_delete(layer)` and obtain `layer` from the current
world Data Layer query. The exact resolver accepts one case-sensitive identity
returned by Unreal for the same instance: internal FName, short name, full
name, instance object path, or backing asset object path. Zero matches fail as
`world_data_layer_missing`; multiple matches fail as
`world_data_layer_identity_ambiguous`. Do not invent an alias or select the
first partial match.

The planned impact must include the map package, the actual
`AWorldDataLayers` external carrier package, and the exact Data Layer instance.
The authorization binds all three. Commit uses the editor Data Layer subsystem,
saves the affected durable packages, and independently reads absence before
returning success. For a World Partition map, reload the map and query Data
Layers again when durable persistence is part of the task oracle. Member Actor
external packages are not deletion targets merely because the Actor belongs to
the removed Data Layer; they must remain unchanged unless a separately planned
operation owns them.

`world.level_content.delete_scope` keeps `folder_path` as the required scope
boundary. Without `managed_id`, it is the explicit broad operation and includes
actors in that folder and its descendants. With `managed_id`, planning and
execution use the same exact managed-actor resolver: the world must contain
exactly one actor carrying both `UAI.Managed` and the canonical
`UAI.Id=<managed_id>` tag, and that actor must be in the exact `folder_path`.
Missing, duplicate, ambiguous, marker-less, or folder-mismatched identities
fail before mutation. The destructive plan projects that actor path rather than
the whole folder, so a same-folder sibling with a different managed identity is
outside the authorization and remains untouched.
