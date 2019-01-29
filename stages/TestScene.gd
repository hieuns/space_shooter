extends Node2D

var RedEnemy = preload("res://enemies/RedEnemy.tscn")

var enemies_spawned = false

func _ready():
  var screensize = get_viewport().size

  $EnemyManager.init(self, [RedEnemy], [$Path1])

  $Player.position = Vector2(screensize.x / 2, screensize.y - 50)

  $Background.init(screensize)

func _process(delta):
  if !enemies_spawned:
    $EnemyManager.spawn_enemies(10)
    enemies_spawned = true

func _on_Player_shoot(Bullet, _position, _direction):
  var bullet_instance = Bullet.instance()
  add_child(bullet_instance)
  bullet_instance.start(_position, _direction)

func _on_Enemy_explode(_explosion):
  add_child(_explosion)
