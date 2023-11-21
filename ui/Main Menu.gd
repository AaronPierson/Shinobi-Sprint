extends Control

@export var scene_manager : SceneManager
@onready var start = $VBoxContainer/Start

func _ready():
	start.grab_focus()

func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/SceneManager.tscn")
