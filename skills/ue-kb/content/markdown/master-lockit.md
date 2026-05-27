# 连接你的Master Lockit系统

---
title: "连接你的Master Lockit系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/connecting-your-master-lockit-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "连接你的Master Lockit系统"]
---

# 连接你的Master Lockit系统

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / 连接你的Master Lockit系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/connecting-your-master-lockit-system-in-unreal-engine

## 步骤

在本分段中，你将通过使用Live Link的Ambient Master Lockit Plus设备连接智能镜头。

制片摄像机上的智能镜头将连接到Master Lockit Plus，并且Master Lockit Plus将通过以太网连接到虚幻引擎工作站网络。

1. 点击 **设置（Settings）> 插件（Plugins）**，打开 **插件菜单（Plugins Menu）**。点击 **虚拟制片（Virtual Production）** 类别并搜索 **LiveLinkMasterLockit** 插件。

   ![打开插件菜单](../../../../../assets/images/9f/9ff93cf69b7576f0a6f26fe3a08db8239f7e03f39b79cf37e0a297b493c6795c.jpg)
2. 启用该插件，然后点击消息窗口上的 **是（Yes）**。点击 **立即重启（Restart Now）** 以重启编辑器。

   ![添加Master Lockit](../../../../../assets/images/bb/bb1d7fbccf1d50dd91b4253bbbadb8091640e4bc015599fc64341b29ba6c9c83.jpg)

   ![点击](../../../../../assets/images/9d/9dbf3b376841cd8c94e80ae5d5270525f43e9c96283e3eca898b957faddcc91f.png)
3. 编辑器完成加载后，转到 **Live Link** 窗口并点击 **+ 源（+ Source）> MasterLockit**。输入 **Master Lockit的IP地址**，然后点击 **确定（OK）**。

   ![添加Master Lockit](../../../../../assets/images/fc/fc85d7f32a619d9f9f22b3cadb3cbd884c5d4846a92b6823cb57b189f4bdcf54.jpg)
4. 选择窗口中的 **Master Lockit设备（Master Lockit Device）** 并点击 **查看选项（View Options）**，然后选择 **显示帧数据（Show Frame Data）**。确认 **Live Link** 分段中的值正确更新。

   ![显示帧数据](../../../../../assets/images/ec/ec47cedf3456d9caf20f1e31b1cef4269efcce3adb812458f1924d9f9a7756b3.jpg)
5. 在 **世界大纲视图（World Outliner）** 窗口中选择 **电影摄像机Actor（CineCamera Actor）**，然后转到 **细节（Details）** 面板。选择 **Live Link控制器（Live Link Controller）** 组件，然后向下滚动到 **Live Link** 分段。点击 **主题表示（Subject Representation）** 下拉菜单，然后选择你的 **Master Lockit设备（Master Lockit Device）**。

   ![将Master Lockit设备添加到主题表示](../../../../../assets/images/01/016b7582c9ff2e0d9ecee6bb7a176102b07d0ee60de4653d1a9cea1ef731fec6.jpg)
6. 选择 **摄像机组件（Camera Component）**，然后向下滚动到 **焦点设置（Focus Settings）**。验证更改物理摄像机上的焦点和光圈是否更新了 **电影摄像机Actor（CineCamera Actor）** 中的相同设置。
7. 将 **聚焦方法（Focus Method）** 设置从 **手动（Manual）** 更改为 **禁用（Disabled）**。这将阻止CG电影摄像机上的焦点发生变化，因为焦点是由物理摄像机控制的

   ![将](../../../../../assets/images/3c/3c0bca4ec7a81136e2989fb30f16f8ce2d0d6f143d854e0b2926b8d417d25b3f.jpg)

#### 结果

在本指南中，你使用Live Link连接了你的Master Lockit设备，并从制片摄像机上的智能镜头流送了聚焦、光圈和变焦。

