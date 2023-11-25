extends Node2D

signal level_changed(level_name)
signal player_died
# Change this for each of your levels
@export var level_name : String
@onready var next_level = $next_level


func _ready():
	next_level.monitorable = false
	next_level.monitoring = false
	await get_tree().create_timer(1.0).timeout
	next_level.monitorable = true
	next_level.monitoring = true

func _on_area_2d_body_entered(body):
	print("Player died")
	if body.is_in_group("Player"):
		print("kill player")
		emit_signal("player_died", body)

func _on_next_level_body_entered(body):
	print("next level")
	if body.is_in_group("Player"):
		print("go to next level")
		emit_signal("level_changed", level_name)
