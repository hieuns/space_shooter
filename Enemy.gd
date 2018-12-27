extends Area2D

const DEFAULT_MOVEMENT_SPEED = 200

var velocity = Vector2()
var isDead = false

func _process(delta):
  position += velocity * delta

func start(_position, _direction, speed):
  position = _position
  velocity = _direction * speed

func explode():
  isDead = true
  $Sprite.hide()
  $AnimatedSprite.show()
  $AnimatedSprite.play("explode")

func destroy():
  queue_free()
