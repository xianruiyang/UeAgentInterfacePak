# Oculus使用前准备

---
title: "Oculus使用前准备"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/oculus-prerequisites-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发", "Oculus Rift", "Oculus使用前准备"]
---

# Oculus使用前准备

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发 / Oculus Rift / Oculus使用前准备

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/oculus-prerequisites-in-unreal-engine

为了让你的虚幻项目能在Oculus头显上跑起来，你必须在 **Unreal Engine** 中启用 **Oculus VR** 插件。你还需要允许你的头显能运行未知来源的应用。通过允许运行未知来源的应用，你的工程无需向Oculus提交注册和审核，就能在设备上测试。更多详情，请参阅

为了让你的工程在Oculus VR上跑起来，请遵循以下步骤：

1. 请确保[下载了Oculus应用](https://www.oculus.com/setup/)并安装到你的电脑上。
2. 打开 **Oculus应用**。
3. 在Oculus应用中，点击 **设置（Settings） > 通用（General）** 并启用 **未知来源（Unknown Sources）**。
4. 打开你的虚幻项目。
5. 在 **虚幻编辑器** 中，在主菜单中选择 **编辑（Edit） > 插件（Plugins）**。
6. 在左侧的 **插件（Plugins）** 窗口中，选择 **虚拟现实（Virtual Reality）**。虚拟现实插件会显示在右侧面板中。
7. 找到 **Oculus VR** 然后确保启用该插件。

![undefined](../../../../../../../assets/images/53/5393a56358ae8b9ab47098ae1a7ae1ba29c85bc91489b25342bdba03ba08c66d.jpg)

Click image for full size.

## Oculus VR插件设置

你可以在Oculus VR中根据你的项目修改设置，例如调整像素密度，让HMD渲染你的运动控制器（手柄）。如需查看项目的Oculus VR插件设置，你必须先在电脑上运行Oculus应用。

请遵循以下步骤，以便在你的项目中查看并编辑 **Oculus VR** 插件的设置：

1. 确保 **Oculus应用** 在电脑上运行。
2. 如果该应用未运行：

   1. 如果 **虚幻引擎** 未关闭，请关闭它。
   2. 打开Oculus应用。
   3. 打开虚幻引擎。
3. 在编辑器中打开你的项目。
4. 打开 **编辑（Edit） > 项目设置（Project Settings…）**。
5. 在 **项目设置（Project Settings）** 中，向下滚动到 **插件（Plugins）** 分段并选择 **OculusVR**。右侧面板会显示Oculus VR插件的设置选项。

![undefined](../../../../../../../assets/images/30/30b34c83277de9cd5186dbe6f492a111a466e05ae956b7940afcae6dadfe1c7f.png)

Click image for full size.

## Oculus故障调试

假如你在使用Oculus头显时遇到了问题，请访问[Oculus支持中心](https://support.oculus.com/)查阅是否有对应的解决方案。

