# C++、插件与 API

## 覆盖范围

- UE module、plugin、Build.cs、Editor-only API。
- UObject 反射宏、属性、函数、Subsystem、Delegates。
- UE 源码定位、API 行为确认、版本差异处理。
- 编译、链接、热重载、Editor DLL 占用。

## 阅读时机

- 需要修改 UAI 插件、Editor 工具、命令实现或 smoke 测试。
- 需要从 UE 源码确认某个编辑器菜单、节点、模块或跳转行为。
- 出现链接失败、DLL 占用、API 不存在、版本差异或编译时间问题。

## 后续填充位置

- Editor module 与 runtime module 边界。
- 常见反射宏与生命周期。
- 源码定位策略。
- 多 cpp 拆分和编译加速规则。
