extends Node2D

var RedEnemy = preload("res://enemies/RedEnemy.tscn")

var enemies_spawned = false

func _ready():
  var screensize = get_viewport().size

  $EnemyManager.init(self, [RedEnemy], $EnemyMovementPaths.get_children())

  $Player.init(Vector2(screensize.x / 2, screensize.y - 50))

  $Background.init(screensize)

func _process(delta):
  if !enemies_spawned:
    $EnemyManager.spawn_enemies(10)
    enemies_spawned = true

func player():
  return $Player if has_node("Player") else null

func _on_Player_explode(_explosion):
  add_child(_explosion)

func _on_Player_shoot(bullet):
  add_child(bullet)

func _on_Enemy_explode(_explosion):
  add_child(_explosion)

func _on_Enemy_shoot(bullet):
  add_child(bullet)
