# Niagara 详细参考入口

本目录用于按需查询 Niagara 内置模块、默认参数和模块分类。默认不要一次性读取所有文件；根据任务精确打开需要的文件。

## 阅读顺序

1. 常用效果制作：先读 `common-modules.md`。
2. 确认内置参数和命名空间：读 `default-parameters.md`。
3. 查询某个模块是否存在：读 `module-inventory.md`。
4. 查询某个分类的模块名和参数名：进入 `modules/` 下对应分类文件。

## 约定

- 模块名、参数名、命名空间和资产路径保持 UE 原始英文，不翻译。
- 中文说明只解释用途、选择规则和验证方式。
- 具体参数默认值以当前项目导出的 Niagara folder JSON 和 UE 面板读回为准。
- 写入 Niagara 参数时优先使用结构化 JSON workflow，不靠记忆硬写 `value_text`。
