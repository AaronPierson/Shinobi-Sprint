extends CharacterBody2D
@export var path_follow : PathFollow2D = get_parent()
@export var speed : float
@onready var animated_sprite_2d = $AnimatedSprite2D
var post_x = null
@onready var ai_sound = $ai_sound



func _ready():
	# Connect the "body_entered" signal to a function "_on_Body_entered"
	pass
	
func _physics_process(delta):
	if post_x != null:
		if global_position.x <= post_x:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
			
	post_x = global_position.x

	if path_follow:
		path_follow.progress_ratio += speed * delta
		

func _on_attack_body_entered(body):
	if body.is_in_group("Player"):
		print("player should die")
		body.apply_damage(50)

signal enemy_died
func squash():
	print("slime should die")
	ai_sound.play()
	emit_signal("enemy_died", 50)
	# Make the player bounce off
	queue_free()

