# Simple Authoring typed CRUD contract

## Scope

Simple Authoring activates 102 typed UE mutation commands through the shared
public command edge. The five production families are:

| Family | Command count | Public namespace |
|---|---:|---|
| WorldSimpleEffect | 9 | `world` |
| LandscapeGeometryEffect | 2 | `landscape` |
| ModelingGeometryEffect | 31 | `mesh` |
| AssetDataSimpleEffect | 53 | `asset` |
| EditorProjectSimpleEffect | 7 | `editor_project` |

The exact command IDs, Python methods, parameter names and wire types are the
102 entries exported in `Resources/UaiCommandManifest.json`. The manifest is a
deterministic projection of the production C++ registry; documentation and
Python code do not maintain a second command list.

## Caller flow

The public caller performs only these steps:

1. use the active domain Query/candidate command to select a canonical target
   and obtain its current revision and any required field identities;
2. call one generated typed SDK method with the command's declared parameters;
3. inspect the returned operation outcome and structured error;
4. use the active domain Query/readback command to independently confirm the
   resulting state when the task needs an external readback.

There is no public `reference.catalog_search` command. Command discovery uses
`query.command.search` followed by exact `query.command.detail`; target and
field discovery stays with the active domain owner instead of a second global
target directory.

For update-style commands, `target_ref` identifies the selected target,
`expected_revision` prevents stale writes, and `changes[]` contains typed field
changes. A change states the field identity, presence and typed canonical
value. Create, delete and domain operations expose only their compiled
Descriptor inputs; callers do not construct sessions, bindings, tickets,
plans, execution receipts, persistence artifacts or claimed readback.

Python uses one import and one connection context:

```python
import uai

with uai.connect("connection.toml") as client:
    result = client.editor_project.project_settings_update(
        changes=changes,
        expected_revision=target_revision,
        target_ref=target_ref,
    )
```

The SDK forwards the generated command over the configured transport. It does
not implement UE business rules or a second authoring path.

## One runtime path

Every active typed command follows the same production composition:

```text
public command edge
  -> exact command contract and thin handler
  -> immutable family profile
  -> exact target/reference resolution
  -> C3 operation application
  -> C6 plan
  -> C7 GenericEffect execution
  -> C8D durable persistence
  -> C9 independent persisted readback
  -> C10 outcome
```

Command handlers only decode the public parameters and select the exact
immutable profile bound at startup. They do not choose mutation mechanics by
string, save files, synthesize verification results or fall back to legacy
handlers.

`complete` requires durable acknowledgement and a semantic match from the
independent persisted readback. A mismatch is `partial`; unavailable durable
state is `state_unknown`. A successful transport envelope is not proof of a UE
state change.

## Target, field and revision semantics

- Catalog candidates expose canonical selectors and generations.
- Exact resolution rejects ambiguous, missing or incompatible targets.
- `expected_revision` is checked before mutation and is not copied into the
  expected post-write business state.
- C9 re-resolves the persisted target after C8D. It must not reuse the live
  object, pre-write snapshot, handler cache or caller-provided value.
- Editor Project settings/config readback uses durable config-file state rather
  than the mutable global config cache.
- Legal canonical values have no policy-defined nesting-depth limit. Resource
  budgets still bound bytes, nodes and execution work.

## Persistence ownership

C8D owns persistence for all five families. Package-backed content is saved as
an owned package artifact; Editor Project profiles use their declared project
config artifact. Domain hooks mutate UE state but do not independently save or
delete durable artifacts.

Consequently, the following standalone legacy write/save commands are retired
and have no exact or prefix invoker:

- `save_current_level`
- `level_streaming_save`
- `modeling_save_mesh_asset`
- `level_topology_set_actor_assignments`
- `config_apply_section`
- `project_settings_apply_page`
- `device_profile_apply_json`
- `localization_apply_json`
- `platform_config_apply_json`
- `scalability_apply_json`
- `string_table_apply_json`

There is no alias, dual write, fallback or compatibility route for these IDs.
Lifecycle command parameters that happen to use names such as
`save_current_level` are separate parameter contracts and do not reactivate a
standalone command.

## Editor Project mapping

The seven Editor Project write commands are:

- `editor_project.config_section.update`
- `editor_project.device_profile.update`
- `editor_project.localization_target.update`
- `editor_project.platform_config.update`
- `editor_project.project_settings.update`
- `editor_project.scalability_group.update`
- `editor_project.string_table.update`

Callers select the target through the relevant active Editor Project Query
surface, then request its exact write metadata with the closed
`editor_project_capability: "target.read"` action. The five Query commands are
`config.section`, `config.resolved_value`, `project.settings`,
`project.platform`, and `project.validation`; they all route `target.read` to
the same production Editor Project resolver. The observation contains
`target_ref`, `profile_id`, and `target_revision`; project-settings targets also
contain exact `fields[]` identities, type IDs, current canonical values, and
field revisions, while config-backed targets contain independently loaded
`entries`.

The caller then submits the matching generated update method and uses the same
Query route for independent readback. It must not guess a revision, restore
`reference.catalog_search`, or maintain a second target/field catalog. All
seven commands share the same authority, revision, C8D and C9 rules while
retaining their profile-owned fields and native UE mutation hooks.
