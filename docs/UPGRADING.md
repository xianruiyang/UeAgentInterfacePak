# 更新 UAI 与恢复旧版

Pak 是插件、CMD 和 skills 的版本组合入口。其子模块提交固定当前组合；不要分别拉取各子仓库最新版本
后仍将它称为同一 Pak 版本。当前支持基线为 Windows 与配套原生补丁的 UE 5.6.1；其他版本未由本次证据证明。

## 从旧版更新

1. 保存项目、资产、工作区 HJSON 及本地源码修改。先检查 Pak 与各子模块的 `git status`；存在修改时，
   在独立目录克隆新版或自行提交保留，不用强制 checkout/reset 覆盖现场。保留当前 Pak 提交号以便恢复。
2. 对无本地修改的 Pak checkout，执行：

   ```powershell
   git fetch origin --tags
   git switch main
   git pull --ff-only origin main
   git submodule sync --recursive
   git submodule update --init --recursive
   ```

   需要固定版本时，获取后使用 `git switch --detach <Pak-tag-or-commit>`，再更新子模块。
   检查 `git submodule status --recursive`：前导 `+` 表示 checkout 偏离 Pak 引用，`-` 表示尚未初始化。
3. 关闭使用目标引擎的 Editor。按 [EnginePatches/README.md](../UeAgentInterface/EnginePatches/README.md)
   备份并应用所选 Plugin 版本的补丁，重编相关引擎模块，再构建目标项目的 Editor target。普通项目构建
   不会代替 Installed Build 引擎模块部署。不要将其他引擎构建的 DLL 直接复制到当前安装。
4. 使用同一 Pak 的 CMD 安装 SDK 与命令行：

   ```powershell
   python.exe UeAgentInterfaceCMD/tools/sdk_environment.py install
   python.exe UeAgentInterfaceCMD/tools/sdk_environment.py status
   ```

   命令从 Pak 根执行，Python 及离线安装要求见 [SDK 文档](../UeAgentInterfaceCMD/docs/PYTHON_SDK_AND_CLI.md)。
   使用原位置 editable 安装时，普通源码更新立即生效；跨目录或依赖声明变化后重新执行 install。
   用户级命令注册指向安装时选择的 CMD，因此切换版本后也应核对 status。
5. 按 [skills 说明](../skills/README.md) 更新需要的 Pak-owned skill。不要把旧 CLI exe、静态 Connection
   模板、`uai_core` 或 Plugin/CMD 文档镜像拷回活动 skill。`understand-space` 由外部 AgentBase 维护。
6. 启动目标 Editor 和 UAI Server。在项目目录运行 `ueagentinterfacecmd connection show`、
   `ueagentinterfacecmd exec project.summary`，确认连接的是预期项目。独立部署按 SDK 文档配置 Connection TOML。
   SDK 内部 HTTP transport 仍有效；业务脚本通过公开 SDK/CLI 调用。

当前 Plugin manifest 与 CMD generated binding 应来自同一发行组合。普通使用者无需重新生成 binding；
维护者只从 `UeAgentInterface/Resources/UaiCommandManifest.json` 生成，不能从旧 schema 或文档恢复命令表。

旧 HJSON 工作区先保留原件。对新版本目标重新导出 workspace，并按当前公开字段迁移用户修改；
不要自行补造机器身份或将旧错误文本当作新诊断协议。导入错误应先按返回的具体原因和输入位置修正。

## 恢复旧版

固定 Pak 旧提交会恢复当时真实的子模块组合；各子仓库单独的旧 main 标签只是该仓库的保留点，
不替代 Pak 原有 gitlink。推荐在独立目录 checkout 旧 Pak 版本并初始化子模块，保留新版现场。
SDK/skills 和需要回退的引擎模块也要按旧版本恢复。切换 Git 版本不会自动回退项目资产或引擎二进制，
因此升级前的资产和引擎备份仍需保留。

## 本次验证边界

本次版本的实际验证和未覆盖范围见 [2026-10-31 发行说明](releases/2026-10-31.md)。
此前八项内容实践的两次连续结果仍只保留其原版本和流程范围，不替代新功能的独立证据。
当前版本补充了公共 HJSON、碰撞/Blueprint 回归、原生截图与零尺寸初始化等有界验证，
不代表全部 UAI 指令、所有 UE 版本或任意模型组合均已验证。发布整理另外核对源文件、安装说明、manifest/binding 和版本引用；
历史 `retired/` 材料不参与运行或命令发现，也不是当前完成门禁。
