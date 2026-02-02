extends Node
@onready var game : Node2D = get_node("/root/game")

signal reset_game
var frog : Frog

func reset():
	reset_game.emit()