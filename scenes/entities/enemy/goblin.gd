extends CharacterBody2D

@onready var die = $die
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d_right = $RayCast2DRight
@onready var ray_cast_2d_ground = $RayCast2DGround
@onready var ray_cast_2d_left = $RayCast2DLeft
@onready var area_2d_sight = $Area2DSight
@onready var attack_area = $AttackArea

@export var SPEED = 20
@export var CHASE_SPEED = 50
@export var PATROL_DISTANCE = 500

var direction = 1
var start_position
var chasing_player = false
var current_speed = SPEED

signal enemy_died

func _ready():
	start_position = position.x
	ray_cast_2d_right.enabled = true
	ray_cast_2d_left.enabled = true

func _physics_process(delta):
	current_speed = SPEED if not chasing_player else CHASE_SPEED
	velocity.x = current_speed * direction
	move_and_slide()
	if abs(position.x - start_position) > PATROL_DISTANCE:
		direction = 1
		animated_sprite_2d.flip_h = false
		area_2d_sight.scale.x = 1
		attack_area.scale.x = 1
		#during patrol
	if ray_cast_2d_right.is_colliding():
		animated_sprite_2d.flip_h = true
		start_position = position.x
		direction = -1
		area_2d_sight.scale.x = -1
		attack_area.scale.x = -1

	if ray_cast_2d_left.is_colliding():
		print("left hit wall")
		animated_sprite_2d.flip_h = false
		start_position = position.x
		direction = 1
		area_2d_sight.scale.x = 1
		attack_area.scale.x = 1


func squash():
	print("goblin should die")
	die.play()
	emit_signal("enemy_died", 100)
	queue_free()


func _on_area_2d_sight_body_entered(body):
	if body.name == "Player":
		chasing_player = true
		SPEED = CHASE_SPEED
		if body.global_position.x > global_position.x:
			direction = 1
		else:
			direction = -1


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		print("player damage 50")
		body.apply_damage(50)
