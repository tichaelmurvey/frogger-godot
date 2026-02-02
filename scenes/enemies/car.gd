extends Area2D

@export var SPEED = 30
@export var starting_pos : Vector2
var velocity : Vector2
func _ready() -> void:
	velocity = Vector2(SPEED, 0)
	starting_pos = position
	GameEnv.reset_game.connect(reset)

func _physics_process(delta: float) -> void:
	# print("car physics process")
	position += velocity*GameEnv.game_speed*delta
	position.y = starting_pos.y
	if position.x > GameEnv.game.right_edge:
		position.x = GameEnv.game.left_edge
	if position.x < GameEnv.game.left_edge:
		position.x = GameEnv.game.right_edge

func reset():
	velocity = Vector2(SPEED, 0)


func _on_body_entered(body: Node2D) -> void:
	if body is Frog:
		body.get_hit()
