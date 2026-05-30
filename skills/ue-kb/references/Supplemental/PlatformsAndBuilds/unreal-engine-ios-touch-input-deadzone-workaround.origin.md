# iOS 触摸输入死区解决方法

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/wzOG/unreal-engine-ios-touch-input-deadzone-workaround

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 740 字符。

## 摘要

文章由 Ryan B 撰写。在操作系统级别，iOS 处理触摸输入并强制执行一个小的盲区。通常这很好，但它可能会阻止非常小的触摸输入变化。我们找到解决此问题的解决方案是...

## 中文整理

### 概览

*文章由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* 在操作系统级别，iOS 处理触摸输入并强制执行一个小的死区。通常这很好，但它可能会阻止非常小的触摸输入变化。我们找到的解决此问题的解决方案是通过小部件驱动我们的大部分输入。为了处理我们的触摸输入，我们只使用触摸移动事件，该事件发生在 OnTouchFirstMove 之后，这样操作系统就不应该再过滤东西，并且应该允许更精确的控制。
