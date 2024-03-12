extends CharacterBody2D

signal took_damage

@export var speed = 300
@export var rocket_offset = 80

@onready var rocket_container = $RocketContainer
@onready var rocket_shot = $RocketShotSound


var rocket_scene = preload("res://scenes/rocket.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed	
	if Input.is_action_pressed("move_right"):
		velocity.x = speed	
		
	move_and_slide()
	
	var viewport_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0, 0), viewport_size)	
	
func shoot():
	var rocket = rocket_scene.instantiate()
	rocket_container.add_child(rocket)
	rocket.global_position = global_position
	rocket.global_position.x += rocket_offset
	rocket_shot.play()

func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()
