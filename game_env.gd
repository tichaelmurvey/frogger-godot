extends Node
@onready var game : Node2D = get_node("/root/game")
var level = 1
@export var game_speed = 1

signal reset_game
signal level_up
var frog : Frog

func reset():
	reset_game.emit()

func beat_level():
	print("level up!")
	level += 1
	game_speed += 0.2
	level_up.emit()