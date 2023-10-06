extends CharacterBody2D
@onready var die = $die
@onready var animated_sprite_2d = $AnimatedSprite2D

var bomb = preload("res://scenes/entities/bomb.tscn")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var timer = get_tree().create_timer(1.0)  # Creates a timer that ticks every second
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))  # Connects the timer's timeout signal to a function

func _on_Timer_timeout():
	throw_projectile()

func throw_projectile():
	animated_sprite_2d.play("attack")
	var projectile = bomb.instantiate()
	projectile.global_position = self.global_position
	get_parent().add_child(projectile)

func _physics_process(delta):
	# Add the gravity.
	move_and_slide()
	
	
	
signal enemy_died
func squash():
	print("bomber should die")
	die.play()
	emit_signal("enemy_died", 150)
	# Make the player bounce off
	queue_free()
