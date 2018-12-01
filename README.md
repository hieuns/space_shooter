Things I learned:
  - When you define an inherited scene which inherites a scene extends the Area2D or KinematicBody2D, the parent scene **must** have a collision node, otherwise you can't call user-defined methods of that scene's script. In the inherite scene, define a shape for that collision node.
