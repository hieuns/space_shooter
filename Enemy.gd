extends Area2D

signal explode(_position)

const DEFAULT_MOVEMENT_SPEED = 200

var Explosion = preload("res://Explosion.tscn")

var velocity = Vector2()
var spawning_scene
var isDead = false

func _process(delta):
  position += velocity * delta

func start(_spawning_scene, _position, _direction, speed):
  spawning_scene = _spawning_scene
  position = _position
  velocity = _direction * speed

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.start(position)
  spawning_scene.add_child(explosion)

func explode():
  isDead = true
  $Sprite.hide()

  _show_explosion()

  queue_free()
