# Public Command Edge Contract
## Purpose

The public command edge is the transport-neutral entry used by generated
clients and the thin CLI. It accepts one exact `uai.command.v1` request and
forwards it through the process-active immutable C++ registry to one exact
handler. It does not expose internal descriptors, provider bindings, route
selection, sessions, tickets, or business defaults.

## Ownership

| Concern | Owner |
|---|---|
| process capability registration and one frozen authority snapshot | `DomainCapability` |
| command IDs, field shape, availability, side effects, purpose, errors and contract hash | domain command declarations frozen by `FUeAgentImmutableCommandRegistry` |
| formal SDK projection | `FUeAgentActiveCommandManifest` → `Resources/UaiCommandManifest.json` |
| wire encode/decode and request validation | `FUeAgentCommandProtocolCodec` / `FUeAgentCommandIngress` |
| exact command-to-handler mapping | `FUeAgentExactCommandDispatch` |
| transport-neutral service lifecycle | `FUeAgentCommandService` |
| HTTP route, authentication and adapter lifecycle | `FUeAgentInterfaceModule` and the concrete transport adapter |
| Query, authoring, operation and readback behavior | the exact domain handler and its application/mechanics owner |

Active composition and HJSON provider projection have no independent process
catalog. Module startup obtains the one cached DomainCapability authority,
verifies the committed manifest against its immutable command registry, and
only then publishes the command route. A missing or stale manifest fails
startup; the legacy registry and Python code are not fallback command sources.

## Transport binding

- wire schema: `uai.command.v1`
- transport channel: `uai.command`
- current HTTP adapter route: `POST /api/uai/command`
- authentication header: `X-UeAgentInterface-Token`

HTTP is only an adapter. The registry, protocol, exact dispatch, and domain
handlers do not select HTTP routes.

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
parameters remain omitted; explicit `null` remains explicit. JSON numbers keep
their original lexeme through protocol parsing.

A `command_result` preserves request identities and contains `ok`,
`payload`, and `error`. A successful envelope has an object payload and
`error=null`; a failed result preserves the server payload and structured
error. Envelope, registry, binding-hash, parameter, caller, and result-identity
failures return `protocol_error`. An `ok=true` envelope alone does not prove
that a write persisted or that independent readback matched.

## Discovery boundary

Command discovery is owned only by:

- `query.command.search(intent, limit?, cursor?)`
- `query.command.detail(command_id, contract_hash, variant_id?)`

Search returns a bounded candidate set with exact command identities and
contract hashes. A candidate may additionally carry an exact executable
`variant_id` when one command owns multiple policy/family request shapes. The
selected command/hash pair and optional variant are passed unchanged to detail.
Variant detail returns its exact purpose and complete top-level
`request_schema`; a command-only candidate keeps the generic command detail
contract. Variant identity selects discovery metadata and does not create a
second executable command or replace the command contract hash. There is no
public `reference.catalog_search`; target, field, node, component, Actor, and
other content candidates remain with their applicable domain Query owner.

## Reference read and effect

`reference.asset_read` accepts required `object_path` and optional
`context` and `projection` objects. It is the independent public readback for
the reference asset surface.

`reference.asset_apply` accepts required `object_path` and `intent`, plus
optional nullable `proposed_text`. The server owns target resolution,
authorization, mutation, persistence and readback. The SDK and CLI do not
construct internal descriptors, tickets, plans or success claims.

## Structured workspace commands

`content_graph.export_workspace` accepts:

- required `target:string`;
- required `workspace_path:string`;
- optional `profile_id:string`.

The server performs the fresh content read, semantic projection and atomic
workspace publication. Callers do not assemble internal read sections or
provider routes.

`content_graph.import_workspace` accepts:

- required `target:string`;
- required `source:object`;
- required `expected_revision:string`;
- required `authorization_id:string`;
- optional `limits:object`.

`source.kind` is `directory`, `single_file`, or `inline`. File-backed
sources carry `path`; inline sources carry the document specified by the
current HJSON contract. Domain intent is expressed by that document, not by a
client-side route, `intent`, or `dry_run` compatibility parameter. The C++
server owns parsing, planning, validation, mutation, compile/settle,
persistence, independent readback, failure state and cleanup.

## Manifest boundary

`Resources/UaiCommandManifest.json` is the deterministic client projection of
the active immutable registry. Its source kind is
`cpp_immutable_command_registry_export`. It contains only:

- command ID, namespace, method and active status;
- exact parameter name/type/required/nullable shape;
- supported wire range and binding hash;
- registry hash and exporter provenance.

It does not contain descriptor identities, HTTP routes, business defaults,
success rules, domain schemas, or Python business logic. Generated `.py` and
`.pyi` bindings consume only this manifest and are checked rather than
hand-maintained.

## Evidence boundary

The DomainCapability/T35 contracts prove one active registry, exact dispatch,
manifest equality, and absence of omitted-contribution fallback. Command-edge
and binding tests prove wire shape and one-command forwarding. Each domain still
requires its own public ingress, real UE mechanics, persistence/readback,
failure and cleanup evidence before its capability can be called complete.
