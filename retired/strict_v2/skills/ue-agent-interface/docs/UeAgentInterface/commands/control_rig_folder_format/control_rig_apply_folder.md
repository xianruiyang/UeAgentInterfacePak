---
command: control_rig_apply_folder
category: control_rig_folder_format
title: Control Rig Structured Apply
summary: Atomically apply one Control Rig index.hjson
aliases: []
tags: [control_rig, authoring, apply]
status: active
---

# `control_rig_apply_folder`

Applies the single `index.hjson` in required `folder_path`. Optional `asset_path` is an external identity assertion and must match `target.asset_path` in the document.

The document selects `create`, `update`, `upsert`, `clone`, or `remove`. Create uses the native Control Rig factory seed. Update and clone preserve omitted source state. Root `properties` and `provider_extension` participate in one preflight, transaction, rollback, compile/save hook, and shared snapshot verification.

Unknown workspace files and unknown provider fields are rejected. Legacy multi-file Control Rig folders are not accepted.

The response includes transaction `status`, `phase`, `resolved_operation`, `asset_path`, `object_path`, mutation counts, and rollback state. A successful result has already passed write-after-readback verification.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
