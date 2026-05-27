# Math（Niagara 内置模块）

# Math（Niagara 内置模块）

- 条目数：`23`
- 说明：模块名和参数名保持 UE 原始英文；中文内容用于说明如何查阅和使用。
- 参数默认值和可写格式以当前项目导出的 Niagara folder JSON 为准。

## `AvoidCone`

- 参数名：`AxisToParticleVector_ConstrainedOrNot`、`Cone Apex`、`Cone Axis`、`Constraint - Closest Point to Particle`、`Constraint Vector - Pre Projected`、`Constraint Vector - Projected Onto Plane`、`Nearest Surface Location`、`Nearest Surface Normal`、`Plane Constraint Amount`、`Position`、`Active`、`Apply Radial Falloff`、`Cone Coodinate Space`、`Constraint Influence`、`Constraint Plane Coordinate Space`、`Debug Sprite Width`、`Falloff Angle Inner`、`Falloff Angle Outer`、`Falloff Radius`、`Global Distance Field`、`Nearest Surface Constraint Falloff Distance`、`Nearest Surface Constraint Falloff Rate`、`Strength`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `AvoidDistanceFieldSurfaces_GPU`

- 参数名：`Distance Field`、`DistanceToNearestSurface`、`Nearest Position (World Space)`、`Nearest Surface Vector (World Space)`、`Proximity Avoidance Vector (World Space)`、`Sampling World Position`、`Trace Avoidance Force (World Space)`、`Trace Avoidance Vector Normalized (World Space)`、`Trace Normal (World Space)`、`World Space Trace Intersection`、`Active`、`Debug Nearest Surface Sprite Width`、`Debug Surface Vector Length`、`Debug Trace Normal Vector Length`、`Debug Trace Sprite Width`、`Falloff Distance`、`First Frame`、`Max Iteration Count`、`Max Trace Distance`、`Min Trace Step Size`、`Nearest Surface Avoidance Strength`、`Normal Calculation Sample Radius`、`Obstactle Avoidance Strength`、`Position`、`Reflected Trace Debug Length`、`Trace Direction Convergence Rate`、`Trace Vector`、`Trace Vector's Coordinate Space`、`Trace Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ConeSphereIntersection`

- 参数名：`Apply Actor Scale`、`Destination Space`、`Direction`、`Return A Position`、`Scale`、`Spread`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ConstrainVectorToCone`

- 参数名：`Cone Axis`、`Coordinate Space`、`Fallback Offset Vector`、`Max Angle`、`Vector`、`Vector Coordinate Space`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FadeOverTime`

- 参数名：`Active`、`DeltaTime`、`Fade Rate`、`Initialization Frame`、`Minimum Step Size`、`Minimum Value`、`Minimum Value Difference`、`Target Value`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FindClosestPointOnLineSegment`

- 参数名：`Line Segment End Position`、`Line Segment Start Position`、`Local Line Segment`、`Start Point To Position Vector`、`Calculate Line As Segment`、`Line Segment End`、`Line Segment Input Space`、`Line Segment Start`、`Sample Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FindClosestPointOnTriangle`

- 参数名：`ClosestLineSegmentDistance`、`ClosestLineSegmentPosition`、`Distance PointProjectedOntoPlane`、`PlaneNormal`、`PlanePivotPoint`、`PointProjectedOntoPlane`、`SimPos1`、`SimPos2`、`SimPos3`、`The Plane Projection Is on The Triangle`、`ValidNormal`、`Coordinate Space`、`Query Position`、`Triangle Vertex 1`、`Triangle Vertex 2`、`Triangle Vertex 3`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `FindScreenSpaceBoundingBox`

- 参数名：`AllPointsInFrontOfCamera`、`BoundingBoxCenter`、`BoundingBoxExtents`、`BoxWithinViewFrustrum`、`CameraInsideBB`、`CameraQuery`、`MaxSSBBXPT`、`MinSSBBXPT`、`Bounding Box Center`、`Bounding Box Extents`、`Camera Query`、`Clip Plane Offset`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `Flight_Orientation`

- 参数名：`BasisVectorsAreUpsideDown`、`CurrentBankingQuat`、`Model Y Axis`、`ReverseCourse`、`SmoothZVectorValue`、`TransformedUpVector`、`VelocityMagnitude`、`Bank Rate`、`Course Redirection Convergence Rate`、`Course Redirection Engagment Deceleration Angle`、`Enabled`、`Foward Vector (Mesh Space)`、`Initial Forward Vector`、`Maximum Banking Angle`、`Minimum Banking Angle`、`Particle Velocity`、`Previous Particle Velocity`、`Right Vector (Mesh Space)`、`Rotation Decay Rate In Degrees`、`Turn On Course Redirection`、`Up Vector`、`Up Vector Coordinate Space`、`Upright Roll Correction Speed`、`Velocity Orientation Convergence Rate`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MatchVelocity_ViaForce`

