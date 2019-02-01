extends Area2D

signal explode(_explosion)

export var deg_sprite_rotation = 90;

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

  if _movement_path.is_object_rotate_along_path():
    movement_position.rotate = true
    should_rotate_along_path = true
  else:
    rotation = deg_sprite_rotation

  speed = _speed

func _process(delta):
  movement_position.offset += speed * delta
  position = movement_position.global_position

  if should_rotate_along_path:
    rotation = deg2rad(deg_sprite_rotation) + movement_position.rotation

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
