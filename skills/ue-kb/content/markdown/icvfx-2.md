# ICVFX 景深补偿（续 2）

# ICVFX 景深补偿（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/earV/unreal-engine-icvfx-depth-of-field-compensation
- 原始文件：unreal-engine-icvfx-depth-of-field-compensation.origin.md
- 分段：第 2/3 段

虚幻引擎电影摄影机 actor 需要输入 F 制光圈值，因此，如果您的镜头处于 T 制光圈，您将需要转换为 F 制光圈以获得最准确的结果。然而，使用 T-stop 值而不进行转换，您可能会发现非常好的结果，所以不要担心。

### 扫描上的不对称平截头体

还值得注意的是，扫描设置上的不对称平截头体在某些极端情况下可能会影响 DOF，因此请相应地调整 DOF 增益。

### 虚拟前景物体

无法补偿在电影摄影机 actor 和 nDisplay Config actor 之间的墙上渲染的虚拟对象，因此您可能希望禁用这些以获得最佳结果，并依靠物理设置道具来提供前景元素。

### 变形切片分辨率

最后，从 5.4 开始，镜头挤压因子参数现在将增加视锥体的水平分辨率，因此请务必在优化内容时考虑到这一点。在无法做到这一点的情况下，一个好的解决方法是根据挤压因子降低视锥体分辨率乘数或降低视锥体分辨率的高度（例如，挤压因子为 1.8 需要将垂直分辨率除以 1.8） - 虚拟生产

## 相关链接

