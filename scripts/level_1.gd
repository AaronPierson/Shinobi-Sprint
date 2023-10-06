extends Node2D

signal level_changed(level_name)
signal player_died
# Change this for each of your levels
@export var level_name = "Level1"  

func _ready():
	pass

func _on_area_2d_body_entered(body):
	print("Player died")
	if body.is_in_group("Player"):
		print("kill player")
		emit_signal("player_died")

func _on_next_level_body_entered(body):
	print("next level")
	if body.is_in_group("Player"):
		print("go to next level")
		emit_signal("level_changed", level_name)
		print(level_name)
