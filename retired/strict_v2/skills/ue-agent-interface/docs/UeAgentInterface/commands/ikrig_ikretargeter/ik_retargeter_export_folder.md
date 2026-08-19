---
command: ik_retargeter_export_folder
category: ikrig_ikretargeter
title: IK Retargeter Structured Export
summary: Export one IK Retargeter as index.hjson
aliases: []
tags: [ik_retargeter, authoring, export]
status: active
---

# `ik_retargeter_export_folder`

Exports one `UIKRetargeter` through the shared read-only snapshot, projection, and HJSON writer pipeline.

Inputs: required `asset_path`; optional `folder_path`; optional `profile` (`llm_authoring`, `readback`, `debug`, or `validation`). The owned workspace is reset and exactly one `index.hjson` is written.

The response is the shared export workspace result plus normalized `asset_path`. Export does not compile, save, or mutate the retargeter.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md) for rig references, arbitrary retarget op structs, mappings, poses, and transform spaces.
