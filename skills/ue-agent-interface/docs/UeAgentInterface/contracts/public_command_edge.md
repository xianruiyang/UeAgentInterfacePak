# Public Command Edge Contract

## Purpose

The public command edge is the transport-neutral entry used by generated
clients and the CLI. It exposes one immutable C++ command registry and forwards
each valid request to exactly one C++ handler.

It does not expose the internal Query/Operation descriptor, server session,
binding ticket, candidate binding, route selection, or business defaults.

## Ownership

| Concern | Owner |
|---|---|
| command IDs, parameter shape, wire range, status, binding hash | `FUeAgentImmutableCommandRegistry` |
| formal SDK input | `Resources/UaiCommandManifest.json`, exported from the C++ registry |
| wire encode/decode and parameter validation | `FUeAgentCommandProtocolCodec` / `FUeAgentCommandIngress` |
| exact command-to-handler mapping | `FUeAgentExactCommandDispatch` |
| transport binding and authenticated principal | `FUeAgentTransportService` / `FUeAgentCommandService` |
| Query/effect behavior | unified C3Q/C3O application ports owned by the composed production runtimes |

Runtime dispatch always uses the C++ registry. The owned C++ exporter test
verifies the committed manifest byte-for-byte before client generation or
release; a stale SDK projection does not disable unrelated Editor routes at
runtime, and it never becomes a fallback command source.

## Transport binding

- wire schema: `uai.command.v1`
- transport channel: `uai.command`
- current HTTP adapter route: `POST /api/uai/command`
- authentication header: `X-UeAgentInterface-Token`

HTTP is only an adapter. The contract registry, codec, dispatch, and handlers do
not select or inspect HTTP routes.

## Request and result

A command request has these exact top-level fields:

- `schema`
- `version`
- `message_kind=command_request`
- `correlation_id`
- `request_id`
- `command_id`
- `command_binding_hash`
- `params`

Unknown top-level fields and unknown parameters are rejected. Omitted optional
parameters remain omitted; explicit `null` remains explicit. JSON numbers are
parsed with their original lexeme, so integers above the exact IEEE-754 range
are not rounded during protocol round-trips. Ordinary nested JSON has no
policy-defined depth limit.

`command_result` preserves the request identities and contains `ok`, `payload`,
and `error`. A successful result has an object payload and `error=null`; a
failed result preserves both the server payload and structured error. Envelope,
registry, binding-hash, parameter, caller, and result-identity failures return
`protocol_error`.

## Active commands

The production registry currently exports 340 unique active contracts through
one immutable manifest. They cover command discovery/detail, calibrated Query,
Read/Export, Reference CRUD, Simple Authoring, domain candidate/authoring,
Timeline/Spatial, GraphCompound, destructive/import, long-running/session and
the shared content-graph HJSON ingress. The Simple Authoring contracts are defined by the five-family
[`simple_authoring_typed_crud.md`](simple_authoring_typed_crud.md) contract.
All 212 commands use this same edge and exact C++ registry; family commands do
not add domain HTTP routes.

### TimelineSpatial commands

The 59 TimelineSpatial commands are generated from the exact WorldSpatial,
TimelineAnimation, and RigSimulationSpatial activation profiles. Each command
has one handler and enters either the unified Query application or the unified
Operation application according to its immutable operation kind. Python and
the HTTP adapter do not select adapters or domain families.

`viewport.instance.list` is a discovery command and therefore does not require
a caller to know a viewport identity in advance. Its production result exposes
explicit `level:<index>` identities for the current editor world. Directory
readback remains available when the editor is minimized and a viewport has no
renderable surface; projection, ray, and pixel-scale commands retain their own
renderable-surface preconditions. The production QueryComposition is replaced
after an Editor map opens so world-bound handlers do not remain attached to the
startup `Untitled` world.

### `content_graph.import_workspace`

Parameters:

- required `target:string`
- required `carrier:string`
- required `hjson_document:string`
- required `expected_revision:string`
- required `authorization_id:string`
- optional `limits:object`

`carrier` identifies the external-input carrier while `hjson_document` carries
the exact versioned document. The server validates target, carrier, authorization,
revision and bounded resource limits before any write. T13 owns the shared
initialization and recursive composition path; domain adapters do not parse or
recursively reinterpret the document.

The C++ server owns source loading, HJSON semantics, execution, persistence,
and independent unload/reload readback. A successful persisted response reports
`mutation_applied`, `compile_settled`, `package_saved`, and
`unloaded_reloaded`; callers must not infer persistence from `ok=true` alone.
The client forwards exactly one command and does not implement HJSON business
logic.

### `query.command.search` and `query.command.detail`

`query.command.search` accepts required `intent:string` plus optional bounded
`limit` and `cursor`. It returns a small candidate set; this is the only fuzzy
step. `query.command.detail` requires the selected `command_id` and exact
`contract_hash`, then returns the full parameter contract, invocation templates
and stable tutorial references. Callers pass that identity unchanged to the
generated method, `Client.execute_exact`, or the CLI.

Target/content discovery remains owned by the selected public Query or domain
candidate command; command discovery never substitutes a target identity.

### `reference.asset_apply`

Parameters:

- required `object_path:string`
- required `intent:string` (`create`, `update`, or `delete`)
- optional nullable `proposed_text:string`

The handler calls the existing reference C3O application. The server resolves
the exact candidate, reads persisted pre-state, issues the binding ticket, and
constructs the internal operation request under one resource/deadline/
cancellation context. Clients do not create or submit session, descriptor,
binding, or ticket data.

### `reference.asset_read`

Parameters:

- required `object_path:string`

This is the public independent readback for a reference asset. The handler
performs exact catalog search, exact candidate resolution, and persisted
state-read through the existing C3Q application boundary while keeping the
session, descriptor, candidate and binding data server-owned.

The returned snapshot contains the persisted projection when the asset exists
and an empty `entries` array after deletion. It does not infer existence from a
catalog candidate, local files, or a previous apply result.

## Manifest boundary

`Resources/UaiCommandManifest.json` contains only the deterministic registry
projection needed for static client generation:

- command ID, namespace, method, status;
- exact parameter name/type/required/nullable shape;
- supported wire range and command binding hash;
- registry hash and C++ export provenance.

It does not contain Descriptor identities, HTTP routes, business defaults,
success/verification rules, domain schemas, or Python CommandSpec data.

The Automation test
`UeAgentInterface.Composition.TimelineSpatial.E3.ActivationContract` is the
owned C++ exporter and byte-for-byte verifier for the complete production
registry. Set
`UAI_UPDATE_COMMAND_MANIFEST=1` only for the intentional export run; normal
runs verify without rewriting the file.
