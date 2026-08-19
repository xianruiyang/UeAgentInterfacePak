---
command: control_rig_validate_folder
category: control_rig_folder_format
title: Control Rig Structured Validation
summary: Preflight one Control Rig index.hjson without mutation
aliases: []
tags: [control_rig, authoring, validate]
status: active
---

# `control_rig_validate_folder`

Runs the same workspace loader, exact-file checks, input contract, native seed resolution, recursive property parsing, domain controller parsing, identity resolution, and dependency preflight used by Apply, without mutating the target.

Input `folder_path` is required. Optional `asset_path` must match the document target.

The response reports `status`, `requested_operation`, `asset_exists`, `would_create`, `no_op`, `units_checked`, and planned Control Rig mutation counts.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
