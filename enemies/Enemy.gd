extends Area2D

signal explode(_explosion)

export var sprite_rotation_degrees = -90;
export var desire_rotation_degrees = 90;

const DEFAULT_MOVEMENT_SPEED = 200

var Explosion = preload("res://explosions/Explosion.tscn")

var movement_position
var speed = DEFAULT_MOVEMENT_SPEED
var should_rotate_along_path = false
var isDead = false

func init(_movement_path, _speed):
  movement_position = PathFollow2D.new()
  movement_position.loop = false
  _movement_path.add_child(movement_position)

  if _movement_path.should_rotate_object:
    should_rotate_along_path = true
  else:
    rotation = deg2rad(desire_rotation_degrees - sprite_rotation_degrees)

  if _movement_path.object_speed != 0:
    speed = _movement_path.object_speed
  else:
    speed = _speed

func _process(delta):
  movement_position.offset += speed * delta
  position = movement_position.global_position

  if should_rotate_along_path:
    rotation = movement_position.rotation - deg2rad(sprite_rotation_degrees)

  if movement_position.unit_offset > 1:
    queue_free()

func explode():
  isDead = true
  $Sprite.hide()

  _show_explosion()

  queue_free()

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.init(position)
  emit_signal("explode", explosion)
