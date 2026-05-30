# 如何在 Blueprint 5.4 中正确声明智能对象

# 如何在 Blueprint 5.4 中正确声明智能对象

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/DBJX/unreal-engine-how-to-claim-smart-objects-in-blueprint-5-4-correctly

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1970 字符。

## 摘要

随着虚幻引擎 5.4 中智能对象系统的发展，最显着的变化之一是弃用了 Claim 节点，该节点以前用于将智能对象槽标记为由演员占用。

## 中文整理

### 声明智能对象插槽的更新方法：

![教程图片](assets/unreal-engine-how-to-claim-smart-objects-in-blueprint-5-4-correctly/image-01.jpg)

### 重要的

*您可以按照[智能对象](https://dev.epicgames.com/documentation/en-us/unreal-engine/smart-objects-in-unreal-engine---quick-start#createthebehaviortreetasks)的官方教程并从**创建行为树任务**步骤进行修改。*随着虚幻引擎5.4中**智能对象**系统的发展，最显着的变化之一是**弃用了Claim节点**，之前用于标记演员所占用的智能对象槽。

![5.2 及之前版本的旧索赔节点](assets/unreal-engine-how-to-claim-smart-objects-in-blueprint-5-4-correctly/image-02.jpg)

### 索赔做了什么？

在虚幻引擎的早期版本中，Claim 节点允许开发人员直接将 **智能对象槽** 标记为为特定参与者保留。虽然功能强大，但它缺乏灵活性和精细控制，特别是在多个参与者可能竞争同一位置的更复杂的系统中。

### 将智能对象插槽标记为已声明现在有什么作用？

从 UE 5.4 开始，推荐的节点是： **将智能对象插槽标记为已声明** 该新节点提供了**更加结构化和稳健的**实现，需要以下内容： 1. 从智能对象请求结果中获取的插槽句柄。 2. 试图占据该位置的演员（例如 NPC）。 3. 声明优先级，用于控制当多个参与者尝试声明同一位置时如何解决冲突。

![5.3 和 5.4 版本声明智能对象引用的新方法](assets/unreal-engine-how-to-claim-smart-objects-in-blueprint-5-4-correctly/image-03.jpg)

### 当前实施（图片）

In the provided image, the new implementation process is shown: 1. A search result (Out Results) is obtained using a specific index (Slot Number). 2. Break SmartObjectRequestResult节点用于提取Slot Handle。 3. 然后将其与参与者 (NPC) 和所需的优先级（正常）一起传递到将智能对象槽标记为已声明节点。此设置以更可靠、更清晰的方式有效地取代了旧的 Claim 节点。谢谢！

