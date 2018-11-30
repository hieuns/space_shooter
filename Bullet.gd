extends Area2D

const SPEED = 400
# original angle of bullet sprite: Vector2(0, -1)
const ORIGINAL_ANGLE = deg2rad(-90)

var velocity = Vector2()

func _process(delta):
  position += velocity * delta

func start(_position, _direction, z_index):
  position = _position
  rotation = _direction.angle() - ORIGINAL_ANGLE
  velocity = _direction * SPEED
  $Sprite.z_index = z_index

func _on_Visibility_screen_exited():
  queue_free()
