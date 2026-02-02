class_name MyLog
extends Area2D
@export var SPEED = 30
@export var WIDTH_OFFSET = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED*delta
	if position.x > GameEnv.game.right_edge + WIDTH_OFFSET:
		position.x = GameEnv.game.left_edge - WIDTH_OFFSET
	if position.x < GameEnv.game.left_edge - WIDTH_OFFSET:
		position.x = GameEnv.game.right_edge + WIDTH_OFFSET
