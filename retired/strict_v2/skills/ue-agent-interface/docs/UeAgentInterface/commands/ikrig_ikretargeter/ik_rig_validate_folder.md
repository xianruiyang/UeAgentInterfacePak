---
command: ik_rig_validate_folder
category: ikrig_ikretargeter
title: IK Rig Structured Validation
summary: Preflight one IK Rig index.hjson without mutation
aliases: []
tags: [ik_rig, authoring, validate]
status: active
---

# `ik_rig_validate_folder`

Runs the same exact-file workspace, identity, native seed, recursive property, arbitrary solver struct, controller document, and dependency preflight as Apply without mutating the target.

Input `folder_path` is required. Optional `asset_path` must match the document target. The response reports readiness, resolved intent, no-op state, and planned goal, solver, and chain mutations.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
