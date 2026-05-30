# 分配 HLOD 大楼

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/jP4m/unreal-engine-distributing-hlod-building

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3381 字符。

## 摘要

本文由 Ryan B 撰写。本文提供有关分发 HLOD 构建的信息。命令序列在 Engine\Build\Graph\Examples\BuildWorldPartitionHLODs.xml 文件中定义，您可以...

## 中文整理

### 概览

*本文由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* 本文提供有关分发 HLOD 构建的信息。命令序列在 Engine\Build\Graph\Examples\BuildWorldPartitionHLODs.xml 文件中定义，您需要引用 [BuildGraph 文档](https://docs.unrealengine.com/4.27/ProductionPipelines/BuildTools/AutomationTool/BuildGraph/#writingbuildgraphscripts)，因为将其挂接到分布式构建系统还需要一些额外的工作。下面是一个示例图形脚本，用于使用 BuildGraph 为您的世界生成 HLOD。默认情况下，此脚本会将工作负载拆分为 10 个构建器，如果您使用 Horde，则可能会将工作分配到多台计算机上： RunUAT BuildGraph -script=Engine\Build\Graph\Examples\BuildWorldPartitionHLODs.xml -Target=“HLOD Generation” -set:ProjectName=YourProject -set:EditorTarget=YourProjectEditor -set:MapName=YourMap 参数： - -set:ProjectName=YourProject - 您的项目名称。 - -set:EditorTarget=YourProjectEditor - 编辑器目标的名称。 - -set:MapName=YourMap - 要构建 HLOD 的地图名称。 - -set:BuilderCount=N - 构建器数量。 HLOD 构建将在这 N 个构建者之间平均分配。 - -set:SubmitHLODs=true|false - 是否在流程结束时提交更改。 - -set:ShelveHLODs=true|false - 是否搁置生成的 HLOD。这在调整 HLOD 生成时很方便。如果提供此选项，您还必须通过 ShelveUser 和 ShelveWorkspace 选项指定 Perforce 用户和工作空间。 - -set:ShelveUser=P4User - 如果设置了 ShelveHLODs 选项，则强制应搁置生成结果的用户。 - -set:ShelveWorkspace=P4Workspace - 如果设置了 ShelveHLODs 选项，则应在其中搁置生成结果的 Perforce 工作区。如果您不打算依赖 BuildGraph，您仍然可以在此文件中找到需要使用的命令。如果您不打算依赖 BuildGraph，您仍然可以在前面提到的 Engine\Build\Graph\Examples\BuildWorldPartitionHLODs.xml 文件中找到需要使用的命令。具体来说，您需要执行以下操作： - 设置 HLOD - 在一台计算机上运行。此步骤将创建一个 HLODTemp 文件夹，其中包含 HLODBuildManifest.ini 和其他一些文件。您需要将此文件夹复制到后续步骤中使用的其他计算机。 “YourProject YourMap -run=WorldPartitionBuilderCommandlet -builder=WorldPartitionHLODsBuilder -DistributedBuild -SetupHLODs -BuilderCount=N -SCCProvider=None” - 在 N 台计算机上运行。 “YourProject YourMap -run=WorldPartitionBuilderCommandlet -builder=WorldPartitionHLODsBuilder -DistributedBuild -SetupHLODs -BuilderIdx=[0, N[ -AllowCommandletRendering -SCCProvider=None” - 最终确定 HLOD - 要完成该过程，请运行此步骤。确保 N 台计算机的 HLODTemp 文件夹已复制到运行此步骤的计算机。 “YourProject YourMap -run=WorldPartitionBuilderCommandlet -builder=WorldPartitionHLODsBuilder -DistributedBuild -FinalizeHLODs -SCCProvider=None” 在[知识库！](https://forums.unrealengine.com/docs) 上获取更多答案！
