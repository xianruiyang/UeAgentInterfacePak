# 性能、调试与验证

## 覆盖范围

- UE 日志、Message Log、编译日志、Crash Report。
- CPU/GPU profiling、stat 命令、渲染调试视图。
- 自动化 smoke、读回验证、截图验证、dirty resource 检查。
- 异常失败、假成功、异步编译、编辑器缓存和崩溃排查。

## 阅读时机

- UAI 或 UE 命令返回成功但实际状态不对。
- 出现崩溃、卡死、编译失败、性能异常、截图不可信或 runtime probe 不稳定。
- 需要设计可重复验收流程。

## 后续填充位置

- 日志和 crash 证据收集清单。
- 编译错误与 Stack issue 对照。
- 自动化验证分层。
- 性能排查入口和常用指标。
