---
title: "审查测试结果"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/review-test-results-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "审查测试结果"]
---

# 审查测试结果

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / 审查测试结果

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/review-test-results-in-unreal-engine

你可以查看三种不同格式的测试报告：

- 日志文件
- JSON
- HTML

## 日志文件

默认情况下，自动化测试框架会记录事件和测试状态。

其格式为：

- Test Started. Name={<short name>} Path={<full name>}
- Test Completed. Result={<status>}. Name={<short name>} Path={<full name>}
- BeginEvents: <test full name> (... events caught during the test) EndEvents: <test full name>
- **** TEST COMPLETE. EXIT CODE: <exit code number> ****

> [!NOTE]
> 退出代码为0表示无测试失败。

## JSON

命令行参数 `-ReportExportPath="<output path>"` 会将报告存储到目标路径的 `.json` 文件中。

文件中包含测试运行的详细信息，包括：

- 出现的所有事件、
- 各测试的时长、
- 设备详情。

### 示例

```
{  "devices": [    {      "deviceName": "00-00-000-00",      "instance": "878B6A854613D3B6A69CDEAFBA1C5DBA",      "platform": "WindowsEditor",      "oSVersion": "Windows Server 2022 (21H2) [10.0.20348.524] ",      "model": "Default",      "gPU": "Microsoft Basic Display Adapter",      "cPUModel": "Intel(R) Xeon(R) Platinum 8259CL CPU @ 2.50GHz",      "rAMInGB": 127,      "renderMode": "D3D11_SM5",      "rHI": "DirectX 11",      "appInstanceLog": ""    }  ],  "reportCreatedOn": "2000.01.01-12.00.00",  "succeeded": 1,  "succeededWithWarnings": 0,  "failed": 0,  "notRun": 0,  "inProcess": 0,  "totalDuration": 0.3,  "comparisonExported": false,  "comparisonExportDirectory": "",  "tests": [    {      "testDisplayName": "Test1",      "fullTestPath": "Project.Functional Tests.SomeGroup.Test1",      "state": "Skipped",      "deviceInstance": [        "878B6A854613D3B6A69CDEAFBA1C5DBA"      ],      "duration": 0,      "dateTime": "2000.01.01-12.00.00",      "entries": [        {          "event": {            "type": "Info",            "message": "Skipping test: Tests for review [config]",            "context": "",            "artifact": "00000000000000000000000000000000"          },          "filename": "",          "lineNumber": -1,          "timestamp": "2000.01.01-12.00.00"        }      ],      "warnings": 0,      "errors": 0,      "artifacts": []    },    {      "testDisplayName": "Test2",      "fullTestPath": "Project.Functional Tests.SomeGroup.Test2",      "state": "Success",      "deviceInstance": [        "878B6A854613D3B6A69CDEAFBA1C5DBA"      ],      "duration": 0.3,      "dateTime": "2000.01.01-12.00.00",      "entries": [],      "warnings": 0,      "errors": 0,      "artifacts": []    }  ]}
```

## HTML

关于HTML报告的详情，请参阅[设置自动化测试报告服务器](../setting-up-an-automation-test-report-server/index.md)。
