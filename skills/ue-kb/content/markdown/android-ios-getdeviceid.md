# Android 和 iOS 的 GetDeviceID 注意事项

# Android 和 iOS 的 GetDeviceID 注意事项

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/l77y/unreal-engine-getdeviceid-considerations-for-android-and-ios

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1433 字符。

## 摘要

文章由 Ryan B 撰写。在为 iOS 和 Android 创建应用程序时，您可能希望通过 FGenericPlatformMisc::GetDeviceID() 唯一标识用户所在的设备。这通常可以用来唯一标识一个设备，b…

## 中文整理

### 概览

*文章由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* 在为 iOS 和 Android 创建应用程序时，您可能希望通过 **FGenericPlatformMisc::GetDeviceID()** 唯一标识用户所在的设备。这通常可以唯一地标识设备，但这些平台需要注意一些关键的例外情况，这可能会导致重复或空白值： Android 在 Android 上，它使用 **Secure.ANDROID_ID** ，它在 Android 8.0 之前和之后具有一些不同的属性（[您可以在此处阅读](https://developer.android.com/reference/android/provider/Settings.Secure#ANDROID_ID)），但它们在不同设备上应该有所不同。也就是说，该值可以为空或不唯一，具体取决于 OEM 实现，因此如果您获得相同的值，则可能是原因。 iOS 特别针对 iOS，它是使用 **UIDevice::identifierForVendor** 实现的。从[Apple关于identifierForVendor的开发者页面](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor)来看，不是从App Store安装的应用程序会根据应用程序的捆绑包ID计算该值，该值在运行同一应用程序的所有设备上都是相同的。

