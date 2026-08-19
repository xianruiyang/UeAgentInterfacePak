# strict_v2 历史证据边界

本目录保存重构前 strict_v2 现场的历史证据。它满足以下硬边界：

- **no import**：活动 Plugin、CMD、Pak skill 或发布脚本不得从这里导入业务实现；
- **no runtime**：目录存在不表示其中脚本、测试、命令、计划或生成物仍可执行；
- **no authority**：旧需求、计划、audit、candidate、receipt、任务表和实现文档都不是当前需求、设计、
  任务状态、公开命令或完成判定真源；
- **no bulk conclusion**：不能只凭路径名、年龄、tracked 状态或旧结果批量删除，也不能整体恢复为活动面。

当前 1,880 个 path 的原始 byte 由 Pak recovery ref
`refs/heads/codex/recovery/root-env-20260819-pak-content`（commit
`c99c936771c2eee68f80f0bde8f3adeeef6cd06a`）保存；开发分支 adoption commit
`739bbee1ec04e65f518781ff6e952595b6c00073` 让同一现场可继续分类，但没有改变其历史身份。

Pak 根 `.ignore` 让本目录退出普通 `rg/fd/srcq` 发现。审计历史时应使用明确路径或 `--no-ignore`，并先
确认具体 consumer、用途、owner、版本和证据上限。某项只有在当前消费者已迁移或证明不存在、必要
证据已由正确 owner 保存、且退出动作可恢复时，才可以归档得更深或删除。

重新启用任何内容必须建立新的当前需求、设计、owner、正式入口和验证证据；复制回 active path、让旧
测试重新被发现，或从旧计划/receipt 推断当前完成都不构成重新启用。
