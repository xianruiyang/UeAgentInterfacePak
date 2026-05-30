# Slate：自定义导航控件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/P8dV/unreal-engine-slate-customizing-navigation-controls

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1701 字符。

## 摘要

Cody A. Slate 撰写的文章在 FNavigationConfig 中定义了一些默认导航键映射，大多数 Slate 小部件都使用它来处理输入事件并将其转换为定向输入或接受/取消…

## 中文整理

### 概览

*由 [Cody A.](https://dev.epicgames.com/community/profile/Zvl0/Cody.Albert) 撰写的文章* Slate 在 FNavigationConfig 中定义了一些默认导航键映射，大多数 Slate 小部件使用它来处理输入事件并将其转换为定向输入或接受/取消操作。例如，Enter 和空格键以及 Virtual_Accept 游戏手柄键（通常映射到底面按钮）都被转换为 EUINAvigationAction::Accept 操作：

```cpp
EUINavigationAction FNavigationConfig::GetNavigationActionForKey(const FKey& InKey) const
{
    if (InKey == EKeys::Enter || InKey == EKeys::SpaceBar || InKey == EKeys::Virtual_Accept)
    {
        // By default, enter, space, and gamepad accept are all counted as accept
        return EUINavigationAction::Accept;
    }
    else if (InKey == EKeys::Escape || InKey == EKeys::Virtual_Back)
    {
        // By default, escape and gamepad back count as leaving current scope
```

可以通过注册您自己的导航类来自定义用于这些操作的映射。首先，您将重写 FNavigationConfig 并实现您想要修改的任何函数（GetNavigationDirectionFromKey、GetNavigationActionFromKey 等）。然后，您将通过 FSlateApplication::SetNavigationConfig 向 SlateApplication 提供导航配置文件。请注意，编辑器维护两个单独的 FNavigationConfig 实例，一个用于编辑器，一个用于游戏玩法。这可以防止运行时导航控件的更改影响编辑器。
