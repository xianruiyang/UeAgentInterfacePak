---
command: level_diff_folder
category: level_content
title: Diff Level Workspaces
summary: 按 canonical workspace unit 比较两份统一 Level HJSON 目录。
tags: [level_content, hjson, workspace, diff]
status: active
---

# `level_diff_folder`

先用 Level workspace contract 分别加载两份目录，再比较 `index.hjson`、Actor unit 和 Component unit 的 canonical document。比较忽略 HJSON 排版差异，但保留真实结构和值差异。

```json
{
  "base_folder":"Saved/UeAgentInterface/Authoring/LevelBase",
  "target_folder":"Saved/UeAgentInterface/Authoring/LevelEdit",
  "max_changes":256
}
```

- `base_folder` 别名为 `left_folder`。
- `target_folder` 别名为 `right_folder`。
- `max_changes` 默认 256；达到上限时 `truncated=true`。

成功返回 `schema=uai.level.workspace_diff.v1`、`equal`、`change_count`、`truncated` 和按相对路径排序的 `changes[]`。每项只报告 `path` 与 `kind=added|removed|changed`，不会展开大段属性 payload。

Diff 是只读 workspace 审阅工具，不连接当前 world 做语义状态比较，也不替代 `level_validate_folder` 或 Apply 后的 `level_export_folder` 读回。
