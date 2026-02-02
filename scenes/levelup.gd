extends AudioStreamPlayer
@export var DEATH_TYPE : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEnv.level_up.connect(play)
