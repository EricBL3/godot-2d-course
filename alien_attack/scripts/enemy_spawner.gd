extends Node2D

signal enemy_spawned(enemy)
signal path_enemy_spawned(path_enemy)

@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

func spawn_enemy():
	var random_spawn_pos = spawn_positions.get_children().pick_random()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = random_spawn_pos.global_position
	emit_signal("enemy_spawned", enemy)

func _on_timer_timeout():
	spawn_enemy()


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy)
