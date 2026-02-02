extends CharacterBody2D

@export var SPEED = 30
@export var starting_pos : Vector2

func _ready() -> void:
	velocity = Vector2(SPEED, 0)
	starting_pos = position
	GameEnv.reset_game.connect(reset)

func _physics_process(delta: float) -> void:
	var collisions = move_and_collide(velocity*GameEnv.game_speed*delta)

	if collisions and collisions.get_collider() is Frog:
		collisions.get_collider().get_hit()
	position.y = starting_pos.y
	if position.x > GameEnv.game.right_edge:
		position.x = GameEnv.game.left_edge
	if position.x < GameEnv.game.left_edge:
		position.x = GameEnv.game.right_edge

func reset():
	pass
