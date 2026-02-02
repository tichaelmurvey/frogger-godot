extends Node
@onready var game : Node2D = get_node("/root/game")
var frog_scene = preload("res://scenes/enemies/frog.tscn")
var level = 1
@export var INITIAL_GAME_SPEED = 1
var DEATH_TIME = 1.0
var game_speed = 0
var starting_pos : Vector2
signal death_start
signal reset_game
signal level_up
var frog : Frog
var in_freeze = false

func _ready() -> void:
	game_speed = INITIAL_GAME_SPEED

func reset():
	GameEnv.game_speed = 0.1
	in_freeze = true
	death_start.emit()
	await get_tree().create_timer(DEATH_TIME).timeout
	in_freeze = false
	reset_game.emit()
	frog.queue_free()
	frog = frog_scene.instantiate()
	game.add_child(frog)
	GameEnv.game_speed = INITIAL_GAME_SPEED

func beat_level():
	print("level up!")
	level += 1
	game_speed += 0.2
	level_up.emit()
