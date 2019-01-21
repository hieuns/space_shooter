extends Area2D

const SPEED = 600
# original angle of bullet sprite: Vector2(0, -1)
const ORIGINAL_ANGLE = deg2rad(-90)

var velocity = Vector2()

func _process(delta):
  position += velocity * delta

func start(_position, _direction):
  position = _position
  rotation = _direction.angle() - ORIGINAL_ANGLE
  velocity = _direction * SPEED

func _on_Visibility_screen_exited():
  queue_free()

func _on_Bullet_area_entered(area):
  if area.isDead:
    return

  area.explode()
  queue_free()
