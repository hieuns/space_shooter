extends Node2D

func _ready():
  # Called when the node is added to the scene for the first time.
  # Initialization here
  $Player.position = $PlayerStartingPosition.position

func _on_Player_shoot(Bullet, _position, _direction):
  var bullet_instance = Bullet.instance()
  add_child(bullet_instance)
  bullet_instance.start(_position, _direction)
