---
title: "关卡序列"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/level-sequence-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "关卡序列"]
---

# 关卡序列

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 关卡序列

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/level-sequence-settings-in-the-unreal-engine-project-settings

## 关卡序列

### 时间轴

| **分段** | **说明** |
| --- | --- |
| **默认锁定引擎显示速率（Default Lock Engine to Display Rate）** | 0: 锁定到播放帧的播放。 1: 带有子帧插值的未锁定播放。 |
| **默认显示速率（Default Display Rate）** | 指定新建关卡序列的默认显示帧率；同时在序列被设置为帧锁定时定义帧锁定的帧率。 示例： **30 fps** **120/1 (120 fps)** **30000/1001 (29.97)** **0.01s (10ms)** |
| **默认更新分辨率（Default Tick Resolution）** | 指定新建关卡序列的默认更新分辨率。 示例： **30 fps** **120/1 (120 fps)** **30000/1001 (29.97)** **0.01s (10ms)** |
| **默认时钟来源（Default Clock Source）** | 指定新建关卡序列的默认时钟来源。 你可以从以下选项中选择： **更新（Tick）** **平台（Platform）** **音频（Audio）** **相对时间码（Relative Timecode）** **时间码（Timecode）** **播放每帧（Play Every Frame）** **自定义（Custom）** |
