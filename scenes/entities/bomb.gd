extends RigidBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	pass
	# Apply an initial force to the bomb (adjust as needed)
	#apply_impulse(Vector2.ZERO, Vector2(500, -500))

func _on_expload_timeout():
	queue_free()

func _on_body_entered(body):
	pass



func _on_attack_body_entered(body):
	print("_on_body_entered")
	print(body)
	if body.is_in_group("Player"):
		print("blowup player")
		animated_sprite_2d.play("default")
		body.apply_damage(100)
		#body.queue_free()  # Remove the player
		queue_free()  # Remove the bomb
