extends Area2D

signal explode(_explosion)

const DEFAULT_MOVEMENT_SPEED = 200

var Explosion = preload("res://explosions/Explosion.tscn")

var velocity = Vector2()
var isDead = false

func _process(delta):
  position += velocity * delta

func init(_position, _direction, speed):
  position = _position
  velocity = _direction * speed

func explode():
  isDead = true
  $Sprite.hide()

  _show_explosion()

  queue_free()

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.init(position)
  emit_signal("explode", explosion)
