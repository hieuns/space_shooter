extends Area2D

signal explode(_explosion)
signal shoot(_bullet)

export var desire_rotation_degrees = 90
export var can_shoot = false

const SPRITE_ROTATION_DEGREES = -90
const SPRITE_ROTATION_VECTOR = Vector2(0, -1)
const DEFAULT_MOVEMENT_SPEED = 200
const LIMITED_FACING_ANGLE_DEGREES = 3

var Explosion = preload("res://explosions/Explosion.tscn")
var Bullet = preload("res://bullets/EnemyBullet.tscn")

var target_reference
var movement_position
var speed = DEFAULT_MOVEMENT_SPEED
var should_rotate_along_path = false
var is_gun_on_cooldown = false
var is_dead = false

func init(_movement_path, _speed, _target):
  movement_position = PathFollow2D.new()
  movement_position.loop = false
  _movement_path.add_child(movement_position)

  if _movement_path.should_rotate_object:
    should_rotate_along_path = true
  else:
    rotation = deg2rad(desire_rotation_degrees - SPRITE_ROTATION_DEGREES)

  speed = _movement_path.object_speed if _movement_path.object_speed != 0 else _speed

  target_reference = weakref(_target) if _target else null

func _process(delta):
  movement_position.offset += speed * delta
  position = movement_position.global_position

  if should_rotate_along_path:
    rotation = movement_position.rotation - deg2rad(SPRITE_ROTATION_DEGREES)

  if _able_to_shoot():
    _shoot()

  if movement_position.unit_offset > 1:
    queue_free()

func explode():
  is_dead = true
  $Sprite.hide()
  _show_explosion()
  queue_free()

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.init(position)
  emit_signal("explode", explosion)

func _able_to_shoot():
  return can_shoot and !is_gun_on_cooldown and _is_target_exist() and _is_facing_target()

func _is_target_exist():
  return target_reference and target_reference.get_ref()

func _is_facing_target():
  var facing_direction = SPRITE_ROTATION_VECTOR.rotated(rotation)
  var direction_to_target = _normalized_direction_to_target()
  return facing_direction.dot(direction_to_target) >= cos(deg2rad(LIMITED_FACING_ANGLE_DEGREES))

func _shoot():
  is_gun_on_cooldown = true
  $ShootCooldown.start()

  var bullet = Bullet.instance()
  bullet.start(position, _normalized_direction_to_target())

  emit_signal("shoot", bullet)

func _normalized_direction_to_target():
  return (target_reference.get_ref().position - position).normalized()

func _on_ShootCooldown_timeout():
  is_gun_on_cooldown = false