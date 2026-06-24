# 编辑器资产与内容体系

## 覆盖范围

- Content Browser、Package Path、Object Path、Asset Registry。
- 资产保存、重命名、移动、删除、重定向器。
- 引用关系、软引用、硬引用、路径字符串引用。
- 导入导出、迁移、Derived Data、Asset Editor 状态。

## 阅读时机

- 需要定位资产、判断引用、清理资源、保存或删除资产。
- 任务涉及 `/Game/...` 路径、`.uasset` 文件、Asset Registry 或内容浏览器行为。
- UAI 返回成功但内容浏览器或资产状态看起来不一致。

## 后续填充位置

- Package path / object path / file path 对照表。
- 删除资产前的安全检查。
- 重定向器和引用修复流程。
- dirty asset 与打开的 Asset Editor 关系。
