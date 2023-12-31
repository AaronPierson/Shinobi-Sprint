extends CharacterBody2D

enum State {
	IDLE,
	RUNNING,
	JUMPING,
	ATTACKING,
	DYING
}

var state = State.IDLE


@export var SPEED = 100.0
const JUMP_VELOCITY = -225.0
const JUMP_HOLD_VELOCITY = -60.0

var jump_count = 0
var coyote_timer: float = 0.0
var is_jumping = false

@export var coyote_time = 0.1
@export var bounce_impulse = -200
@export var bounce_fall_speed = 900  # Adjust this value to change the fall speed after bouncing
@export var Health = 100

@onready var animation_player = $AnimationPlayer
@onready var player_sprite_2d = $PlayerSprite2D
@onready var camera_2d = $"../Camera2D"
@onready var jump_sound = $Jump_sound
@onready var die_sound = $die_sound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_alive = true

func _physics_process(delta):
	if is_alive:
	# Add the gravity.
		if not is_on_floor():
			coyote_timer -= delta
			if velocity.y < 0:
				velocity.y += gravity * delta
			else:
				velocity.y += gravity * 2.2 * delta

		match state:
			State.IDLE:
				animation_player.play("idle")
				if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
					print("idle -> running")
					state = State.RUNNING
			State.RUNNING:		
			# Player Movement
				var direction = Input.get_axis("move_left", "move_right")
				if direction != 0:
					velocity.x = direction * SPEED
					animation_player.play("run")
					if velocity.x >= 0:
						player_sprite_2d.flip_h = false
					else:
						player_sprite_2d.flip_h = true
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
					print("running -> idle")
					state = State.IDLE

		# Handle Jump.
		if is_on_floor():
			var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
			jump_count = 0
			coyote_timer = coyote_time
		if Input.is_action_just_pressed("jump") and coyote_timer > 0:
			jump_count += 1
			animation_player.play("jump_up")
			is_jumping = true   # Set is_jumping to true here
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
		elif not is_on_floor() and jump_count < 2 and Input.is_action_just_pressed("jump"):
			jump_count += 1
			animation_player.play("double_jump")
			velocity.y = JUMP_VELOCITY + 35
			jump_sound.play()
		if is_jumping and Input.is_action_just_released("jump") and velocity.y < JUMP_HOLD_VELOCITY:
			is_jumping = false
			velocity.y = JUMP_HOLD_VELOCITY	


		# Iterate through all collisions that occurred this frame
		for index in range(get_slide_collision_count()):
			# We get one of the collisions with the player
			var collision = get_slide_collision(index)
			# If the collision is with ground
			if (collision.get_collider() == null):
				continue
			# If the collider is with a 
			if collision.get_collider().is_in_group("Enemy"):
				var Enemy = collision.get_collider()
			# we check that we are hitting it from above.
				if Vector2.UP.dot(collision.get_normal()) > 0.1:
			# If so, we squash it and bounce.
					Enemy.squash()
					jump_count = 0
					velocity.y = bounce_impulse
					gravity = bounce_fall_speed
			elif collision.get_collider().is_in_group("Traps"):
				print("you landed on a trap")
		move_and_slide()

signal player_died_reload()	
signal player_health_update
func apply_damage(damage):
	print("player was hit")
	Health -= damage
	print(Health)
	if(Health <= 0):
		print("kill player")
		is_alive = false
		emit_signal("player_died_reload")
	else:
		emit_signal("player_health_update", Health)
