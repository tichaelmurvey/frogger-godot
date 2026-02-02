extends Panel

var stylebox : StyleBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEnv.death_start.connect(do_show)
	GameEnv.reset_game.connect(do_hide)
	stylebox = get_theme_stylebox("panel")

func do_show(reason: String):
	if reason == "WATER":
		stylebox.border_color = Color.BLUE
	if reason == "CAR":
		stylebox.border_color = Color.RED
	show()

func do_hide():
	hide()