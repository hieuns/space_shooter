extends Node2D

var BlackEnemy1 = preload("res://enemies/BlackEnemy1.tscn")
var enemies_spawned = false

func _ready():
  var screensize = get_viewport().size
  var spawning_points = [
    {position = Vector2(0, 0), direction = Vector2(4, 1)},
    {position = Vector2(screensize.x, 0), direction = Vector2(-4, 1)}
  ]
  $EnemyManager.init(self, [BlackEnemy1], spawning_points)

  $Player.position = Vector2(screensize.x / 2, screensize.y - 50)

  $Background.init(screensize)

func _process(delta):
  if !enemies_spawned:
    $EnemyManager.spawn(10)
    enemies_spawned = true

func _on_Player_shoot(Bullet, _position, _direction):
  var bullet_instance = Bullet.instance()
  add_child(bullet_instance)
  bullet_instance.start(_position, _direction)

func _on_EnemyManager_enemy_destroyed(_explosion):
  add_child(_explosion)
