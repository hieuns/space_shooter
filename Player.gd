extends Area2D

signal shoot(Bullet, _position, _direction)

const SPEED = 400

var Bullet = preload("res://PlayerBullet.tscn")
var screensize
var can_shoot = true

func _ready():
  # Called when the node is added to the scene for the first time.
  # Initialization here
  screensize = get_viewport().size

func _process(delta):
  # Called every frame. Delta is time since last frame.
  # Update game logic here.
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
  if can_shoot:
    can_shoot = false
    $ShootCooldown.start()

    var _direction = Vector2(0, -1)
    emit_signal("shoot", Bullet, $FirePosition1.global_position, _direction)
    emit_signal("shoot", Bullet, $FirePosition2.global_position, _direction)

func _on_ShootCooldown_timeout():
  can_shoot = true

func _on_Player_area_entered(area):
  queue_free()
