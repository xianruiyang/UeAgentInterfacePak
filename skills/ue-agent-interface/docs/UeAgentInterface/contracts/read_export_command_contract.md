# Read and semantic export command contract
## Public authority

Read, search, query, probe, validation, difference inspection, and semantic
export use the shared `POST /api/uai/command` adapter and
`uai.command.v1` wire schema. Their public identities and fields come only
from the process-active `FUeAgentImmutableCommandRegistry`; the committed
manifest and generated Python bindings are one-way projections.

Public parameters never expose descriptor IDs, provider bindings, route
selectors, HTTP paths, or another dispatch language. Internal descriptor/route
inventories may remain implementation details, but they neither define nor
supplement the public command set.

## Command and content discovery

Unknown command identities are discovered through
`query.command.search`, then resolved through
`query.command.detail` with the exact returned `command_id` and
`contract_hash`. There is no public `reference.catalog_search`.

Object, asset, node, component, Actor, field and creation candidates belong to
the applicable domain Query surface. A selected identity must be accepted
unchanged by the downstream public read or authoring command; Python and the CLI
do not apply aliases or domain mappings.

## Read behavior

Query and read handlers are side-effect free. They validate the public input,
resolve the exact domain owner, and return a typed observation with its
identity, revision, completeness and applicable partial/failure information.
An internal result envelope being structurally valid is not business success;
callers check the command Result and its query/operation error before consuming
payload fields.

`reference.asset_read` accepts required `object_path` and optional
`context` and `projection`. It is an independent readback surface and does
not infer persistence from a previous apply result, a catalog candidate, or a
local file.

## Semantic export

`content_graph.export_workspace` accepts:

- required `target`;
- required `workspace_path`;
- optional `profile_id`.

The server performs a fresh content-graph read, composes the semantic authoring
model and export plan, and atomically publishes the workspace. Complete export
is not rejected by a hard token gate; token reduction comes from semantic
projection, profiles, references and deterministic file layout.

The returned artifact/receipt is evidence only for the command's declared
scope. A successful transport envelope does not by itself prove a complete
workspace, correct target coverage, or later importability.

## Retired routes and second truths

The retired `/api/uai/reference` and `/api/uai/export` routes, route-local
writers, route-local serializers, Python CommandSpec registries, and historical
command catalogs are not active and are not fallback paths. Tests and docs
must not restore them to satisfy an obsolete command count or receipt.

## Evidence boundary

Current contract tests verify that discovery, reference read, and semantic
export identities exist in the immutable manifest, that
`reference.catalog_search` is absent, that generated bindings contain the
same identities, and that public fields expose no internal dispatch data.
Domain product readiness still requires current public execution, real UE
observation, applicable persistence/readback, failure and cleanup evidence.
