---
command: ik_retargeter_validate_folder
category: ikrig_ikretargeter
title: IK Retargeter Structured Validation
summary: Preflight one IK Retargeter index.hjson without mutation
aliases: []
tags: [ik_retargeter, authoring, validate]
status: active
---

# `ik_retargeter_validate_folder`

Runs the same exact-file workspace, identity, native seed, recursive property, arbitrary op struct, controller document, spatial contract, and dependency preflight as Apply without mutating the target.

Input `folder_path` is required. Optional `asset_path` must match the document target. The response reports readiness, resolved intent, no-op state, and planned op, mapping, and pose mutations.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md).
