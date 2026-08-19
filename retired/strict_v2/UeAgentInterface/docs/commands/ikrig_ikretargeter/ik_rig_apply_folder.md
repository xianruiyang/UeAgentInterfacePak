---
command: ik_rig_apply_folder
category: ikrig_ikretargeter
title: IK Rig Structured Apply
summary: Atomically apply one IK Rig index.hjson
aliases: []
tags: [ik_rig, authoring, apply]
status: active
---

# `ik_rig_apply_folder`

Applies the single `index.hjson` in required `folder_path`. Optional `asset_path` is an external identity assertion and must match the document target.

Create uses the native IK Rig factory seed. Goals, solver structs, solver order, and retarget chains are applied through `UIKRigController`; root `properties` use the shared recursive UObject/UStruct codec. Arbitrary solver `UScriptStruct` values are supported through `struct_path` plus typed `value`.

The command uses the shared atomic preflight, rollback, compile/save, and state-snapshot verification pipeline. Unknown workspace files and legacy multi-file folders are rejected.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
