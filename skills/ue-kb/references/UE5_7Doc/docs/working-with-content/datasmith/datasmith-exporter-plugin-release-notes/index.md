---
title: "Datasmith Exporter Plugin Release Notes"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/datasmith-exporter-plugin-release-notes-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith Exporter Plugin Release Notes"]
---

# Datasmith Exporter Plugin Release Notes

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith Exporter Plugin Release Notes

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/datasmith-exporter-plugin-release-notes-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

> [!NOTE]
> To view the release notes for the Datasmith Exporter Plugins for Twinmotion, see [Datasmith Release Notes for Twinmotion](https://dev.epicgames.com/documentation/twinmotion/datasmith-explorer-plugin-release-notes-for-twinmotion) in the Twinmotion documentation.

## Datasmith exporter Plugin: SketchUp 5.7.300

**New:**

- Windows:

  - The Datasmith Exporter Plugin is now signed in Sketchupʼs Extension Manager.
  - Mac:

    - The Datasmith Exporter Plugin is now signed in Sketchupʼs Extension Manager.

## Datasmith Exporter Plugin: SketchUp

**New:**

- Provides a way to export the current viewport camera transform information in Datasmith and through Direct Link.

**Bug Fix:**

- You can now install the Datasmith Exporter plugin if a previous install is not found.

## Datasmith Exporter Plugin: Rhino 3D

**New:**

- Provides a way to export the current viewport camera transform information in Datasmith and through Direct Link.
- Provides a way to export Named views camera transform information in Datasmith and through Direct Link.

**Bug Fix:**

- Direct Link for Unreal Engine 5.7 updates lights on settings change in Rhino.
- Fixed UV repetition on objects for Datasmith (.udatasmith files)
- Allow Install of Datasmith Exporter plugin if previous install is not found.
- Material Handling:

  - Custom Materials

    - Exported as expected.
  - Double Sided Materials

    - Currently exports only the front face.

    > [!NOTE]
    > Rhinoʼs “Double Sided” material actually uses two different materials, one per face. This is not currently supported in UE and TM.
- Emission:

  - Only intensity = 1 is supported.
- Gem and Glass:

  - Partially supported.
  - Generates a material with some opacity, which is not equivalent to true clarity.
  - Refraction values cannot be exported due to a limitation in the Datasmith material, where refraction mode is not exposed or changeable.
- Metal:

  - Exported as expected.
- Paint:

  - No special behavior.
  - Physically-based.
  - Exported as expected.
- Picture

  - Partially supported.
  - Only basic properties are exported.
  - Masking and other advanced attributes are ignored.
- Plaster

  - Exported as expected.
- Plastic

  - Exported as expected.
- Fixed the issue where Rhino Mac force shutdowns when clicking Sync for Direct Link Resolved

## Datasmith Exporter Plugin: ArchiCAD

**New:**

- Now supports ArchiCAD 29.

**Bug Fix:**

- You can now install the Datasmith Exporter plugin if a previous install is not found.

## Datasmith Exporter Plugin: NavisWorks

**Bug Fix:**

- You can now install the Datasmith Exporter plugin if a previous install is not found.

## Datasmith Exporter Plugin: SolidWorks

**Bug Fix:**

- You can now install the Datasmith Exporter plugin if a previous install is not found.

Datasmith Exporter Plugin Release Note
