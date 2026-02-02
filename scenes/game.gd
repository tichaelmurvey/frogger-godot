extends Node2D

@export var right_edge = 300
@export var left_edge = 0
@export var camera:Camera2D

var shake_intensity:float = 0
var MAX_SHAKE_INTENSITY = 10
var SHAKE_DECAY:float = 5
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEnv.death_start.connect(shake_camera)
	pass # Replace with function body.

func shake_camera() -> void:
	shake_intensity = MAX_SHAKE_INTENSITY

func _process(delta: float) -> void:
	shake_intensity = lerp(shake_intensity, 0.0, SHAKE_DECAY * delta)
	#print("Shake Intensity:", shake_intensity)
	camera.offset = get_rand_offset()

func get_rand_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-1, 1) * shake_intensity, 
		rand.randf_range(-1, 1) * shake_intensity)
	
