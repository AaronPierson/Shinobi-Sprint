extends CharacterBody2D
@onready var die = $die

const SPEED = 50
const JUMP_VELOCITY = -100

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	move_and_slide()
	if velocity.length() > 0:
		animated_sprite_2d.play("run")
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

signal enemy_died
func squash():
	print("goblin should die")
	die.play()
	emit_signal("enemy_died", 100)
	# Make the player bounce off
	queue_free()
