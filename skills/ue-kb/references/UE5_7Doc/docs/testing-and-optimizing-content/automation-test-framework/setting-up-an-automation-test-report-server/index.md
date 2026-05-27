---
title: "设置自动化测试报告服务器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-an-automation-test-report-server"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "设置自动化测试报告服务器"]
---

# 设置自动化测试报告服务器

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / 设置自动化测试报告服务器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-an-automation-test-report-server

**自动化系统** 可以用来在 **虚幻引擎** 中运行各种系统的测试，但在提供数据可视性方面有一些限制，可能妨碍将其用于分布式测试。自动化系统可以生成HTML报告而不是日志文件，但这些报告会逐渐变得更复杂，如果HTML报告不是本地自足的，你就无法直接在主流Web浏览器上将其打开。

若要解决此限制，你可以使用 **自动化测试报告服务器** 将测试结果输出到共享盘。然后，你可以连接该服务器来阅读报告。

由于自动化测试报告服务器没有后端（除了提供文件之外），它是一种非常基本的、要求不高的Web服务器，你可以在大多数硬件上轻松设置。这意味着，远程运行测试的外部第三方可以自行设置服务器来共享测试结果。

## 必备项

要设置自动化测试报告服务器，你必须拥有以下必备库和程序：

- [Node.js](https://nodejs.org/en/download/)
- [Bower](https://bower.io/)
- [Git](https://git-scm.com/downloads)

不安装这些必备项会遇到错误。

> [!NOTE]
> 你可以在本地主机上执行此设置流程，但由于你无法共享本地主机，你将需要为其设置有效的DNS和IP地址，服务器才可供远程访问。
>
> 设置Web域和地址不在本文档讨论范围内。请酌情选择最适合你的解决方案。

## 步骤

请按如下操作设置你的自动化测试报告服务器。

在下面的说明中，按如下所示替换占位符分段：

- `(path to result)`：测试结果输出的存储路径。例如，`C:\http_server\local`。
- `(stream root)`：源控制流送或UE安装所在的路径。例如，`C:\Epic\UE`。

### 安装HTTP服务器

1. 确保你安装了所有需要的[必备项](#%E5%BF%85%E5%A4%87%E9%A1%B9)。
2. 打开命令提示符窗口。
3. 确保 `%USERPROFILE%\AppData\Roaming\npm` 位于你的命令提示符路径中。
4. 运行以下命令：

   ```
            npm install http-server bower -g		
   ```

   这将全局安装Bower web服务器。
5. 运行以下命令：

   ```
            xcopy (stream root)\Engine\Content\Automation (path to result) /E		
   ```

   这将递归式复制HTTP服务器的图像、配置文件和模板，以供生成的测试报告引用。
6. 运行以下命令：

   ```
            cd (path to result)& bower install		
   ```

   这将要求Bower安装已复制的配置文件中引用的javascript库。

### 运行HTTP服务器

1. 运行以下命令：

   ```
            cd (path to result)& http-server		
   ```

   这会切换到HTTP服务器的工作目录，并开始运行。
2. 将命令提示符保持打开状态。关闭命令提示符将关闭服务器。

### 查看测试结果

1. 运行自动化测试时，使用以下命令指定输出的 `(path to result)` 目录。这会设置你的测试以直接输出到你在其中设置web服务器及其资源的文件夹。

   ```
        -ReportExportPath=C:\http_server\local
   ```
2. 在浏览器中打开你的web服务器IP地址。你可以在内部使用 `http://localhost:8080/`，但如前所述，你需要设置正确的web地址以用于分布式工作。

   输出路径与服务器路径相同则可以直接使用。但是，要使用子目录来存储文件，就需要将其添加到该路径。

   例如，你输出到如下所示的路径：`C:\http_server\local\mypath`，则URL应该是：`http://localhost:8080/mypath`。
3. Web服务器将提供文件列表。输出到正确目录的报告都将立即显示。
4. 如果你提供[会话名称](#%E4%BC%9A%E8%AF%9D)，并将 `Index.html` 和 `index.json`（通常位于目标目录中）与目录一起移动，你可以按名称访问特定测试会话的结果。
5. 查看完结果之后，你可以关闭命令提示符并关闭服务器。

### 设置单独的测试会话

要更好地整理测试结果并防止覆盖，你可以将不同的测试会话分入不同的目录。

1. 定义你所选的目录名称，以便更轻松地识别特定测试。在本示例中，我们将使用 **Session1**。
2. 将你的自动化测试的结果输出到 `(path to result)\Session1`。
3. 当你运行一组不同的测试时，请更改名称。对于每一组新的测试，你可以将会话编号递增，或使用完全不同的描述性名称。这将避免覆盖之前的结果。
4. 要通过web浏览器访问你的结果，请将合适测试会话的目录名称应用于该路径。

## 结果

如果一切正常运作，你将看到类似于下图的内容，显示已执行的测试列表及其各自的状态。

![自动化测试报告服务器提供一些测试结果](../../../../assets/images/ac/ac8705cfbf1af88cf24e5bf3a5fcfbfa5ae8f7821fa8a4a853b6d64a33caf20a.jpg)
