# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答（续 2）

# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/lpbK/unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5
- 原始文件：unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5.origin.md
- 分段：第 2/5 段

By default — no, because UE strips all UE_LOG calls in Shipping builds. You have two options: - Use a Test Build (Server/Development Shipping) from the GitHub source engine These builds keep UE_LOG, unlike the Launcher version. Use a Test Build (Server/Development Shipping) from the GitHub source engine These builds keep UE_LOG, unlike the Launcher version. - Use GLS_LOG instead of UE_LOG GLS intercepts logs safely in Shipping builds and shows them in the GLS overlay. This is the recommended and safe method — GLS_LOG is removed from final distribution builds when GLS is disabled. C++ build

flag -gls_disable or bEnableLogsInShippingBuilds = false on ini configs 复制完整片段 (1行长度) Use GLS_LOG instead of UE_LOG GLS intercepts logs safely in Shipping builds and shows them in the GLS overlay. This is the recommended and safe method — GLS_LOG is removed from final distribution builds when GLS is

disabled.

### 什么是 -gls_disable 构建标志以及何时应该使用它？

-gls_disable 在打包过程中完全关闭 GLS。您必须在最终发行版本（Steam、PlayStation、Xbox 等）中使用此标志，以便： - GLS 覆盖完全禁用，GLS 覆盖完全禁用， - 不收集 GLS 日志，不收集 GLS 日志， - 发布的游戏中不会出现调试信息。附带的游戏中没有出现调试信息。这可确保符合商店要求并防止将内部调试数据暴露给玩家。

### 如何在最终发行版本中正确禁用 GLS 以通过认证？

您有两个安全的选择： - 在设置中关闭 GLS 日志记录：bEnableLogsInShippingBuilds = false （在 Project Settings 或 DefaultGame.ini 中） 在设置中关闭 GLS 日志记录：bEnableLogsInShippingBuilds = false （在 Project Settings 或 DefaultGame.ini 中） - 或者保持启用状态，但将游戏打包为：-gls_disable 这将完全禁用覆盖和日志收集。或者保持启用状态，但使用以下命令打包游戏：-gls_disable 这将完全禁用覆盖和日志收集。任何一种方法都可以保证 GLS 在您的最终商店构建中完全关闭，并且可以安全进行认证。

### GLS_LOG 在没有 UI 的专用服务器版本中可用吗？

不会。GLS 在专用服务器构建中会自动禁用 - 插件不会加载，并且覆盖层不会初始化。 GLS_LOG 调用只是回退到 UE_LOG，因此服务器构建无需 GLS 即可正常工作。

### C++ 日志记录

### 为什么应该使用 GLS_LOG 而不是 UE_LOG？

当您在 UE_LOG 受限或不可用的情况下需要日志时，请使用 GLS_LOG： - 在运输版本中工作（UE_LOG 被完全剥离）。适用于 Shipping 版本（UE_LOG 已完全删除）。 - 按类、对象、函数、标签、网络角色和 PIE 实例进行高级过滤。按类、对象、函数、标签、网络角色和 PIE 实例进行高级过滤。如果您只需要在开发版本中进行标准控制台日志记录，则 UE_LOG 就可以 - 但对于运输中或设备上的实际调试，GLS_LOG 是更好的选择。

### 如何在我的 C++ 类中启用 GLS_LOG？

要在 C++ 中使用 GLS_LOG： - 在编辑 → 插件 → 游戏日志系统中启用该插件。在编辑 → 插件 → 游戏日志系统中启用插件。 - 在模块的 .Build.cs 中，添加 GLS 模块： PublicDependencyModuleNames.AddRange(new string[] { "GLS" });在要记录的 .cpp（或 .h）中，包括： #include <GLSMacroses.h> 在模块的 .Build.cs 中，添加 GLS 模块： PublicDependencyModuleNames.AddRange(new string[] { "GLS" });在要记录的 .cpp（或 .h）中，包括：#include <GLSMacroses.h> - 现在您可以使用：GLS_LOG(LogTemp, Display, TEXT("Hello from GLS_LOG"));现在您可以使用： GLS_LOG(LogTemp, Display, TEXT("Hello from GLS_LOG"));

### GLS_LOG中的上下文系统如何工作，与UE_LOG有何不同？

GLS_LOG 自动捕获调用日志的 UObject 上下文 — 类、对象实例、函数、网络角色、PIE 索引等。这允许您按以下条件过滤日志： - 类、 - 特定对象、特定对象、 - 函数、函数、 - 网络角色（服务器/客户端）、网络角色（服务器/客户端）、 - PIE 实例。 PIE 实例。 UE_LOG 不捕获此上下文。它仅写入纯文本消息，没有指向生成它的对象的链接。借助 GLS_LOG，每条消息都与其来源相关联，从而使过滤和调试更加精确 — 特别是在多人游戏、PIE 和大型项目中。

### 使用 GLS_LOG 宏安全吗？

是的——GLS_LOG 是完全安全的。 - 在运输版本中，GLS_LOG 与 UE_LOG 一样被删除，并且运行时成本为零。在 Shipping 版本中，GLS_LOG 与 UE_LOG 一样被删除，并且运行时成本为零。 - 如果禁用 GLS 日志记录，GLS_LOG 将自动回退到 UE_LOG。如果禁用 GLS 日志记录，GLS_LOG 将自动回退到 UE_LOG。 - 它不会破坏游戏逻辑，也不会自行分配大量内存。它不会破坏游戏逻辑，也不会自行分配大量内存。您可以在任何构建配置中自由使用它。

### 为什么 GLS_LOG 不能在没有 UObject 的纯 C++ 结构或辅助类中工作？

