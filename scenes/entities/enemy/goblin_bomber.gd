extends CharacterBody2D
@onready var die = $die
@onready var animated_sprite_2d = $AnimatedSprite2D
var bomb = preload("res://scenes/entities/bomb.tscn")
@onready var attack_cooldown = $AttackCooldown
@export var x_range = 100
@export var y_range = -250

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	attack_cooldown.connect("timeout", Callable(self, "_on_Timer_timeout"))  # Connects the timer's timeout signal to a function

func _on_Timer_timeout():
	throw_projectile()


func throw_projectile():
	animated_sprite_2d.play("attack")
	var projectile = bomb.instantiate()
	projectile.global_position = self.global_position
	projectile.mass = 1  # Adjust as needed
	projectile.apply_impulse(Vector2(x_range, y_range))  # Apply an initial force
	animated_sprite_2d.play("idle")
	get_parent().add_child(projectile)
	
	
signal enemy_died
func squash():
	print("bomber should die")
	animated_sprite_2d.play("die")
	die.play()
	emit_signal("enemy_died", 150)
	# Make the player bounce off
	queue_free()


func _on_attack_body_entered(body):
	if body.is_in_group("Player"):
		print("player should take damage")
		body.apply_damage(50)	
