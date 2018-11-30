extends Area2D

const SPEED = 400

var screensize

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

  if velocity.length() > 0:
    velocity = velocity.normalized() * SPEED
    position += velocity * delta

  position.x = clamp(position.x, 0, screensize.x)
  position.y = clamp(position.y, 0, screensize.y)
