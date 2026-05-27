---
title: "Movement Components"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/movement-components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "组件", "Movement Components"]
---

# Movement Components

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / 组件 / Movement Components

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/movement-components-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Movement Components** provide a form a movement to the Actor (or Character) that they are a sub-object of.

## Character Movement Component

The **Character Movement Component** allows avatars not using rigid body physics to move by walking, running, jumping, flying, falling, and swimming. It is specific to **Characters** and cannot be implemented by any other class. It is automatically added when creating **Blueprints** based on the Character class and not manually added.

Properties that can be set include values for falling and walking friction, speeds for travel through air and water and across land, buoyancy, gravity scale, and the physics forces the Character can exert on Physics objects. The Character Movement Component also includes root motion parameters that come from the animation and are already transformed in world space, ready for use by physics. See [Root Motion](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/locomotion/root-motion/index.md) for more information.

For information on working with Character Movement, see [Setting Up Character Movement](https://dev.epicgames.com/documentation/unreal-engine/setting-up-character-movement?application_version=5.7).

## Projectile Movement Component

A **Projectile Movement Component** updates the position of another component during its tick. Behavior such as bouncing after impacts and homing toward a target are supported by this type of component. Normally the root component of the owing actor is moved, however another component may be selected (see [SetUpdatedComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/UMovementComponent/SetUpdatedComponent?application_version=5.5)). If the updated component is simulating physics, only the initial launch parameters (when initial velocity is non-zero) will affect the projectile, and the physics simulation will take over from there.

An example of a Blueprint using a Projectile Movement Component is shown below (click for full sized image).

## Rotating Movement Component

The **Rotating Movement Component** performs continuous rotation of a component at a specific rotation rate. Rotation can optionally be offset around a pivot point. Important to note, collision testing is not performed during movement.

An example of using a Rotating Movement Component might be in the form of an airplane's propellers, or a windmill, or even a series of planets revolving around the sun.
