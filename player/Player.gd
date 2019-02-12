extends Area2D

signal explode(_explosion)
signal shoot(_bullet)

const DESIRED_ROTATION_DEGREES = -90
const SPEED = 300

var Explosion = preload("res://explosions/Explosion.tscn")
var Bullet = preload("res://bullets/PlayerBullet.tscn")

var screensize
var is_gun_on_cooldown = false
var is_dead = false

func init(_position):
  position = _position
  rotation = deg2rad(DESIRED_ROTATION_DEGREES)

func _ready():
  screensize = get_viewport().size

func _process(delta):
  var velocity = Vector2()

  if Input.is_action_pressed("move_up"):
    velocity.y -= 1
  if Input.is_action_pressed("move_down"):
    velocity.y += 1
  if Input.is_action_pressed("move_left"):
    velocity.x -= 1
  if Input.is_action_pressed("move_right"):
    velocity.x += 1
  if Input.is_action_pressed("shoot"):
    shoot()

  if velocity.length() > 0:
    velocity = velocity.normalized() * SPEED
    position += velocity * delta

  position.x = clamp(position.x, 0, screensize.x)
  position.y = clamp(position.y, 0, screensize.y)

func setZIndex(z_index):
  $Sprite.z_index = z_index

func shoot():
  if !is_gun_on_cooldown:
    is_gun_on_cooldown = true
    $ShootCooldown.start()

    var _direction = Vector2(0, -1)
    var bullet1 = Bullet.instance()
    var bullet2 = Bullet.instance()

    bullet1.start($FirePosition1.global_position, _direction)
    bullet2.start($FirePosition2.global_position, _direction)
    emit_signal("shoot", bullet1)
    emit_signal("shoot", bullet2)

func explode():
  is_dead = true
  $Sprite.hide()
  _show_explosion()
  queue_free()

func _show_explosion():
  var explosion = Explosion.instance()
  explosion.init(position)
  emit_signal("explode", explosion)

func _on_ShootCooldown_timeout():
  is_gun_on_cooldown = false

func _on_Player_area_entered(area):
  explode()
