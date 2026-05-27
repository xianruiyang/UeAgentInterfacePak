# UGS预编译二进制文件

---
title: "UGS预编译二进制文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-precompiled-binaries-in-unreal-game-sync-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "UnrealGameSync (UGS)", "UGS预编译二进制文件"]
---

# UGS预编译二进制文件

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / UnrealGameSync (UGS) / UGS预编译二进制文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-precompiled-binaries-in-unreal-game-sync-for-unreal-engine

使用 **UnrealGameSync（UGS）** 同步和编译某个版本时，需要你的本地机器有可以编译 **虚幻引擎（UE）** 的IDE，并使用一系列脚本来自动执行编译过程。但是，项目中的许多贡献者并不使用代码库，或者无法访问IDE。为了使这些用户能够运行项目的最新版本，UGS支持将 **预编译二进制文件（PCB）** 添加到版本中。你可以使用 `.zip` 文件形式将PCB提交到Perforce，以将其与变更列表关联。此后，UGS可以同步和解压缩 `.zip` 文件的内容，而不是在本地进行编译。

执行此操作使用的用户界面与本地编译相同，但没有匹配二进制文件的更改都将显示为灰色。配置完成后，用户可以选中 **选项（Options）** 菜单下的 **同步预编译二进制文件（Sync Precompiled Binaries）**，选择使用预编译二进制文件。

## 基本的Perforce设置

以下过程解释了用户需要什么，才能将预编译二进制文件用于UE项目。此过程假定用户已[设置Perforce以用作源代码控制系统](../../../collaboration-and-version-control/using-perforce-as-source-control/index.md)。要设置用于UGS的Perforce服务器的内容，请按此处所述进行操作。

用户将需要单个流送，其中包含引擎源代码、非虚幻构建过程生成的依赖项以及自己项目。

