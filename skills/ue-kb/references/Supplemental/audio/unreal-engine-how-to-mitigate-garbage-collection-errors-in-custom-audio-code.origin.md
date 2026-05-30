# 如何减少自定义音频代码中的垃圾收集错误

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/5kOb/unreal-engine-how-to-mitigate-garbage-collection-errors-in-custom-audio-code

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2044 字符。

## 摘要

文章由 Anna L 撰写。自定义 C++ 音频代码中最常见的错误之一涉及 UObject 被 Unreal 的垃圾收集系统意外删除。因为Unreal的音频引擎涉及多个线程……

## 中文整理

### 概览

*文章由 [Anna L.](https://dev.epicgames.com/community/profile/Ob2/lantz.anna) 撰写* 自定义 C++ 音频代码中最常见的错误之一涉及 UObject 被 Unreal 的垃圾收集系统意外删除。由于 Unreal 的音频引擎涉及多个线程，因此您可能需要采取更多步骤来确保当音频渲染线程中仍然存在对音频资源的引用时，音频资源不会面临被垃圾回收拾取的风险。如果出现以下情况，这可能是您遇到的问题：

```cpp
- You've written C++ code that interacts with Unreal's Native Audio Engine, and/or are creating audio UAssets such as USoundBase's within C++ code
  
- You are getting somewhat unpredictable crashes during level teardown/transitions, or when attempting to read or write from certain audio assets
  
- You are failing ensures or otherwise getting errors involving audio data not existing when you attempt to read/write to it.
```

为了减少垃圾收集错误，将 UObject 排除在音频渲染线程之外非常重要。这意味着将 UObject 或指向 UObject 的智能指针放入 RunCommandOnAudioThread 调用的参数中永远不安全。相反，建议为您的 UObject 使用代理 - 例如，不从 UObject 继承但包含相同数据的 C++ 对象。 USoundWave 和 FWaveInstance 之间的关系可以提供一个很好的代码示例，说明如何使用代理。然而，只要垃圾收集系统知道您持有对它们的引用，在游戏和音频线程上引用 UObject 就是安全的。最简单的方法是使用 TStrongPtr 对对象进行 UProperty 引用，或者从 FGCObject 继承一个单独的类并使用 AddReferencedObjects() 方法。
