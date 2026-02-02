extends Node2D

@export var right_edge = 300
@export var left_edge = 0
@export var camera:Camera2D
#@export var frog:Frog
var NORMAL_ZOOM = Vector2(4.0, 3.5)
var CLOSE_ZOOM = Vector2(8.0, 7.0)
var desired_zoom:Vector2 = NORMAL_ZOOM
@onready var DEFAULT_CAMERA_POSITION = camera.position
@onready var zoom_target = DEFAULT_CAMERA_POSITION
var zoom_speed:float = 5
var do_zoom = false

var shake_intensity:float = 0
var MAX_SHAKE_INTENSITY = 10
var SHAKE_DECAY:float = 5
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEnv.death_start.connect(shake_camera)
	GameEnv.reset_game.connect(reset_camera)
	pass # Replace with function body.

func shake_camera(reason: String) -> void:
	desired_zoom = CLOSE_ZOOM
	zoom_target = GameEnv.frog.position
	shake_intensity = MAX_SHAKE_INTENSITY
	do_zoom = true
	
func reset_camera() -> void:
	camera.position = DEFAULT_CAMERA_POSITION
	camera.zoom = NORMAL_ZOOM
	do_zoom = false
	#desired_zoom = NORMAL_ZOOM
	#zoom_target = DEFAULT_CAMERA_POSITION

func _process(delta: float) -> void:
	if do_zoom:
		camera.zoom = lerp(camera.zoom, desired_zoom, zoom_speed * delta)
		camera.position = lerp(camera.position, zoom_target, zoom_speed * delta)
	
	shake_intensity = lerp(shake_intensity, 0.0, SHAKE_DECAY * delta)
	#print("Shake Intensity:", shake_intensity)
	camera.offset = get_rand_offset()

func get_rand_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-1, 1) * shake_intensity, 
		rand.randf_range(-1, 1) * shake_intensity)
	