- 参数名：`Mass`、`Max Acceleration`、`Particle Velocity`、`Velocity to Match`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MinMaxOpWithValidChecks`

- 参数名：`A`、`B`、`Is A valid`、`Is B valid`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `MoveToNearestDistanceFieldSurface_GPU`

- 参数名：`Averaged Normals`、`DistanceFieldDI`、`DistanceToSurface`、`KillParticle`、`New Position`、`RadiusOffsetPosition`、`SurfaceNormal`、`Vector to Nearest Surface`、`WorldPosition`、`Active`、`DebugDraw`、`Kill by Distance`、`Position`、`Radius`、`Rigid Mesh Collision Query`、`Sample Position`、`Use Global Distance Field Search This Frame`、`Use Rigid Body Distance Fields This Frame`、`Volume Center Location`、`Volume Extents`、`Volume Transform Coordinate Space`、`VolumeTexture`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PlaceParticlesOnA_Rectangle`

- 参数名：`Z Basis Vector`、`Placement On X`、`Placement On Y`、`Plane Centroid`、`X Basis Vector`、`X Dimension`、`Y Basis Vector`、`Y Dimension`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PlaceParticlesOnDepthBuffer_GPU`

- 参数名：`New Collision Query`、`Collision Query`、`Max Z Depth`、`Mesh Axis To Orient`、`Position`、`Use Max Z Depth`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `PureRoll_Orientation`

- 参数名：`Particle Radius`、`Mesh Dimensions`、`Rotation Rate`、`Scale`、`Surface Normal`、`Update Rotation Rate`、`Velocity`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `RayTraceDistanceField_GPU`

- 参数名：`Normalized Incoming Direction Vector`、`Global Distance Field`、`Max Trace Length`、`Minimum Step Size`、`NumberOfIterations`、`Ray Origin`、`Ray Vector`、`Trace Width`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `ReadDistanceField_GPU`

- 参数名：`Global Distance Field`、`Sample Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SlerpVector`

- 参数名：`Alpha`、`Scale`、`Vector A`、`Vector B`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SolveFloatSpringConstraint`

- 参数名：`Attachement Point Velocity`、`Dampening Coefficient`、`Debug Line Size`、`Debug Position`、`DebugDraw`、`DeltaTime`、`Desired Minimum Separation Distance`、`Equilibrium Value`、`Tightness`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpherePlaneIntersection`

- 参数名：`Normalized Angle`、`Plane Normal`、`Plane Position`、`Radius Percentage For Placement`、`Sphere Position`、`Sphere Radius`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `SpherePlaneIntersection_System`

- 参数名：`Normalized Angle`、`Plane Normal`、`Plane Position`、`Radius Percentage For Placement`、`Sphere Position`、`Sphere Radius`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `TrackDistanceTraveled`

- 参数名：`Current Position`、`Minimum Speed`、`Previous Position`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

## `WedgeLocation`

- 参数名：`Local Pivot Offset`、`Pivot`、`Scale`、`Transform Definition Space`、`X Basis Vector`、`Y Basis Vector`、`Z Basis Vector`
- 使用提示：先通过 Niagara folder JSON 导出真实模块，再修改 module input；不要凭记忆写入参数。

