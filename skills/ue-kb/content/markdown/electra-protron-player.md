# Electra Protron Player

---
title: "Electra Protron Player"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/electra-protron-player-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "Electra媒体播放器", "Electra Protron Player"]
---

# Electra Protron Player

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / Electra媒体播放器 / Electra Protron Player

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/electra-protron-player-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Electra Protron** is a version of the Electra player optimized for local filesystems and container based media. It is meant to help you achieve smooth in-editor scrubbing, looping, and seeking performance, not only in-editor but also for live video performance. For best scrubbing performance, use the Apple Pro Res codec.

## Enabling Electra Protron in the Editor

In the **Project Settings**, you can find a new section called **Electra Protron Factory**. This provides a way for you to override the default player to pick Protron as preferred player over Electra for the following cases:

- In-Editor: Protron only gets picked while in editor.
- In-Game: Protron also gets picked while in Standalone or Packaged modes.

![Electra Protron Factory in the Project Settings](../../../../../../assets/images/d9/d98ac131101dd6cbf6d1d1e293a2c4ae54d431458c28fd1d2a4db601fbeeb25c.jpg)

## Enabling Protron Player in File Media Source Assets

The Protron player is part of the Electra plugin so there are no other prerequisites for enabling it. By default, UE uses the Electra player instead of the Protron player. If you do not want to use the Project Settings override, you can still use the Protron player directly with any File Media Source asset you want. Proceed as follows:

- Open the asset in the editor.
- In the **Details**panel under **Platforms**, open the menu for **Windows**, then select **Electra Protron**.

Any further playback request for the asset, for example from the Media Plate actor, the Media Track in Sequencer, or the Media Viewer, now uses Protron Player.

![Electra Protron in the Details panel of a File Media Source asset](../../../../../../assets/images/c0/c0b36a30b078d1dda0750562d828598364d5947f152c8b5d784fba95927cda6c.jpg)

## Verifying Protron

To ensure UE uses Protron when appropriate, you can verify the player in-use in various areas where the engine plays media assets.

### File Media Source

You can verify Protron is used when playing a File Media Source asset. When you open and play the media asset, you can see the current active Player name displayed under Media Details during playback.

![Electra Protron in the File Media Source asset Media Details](../../../../../../assets/images/2e/2ed99625d54d00b8d4d1130a1a4c50e8afbc6dc843f85dde013024208478b186.jpg)

### Media Plate Actor

The same Media Details section is also available in the Details panel of the Media Plate Actor.

![Electra Protron in the Media Plate actor Details panel](../../../../../../assets/images/29/29643e133e6b2ece470f606077d355bb40f28b43934d108199d18224644e346e.png)

### Sequencer

The Sequencer Media sections display Player and Media information during playback.

![Electra Protron in Sequencer](../../../../../../assets/images/82/8275579a6a7da35e4f537cb45adfcd3a1d64c45936ac45f038047241a4ee55df.jpg)

### Media Viewer

The Media Viewer plugin supports video playback, and displays Player and Media information as an overlay during playback.

![Electra Protron in the Media Viewer](../../../../../../assets/images/83/83480445bd8444eb1058b40fa0618327efd217b54e57b95bf1d573a2f49dae73.jpg)

