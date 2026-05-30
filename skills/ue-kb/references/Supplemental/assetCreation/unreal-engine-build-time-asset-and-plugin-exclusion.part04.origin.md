# 构建时资产和插件排除 (Part 4/4)

Source file: `unreal-engine-build-time-asset-and-plugin-exclusion.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### Fortnite 提示：Cook-time PreSave 版本检查

**PreSave 烹饪时版本检查示例**

```cpp
#if WITH_EDITOR
void AExampleActor::PreSave(FObjectPreSaveContext ObjectSaveContext)
{
	Super::PreSave(ObjectSaveContext);

	if (ObjectSaveContext.IsCooking())
	{
		// Check actor's VersionRange against the version being cooked for	
		if (!UExampleAssetManager::DoesVersionRangeInclude(VersionRange))
		{
```
### 7. 总结和进一步考虑
