---
title: "合成材质节点参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/compositing-material-nodes-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "Real-Time Compositing with Composure", "合成材质节点参考"]
---

# 合成材质节点参考

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / Real-Time Compositing with Composure / 合成材质节点参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/compositing-material-nodes-reference-for-unreal-engine

为了简化合成操作，我们添加了一系列节点来提供最常见的一些合成操作。我们将在这里简要地重点介绍各个节点及其用途。

![image1.png](../../../../../assets/images/25/252183ad1641355165593ccf77aa8434e40c5d4186f57341cf1124c14cdffbe7.jpg)

> [!NOTE]
> 合成材质节点需要 **float4** 输入，因此确保传递 **RGBA**，而不仅仅是 **RGB**。

## Over

该节点使用输入A的alpha将一个图像（A）叠加到另一个图像（B）。

![image7.png](../../../../../assets/images/8f/8fc49abce633ad9b3f5b569f6ac07d26c0bcf1896d1eb94ded36aaefa742a29c.png)

> [!NOTE]
> 该节点需要输入颜色通道预乘图像的alpha。

## In

该节点返回A在B形状以部的部分。

![image2.png](../../../../../assets/images/c5/c55796d4c6c6d516f5ab8b5df85734ec886a8e9abecf2603343377d76faf14cc.png)

## Out

该节点返回A在B形状以外的部分。

![image3.png](../../../../../assets/images/bf/bf5b0dc53b33220e8b6132f6c331e5853db6c73b8181be92f2a4a730aa2e980f.png)

## PreMult

该节点将输入的RGBA通道乘以其alpha。

![image6.png](../../../../../assets/images/37/37eae636e1c4041e543d54ee1335c0cd3f848fbbf1987b89592186919ff7ec32.png)

## UnPreMult

该节点将用输入的RGBA通道除以其alpha。

![image5.png](../../../../../assets/images/a8/a8cdb4a7d5edbcec09b095a0a96f5b2685ab975d2f89c20fe97acbd7b9728cdb.png)

## KeyMix

该节点使用指定的遮罩将两个图像叠加在一起。

![image4.png](../../../../../assets/images/b7/b748b9bab9bad32db4043276809c3f954e102efcf1573bf3fa4593993884d0bd.png)
