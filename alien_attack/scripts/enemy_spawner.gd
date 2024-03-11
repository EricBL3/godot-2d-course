extends Node2D

@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://scenes/enemy.tscn")

func spawn_enemy():
	var random_spawn_pos = spawn_positions.get_children().pick_random()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = random_spawn_pos.global_position
	add_child(enemy)

func _on_timer_timeout():
	spawn_enemy()
