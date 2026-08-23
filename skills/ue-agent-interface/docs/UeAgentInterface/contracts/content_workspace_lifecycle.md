# UAI Content workspace lifecycle

This document is the single formal owner for UAI-managed package namespaces in
the current project. It defines where Agent-owned work may be created and what
evidence is required to retain, reclassify, move, or remove it. It does not
classify pre-existing Content by name and does not authorize a mutation.

The canonical managed namespace is `/Game/UAI`. A package path is only a
routing hint: ownership also requires the current task, fixture, producer, or
run receipt to name the exact package. Content outside the canonical namespace,
and every legacy namespace not yet classified through Unreal semantics, is
user/unknown protected by default.

## Lifecycle classes

| Class | Canonical package root or entry | Owner and retention | Required exit |
| --- | --- | --- | --- |
| User or unknown content | The user-selected destination outside `/Game/UAI/**`, or any unclassified existing package | The user or an unresolved owner. Retain indefinitely. UAI may edit only the exact object authorized for the current task. | No automatic cleanup. Moving, renaming, replacing, or deleting requires a new exact impact decision and independent package/reference readback. |
| Active task content | `/Game/UAI/Tasks/<task_key>/**` while Agent-owned work has not been accepted | The current task contract and its receipts. Retain until the task is accepted, abandoned with evidence preserved, or reclassified. | Move through Unreal package semantics to the user's chosen destination, reclassify to a registered regression fixture, or remove only the exact task-owned packages after dirty/reference/recovery checks. |
| Long-term regression fixture | `/Game/UAI/Regression/<fixture_key>/**` | The formal test source or runner that names the exact package and reconstruction/acceptance oracle. Retain while that consumer remains active. | Retire or migrate the consuming test first, prove no remaining package consumers, then remove through the destructive-content contract and read back absence. |
| Reconstructable experiment | `/Game/UAI/Experiments/<capability_key>/<run_key>/**` | The exact experiment producer and a reproducible input/runner receipt. Retain only while it changes an active decision or reproduces an unresolved defect. | Extract the minimum durable evidence outside Content, confirm reconstruction inputs, then remove exact self-owned packages and read back absence. |
| One-time package output | `/Game/UAI/Transient/<run_key>/**` | The current run receipt. It must not acquire downstream consumers. If a filesystem artifact is sufficient, use `tmp/` or `runtimeLogs/` instead of Content. | Clean within the same run after the result is observed. A failed or uncertain cleanup is recorded as an unresolved exact package; it is never retried blindly or treated as absent. |

`task_key`, `fixture_key`, `capability_key`, and `run_key` are
UE-valid stable path segments. The task/result receipt keeps the mapping to the
full task or run identity; package folders do not duplicate task state.

## Creation and acceptance

Before the first mutation, the consumer records:

1. exact package/object identities and the intended lifecycle class;
2. current Asset Registry/package resolution and applicable references;
3. dirty resources and any user-selected destination;
4. the producer, reconstruction or acceptance oracle, retention decision, and
   planned exit;
5. the current command contract, authorization version, and recovery boundary.

Creation then uses only a current manifest command through the public `uai`
SDK or its thin CLI. A successful response is not acceptance: the consumer
waits for the operation's real terminal state, persists as required, and
independently reads the exact registry/package/object result.

Acceptance has only three durable outcomes:

- user content at a user-selected destination;
- a long-term regression fixture with a real formal test consumer;
- a task result that keeps no UE package after exact cleanup.

Representative evidence may be retained in `runtimeLogs/`; it does not require
retaining every generated package.

## Cleanup and migration gates

Cleanup or migration is permitted only for the exact packages owned by the
current task/run or by a formally retired fixture. The caller must use the
current destructive-content preview/authorization/execute contract and bind
its authorization to the exact target and current impact. Before execution it
checks dirty state, package resolution, hard/soft/manage/searchable-name
relations, recovery evidence, and any task-specific consumers.

After execution, an independent readback must cover every applicable layer:
service/object identity, package load/resolution, Asset Registry identity and
relations, on-disk package presence, dirty resources, and owned process/output
cleanup. An unresolved registry query alone proves neither disk absence nor
deletion safety.

A counterexample stops the batch. The caller records the exact package and
unknown layer, invalidates dependent cleanup assumptions, and returns to
classification or contract design. It does not retry a side-effecting request
because a transport disconnected.

## Legacy Content boundary

Existing roots including `/Game/__UAI_RSP004`, `/Game/__UAI_Smoke`,
`/Game/__UeAgentInterfaceScratch`,
`/Game/__UeAgentInterfaceValidation`, `/Game/AutoTests`,
`/Game/StrictV2`, `/Game/UAI_Automation`, `/Game/UAI_Temp`, and
`/Game/UAIValidation` are protected legacy/unclassified namespaces. They are
not aliases for the canonical root and are not migration or cleanup queues.

Classify a legacy package only when a current task touches it. Use Asset
Registry/package semantics and a real consumer to choose one lifecycle class;
then either leave it protected, migrate it through Unreal semantics with
reference readback, or remove an exact proved self-owned package. Directory
names, timestamps, Git tracking, and disk presence do not establish owner,
validity, or deletion authority.

## Current evidence boundary

The T46/T52 real-content chain proved one exact
`/Game/UAIValidation/T46/LV_T46_BackgroundWhitebox` lifecycle: create,
persisted readback, visual acceptance, restoration, destructive authorization,
and service/registry/disk absence. That package is not a permanent fixture.

The T54 read-only preflight confirmed that the same T46 target is no longer
registered. It also found a disk file at
`/Game/UAI_Automation/T47B/PublicSdkWorld_HLODLayer_Instanced` while both
registry record and relation queries were unresolved. This is direct evidence
that disk presence cannot classify or authorize legacy Content. It does not
establish whether that T47B file is loadable, referenced, obsolete, or safe to
remove.
