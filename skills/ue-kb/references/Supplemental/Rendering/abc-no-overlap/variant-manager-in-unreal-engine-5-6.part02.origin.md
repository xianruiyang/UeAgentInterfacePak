# 虚幻引擎 5.6 中的变体管理器（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6
- 原始文件：variant-manager-in-unreal-engine-5-6.origin.md
- 分段：第 2/2 段

将变体集拖放到您的关卡中。接下来，添加 BP_ConfiguratorManager 蓝图（包含在产品配置器模板中）。这将设置用于与您的变体交互的 UI 元素。在 BP_Configurator 详细信息面板中： - 将 LVSActor 设置为您的变体集。将 LVSActor 设置为您的变体集。 - 将相机 Actor 设置为您的 CineCameraActor。将 Camera Actor 设置为您的 CineCameraActor。然后，打开世界设置并将游戏模式切换为 BP_ConfigGameMode。这将启用模板的配置器功能。按“播放”——您现在应该在界面中看到您的变体预设，并且能够在它们之间切换。如果您在退出播放模式后遇到此消息，请不要担心 — 这不会影响功能：“蓝图运行时错误：尝试读取属性 CallFunc_ GetComponentByClass_ReturnValue 时未访问任何内容”。要删除它，请打开 BP_Configurator → InitCamera Function，然后断开 Init Camera 和 Return Node 连接器。

### 结论

您现在已经在虚幻引擎中创建了一个可用的变体管理器配置器！尝试通过添加灯光变化、后期处理效果或其他摄像机视图来扩展您的设置，以使您的演示更具互动性。通过添加新材质、照明设置或动画触发器来进一步进行实验。变体管理器可以轻松管理并呈现无限的创意可能性。快乐开发！

## 相关链接

- [Creating Interactive Product Configurators with Variant Manager in Unreal Engine 5.6](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#creatinginteractiveproductconfiguratorswithvariantmanagerinunrealengine56)
- [What is the Variant Manager?](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#whatisthevariantmanager?)
- [STEP ONE: CREATING A NEW PROJECT](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#stepone:creatinganewproject)
- [STEP TWO: DESIGNING THE MATERIALS](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#steptwo:designingthematerials)
- [STEP THREE: PLACING CAMERAS AND SCENE OBJECTS](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#stepthree:placingcamerasandsceneobjects)
- [STEP FOUR: ESTABLISHING THE VARIANT SETS](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#stepfour:establishingthevariantsets)
- [What is a Variant Set?](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#whatisavariantset?)
- [Creating and Configuring Variant Sets](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#creatingandconfiguringvariantsets)
- [Configuring Object Variants](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#configuringobjectvariants)
- [Configuring Camera Variants](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#configuringcameravariants)
- [Configuring Material Variants](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#configuringmaterialvariants)
- [STEP FIVE: GENERATING THUMBNAILS FOR THE VARIANTS](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#stepfive:generatingthumbnailsforthevariants)
- [STEP SIX: SETTING UP THE CONFIGURATOR IN THE LEVEL](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#stepsix:settinguptheconfiguratorinthelevel)
- [Conclusion](https://dev.epicgames.com/community/learning/tutorials/b2W0/variant-manager-in-unreal-engine-5-6#conclusion)
