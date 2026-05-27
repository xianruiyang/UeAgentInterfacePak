# Virtual Cameras

---
title: "Virtual Cameras"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/virtual-cameras-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer中的摄像机", "Virtual Cameras"]
---

# Virtual Cameras

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer中的摄像机 / Virtual Cameras

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/virtual-cameras-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

A **Virtual Camera** drives a **Cine Camera** in **Unreal Engine** by using a modular component system to manipulate camera data and output the final results to a variety of external output devices. In addition, the Virtual Camera system provides its functionality while in the **editor** and during **Play In Editor (PIE)** or **Standalone Game** mode.

The **Virtual Camera Component (VCamComponent)** is the base component that enables building custom virtual cameras in Unreal Engine. With the VCamComponent, a user can drive a Cine Camera inside Unreal Engine by adding custom **Modifiers** and **Output Providers**. The Modifiers manipulate the camera data with custom effects such as filtering, tracking, and auto focus. The Output Providers route the output of the virtual camera to **Composure**, **Media Framework**, editor viewports, or any devices running the **Unreal Remote** app.

In addition, this new architecture includes the following:

- **[Multi-User editing](../../../../production-pipeline/multi-user-editing/index.md)** support for all features.
- The ability to overlay custom UMG controls over the output and interact with them in the editor or on a device.
- Built-in support for input hardware such as controllers and touchscreens.
- Provides the functionality to switch to any custom tracking system with **Live Link**.
- An updated Unreal Remote app with a new UI and improved streaming performance.

For further documentation regarding the virtual camera system, please see the page links below.

- [Controlling a Virtual Camera Actor using Live Link](controlling-a-virtual-camera-actor-using-live-link/index.md) - Use the sample Virtual Camera Actor, driven by Live Link, to control a Cine Camera Actor.

- [Unreal VCam Tools and Configuration](controlling-a-v-40d33a7c/unreal-vcam-tool-14c8c5ab/index.md) - Tools and configuration options for the Unreal VCam app.

- [Unreal VCam Virtual Camera Settings](controlling-a-v-40d33a7c/unreal-vcam-virt-2875e75d/index.md) - Settings and configuration information for the Unreal VCam app

- [Virtual Camera Multi-User Quick-Start Guide](virtual-camera-multiuser-quickstart-guide/index.md) - Use Switchboard to connect multiple users to simultaneously operate Virtual Cameras.

- [Configuring a Virtual Camera Component](configuring-a-virtual-camera-component/index.md) - A guide to understanding and configuring a custom virtual camera.

- [Controlling Inputs to Virtual Camera Controls](controlling-inputs-to-virtual-camera-controls/index.md) - How to manage, edit, and configure inputs to virtual camera controls.

- [Using Multiple Virtual Cameras](using-multiple-virtual-cameras/index.md) - How to set up multiple virtual cameras in a virtual production environment.

