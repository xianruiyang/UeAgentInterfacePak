# 图像序列Mip

---
title: "图像序列Mip"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/image-sequence-mipmapping-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "媒体框架概述", "图像序列Mip"]
---

# 图像序列Mip

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / 媒体框架概述 / 图像序列Mip

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/image-sequence-mipmapping-in-unreal-engine

## 介绍

本文档提供了关于将多级渐进纹理（以下简称Mipmap）用于图像序列的概述。

> [!TIP]
> 5.1的用户可以使用[处理EXR工具](../../../the-media-plate-actor/convert-media-into-the-exr-format-with-the-proc-37b051d3/index.md)生成带正确设置的 `.exr` 文件，与[媒体板Actor](https://dev.epicgames.com/documentation/404)一起使用。

## Mipmap

图像序列中的Mipmap可用于缩短数据的加载时间。

Mipmap不会作为法线纹理导入到引擎中，因此不会为EXR Mipmap创建UAsset。由于此行为，需要手动生成mip级别，然后才能在引擎中使用。请参阅[使用Nuke和Python脚本创建EXR Mipmap](#%E4%BD%BF%E7%94%A8nuke%E5%92%8Cpython%E8%84%9A%E6%9C%AC%E5%88%9B%E5%BB%BAexr%20mipmap)，了解如何生成你自己的Mipmap。

### 限制

- 目前仅支持EXR文件。
- 不支持各向异性Mip。
- 数据加载时间缩短是通过仅加载所需Mip等级实现的。
- 对于经过GPU优化的流送内容，所有EXR图像序列都应是未压缩的。
- 当EXR未压缩时，你才能在加载EXR时获得GPU加速。
- Mip级别要么全部压缩，要么全部未压缩。如果一个级别压缩，另一个级别未压缩，就会打断链条。

## 文件目录结构

Mipmap文件目录结构应如下所示，文件名遵循Cineon命名规范，并且是行业标准。

```
	Smoke_Element/2048x2048/Smoke_Element.00001.exr	Smoke_Element/1024x1024/Smoke_Element.00001.exr	Smoke_Element/512x512/Smoke_Element.00001.exr 
```

文件名和目录名必须遵循以下规则：

- 所有文件夹名称需要是二的乘方，例如，1024x512。
- Mip的图像名称应该与源图像完全相同。

## 编辑器设置

要使用Mipmap功能，必须将 `ImgMediaPlayback` 组件添加到所有会显示这些图像的对象。如果某个对象上没有该组件，则该对象不会用于确定应使用哪些mip级别。

你可以使用以下控制台命令启用调试：

`ImgMedia.MipMapDebug 1`

这会显示每个图像序列当前正在使用哪个mip级别。

## Mip级别选择

Mip级别是根据每个需要显示图像的对象的预估"像素-纹素"密度来选择的。

由于摄像机位置会被用于计算，因此快速移动的摄像机可能会在估算中引入更多误差。进一步的工作可以改进估算，并将摄像机移动考虑在内。

可以使用 `ImgMediaPlayback` 组件上的 **LODBias** 设置手动调整所选Mip级别。

## 使用Nuke和Python脚本创建EXR Mipmap

Nuke和Python脚本可以帮助你自动生成mip级别。每个脚本都可在此页下载和查看。

[nukeMipMap.py](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/64163bff-c10b-4e2b-bf50-cf53f857cf76/nukemipmap.zip)是可以在[Nuke](https://www.foundry.com/products/nuke)中运行的Python脚本，它将设置合适的LOD生成树。

- 要使用该脚本，请选择你的EXR序列，然后设置所需的mip级别数量。
- 在脚本顶部，选择你想为其创建mipmap的read节点，然后执行。
- 在Nuke中将为你创建所有必要的reformat和write节点。
- 将为你创建每个mip渲染所需的全部必要分辨率文件夹。
- Mip渲染的路径将基于执行中的所选read节点。

nukeMipMap.py

```
	# 所有序列需要位于按图像分辨率命名的文件夹中。	# 示例 - D:/Perforce/EXR_Sequences/Smoke/2048x2048/	            D:/Perforce/EXR_Sequences/Smoke/1024x1024/				D:/Perforce/EXR_Sequences/Smoke/512x512/ 	# 对于经过GPU优化的流送内容，所有EXR图像序列都应是未压缩的。	# 当EXR未压缩时，你才能在加载EXR时获得GPU加速。	# 要更快加载到虚幻中，首选未压缩格式。	# 所有mip要么全部压缩，要么全部未压缩。如果一个级别压缩，另一个级别未压缩，就会打断链条。	# 所有mip级别的名称都需要与源文件的名称完全相同。	# 要使用该脚本，请选择你的EXR序列，然后设置所需的mip级别数量。	# 在脚本顶部，选择你想mip的read节点，然后执行。	# 在Nuke中将为你创建所有必要的reformat和write节点。	# 将为你创建每个mip渲染所需的全部必要分辨率文件夹。	# 所有文件夹名称需要是2的乘方。示例 - (128,256,512,1024)	# Mip渲染的路径将基于执行中的所选read节点。 	import nuke	import os 	# 你想要多少个mip级别？	mipLevels = 3 	# 抓取节点选择	selectedRead = nuke.selectedNodes()	addLevel = mipLevels + 1 	# 获取图像序列的高度和宽度	def getHeightWidth(read):		getFormat = []		getHeight = []		getWidth = []		getFormat = read.format()		getHeight = getFormat.height()		getWidth = getFormat.width()		dirResName = str(getWidth) + 'x' + str(getHeight) 	return dirResName 	def getFilePathName(readNode):		getName = readNode['file'].value() 	return getName 	# 创建目录	def createDirectories(readNode,read):		getNameLocal = getFilePathName(readNode)		getHeightWidthLocal = getHeightWidth(read)		getSequenceName = []		parentPath = []		dirResName = []		dirName = []		setRenderPathName = []		getSequenceName = getNameLocal.split('/')[-1]		parentPath = getNameLocal.split(getSequenceName)[0]		dirName = parentPath + getHeightWidthLocal 	# 设置渲染路径名称	setRenderPathName = dirName + '/' + getSequenceName	isThere = os.path.isdir(dirName)	if isThere == False:		os.makedirs(dirName) 	return setRenderPathName 	# 创建reformat	def createReformatNodes(connectReformat):		createScale = nuke.nodes.Reformat()		createScale['type'].setValue("scale")		createScale['scale'].setValue(0.5)		createScale.connectInput(1,connectReformat)	return createScale 	# 创建write节点	def createWriteNodes(path,connect):		createWrite = nuke.nodes.Write()		createWrite['file'].setValue(path)		createWrite['file_type'].setValue('exr')		createWrite['compression'].setValue('none')		createWrite.connectInput(1,connect)	return createWrite 	# 生成树	if len(selectedRead) > 0:	for x in selectedRead:		getFilePathName(x)			for index in range(addLevel):				if index == 0:			getHeightWidth(x)			setPathLocal = createDirectories(x,x)			createWriteLocal = createWriteNodes(setPathLocal,x)		else:			createScaleLocal = createReformatNodes(createWriteLocal)			getHeightWidth(createScaleLocal)			setPathLocal = createDirectories(x,createScaleLocal)			createWriteLocal = createWriteNodes(setPathLocal,createScaleLocal)		else:		nuke.alert("未选择任何对象。请选择你的EXR序列READ NODES 以生成Mipmap") 
```

[Unreal_ExrMipMap_GenerationExample.nk](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/755fe8e0-4e53-46c6-9c4d-bb61be2d3c5b/unreal_exrmipmap_generationexample.zip)是一个示例Nuke脚本，其中包含已为你创建的树。它演示了Mipmap需要什么样的文件夹结构才能生成合适的LOD缩放，并显示了没有压缩的write节点配置。

Unreal_ExrMipMap_GenerationExample.nk

```
	#! C:/Program Files/Nuke12.0v3/nuke-12.0.3.dll -nx	version 12.0 v3	define_window_layout_xml {<?xml version="1.0" encoding="UTF-8"?>	<layout version="1.0">	<window x="-1" y="-8" w="2560" h="1377" maximized="1" screen="0">		<splitter orientation="1">			<split size="40"/>			<dock id="" hideTitles="1" activePageId="Toolbar.1">				<page id="Toolbar.1"/>			</dock>			<split size="2516" stretch="1"/>			<splitter orientation="2">				<split size="1333"/>				<dock id="" activePageId="DAG.1" focus="true">					<page id="DAG.1"/>					<page id="Curve Editor.1"/>					<page id="DopeSheet.1"/>				</dock>			</splitter>		</splitter>	</window>	<window x="3219" y="212" w="1885" h="746" screen="1">		<splitter orientation="2">			<split size="746"/>			<dock id="" activePageId="Viewer.1">				<page id="Viewer.1"/>			</dock>		</splitter>	</window>	</layout>	}	Root {	inputs 0	name C:/Users/Desktop/EXR_Mipmap/Unreal_ExrMipMap_GenerationExample.nk	format "2048 1556 0 0 2048 1556 1 2K_Super_35(full-ap)"	proxy_type scale	proxy_format "1024 778 0 0 1024 778 1 1K_Super_35(full-ap)"	colorManagement Nuke	workingSpaceLUT linear	monitorLut sRGB	int8Lut sRGB	int16Lut sRGB	logLut Cineon	floatLut linear	}	BackdropNode {	inputs 0	name LOD1	tile_color 0x999dbcff	gl_color 0x3f4cccff	label "\t- 按0.5缩放，以创建第二个mip级别，也称为LOD1\n\t- 图像需要位于使用新的图像分辨率的文件夹中。\n\t- 图像分辨率文件夹需要位于源元素(LOD0)所在的相同目录中\n\t- 示例：D:/Perforce/EXR_Sequences/Smoke/1024x1024/\n\t- 图像应与源完全同名，并使用相同的压缩类型"	xpos -584	ypos -19	bdwidth 633	bdheight 157	}	BackdropNode {	inputs 0	name LOD2	tile_color 0x96c499ff	gl_color 0x73cc71ff	label "\t- 按0.25缩放，以创建第三个mip级别，也称为LOD2\n- 图像需要位于使用新的图像分辨率的文件夹中\n- 图像分辨率文件夹需要位于源元素(LOD0)所在的相同目录中\n- 示例：D:/Perforce/EXR_Sequences/Smoke/512x512/\n- 图像应与源完全同名，并使用相同的压缩类型"	xpos -1057	ypos 180	bdwidth 587	bdheight 160	}	BackdropNode {	inputs 0	name LOD3	tile_color 0xb790aaff	label "\t- 按0.125缩放，以创建第四个mip级别，也称为LOD3\n\t- 图像需要位于使用新的图像分辨率的文件夹中。\n\t- 图像分辨率文件夹需要位于源元素(LOD0)所在的相同目录中\n\t- 示例：D:/Perforce/EXR_Sequences/Smoke/256x256/\n\t- 图像应与源完全同名，并使用相同的压缩类型"	xpos -586	ypos 398	bdwidth 662	bdheight 156	}	BackdropNode {	inputs 0	name Source_Element__LOD0	tile_color 0xaf9f9fff	label "源元素\n     - 源图像需要位于以图像分辨率为名称的文件夹中。\n     - 示例 - D:/Perforce/EXR_Sequences/Smoke/2048x2048/\n     - 对于GPU增强优化的流送到虚幻引擎的过程，所有EXR序列都应该是未压缩的\n     - 在mip级别中混合使用压缩和未压缩格式会打断链条"	selected true	xpos -751	ypos -347	bdwidth 592	bdheight 204	}	Read {	inputs 0	file_type exr	file D:/Perforce/Project/Movies/EXR_Sequences/AtmosSmoke_003/smoke_003.####.exr	format "1152 2048 0 0 1152 2048 1 "	first 100	last 360	origfirst 100	origlast 360	origset true	in_colorspace scene_linear	out_colorspace scene_linear	name LOD0	selected true	xpos -573	ypos -230	disable true	} 	Reformat {	type scale	scale 0.5	name Scale_LOD1	xpos -573	ypos 87	} 	set N9841b000 [stack 0]	Reformat {	type scale	scale 0.5	name Scale_LOD2	xpos -573	ypos 287	} 	set N9841a800 [stack 0]	Reformat {	type scale	scale 0.5	name ScaleLOD3	xpos -573	ypos 507	} 	Write {	file D:/Perforce/EXR_Sequences/Smoke/256x256/smoke.####.exr	file_type exr	compression none	first_part rgba	version 5	in_colorspace scene_linear	out_colorspace scene_linear	name LOD3_Write	xpos -463	ypos 501	} 	push $N9841b000 	Write {	file D:/Perforce/EXR_Sequences/Smoke/1024x1024/smoke.####.exr	file_type exr	compression none	first_part rgba	version 6	in_colorspace scene_linear	out_colorspace scene_linear	name LOD1_Write	xpos -368	ypos 81	} 	push $N9841a800 	Write {	file D:/Perforce/EXR_Sequences/Smoke/512x512/smoke.####.exr	file_type exr	compression none	first_part rgba	version 5	in_colorspace scene_linear	out_colorspace scene_linear	name LOD2_Write	xpos -791	ypos 281	}
```

下面生成的图像显示了 `Unreal_ExrMipMap_GenerationExample.nk` 脚本的示例屏幕截图。

[autoGenEXR_mipmap.py](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/33c4dac7-34e4-4577-a7e3-adbef91745e4/autogenexr_mipmap.zip)脚本适用于没有Nuke的用户。此Python脚本将自动创建必要的文件夹，以及将mip级别缩放并写出到磁盘。

> [!WARNING]
> 为了让此脚本能正常运作，你需要安装以下免费的python模块：[numpy](https://pypi.org/project/numpy/)、[opencv](https://pypi.org/project/opencv-python/)和[shutil](https://pypi.org/project/pytest-shutil/)。

autoGenEXR_mipmap.py

```
	import os	os.environ["OPENCV_IO_ENABLE_OPENEXR"]="1"	import cv2 as cv	import numpy as np	import glob	import shutil 	setMipLevel = 3	fileInDir = glob.glob("C:\\Users\\User\\Desktop\\smokeCards\*.exr") 	# 获取父序列的文件路径	grabFirst = fileInDir[0]	splitFile = grabFirst.split('\\')[-1]	getParentPath = grabFirst.replace(splitFile,'') 	# 获取图像分辨率	img = cv.imread(grabFirst, cv.IMREAD_UNCHANGED)	height = np.size(img, 0)	width = np.size(img, 1) 	# 创建文件夹	def createFolders(dirName):		isThere = os.path.isdir(dirName)	if isThere == False:		os.makedirs(dirName) 	# 构建LOD0的文件夹路径并将序列复制到LOD0文件夹	LOD0_folderName = getParentPath + str(width) + 'x' + str(height)	createFolders(LOD0_folderName) 	for x in fileInDir:	getFileName = x.split('\\')[-1]	newFile = LOD0_folderName + '\\' + getFileName	if os.path.isfile(newFile) == 0:		shutil.copyfile(x, newFile)		print('copying ' + newFile + ' to correct file path') 	# 创建经过mip后的EXR文件	def createFiles(file, mipWidth, mipHeight, folderPath):	getName = file.split('\\')[-1]	imageSize = (int(mipWidth), int(mipHeight))	readFile = cv.imread(file, cv.IMREAD_UNCHANGED)	resizeFile = cv.resize(readFile, imageSize, interpolation = cv.INTER_LANCZOS4)	newFile = folderPath + '\\' + getName	cv.imwrite(newFile, resizeFile, [cv.IMWRITE_EXR_TYPE, cv.IMWRITE_EXR_TYPE_HALF])	print("saving mipped file to " + newFile) 	# 为Mip执行数学运算，创建经过mip后的文件夹和文件	for index in range(setMipLevel):	if index == 0:		newWidth = width / 2		newHeight = height / 2		LOD1FolderPath = getParentPath + str(int(newWidth)) + 'x' + str(int(newHeight))		createFolders(LOD1FolderPath)		for file in fileInDir:			createFiles(file, newWidth, newHeight, LOD1FolderPath)	else:		mipWidth = newWidth / 2		mipHeight = newHeight / 2		newWidth = mipWidth		newHeight = mipHeight		lowerMipFolderPath = getParentPath + str(int(newWidth)) + 'x' + str(int(newHeight))		createFolders(lowerMipFolderPath)		for file in fileInDir:			createFiles(file, mipWidth, mipHeight, lowerMipFolderPath) 
```

