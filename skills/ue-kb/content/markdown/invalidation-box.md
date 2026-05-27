# Invalidation Box

---
title: "Invalidation Box"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-invalidation-box-for-umg-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "控件类型参考说明", "Invalidation Box"]
---

# Invalidation Box

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 控件类型参考说明 / Invalidation Box

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-invalidation-box-for-umg-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## 说明

Widgets that are wrapped with an **Invalidation Box** allows the child widget geometry to be cached to speed up Slate rendering. Any widgets that are cached by an Invalidation Box are not pre-passed, ticked, or painted. In general, if you are looking to optimize your project, wrapping certain widgets with Invalidation Boxes may boost your performance (particularly for mobile projects or complicated UI displays). For widgets that do not change constantly, they can be placed inside an Invalidation Box and cached instead of considered during paint, tick, or prepass.

If the widget changes, however, it will become invalid and you will need to manually invalidate the cache which will throw it away essentially and force it to redraw on the next paint pass. Anything that changes the visual appearance of the widget requires it to be invalidated. The only exception to this is a change to the appearance that is not stored in the vertex buffer for those widgets (for example Materials, as changing a Material Parameter does not require invalidating the widget).

## Details

In the **Details** panel for a placed **Invalidation Box**, there are a couple of specific options that can be set that pertain to the widget:

![Invalidation Box properties in the Details panel](../../../../assets/images/c5/c5c6ddf05cac0a17e1477ebf8864d61488710afc8f0b6143d90b4a50cef02483.png)

| Option | 说明 |
| --- | --- |
| **Cache Relative Transforms** | Caches the locations for child draw elements relative to the invalidation box which adds extra overhead to drawing them every frame. However, in cases where the position of the invalidation boxes changes every frame, this can be a big saving. |
| **Is Volatile** | If true, prevents the widget or its child's geometry or layout information from being cached. If this widget changes every frame, but you want it to still be in an invalidation panel, you should make it as volatile instead of invalidating it every frame, which would prevent the invalidation panel from actually ever caching anything. |

Regarding the **Is Volatile** check box, any widget can be set to be volatile. Volatile widgets act like normal Slate widgets pre-invalidation. They're redrawn every frame, including all their children. When combined with the invalidation panel, it allows you to care only about redrawing the most dynamic bits of the UI, as invalidating a whole panel could be far more costly.

## Functions

When using an **Invalidation Box**, it is up to the user to call [Invalidate](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/SlateCore/Widgets/SWidget/Invalidate?application_version=5.5) through C++ or the **Invalidate Layout And Volatility** node (pictured below) on a child widget to force invalidation.

![Invalidate node](../../../../assets/images/ea/eabebb7c2aec307dcf94016fb93f6a99c09f10a6816527d7628ec83a9a94b2e3.jpg)

> [!NOTE]
> Currently, some core widgets do this automatically when certain properties are changed, however more will do it over time.

## Debugging

You can debug your Invalidation Boxes using the **Widget Reflector** (CTRL+Shift+W) and clicking the **Invalidation Debugging** toggle.

> [!NOTE]
> To display the legend when `SlateDebugger.Invalidate.Enable 1` is invoked, use `SlateDebugger.Invalidate.ToggleLegend`.

![Widget Reflector](../../../../assets/images/50/508edebac434c236be8dca8aed5f391ee7f8ba8c615154862c72534993f815d1.png)

Click image for full view.

With the Widget Reflector up and Invalidation Debugging on, you will see the following colors:

| Color | 说明 |
| --- | --- |
| **Yellow** | Paint invalidated this frame. |
| **Gray** | Volatility invalidated this frame. |
| **Cyan** | ChildOrder invalidated this frame. |
| **Black** | RenderTransform invalidated this frame. |
| **White** | Visibility invalidated this frame. |
| **Pink** | Layout invalidated this frame for Invalidation Box. |
| **Blue** | Every widget was reordered. |
| **Red** | Fully re-updated. |

> [!TIP]
> To debug InvalidationBox behavior, use `SlateDebugger.InvalidationRoot.Enable`.

Example below shows an image that is marked as volatile inside of a Border which is wrapped with an Invalidation Box. Since the image is marked as volatile, it can be updated dynamically during gameplay while the Border (or any other art assets that you wanted to appear around the image that do not change) is cached.

![Eample of using Invalidation Box](../../../../assets/images/76/762f7d149d4cefe2478c600bae1452ac168b8821167504513eddf4a8336789b5.jpg)

