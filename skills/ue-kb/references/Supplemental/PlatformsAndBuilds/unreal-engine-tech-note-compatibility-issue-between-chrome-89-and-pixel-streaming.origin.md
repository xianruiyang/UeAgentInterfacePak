# 技术说明：Chrome 89 和 Pixel Streaming 之间的兼容性问题

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/15EK/unreal-engine-tech-note-compatibility-issue-between-chrome-89-and-pixel-streaming

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 748 字符。

## 摘要

文章由 Martin S 撰写。 描述：Chrome 89 中引入的更改导致 SDP 数据包与版本 4.26.1 及更早版本中包含的 WebRTCPlayer 配置不兼容。潜在影响：[C…

## 中文整理

### 概览

*文章由 [Martin S.](https://dev.epicgames.com/community/profile/Jonn/Svegn2) 撰写* **描述：** Chrome 89 中引入的更改导致 SDP 数据包与版本 4.26.1 及更早版本中包含的 WebRTCPlayer 配置不兼容。 **潜在影响：** [严重]：运行 Chrome 89 的用户将无法建立与 Pixel Streaming 应用程序的连接。 **解决方案：** 在webRtcPlayer.js第29行添加以下代码 this.cfg.offerExtmapAllowMixed = false; UE版本4.25、4.24、4.23、4.22、4.21、4.26
