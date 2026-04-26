# Niagara 内置模块分类

本目录按 UE Niagara 内置模块分类组织。每个文件都是中文索引，保留 UE 原始模块名、参数名和资产路径。

## 使用方式

1. 先在 `../module-inventory.md` 确认模块属于哪个分类。
2. 打开对应分类文件，查看模块名和参数名。
3. 在项目中通过 UAI 的 Niagara folder workflow 导出目标 System / Emitter。
4. 基于导出的 JSON 修改 module input，并检查 apply 返回的 Stack issue、compile log 和 runtime probe。

## 注意

- 本目录不替代 UE 编辑器面板和项目导出的 JSON。
- 参数值格式以 UE 导出的 `override_default_value` 和读回结果为准。
- 模块名和参数名是 UE API/资产标识，故保持英文。
