extends Area2D

const SPEED = 600
const SPRITE_ROTATION_DEGREES = -90

var velocity = Vector2()

func _process(delta):
  position += velocity * delta

func start(_position, _direction):
  position = _position
  rotation = _direction.angle() - deg2rad(SPRITE_ROTATION_DEGREES)
  velocity = _direction * SPEED

func _on_Visibility_screen_exited():
  queue_free()

func _on_Bullet_area_entered(area):
  if area.is_dead:
    return

  area.explode()
  queue_free()
