extends Node2D

@export var player_lives = 3

var score = 0
var game_over_screen = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_damage_sound = $PlayerDamageSound


func _ready():
	hud.set_score_label(score)
	hud.set_lives(player_lives)

func _on_deathzone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	player_lives -= 1
	hud.set_lives(player_lives)
	player_damage_sound.play()
	if player_lives == 0:
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var game_over = game_over_screen.instantiate()
		ui.add_child(game_over)
		game_over.set_score(score)


func _on_enemy_spawner_enemy_spawned(enemy):
	enemy.connect("died", _on_enemy_died)
	add_child(enemy)
	
func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy):
	add_child(path_enemy)
	path_enemy.enemy.connect("died", _on_enemy_died)
