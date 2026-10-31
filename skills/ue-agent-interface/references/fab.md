# Fab 资源

使用公开 `client.fab` 指令。UAI 在 Editor 内使用 Fab 原生浏览器；分类和免费目录搜索/详情可匿名查询，用户库、状态和下载授权仍使用已有登录。调用者不读取或传递认证凭据，也不直接请求 Fab 网页/API。

## 选择与获取

资产取舍见[具体场景的选型与组合反馈](../../ue-essential-knowledge/references/07-world-level-rendering/scene-production-stages.md#选型与组合反馈)。已有项目资产能满足当前用途时直接复用；需要 Fab 候选时，以下查询为具体选型提供内容、格式与成本信息，不把下载设为开始搭建的前置。

- `status()` 检查插件、UAI能否取得原生会话及后台浏览器的实际用户库访问，不直接读取FabTab的登录UI。`open()`返回时持久会话恢复可能尚未完成；不能把暂不可用或后台请求失败说成用户退出登录。已知会话正常时不必在每条命令前重复检查。
- `open()` 显式打开原厂 Fab Tab，让其恢复持久登录或供用户完成登录/验证码；默认请求非激活打开，`activate=True` 用于需要立即交互时。打开成功不代表已经登录，随后用 `status()` 确认。状态和搜索不会隐式开窗。
- `categories()` 返回 Fab 原生产品类型；用返回的 `type` 或 `parent=category` 展开子树。默认只展开一层，确需完整树再用 `depth=0`。这里是分类结构，不是用户库数量统计。
- `search()` 默认 `scope="library"`；`scope="free"` 查询免费公开内容，不自动领取。组合 `query`、`type`、`category`；分类值从 `categories` 复制。免费目录支持 `styles=["stylized", "medieval"]` 这样的原生 Style 筛选，slug 从 Fab 公开搜索页选择筛选后的 URL 复制；Rendering Style 与 Period/Theme 共用该字段。关键词与风格筛选职责不同，不把关键词命中称为风格已筛选。用户库的 Style 支持尚未确认，会明确拒绝该组合。按 `has_more/next_page` 使用相同筛选翻页，不把当前页当成全部。
- `asset(name=..., select=..., scope=...)` 沿用搜索返回的原始名称、语义消歧和来源，读取描述、许可名称、格式、文件、大小及可用版本信息。免费目录详情还可复制搜索的 `listing_url`，直接读取那个公开条目并核对名称/语义选择，避免宽泛标题搜索的全分页；默认名称查询保持完整消歧。缺失兼容信息表示未知；完整说明和条款可打开返回的公开 listing 链接。
- `download(...)` 沿用同一资产选择，必要时明确 `format` 和 `file`；同名文件复制详情的 `file_select`。可用 `save_as` 给本地下载起短名。默认文件选择不明确时按诊断返回的真实选项选择，不猜序号或私有标识。
- `downloads()` 分页列出本项目已完成的下载记录。`files(download=..., query=..., page=...)` 查看下载内容或 ZIP 内的全部文件，可按路径关键词筛选并翻页；不解压、不导入。这两类本地查询读取当前已发布记录，不等待活动网络请求或下载结束。`import_asset(download=...)` 重新校验本地内容后导入；这三步不要求在线登录。

查询和传输使用共享 Operation。连续操作用 SDK 等待实际业务结果：

```python
with client.operation.named("fab-pickaxe-download"):
    started = client.fab.download(name="Basic Pickaxe", save_as="Pickaxe")
started.raise_for_error()
result = started.operation.finish_result(timeout=600)
result.raise_for_error()
```

相关调用复用同一个连接。需要在下载期间查看既有资源时，先提交并 `resume()` 原下载 Operation，再发出本地查询并消费各自结果；查询不代表原下载已完成。新下载或修复中的内容没有完成记录时，`downloads()` 不列出它，`files()` 返回 `fab_download_not_ready`；消费这份新内容前仍须完成原下载 Operation。同步原生导入可能占用 Editor 游戏线程，本地查询不能抢占该调用。

超时或断连先 `client.operation.recover(name)` 接续原操作；丢失本地句柄按[SDK 与 runner](sdk-and-runners.md)的 discover/takeover 流程恢复。取消用 handle 的 `close()`，等原生收尾确认后再发替代请求。同步原生导入不能在任意指令中途强行打断，会在返回受控边界后响应取消；不要把尚在等待当成已取消。已结束的下载失败可用同一选择重试，取得新授权并复用或修复私有缓存。

## 导入边界

通用模型/贴图等使用 UE 原生 AssetTools 导入器，`destination` 是新的空 `/Game` 子目录，缺省为 `/Game/Fab/<标题>`。ZIP 中有多个可能的主文件时，用 `files()` 的 `query` 和 `next_page` 查齐候选，再将准确路径传入 `entry`；诊断中的有限预览不是完整清单。依赖文件保留在相邻位置，所需 importer 由当前 UE 插件提供。

原生 UE 内容包按原始 `/Game` 路径整包导入，省略 `destination` 或传 `/Game`，并省略 `entry`；后者不会被静默忽略，也不提供从包中选择单个 uasset 的能力。获取前用详情的大小、格式及已有内容信息判断整包是否值得取用；下载后 `files()` 可核对内容，但不能据此选择性导入原生包。直接改磁盘目录会破坏包内引用，导入后确需迁移时使用公开 `asset.move`。已有资产不覆盖。项目和插件安装包需要相应安装流程，不能当作普通内容资产导入。

导入成功包含保存与独立重新加载，结果给实际资源路径及数量；超过摘要上限会明确标记，进一步查找使用普通资产查询。需要学习包内形制时，按实际导入目录使用[文件夹资产总览](asset-preview.md#文件夹资产总览)筛选当前空间所需部件，再在UE中独立组织实例。导入表示资源可用，不表示已经摆入场景或满足视觉目标。原生导入器错误保留具体原因，成功结果也可能携带warning，应结合其对象和原因判断。失败保留原始诊断及公共恢复信息，不以重新导入替代恢复。

`state="recovery_required"` 表示尚未确认恢复原状。保留失败的 `Result`，使用其 `durable_journals` handle 先 `inspect()`，再按恢复状态 `reconcile()`；后者只核对当前状态，不主动删除或覆盖文件。仍为 `state_unknown` 时按具体原因处理恢复，未闭合时不重放 `import_asset`。判断真实恢复结果，不把“收据已记录”当成“回滚成功”。

## Fab 状态异常

| 诊断 | 对应处理 |
| --- | --- |
| `fab_unavailable` | 在对应 Editor 启用 Fab；按正常项目生命周期处理所需重启 |
| `fab_native_session_unavailable` | UAI尚取不到原生会话；Fab刚打开时等持久恢复完成。若用户My Library已可用，保留现有登录并报告原生会话差异，不要求重复登录 |
| `fab_login_required` | 后台请求HTTP401，不能据此认定FabTab退出；结合`fab.authenticate`或`fab.request`阶段处理。已登录库可用时先查适配器会话，不反复重登，不索要Cookie/Token |
| `fab_interaction_required` | 诊断区分后台页实际出现challenge与HTTP403拒绝，并保留`fab.session/csrf/authenticate/request`阶段及HTTP状态。原生FabTab与UAI后台浏览器不同，不能假定前台交互会解除后台限制 |
| `fab_download_access_required` | 打开资产页面核实所有权、领取和许可要求；免费不等于已取得许可，不自动接受条款或购买 |
| `fab_request_failed` / 传输失败 | 结合 HTTP/原生错误判断临时网络问题；恢复仍在运行的操作，已终止的再重试 |
| `fab_response_changed` | 原生协议与适配不一致，保留具体诊断交插件维护；不绕到凭据提取或猜测 API |
| `fab_cache_record_invalid` / `fab_cache_file_changed` | 缓存记录或文件已损坏，不能继续导入；已结束的下载用同一资产与文件选择重试修复 |
| `fab_download_not_ready` | 用 `downloads()` 选择已完成记录；若原下载仍在运行，先按 Operation 恢复并完成 |
| `fab_pack_header_invalid` / `fab_pack_version_incompatible` | 根据具体包文件、损坏位置或版本原因，重新获取完整文件或从资产详情选择兼容版本；重复导入同一内容不会修复源文件 |

正式字段以当前 `describe` / `command_usage` 为准；只输出当前选择所需的公开字段，不展开内部 Operation、journal、哈希或传输凭据。
