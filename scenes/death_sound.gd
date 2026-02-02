extends AudioStreamPlayer
@export var DEATH_TYPE : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEnv.death_start.connect(handle_sfx)

func handle_sfx(death_input : String):
	if death_input == DEATH_TYPE:
		play()