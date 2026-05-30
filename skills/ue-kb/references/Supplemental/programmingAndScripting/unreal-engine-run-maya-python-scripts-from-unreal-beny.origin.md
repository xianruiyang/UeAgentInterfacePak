# 从 Unreal 运行 Maya Python 脚本

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/BEny/unreal-engine-run-maya-python-scripts-from-unreal

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 501 字符。

## 摘要

这些代码片段应该可以帮助任何有兴趣在 Unreal 中独立运行 Maya 中的 Python 脚本的人。第一个脚本在虚幻中运行。它要求在 Maya 中运行脚本的路径，将任何参数传递给 Maya，并提供基本的输出处理。第二个脚本是一个示例 Maya 脚本，它启用插件并运行一个函数，该函数接受从第一个脚本传入的参数（在本例中为文件路径）。打印语句出现在 Unreal 输出日志中。

## 中文整理

### 概览

**虚幻脚本**

```
# run in unreal
import subprocess
# path to MayaPy.exe
mayaPyPath = 'C:\\Program Files\\Autodesk\\Maya2023\\bin\\mayapy.exe'
# path to the script you want to run inside Maya - r'" necessary if path has spaces, i.e. \Unreal Projects\
scriptPath = r'"C:\Users\[USER]\Documents\Unreal Projects\[PROJECT]\Python\mayaScript.py"'
# sample arg passed in with subprocess
fbxFilePath = 'C:\\SM_AirConditioning_01.fbx'
# open MayaPy with subprocess and capture output.  encoding="utf-8" formats maya output as strings.
maya = subprocess.Popen(mayaPyPath + ' ' + scriptPath + ' ' + fbxFilePath, stdout=subprocess.PIPE,stderr=subprocess.PIPE, encoding="utf-8")
```

**玛雅脚本**

```
# scriptPath var in the unreal code above points to this file.
import sys
import os
import maya.standalone as standalone
standalone.initialize(name='python')
import maya.cmds as cmds

# get fbx file path arg passed in via subprocess - sys.argv[n] returns nth arg included in subprocess Popen call.
fbxFilePath = sys.argv[1]
# no plugins are loaded by default in maya standalone - load fbx plugin
```
