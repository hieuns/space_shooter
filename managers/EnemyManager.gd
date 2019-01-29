extends Node

const DEFAULT_NUM_OF_ENEMIES = 10

var spawning_scene
var enemy_classes = []
var movement_paths = []
var num_of_enemies
var current_enemy_class
var current_movement_path
var spawned_enemies_count = 0

export var spawn_interval = 0.5
export var enemy_speed = 200

func init(_spawning_scene, _enemy_classes, _movement_paths):
  spawning_scene = _spawning_scene
  enemy_classes = _enemy_classes
  movement_paths = _movement_paths

  $SpawnTimer.set_wait_time(spawn_interval)

  randomize()

func spawn_enemies(_num_of_enemies = DEFAULT_NUM_OF_ENEMIES):
  num_of_enemies = _num_of_enemies
  current_enemy_class = _random_enemy_class()
  current_movement_path = _random_movement_path()
  $SpawnTimer.start()

func _on_SpawnTimer_timeout():
  _spawn_enemy()

  if spawned_enemies_count == num_of_enemies:
    spawned_enemies_count = 0
    $SpawnTimer.stop()

func _spawn_enemy():
  var enemy = current_enemy_class.instance()

  enemy.init(current_movement_path, enemy_speed)
  enemy.connect("explode", spawning_scene, "_on_Enemy_explode")
  spawning_scene.add_child(enemy)

  spawned_enemies_count += 1

func _random_enemy_class():
  return enemy_classes[randi() % enemy_classes.size()]

func _random_movement_path():
  return movement_paths[randi() % movement_paths.size()]
