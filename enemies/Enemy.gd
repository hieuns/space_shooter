extends Area2D

signal explode(_explosion)

const DEFAULT_MOVEMENT_SPEED = 200

var Explosion = preload("res://explosions/Explosion.tscn")

var movement_position
var speed = DEFAULT_MOVEMENT_SPEED
var isDead = false

func init(_spawning_path, _speed):
  movement_position = PathFollow2D.new()
  movement_position.loop = false
  _spawning_path.add_child(movement_position)

  speed = _speed

func _process(delta):
  movement_position.offset += speed * delta
  position = movement_position.global_position
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
