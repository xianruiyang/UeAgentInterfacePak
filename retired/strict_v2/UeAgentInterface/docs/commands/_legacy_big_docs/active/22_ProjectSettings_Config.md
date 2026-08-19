# Project Settings / Config

本分册只提供命令导航；当前参数与返回以对应单命令文档为准。

## Project Settings

Project Settings 属性面使用 `uai.uobject_properties.v2`：

```hjson
{
  property_schema: uai.uobject_properties.v2
  properties: [
    { property_path: ProjectName value_kind: string value: { literal: "My Project" } }
  ]
}
```

- `project_settings_export_index`：发现 section id 和 schema/value 摘要。
- `project_settings_export_page`：导出 `ue_agent.project_settings.page.v2` HJSON。
- `project_settings_validate_page`：严格只读 preflight。
- `project_settings_diff_page`：结构化差异。
- `project_settings_apply_page`：原子提交、config 保存和 readback。

输入只接受 `properties[]` 或导出 HJSON 文件。属性 schema hash 不一致、未知属性、错误 `value_kind` 或非法 canonical value 都会阻断整次 apply。

## Raw Config

- `config_export_section`：按 ini section 导出 `entries[]/values{}`。这里的 `values{}` 是 config key/value 领域结构，不是 UObject 属性协议。
- `config_apply_section`：以 `set{}`、`remove[]`、`clear_section` 修改 ini section，单次请求原子提交。

Project Settings UObject authoring 与 raw config 操作是不同边界，不互相兼容或自动转换。
