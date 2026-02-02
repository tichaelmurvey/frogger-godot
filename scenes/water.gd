extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == "frog_butt":
		print("entered the water")
		GameEnv.frog.in_water = true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "frog_butt":
		print("left the water!")
		GameEnv.frog.in_water = false
