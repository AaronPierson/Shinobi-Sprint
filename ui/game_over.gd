extends Control
@onready var try_again = $"VBoxContainer/Try Again"
@export var scene_manager : SceneManager


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
#	try_again.grab_focus()
#	scene_manager.connect("toggle_game_over", on_scene_manager_toggle_paused)

func _on_exit_pressed():
	get_tree().quit()


func _on_try_again_pressed():
	#scene_manager.game_paused = false
	get_tree().reload_current_scene()


func _on_scene_manger_toggle_game_over():
#	if is_paused:
		show()
		try_again.grab_focus()
#	else:
#		hide()
