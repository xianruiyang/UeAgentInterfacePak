# 设置 Oculus Rift Guardian 系统

---
title: "设置 Oculus Rift Guardian 系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-the-oculus-rift-guardian-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发", "Oculus 指南", "设置 Oculus Rift Guardian 系统"]
---

# 设置 Oculus Rift Guardian 系统

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发 / Oculus 指南 / 设置 Oculus Rift Guardian 系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-the-oculus-rift-guardian-system-in-unreal-engine

Skill_family: Tutorial Level 1 Version: 5.0 Parent: sharing-and-releasing-projects/xr-development/supported-xr-platforms/developing-for-oculus/OculusHowTo Order: 4 tags: Basics topic-image:HTGuardian_System_Topic_Image.png prereq:sharing-and-releasing-projects/xr-development/supported-xr-platforms/developing-for-steamvr/HowTo/StandingCamera prereq:sharing-and-releasing-projects/xr-development/making-interactive-xr-experiences/set-up-motion-controllers

Oculus Guardian 系统用于显示 VR 交互区域的边界。追踪设备靠近边界时，Oculus Runtime 将自动进行可视提示，告知用户。以下教程将说明如何把 Oculus Guardian 系统添加到 UE4 项目的玩家 Pawn。

> [!NOTE]
> 需要设置 Guardian 系统使用 Oculus 应用程序才能使其正常使用。如需了解详细操作方法，请查看官方 [Oculus Guardian 系统](https://developer.oculus.com/documentation/pcsdk/latest/concepts/dg-guardian-system/) 设置页面。

> [!WARNING]
> 在 UE 中禁用 Guardian 系统 **不** 明智，也不可取。然而，您可以调整用户靠近边界时 UE 作出的响应。

## 步骤

执行以下操作即可将 Oculus Rift Guardian 系统添加到 UE 玩家 pawn：

1. 打开项目玩家 Pawn 蓝图，确保 **Components** 标签已显示。
2. 点击 **Add Component** 按钮，然后从显示的列表中搜索 **OculusRiftBoundy** 组件。找到组件后，点击将其添加至组件列表。
3. 完成后，玩家 pawn 应与下图相似。

## 最终结果

现在即可在 VR 中运行项目并戴上 Rift 头戴显示器，靠近 VR 交互区的边界时，便会出现以下视频中的内容。

## UE 项目下载

可使用以下链接下载用于创建此例的 UE 项目。

- Oculus Rift Guardian 系统设置项目

