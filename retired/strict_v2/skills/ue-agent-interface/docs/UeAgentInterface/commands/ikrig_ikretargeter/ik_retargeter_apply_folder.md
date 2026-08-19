---
command: ik_retargeter_apply_folder
category: ikrig_ikretargeter
title: IK Retargeter Structured Apply
summary: Atomically apply one IK Retargeter index.hjson
aliases: []
tags: [ik_retargeter, authoring, apply]
status: active
---

# `ik_retargeter_apply_folder`

Applies the single `index.hjson` in required `folder_path`. Optional `asset_path` is an external identity assertion and must match the document target.

Create uses the native IK Retargeter factory seed. Grouped `rigs`, `preview_meshes`, arbitrary `ops` with `op_order`, parent relationships, mappings, and source/target poses are applied through `UIKRetargeterController`. Root `properties` use the shared recursive UObject/UStruct codec.

The command uses the shared atomic preflight, rollback, compile/save, and state-snapshot verification pipeline. Unknown workspace files and legacy multi-file folders are rejected.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
