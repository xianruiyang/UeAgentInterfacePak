# UAI Core Python Playbook

本文件在需要编写或排查 `uai_core` Python 脚本时读取。日常命令参数仍以 `docs/UeAgentInterface/commands/*.md` 为准。

## 定位规则

- `ProjectRoot`：从当前目录向上查找 `.uproject`，或使用用户明确路径。
- `UaiCmdRoot`：优先用户给出的路径，其次 `<ProjectRoot>/UeAgentInterfaceCMD`，再查当前工作区及父目录候选。
- 判断 `UaiCmdRoot` 是否有效：必须存在 `<UaiCmdRoot>/cli/uai_core/`。
- 自动候选找不到时，先问用户安装路径；不要直接使用 CLI 回退。
- 脚本、params 和 report 默认写入 `<UserWorkDir>/tmp/uai_params/` 与 `<UserWorkDir>/runtimeLogs/`。

## 最小模板

```python
from __future__ import annotations

import json
import sys
from pathlib import Path


def find_project_root(start: Path) -> Path:
    for candidate in (start, *start.parents):
        if any(candidate.glob("*.uproject")):
            return candidate
    return start


def is_uai_cmd_root(path: Path) -> bool:
    return (path / "cli" / "uai_core").is_dir()


def find_uai_cmd_root(
    user_work_dir: Path,
    project_root: Path,
    explicit_uai_cmd_root: Path | None = None,
) -> Path:
    candidates: list[Path] = []
    if explicit_uai_cmd_root is not None:
        candidates.append(explicit_uai_cmd_root)
    candidates.append(project_root / "UeAgentInterfaceCMD")
    for base in (user_work_dir, *user_work_dir.parents, project_root, *project_root.parents):
        candidates.append(base / "UeAgentInterfaceCMD")

    seen: set[Path] = set()
    for candidate in candidates:
        resolved = candidate.resolve()
        if resolved in seen:
            continue
        seen.add(resolved)
        if is_uai_cmd_root(resolved):
            return resolved

    raise RuntimeError(
        "Cannot locate UeAgentInterfaceCMD. Ask the user for UaiCmdRoot. "
        "Use SkillDir/tools/uai-cli.exe only after confirming no UAICMD is available."
    )


user_work_dir = Path.cwd().resolve()
project_root = find_project_root(user_work_dir)
uai_cmd_root = find_uai_cmd_root(user_work_dir, project_root)
sys.path.insert(0, str(uai_cmd_root / "cli"))

from uai_core import UaiCore
from uai_core.commands.material import material_apply_folder

ue = UaiCore.from_config(require_token=True)
doctor = ue.doctor()
if not doctor.get("success", False):
    raise RuntimeError(f"UAI doctor failed: {doctor.get('compatibility', {}).get('issues', [])}")

result = material_apply_folder(
    ue,
    asset_path="/Game/Materials/M_Example",
    create_if_missing=True,
    compile_after_apply=True,
    save_after_apply=True,
)
result.raise_for_failure()

runtime_dir = user_work_dir / "runtimeLogs"
runtime_dir.mkdir(parents=True, exist_ok=True)
(runtime_dir / "uai_result.json").write_text(
    json.dumps(result.response, ensure_ascii=False, indent=2),
    encoding="utf-8",
)
```

## 批处理模式

优先使用 `ue.batch(..., stop_on_error=True)` 组织多步骤任务。每个步骤要能独立解释目的，写入后尽量在同一批次内追加 readback/compile/diagnostic。

失败处理：

1. 读取 `failed_index`、`failed_command`、`failed_error`。
2. 读取失败前已成功步骤的 response，判断是否已产生半完成状态。
3. 修正根因后重组后续步骤；不要无视失败继续追加命令。

## Deprecated 命令

废弃命令只用于历史兼容、迁移验证或排查旧资产问题。Python 导入必须走 `uai_core.commands.deprecated.<category>`，并在记录中写明 `deprecated_use_case` 或迁移理由。