> [!NOTE]
> 这种设置相对少见，但你可以使用Perforce分支而不是用UGS流送。详见[使用分支](#%E4%BD%BF%E7%94%A8%E5%88%86%E6%94%AF).

为了确保所有必需的虚幻引擎文件都存在，用户应该复制Epic现有的其中一个Perforce发布流送。

凡是具有命名规范//UE/Release-4.xx的发布流送，都应该可以从中复制。确保 `.p4ignore.txt` 文件已复制，因为这将确保在开发人员开始从本地构建后，不会将额外的文件添加到流送的副本中。

用户还可以使用 **GitHub**[源构建](https://github.com/EpicGames/UnrealEngine)，运行 `GitDependencies.exe`，并上传完整的源代码以及收集到的依赖项。 复制Epic的其中一个Perforce流送仍然是推荐路径，无论如何收集、生成和上传文件，都需要从流送中复制 `.p4ignore.txt` 文件。

无论你决定采用哪种方式在Perforce中设置文件，请确保文件类型和权限与你设置的任何版本的发布流送相匹配。 如果文件在我们的流送中被标记为可写，则它在你的流送中也应该可写。

- 如果可写和不可写之间存在不匹配，可能会导致构建或运行时失败。 要检查这些权限，请在 **Perforce** 中打开流送，并检查文件名右侧。

  ![在Perforce中检查权限](../../../../../assets/images/bf/bf5314ab5356802ef95b6e3cc4ff23fdb3aade5990c521ac7196d1eec6dbed4b.png)
- 如果你发现需要更改流送中的文件类型或权限，请在打开文件进行编辑后，右键点击该文件，然后点击 **更改文件类型（Change Filetype）**。

  ![在Perforce中更改文件类型](../../../../../assets/images/d1/d1d2ab9185d6ba3f0f2b12e759009df42d80750f849e3a1304846c3f347ac9dd.png)

  这将打开一个菜单，供你编辑文件类型和权限，以匹配我们的发布流送。

  > [!NOTE]
  > 如果你在构建期间或运行时收到特定文件的 **拒绝访问（Access Denied）** 错误，很可能是由于这些权限设置不正确。
- 凡是与UGS一起使用的项目，都需要是原生的，并且与虚幻引擎的文件位于同一流送中。原生项目可以从虚幻引擎目录结构的顶级目录中发现，或者可以从 `.uprojectdirs` 文件（也在虚幻引擎目录结构的顶层）中列出的路径深一层级发现。

## 设置流送

用户应使用单独的流送保存预编译二进制 `.zip` 文件。

可以使用单个流送，但我们强烈建议使用第二个单独的流送，所有有权访问第一个流送的用户也可以访问。 这将避免团队成员不使用PCB而引发的变动。

没有必要为此维护一个单独的工作空间；虚幻游戏同步将使用与同步文件相同的登录凭证以无状态方式获取PCB。

要配置将在其中上传PCB的流送，请执行以下操作：

1. 将 `Build/UnrealGameSync.ini` 添加到项目的根目录下，并引用将上传二进制文件的Perforce位置。 这是从Perforce获取PCB时UGS将搜索的内容。

   `Build\UnrealGameSync.ini` 条目示例：

   ```
    [//UE4/Main/Samples/Games/ShooterGame/ShooterGame.uproject] ZippedBinariesPath=//UE4/Dev-Binaries/++UE4+Main-Editor.zip 
   ```

   > [!NOTE]
   > 如果你的UGS设置指向一个 `*.uproject`，那么 `UnrealGameSync.ini` 必须位于 `[Unreal Project Root Directory]/Build/*`。如果你的设置指向一个 `*.uprojectdirs`，将不会搜索该路径。
2. 指定 `ZippedBinariesPath` 时，有一些细节需要记住：

   - 名称 `//UE4/Dev-Binaries/++UE4+Main-Editor.zip` 需要匹配下面上传部分中提到的ArchiveStream参数，其中++UE4+Main是当前分支的名称，斜杠转义为"+"字符。 使用参数时应使用斜杠而不是"+"字符。
   - 任何有权访问PCB流送的用户账号都可以向其上传一组新的PCB，但如何完成取决于用户，因为这取决于工作室想要如何部署。 手动用户可以执行上传操作，或者自动构建节点也可以完成。

## 生成和上传预编译的二进制文件

在设置了两个流送并且用户有权访问之后，就可以生成PCB并将其上传到指定的PCB流送。

生成并上传PCB：

1. 从Perforce同步 **主流送** 内容。
2. 运行基于位于 `[UE Root]/Engine/Build/Graph/Examples/BuildEditorAndTools.xml` 的示例的 **BuildGraph** 脚本，以便生成PCB并将其上传至正确的Perforce位置（使用 `-ArchiveStream` 参数指定位置）。 使用 `BuildEditorAndTools` 的命令示例：

   ```
        Engine\Build\BatchFiles\RunUAT.bat BuildGraph -Script=Engine/Build/Graph/Examples/BuildEditorAndTools.xml -Target="Submit To Perforce for UGS" -set:EditorTarget=ShooterGameEditor -set:ArchiveStream=//UE4/Dev-Binaries -p4 -submit 
   ```

   在此示例中，**ShooterGame** 是一个原生项目，用户想要作为PCB上传的任何项目也需要是原生的。

   > [!NOTE]
   > 可以在文件开头的注释中找到有关使用 `BuildEditorAndTools.xml` 的更多信息。

   > [!NOTE]
   > `ArchiveStream` 需要匹配之前指定的 `ZippedBinariesPath`，但不是使用"+"字符转义斜杠，而是使用斜杠。
3. 此示例将向 `//UE4/Dev-Binaries/++UE4+Main-Editor.zip` 提交zip文件，其中++UE4+Main是当前分支的名称，斜杠转义为"+"字符。应该将相同的路径设置为 `UnrealGameSync.ini`中`ZippedBinariesPath` 的值。

   > [!NOTE]
   > 确保CL说明的格式正确。 UGS偏向每个CL说明都以"CL"开头，后跟8位数（CL ########），以便它了解二进制文件与哪个变更列表关联。

   > [!NOTE]
   > PDB包含在此 `.zip` 文件中，但它们会被剥离以减少构建大小。 这将允许从崩溃中采集调用堆栈，但不允许进行完整调试。 如果团队需要更好的符号存储，可能要使用符号服务器，符号服务器由IT和部署团队实现。

## 使用来自UGS的预编译二进制文件

使用位于主流送中的文件，在预编译的二进制文件成功生成并上传到次级流送后，UGS应该能够检测和使用主流送相关的PCB。

1. 启用 **同步预编译二进制文件（Sync Precompiled Binaries）** 选项，并同步到最新。 图中示例是一个没有任何预编译二进制文件的流送，但如果在前面步骤中正确设置了二进制文件，则该选项应该可选。

   ![虚幻游戏同步选项菜单中的同步预编译二进制文件](../../../../../assets/images/82/826a471a3b44382311e57922cdef009921f9efcbd30490513a5d667913e9282b.jpg)
2. 应该选择并使用PCB，而不是为选择此选项的任何人构建引擎。

## 使用分支

你可以将UGS与Perforce分支一起使用，而不是流送，具体方法是：

1. 将包含你的配置的 `UnrealGameSync.ini` 文件放在Perforce路径：`Engine/Programs/UnrealGameSync/UnrealGameSync.ini`。 你必须将其提交到Perforce，因为UGS使用 `fstat` 来或获取UGS配置的细节。
2. 确认你的 `ZippedBinariesPath` 与PCB的p4仓库路径完全匹配。
3. 在UGS的 **选项（Option）** 菜单中启用 **同步预编译二进制文件（Sync Precompiled Binaries）**。

