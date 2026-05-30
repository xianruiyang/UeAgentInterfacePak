# 将缩略图导出为 PNG

# 将缩略图导出为 PNG

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/yzZa/unreal-engine-exporting-thumbnails-to-pngs

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1193 字符。

## 摘要

将缩略图导出为 PNG 由 Cody A 撰写的文章。对于某些项目，将生成的资源缩略图自动导出为 PNG 文件可能很有用。这可以通过访问缩略图来完成...

## 中文整理

### 概览

*文章由 [Cody A.](https://dev.epicgames.com/community/profile/Zvl0/Cody.Albert) 撰写* 对于某些项目，将生成的资源缩略图自动导出为 PNG 文件可能很有用。这可以通过 ThumbnailTools 命名空间访问缩略图并使用 ImageWrapper 模块将像素转换为 PNG 以便导出来完成。以下代码重新生成缩略图以确保其是最新的，生成压缩的 PNG，并将其保存到磁盘上的某个位置。

```cpp
void UMyThumbnailSaver::SaveThumbnail(FString ObjectPath, FString OutputPath)
{
	FAssetRegistryModule& AssetRegistryModule = FModuleManager::Get().LoadModuleChecked<FAssetRegistryModule>(TEXT("AssetRegistry"));
	FAssetData AssetData = AssetRegistryModule.Get().GetAssetByObjectPath(*ObjectPath);
	UObject* MyObject = AssetData.GetAsset();
	if (MyObject)
	{
		FObjectThumbnail* ObjectThumbnail = ThumbnailTools::GenerateThumbnailForObjectToSaveToDisk(MyObject);
		if (ObjectThumbnail)
		{
```


