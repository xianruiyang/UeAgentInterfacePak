# Slate：使用预处理器拦截输入事件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/LJjB/unreal-engine-slate-intercepting-input-events-with-preprocessors

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2273 字符。

## 摘要

由 Cody A 撰写的文章。虚幻引擎使用 Slate 传播输入事件，将它们直接传递到关键事件的焦点目标，或者使用生成的命中测试网格来定位鼠标光标下的小部件...

## 中文整理

### 概览

*由 [Cody A.](https://dev.epicgames.com/community/profile/Zvl0/Cody.Albert) 撰写的文章* Unreal Engine 使用 Slate 传播输入事件，将它们直接传递到关键事件的焦点目标，或使用生成的命中网格来定位鼠标事件光标下的小部件。然后，这些事件在层次结构中向上冒泡，传递到每个小部件的父级，直到事件被标记为已处理或到达视口，在视口中，它继续进入玩家输入系统和项目设置中配置的绑定。然而，有时需要拦截所有输入事件，无论其目的地如何。这可以通过 Slate 预处理器来完成，从而可以尽早处理输入，而无需在输入管道内的多个级别实现处理程序。 Slate Preprocessors 应继承自 IInputProcessor 接口，该接口包含许多用于处理不同类型事件的函数。请注意，预处理器绝对是接收输入事件的第一件事，返回 true 将终止事件而不进行任何进一步处理：

```cpp
virtual bool HandleKeyDownEvent(FSlateApplication& SlateApp, const FKeyEvent& InKeyEvent) override
{
	//Custom handling here
	
	if(ShouldTerminateEvent())
	{
		return true;
	}
	
	// Propagate input event for further handling by the standard Slate UI pipeline
```

定义预处理器后，您需要将其注册到 Slate。这可以在模块的 StartupModule 函数中完成，或者在发生特定 UI 操作（例如打开菜单）时完成：

```cpp
InputProcessor = MakeShared<FMyInputProcessor>(this);
FSlateApplication::Get().RegisterInputPreProcessor(InputProcessor);
```

Slate 预处理器可用于各种任务，例如在某些菜单打开时对输入进行门控，或者过滤掉某些键以进行特殊处理，而无需在整个输入层次结构的多个点监听该键。您甚至可以使用它来改变事件，终止传入事件并合成不同的输入事件以手动触发。
