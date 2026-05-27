# 设置旁观者屏幕模式的 Texture Plus Eye布局。

---
title: "设置旁观者屏幕模式的 Texture Plus Eye布局。"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-spectator-screen-mode-texture-plus-eye-layout-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "共享XR体验", "虚拟现实旁观者模式", "设置旁观者屏幕模式的 Texture Plus Eye布局。"]
---

# 设置旁观者屏幕模式的 Texture Plus Eye布局。

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 共享XR体验 / 虚拟现实旁观者模式 / 设置旁观者屏幕模式的 Texture Plus Eye布局。

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-spectator-screen-mode-texture-plus-eye-layout-in-unreal-engine

This node sets up the layout for the `TexturePlusEye` function in `ESpectatorScreenMode`.

**Inputs**

| Pin Location | Name | 说明 |
| --- | --- | --- |
|  | (In) Exec | Input execution pin. |
|  | Eye Rect Min | A Vector 2D Structure, setting the minimum position of the screen rectangle that the Eye will be drawn in.Values are normalized between `0.0` and `1.0`. |
|  | Eye Rect Max | A Vector 2D Structure, setting the maximum position of the screen rectangle that the Eye will be drawn in.Values are normalized between `0.0` and `1.0`. |
|  | Texture Rect Min | A Vector 2D Structure, setting the minimum position of the screen rectangle that the Texture will be drawn in.Values are normalized between `0.0` and `1.0`. |
|  | Texture Rect Max | A Vector 2D Structure, setting the maximum position of the screen rectangle that the Texture will be drawn in.Values are normalized between `0.0` and `1.0`. |
|  | Draw Eye First | If this flag is set to `True`, the Eye is drawn before the Texture; however, if this flag is set to false, the Texture will be drawn before the Eye. |
|  | Clear Black | If this flag is set to `True`, the Render Target will be drawn black before either rectangle is drawn. |

**Output**

| Pin Location | Name | 说明 |
| --- | --- | --- |
|  | (Out) Exec | Output execution pin. |

