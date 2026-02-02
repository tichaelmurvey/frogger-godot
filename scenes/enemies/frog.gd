class_name Frog
extends CharacterBody2D

@export var STEP_SIZE = Vector2(16, 10)
@export var particles:GPUParticles2D
var animation_manager : AnimatedSprite2D

var in_water = false
var my_log : MyLog

func _ready() -> void:
	animation_manager = $sprite
	GameEnv.starting_pos = position
	GameEnv.reset_game.connect(reset)
	GameEnv.level_up.connect(reset)
	GameEnv.frog = self

func _process(delta: float) -> void:
	var movement = Vector2.ZERO
	
	if GameEnv.in_freeze:
		return
	
	# Handle player input
	var input_direction = Vector2.ZERO
	if Input.is_action_just_pressed("ui_up"):
		input_direction = Vector2.UP
		animation_manager.animation = "up"
	elif Input.is_action_just_pressed("ui_down"):
		input_direction = Vector2.DOWN
		animation_manager.animation = "down"
	elif Input.is_action_just_pressed("ui_left"):
		input_direction = Vector2.LEFT
		animation_manager.animation = "left"
	elif Input.is_action_just_pressed("ui_right"):
		input_direction = Vector2.RIGHT
		animation_manager.animation = "right"
	if input_direction != Vector2.ZERO:
		movement = input_direction * STEP_SIZE	
	
	# Handle movement on log
	if my_log is MyLog:
		movement.x += my_log.SPEED*GameEnv.game_speed*delta
	
	position += movement

	#check if drowning
	check_out_of_bounds()
	check_drowned()

func get_hit():
	print("Got hit! ow!")
	particles.emitting = true
	die()

func die():
	print("die!")
	
	GameEnv.reset()

func reset():
	position = GameEnv.starting_pos
	in_water = false

func _on_frog_butt_area_entered(area: Area2D) -> void:
	print("area entered!")
	if area is Lilypad:
		GameEnv.beat_level()
	if area is MyLog:
		set_log(area)

func _on_frog_butt_area_exited(area: Area2D) -> void:
	if area is MyLog:
		remove_log(area)
		

func set_log(log: MyLog):
	print("setting log!", log.get_instance_id())
	my_log = log


func remove_log(log : MyLog):
	if my_log == log:
		print("removing log!", log.get_instance_id())
		my_log = null
	else:
		print("tried removing but log already changed!")


func check_drowned():
	if in_water and my_log == null:
		die()

func check_out_of_bounds():
	if position.x > GameEnv.game.right_edge:
		die()
	if position.x < GameEnv.game.left_edge:
		die()
