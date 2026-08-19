---
command: static_mesh_add_socket
category: static_mesh_enhanced_input
title: StaticMesh
summary: **Deprecated for authoring**：新增 Socket
aliases: []
tags: [static_mesh_enhanced_input, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增 Socket
deprecated_replacement: []
---

# `static_mesh_add_socket`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增 Socket
- key_inputs: `asset_path`, `rotation`, `location`, `scale`, `socket_name`
- key_returns: `replace_all=false`, `replace_all=true`, `sockets.json`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `rotation`：UE Rotator，单位 degree；与 `bounds` 一起决定生成物朝向。
- `location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scale`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `socket_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `replace_all=false`：布尔/开关字段；默认值以本命令契约为准。
- `replace_all=true`：布尔/开关字段；默认值以本命令契约为准。
- `sockets.json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
