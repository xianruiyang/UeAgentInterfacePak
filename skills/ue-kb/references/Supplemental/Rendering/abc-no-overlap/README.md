# Rendering ABC No Overlap

[Rendering 补充专题](../README.md)

此子集来自 `D:\program\videoReader\ueSociDocs\selected\rendering-abc-no-overlap\docs`，原始集合包含 83 个 Markdown 整理文档和 365 张 JPG 资源图。导入 KB 时，较长教程被拆成多个 `.partNN.origin.md` 文件以保证 chunk 构建稳定；文档内保留原始 Epic Developer Community URL、运行时分类、摘要和中文整理正文。

## 覆盖主题

- Movie Render Graph / Movie Render Queue / 命令行渲染。
- Render Layer、Render Pass、Custom Depth、Stencil、透明输出和合成流程。
- Material、Ambient Occlusion、Post Process、Petzval Bokeh、水体涟漪和屏幕网格渲染。
- Substrate 水面材质、Lumen fake-normal 折射、Fresnel 反射/折射比例、吸收散射和世界空间多频波浪。
- Lighting、Lumen、Nanite、Path Tracing、渲染农场和 GPU/PSO 问题处理。

## 本地经验教程

- [UE Substrate 水面材质制作教程](ue-substrate-water-material-making-tutorial.origin.md)：从零搭建 `Opaque + Substrate` 水面，重点覆盖 fake-normal 折射、反射/折射双 carrier、Fresnel 能量比例、水体吸收散射、世界空间波浪、P6/P7/P8 实现边界和常见故障排查。

此目录作为 `ue-kb-rendering-supplemental` source 的来源目录；`content/`、`chunks/` 和 `indexes/` 由 kbCli 派生生成，不在此处手动维护。若原文包含 `NiagaraClipboardContent` / Base64 剪贴板导出负载等非自然语言内容，KB 正文会以省略说明替代，避免干扰检索和向量构建。
