# 材质与着色

## 覆盖范围

- Material、Material Function、Material Instance。
- Expression 节点、Root input、参数、静态开关。
- Shader 编译、Substrate、Lumen 相关材质约束。
- UV、Normal、Tangent Space、World Space、Screen Space。

## 阅读时机

- 需要创建或修改材质图、材质函数、材质实例参数。
- 出现材质编译错误、黑色/白色输出、透明/不透明混淆、空间方向错误。
- 需要解释材质节点来源、输入输出语义或 shader 编译结果。

## 通用经验

### 材质采样与过滤

所有贴图和程序化图案都必须考虑屏幕采样与过滤层级。贴图应使用合适的 mipmap、采样过滤和 UV 频率；程序化图案没有自动 mipmap 时，应使用 `fwidth` / `ddx` / `ddy`、`smoothstep`、预滤波、距离淡出或降低频率等方式做等效过滤。否则在远距离、小尺寸、斜视角、细 Ribbon / Beam / Sprite 或高频发光图案上，容易出现摩尔纹、闪烁、虚线、亮点和时域抖动。

## 后续填充位置

- 常用材质空间与坐标转换。
- Root input 与 Blend Mode 的关系。
- Material Function 复用规则。
- 编译错误和 preview 误差排查清单。
