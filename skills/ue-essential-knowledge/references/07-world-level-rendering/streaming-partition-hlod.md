# 流式关卡、World Partition 与 HLOD

传统流式关卡把内容分在多个地图包中，由持久关卡保存子关卡关联。Actor 的所属 Level 决定内容保存在哪张地图，关卡放置变换影响它在组合世界中的位置。Editor 中加载、可见和运行时初始加载/可见标志是不同状态；Editor 保存和显示成功不能证明玩家移动时的流送行为。解除关联与删除子地图资产也具有不同影响。

World Partition 在一个持久 Level 中按空间网格组织内容，运行时根据流送源加载单元。Open World 等模板可以直接创建分区地图；已有普通 Level 则需要独立的原生转换流程。Enable Streaming 只控制已存在 World Partition 的流送行为，开启它不能把普通地图转换为分区地图，关闭它也不转换回传统子关卡。Actor 的空间加载设置决定它是否参与空间距离加载，Data Layer 状态还可能影响其加载资格。外部 Actor 包允许分开保存 Actor，但 Actor 仍属于该分区地图；仅使用外部 Actor 保存也不等于启用 World Partition。见 [Epic UE 5.6 World Partition](https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-in-unreal-engine?application_version=5.6)。

Data Layer Asset 定义可复用的层类型，地图中的 Data Layer Instance 保存该世界的层配置，Actor 再引用其所属层。Editor 层与 Runtime 层职责不同；初始运行时状态是持久配置，Editor 临时加载/可见状态只服务编辑。改变后者不能证明运行时激活或卸载。见 [Epic UE 5.6 Data Layers](https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition---data-layers-in-unreal-engine?application_version=5.6)。

HLOD 为未加载区域提供远景表示。HLOD Layer 保存生成方式及层级、单元大小和加载范围等设置；Actor 可以指定 Layer，地图也可以提供默认 Layer。设置引用与原生生成是两个阶段：已有 Layer 资产不代表代理内容已经生成。Instancing 产生实例化表示，Merged Mesh 和 Simplified Mesh 分别合并或合并后简化网格；生成结果和效果应按所选类型判断，不能要求所有类型都生成独立代理网格。见 [Epic UE 5.6 World Partition HLOD](https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition---hierarchical-level-of-detail-in-unreal-engine?application_version=5.6)。

编辑器临时区域加载用于编辑和检查；运行时流送源、性能、切换距离和玩家可见效果仍须在适用运行环境验证。上述职责不预设某个项目的网格尺寸、HLOD 类型或层数，具体配置按目标内容和当前引擎版本确定。
