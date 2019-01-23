extends Area2D

signal explode(_position)

const DEFAULT_MOVEMENT_SPEED = 200

var Explosion = preload("res://explosions/Explosion.tscn")

var velocity = Vector2()
var manager
var isDead = false

func _process(delta):
  position += velocity * delta

func init(_manager, _position, _direction, speed):
  manager = _manager
  position = _position
  velocity = _direction * speed

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.init(position)
  manager.emit_destroy_signal(explosion)

func explode():
  isDead = true
  $Sprite.hide()

  _show_explosion()

  queue_free()
