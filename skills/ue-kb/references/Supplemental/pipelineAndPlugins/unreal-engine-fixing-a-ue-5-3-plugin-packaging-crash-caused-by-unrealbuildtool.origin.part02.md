# unreal-engine-fixing-a-ue-5-3-plugin-packaging-crash-caused-by-unrealbuildtool.origin (Part 2/2)

Source file: `unreal-engine-fixing-a-ue-5-3-plugin-packaging-crash-caused-by-unrealbuildtool.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 9. 端到端确认：插件实际运行

最终的证明不仅仅是“构建成功”，而是看到插件在编辑器中运行并记录有意义的运行时输出。在我们的例子中，这是 **雕刻系统** 的作用：

```
LogTemp: UEngravableComponent::EnsureRenderTarget - Created heightmap RT 4096x4096 with UAV support
LogTemp: UEngravableComponent::EnsureRenderTarget - Created normalmap RT 4096x4096 with UAV support
LogTemp: UEngravableComponent::RenderTextToMask - Created widget instance
LogTemp: UEngravableComponent::RenderTextToMask - Using widget rendering
LogTemp: UEngravableComponent::RenderTextToMask - Set EngravingText to: Audemars Piguet
LogTemp: UEngravableComponent::RenderTextToMask - Widget rendered successfully via Slate WidgetRenderer
LogTemp: UEngravableComponent::GenerateHeightmapAndNormals - Compute shader dispatched
LogTemp: FEngravingHeightmapGenerator: Using custom noise texture
LogTemp: FEngravingHeightmapGenerator: Pass 1 (heightmap) completed
LogTemp: FEngravingHeightmapGenerator: Pass 2 (normal map) completed
```

当您看到这样的日志时，您就知道： - UBT 是稳定的 - 该插件正在 **编辑器、开发和运输 ** 配置中构建 - 您的实际运行时系统（在本例中为雕刻和计算着色器）正在按预期工作

### 10. 实用清单

如果您遇到类似的打包崩溃（ModuleRules.IsValidForTarget 中的 ArgumentNullException），这里有一个精简清单： - **缩短打包路径** - 使用 E:\UEPkg\MyPlugin\ 之类的内容而不是深度嵌套的路径。 - **删除或禁用未使用/不兼容的插件** - 特别是可能具有错误规则元数据的引擎插件。 - **清除规则程序集** - 删除 Engine\Intermediate\Build\BuildRules\UE5Rules.dll / UE5ProgramRules.dll - 删除 Intermediate\Build\BuildRules\ 下的项目和插件 *ModuleRules.dll - **可选补丁 ** - UBT 将空防护和安全属性读取添加到 ModuleRules.IsValidForTarget。 - 通过 dotnet build 重建 UnrealBuildTool - 来自 Engine\Source\Programs\UnrealBuildTool。 - **重新运行 BuildPlugin ** - 观察： - 规则 DLL 正在重新编译， - C++ 文件正在编译， - 最终构建成功。

### 11.更多资源

- [相关：为虚幻引擎配置器构建渲染器系统](https://dev.epicgames.com/community/learning/tutorials/YGyr/building-a-renderer-system-for-unreal-engine-configurators) **免责声明** 此调查和修复是在 **虚幻引擎 5.3** 上进行的。我不知道这个问题在更高版本的引擎中是否仍然存在。如果源自 ModuleRules.IsValidForTarget 的相同 ArgumentNullException 在较新版本中发生，则根本原因可能是相同的 - UBT 模块规则反射期间为 null ModuleType - 并且相同的缓解步骤（清除缓存的规则程序集、重新生成 UBT 或添加 null 防护）仍应适用。开发人员应在应用修改之前验证其引擎版本并查阅最新的 UBT 源。

## 相关链接

- [RELATED: Building a Renderer System for Unreal Engine Configurators](https://dev.epicgames.com/community/learning/tutorials/YGyr/building-a-renderer-system-for-unreal-engine-configurators)
