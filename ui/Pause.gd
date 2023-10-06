extends Control

@export var scene_manager : SceneManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	scene_manager.connect("toggle_paused", on_scene_manager_toggle_paused)


func on_scene_manager_toggle_paused(is_paused: bool):
	if is_paused:
		show()
	else:
		hide()


func _on_resume_pressed():
	scene_manager.game_paused = false


func _on_exit_pressed():
	get_tree().quit()
