# Read and semantic export command contract

## Public edge

Read, search, query, probe, validation, difference inspection, and semantic
export use the shared `POST /api/uai/command` edge and `uai.command.v1` wire
schema. The public command manifest is exported from the C++ command registry;
Python bindings are generated from that manifest. Public parameters never
expose descriptor IDs, provider bindings, route selectors, or another dispatch
language.

The read inventory contains 46 commands:

- 23 WorldRead commands;
- 16 AssetProjectRead commands;
- 7 ContentGraphRead commands.

Each command maps one-to-one to an exact immutable QueryDescriptor and one
production provider. Commands accept `input`, `context`, and `projection`
objects; commands that address a concrete object additionally require
`target`. Query and search return the common C10 projection of C2/C4 typed
truth and have no mutation path.

Domain input remains owned and validated by the selected descriptor. In
particular, `content_graph.compound` requires `input.sections`; the public edge
does not manufacture client-side business defaults. Semantic Export owns its
complete-section and closure defaults on the server.

## Production ownership

WorldRead resolves the explicit execution world, actor, component, navigation,
physics, and spatial owners. AssetProjectRead resolves real assets, registry
records, open editors, dirty packages, project settings, and configuration
scopes. ContentGraphRead resolves Blueprint, Material, Niagara, PCG, Animation,
and Audio owners and recursively captures their complete object hierarchy.

Canonical state preserves boolean, exact integer, decimal, string, array, and
object values together with type, default, authored presence, override state,
provenance, and revision. Recursive containers have no artificial nesting
depth limit; cumulative C1 resource budgets remain authoritative.

## Semantic export

`content_graph.export_workspace` requires:

- `target`: the asset object path;
- `workspace_path`: the destination directory.

Optional parameters are `input`, `context`, `projection`, and `profile_id`.
Export performs a fresh `content_graph.compound` read through the same C3Q
provider used by the public Query command, retains that C4 snapshot, composes
the C5 semantic authoring model and export plan, and publishes it through C8F.
The returned receipt includes the final workspace path, entry file, snapshot
ID, snapshot evidence ID, plan fingerprint, inventory hash, included file
count, and observed token telemetry.

The workspace is organized by semantic target, owner, and field set. It
preserves exact canonical values while using compact external field names and
does not serialize the raw C4 envelope. Complete export is never rejected by a
token hard gate. Token reduction is achieved through field contracts,
projection profiles, semantic units, and deterministic file layout.

The retired `/api/uai/reference` and `/api/uai/export` routes, legacy
route-local export writer, and route-local serializer are not active and are
not fallback paths.
