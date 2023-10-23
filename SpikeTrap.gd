extends Node2D

func _on_trap_damage_body_entered(body):
	if body.is_in_group("Player"):
		print("player should die")
		body.apply_damage(50)
