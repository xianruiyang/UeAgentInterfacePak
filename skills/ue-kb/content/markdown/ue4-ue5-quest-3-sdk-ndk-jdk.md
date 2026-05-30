# 适用于 UE4&UE5 的 Quest 3 SDK/NDK/JDK

# 适用于 UE4&UE5 的 Quest 3 SDK/NDK/JDK

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/oMEe/unreal-engine-quest-3-sdk-ndk-jdk-for-ue4-ue5

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4215 字符。

## 摘要

UE4&UE5 的正确 SDK/NDK/JDK 设置。

## 中文整理

### 概览

由于 Quest 3 的虚幻引擎中的 Android 设置可能很困难，因此我受到本[教程](https://dev.epicgames.com/community/learning/tutorials/3Vx6/unreal-engine-5-3-2-for-meta-quest-vr)的启发，向您展示了一些我测试过的配置，到目前为止，它们与我的 quest 3（无线和有线连接）配合良好。对我来说，一个很好的版本指示是查看“C:\UE_5.3\Engine\Extras\Android\SetupAndroid.bat”，在这里您可以在第 20 行看到 .bat 将安装哪个版本。确保第 86 行的路径正确，可以将“latest”更改为您的版本，例如“11.0”。 .bat 文件将安装 SDK、Build-Tools、CMake 和 NDK。在我的测试中，如果我使用 .bat 文件或通过 Android Studio 安装这些文件，没有任何差异。 antinnit 的完整教程（适用于 UE5）： [https://forums.unrealengine.com/t/community-tutorial-unreal-engine-5-3-2-for-meta-quest-vr/1376911](https://dev.epicgames.com/community/learning/tutorials/3Vx6/unreal-engine-5-3-2-for-meta-quest-vr) 信息 1：最小。 SDK和Target SDK位于Project Settings -> Platforms -> Andorid。其余部分位于项目设置 -> 平台 -> Andorid SDK。信息 2：在我的测试中，我无法重新启动通过项目启动器构建的应用程序（在耳机内）。在这里，我必须打包项目，这样我就可以随时在耳机中重新启动应用程序。请记住，启动可能会覆盖耳机上打包的 APK，请在“Android 包名称”中使用不同的名称来获得不同的版本。免责声明：这些配置对我有用，但是有无数的配置组合，因为它们对我有用，但这并不意味着它是最好的配置。我仅使用这些配置测试了默认 VR 模板。警告 1：如果您更改“位置 NDK”或“NDK API 级别”等项目设置，这将是您安装的 **所有** 引擎版本的 **全局更改 **。例如，如果您有 UE4 和 UE5 项目，则一个项目中的更改也会影响另一个项目。警告 2：虽然您可以在项目中设置 SDK、NDK 和 JDK，但您**不能**设置构建工具（据我所知），虚幻引擎将始终使用最新版本，因此如果您有 UE4 和 UE5 项目，则必须删除 30.x 之后的构建工具才能启动 UE4 项目，并重新安装 34.x 才能启动 UE5 项目（或保留两者的 30.x，见下文）。到目前为止对我来说有效的配置：**Quest 3 with UE 4.27.2** - Build-Tools (Android Studio): 30.0.3 - Min. SDK：29 - 目标 SDK：29 - 位置 SDK：C:/Users/Admin/AppData/Local/Android/Sdk - 位置 NDK：C:/Users/Admin/AppData/Local/Android/Sdk/ndk/21.4.7075529 - 位置 JAVA (JDK)：C:/Program Files/Java/jdk-13.0.2 - SDK API 级别：android-29 - NDK API 级别： android-29 - 启动：启动 -> 项目启动器 -> Quest 3 (xxx) - 打包：文件 -> 打包项目 -> Android -> Android (ASTC) [使用“Install_XXX-arm64.bat”文件最适合我] **Quest 3 with UE 5.2.1** - 最小。 SDK：32 - 目标 SDK：32 - 位置 NDK：C:/Users/Admin/AppData/Local/Android/Sdk/ndk/25.1.8937393 - SDK API 级别：android-32 - NDK API 级别：android-32 - 启动：平台 -> 项目启动器 -> 任务 3 (xxx) - 包：平台 -> Android -> 包项目 (Android ASTC) [通过任务删除 APK开发中心最适合我] **Quest 3 with UE 5.3.2** - Build-Tools (Android Studio): 30.0.3 [OR 34.0.0] - Location JAVA (JDK): C:/Program Files/Java/jdk-13.0.2 [OR C:/Program Files/Java/jdk-17.0.9] - Launch: Platforms -> Project Launcher -> All_Android_On_xxx* (Quest 3 对我不起作用） * 当我尝试启动 Quest 3 (xxx) 时，我收到错误“语法错误：意外的 '('”。我很确定这是因为 adb.exe 参数中的会话名称中的“(”和“)”未转义。对我来说，这像是 UE5.3.2 中的错误。

