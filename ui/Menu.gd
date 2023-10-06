extends Control
enum MENU_LEVEL { NONE, MAIN, START, SELECT, OPTIONS }

var menus = {
	MENU_LEVEL.SELECT : preload("res://ui/LevelSelect.tscn").instance(),
	MENU_LEVEL.MAIN : preload("res://ui/Menu.tscn").instance(),
}

#     MENU_LEVEL.OPTIONS : preload("res://ui/OptionsScreen.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()



func _on_level_select_pressed():

