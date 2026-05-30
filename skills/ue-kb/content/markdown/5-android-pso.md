# 虚幻引擎 5 Android PSO 缓存

# 虚幻引擎 5 Android PSO 缓存

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Pdo7/unreal-engine-5-android-pso-caching

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4859 字符。

## 摘要

虚幻引擎 PSO 缓存解决方案可以帮助解决 Android 设备上由着色器编译引起的卡顿问题，但文档页面可能会让 Android 开发人员感到困惑，因为它并没有真正针对 Android 平台进行简化，因此在本教程中，我们将介绍如何将 PSO 缓存添加到 Android 项目中。另外，请记住，PSO 缓存确实存在明显增加移动设备上首次启动时间的缺点。

## 中文整理

### 概览

**更新：** 目前此方法不适用于 UE 5.3，如果我找到解决方案，我将更新本教程。 **更新 2**：从 UE5.4 开始，PSO 缓存系统已更改，因此本教程可能不起作用。我将首先使用虚幻引擎 5.2 作为测试示例创建一个第三人称模板项目，并将其命名为“PSOCacheTutorial”。如果需要，您可以打开当前项目。步骤： 1. 启动项目 2. 转到 Edit\Project Settings\Packaging\ 并确保启用“Shader Material Code”和“Shared Native Material Libraries”

![教程图片](assets/unreal-engine-5-android-pso-caching/image-01.jpg)

3. 关闭项目 4. 转到“YourProjectFolder”\Config\Android\（如果不存在则创建） 5. 在 Android 文件夹中打开名为 AndroidEngine.ini 的文件（如果不存在则创建） 6. 在 AndroidEngine.ini 中添加以下行并保存。

```
[DevOptions.Shaders]
NeedsShaderStableKeys=true
```

![教程图片](assets/unreal-engine-5-android-pso-caching/image-02.jpg)

7. 准备您的 Android 手机并确保启用 USB 调试选项并将其连接到您的 PC 8. 重新启动项目 9. 转到“平台”并选择“项目启动器”

![教程图片](assets/unreal-engine-5-android-pso-caching/image-03.jpg)

10. 在面板底部创建一个新的自定义启动配置文件

![教程图片](assets/unreal-engine-5-android-pso-caching/image-04.jpg)

11.根据下图进行配置

![这些设置适用于 ETC2 压缩，但如果需要，您可以将其更改为 ASTC。虽然我还没有测试过，但它应该可以工作。](assets/unreal-engine-5-android-pso-caching/image-05.jpg)

![教程图片](assets/unreal-engine-5-android-pso-caching/image-06.jpg)

12. 返回并启动配置文件 根据您的项目大小和 PC 规格，您将需要等待一些时间才能完成打包。还要确保您的手机已解锁/处于活动状态，因为在某些时候打包过程将停止并等待移动设备解锁才能启动项目。

![教程图片](assets/unreal-engine-5-android-pso-caching/image-07.jpg)

13. 游戏启动后，移动游戏中卡顿的区域，您将在输出日志中看到弹出的日志，如下图所示。

![教程图片](assets/unreal-engine-5-android-pso-caching/image-08.jpg)

我建议您只玩游戏的必要区域，因为收集更多 PSO 会增加项目的首次启动时间。收集完 PSO 后，从手机上拔下电缆（不要使用项目启动器关闭游戏，因为某些原因它不会保存必要的文件。至少在我的设备中是这样。） 14. 关闭项目并重新将手机连接到 PC，然后转到下面的指定目录，因为我们需要从移动设备中提取文件：Phone\Internal Storage\Android\Data\"项目的包名称"\files\UnrealGame\"项目名称"\"Project名称“\已保存\收集的 PSO”

![教程图片](assets/unreal-engine-5-android-pso-caching/image-09.jpg)

将该文件复制到您的电脑并将其放在易于访问的文件夹中。我将把它放在“C:\PSOfiles\”中，并在接下来的步骤中引用它。您现在可以拔掉手机的插头。 15. 再次转到您的项目文件夹，并将文件从“Saved\Cooked\Android_ETC2\"YourProjectName"\Metadata\PipelineCaches\”复制到“C:\PSOfiles\”

![教程图片](assets/unreal-engine-5-android-pso-caching/image-10.jpg)

16. 转到用于项目的引擎安装文件夹，导航到 Engine\Binaries\Win64\ 并在该文件夹中运行命令提示符 17. 现在我们需要准备一个命令行，以便从当前文件生成最后一个文件。命令行应该是这样的：

```
UnrealEditor-Cmd.exe "YourProjectPath.uproject" -run=ShaderPipelineCacheTools expand C:\PSOfiles\*.rec.upipelinecache C:\PSOfiles\*.shk C:\PSOfiles\"Alias Name"_"Project Name"_"Used Graphics API".spc
```

确保在命令行中正确输入“项目名称”和“使用的图形API”，否则它将无法工作。由于我的项目名称是“PSOCacheTutorial”并且我的图形API是OpenGLES3.1，所以我将在下面的命令行中输入它。请记住，如果您的项目使用 OpenGLES，您需要输入“GLSL_ES3_1_ANDROID”，对于 Vulkan，您需要输入“SF_VULKAN_ES31_ANDROID” 这是我的示例：

```
UnrealEditor-Cmd.exe "C:\PSOCacheTutorial\PSOCacheTutorial.uproject" -run=ShaderPipelineCacheTools expand C:\PSOfiles\*.rec.upipelinecache C:\PSOfiles\*.shk C:\PSOfiles\PSOversion1_PSOCacheTutorial_GLSL_ES3_1_ANDROID.spc
```

18. 成功运行上述命令行后，它应该在“C:\PSOfiles\”文件夹中生成一个新文件，将该文件复制到“YourProject\Build\Android\PipelineCaches\” 19. 最后，我们完成了 PSO 缓存，为了测试它，您需要将游戏导出到您的设备，看看着色器编译卡顿是否得到解决。您还可以检查导出日志，看看是否有如下图所示的 PSO 相关日志。感谢您的阅读，我希望您发现它很有用！ - [UE4.27 的 Android PSO 缓存](https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/PSOCaching/PSOCachingOnAndroid) - [UE5 的 PSO 缓存](https://docs.unrealengine.com/5.2/en-US/optimizing-rendering-with-pso-caches-in-unreal-engine)

## 相关链接

- [Android PSO Caching for UE4.27](https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/PSOCaching/PSOCachingOnAndroid)
- [PSO Caching for UE5](https://docs.unrealengine.com/5.2/en-US/optimizing-rendering-with-pso-caches-in-unreal-engine)

