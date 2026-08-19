---
command: ik_rig_export_folder
category: ikrig_ikretargeter
title: IK Rig Structured Export
summary: Export one IK Rig as index.hjson
aliases: []
tags: [ik_rig, authoring, export]
status: active
---

# `ik_rig_export_folder`

Exports one `UIKRigDefinition` through the shared read-only snapshot, projection, and HJSON writer pipeline.

Inputs: required `asset_path`; optional `folder_path`; optional `profile` (`llm_authoring`, `readback`, `debug`, or `validation`). The owned workspace is reset and exactly one `index.hjson` is written.

The response is the shared export workspace result plus normalized `asset_path`. Export does not compile, save, or mutate the IK Rig.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md) for goals, arbitrary solver structs, ordered stacks, chains, and transform spaces.
