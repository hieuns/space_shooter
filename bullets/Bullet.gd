extends Area2D

const DEFAULT_MOVEMENT_SPEED = 600

var velocity = Vector2()

func _process(delta):
  position += velocity * delta

func start(_position, _direction):
  position = _position
  rotation = _direction.angle()
  velocity = _direction * DEFAULT_MOVEMENT_SPEED

func _on_Visibility_screen_exited():
  queue_free()

func _on_Bullet_area_entered(area):
  if area.is_dead:
    return

  area.explode()
  queue_free()
