# Camera2D script
extends Camera2D

var speed = 60

func _physics_process(delta):
	position.x += speed * delta


func _on_scene_manger_player_died():
	speed = 0
