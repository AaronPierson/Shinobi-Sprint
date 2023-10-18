extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0
@export var min_position := -100.0  # Define minimum position
@export var max_position := 100.0   # Define maximum position

var player: CharacterBody2D

var move_direction : Vector2
var wander_time : float
var direction: Vector2 = Vector2(0, 0)

@onready var ray_cast_2d_ground = $"../../RayCast2DGround"
@onready var ray_cast_2d_wall = $"../../RayCast2DWall"


#func randomize_wander():
#	move_direction = Vector2(randf_range(-1,1), 0 ).normalized()
#	wander_time = randf_range(1, 1.5)
	

func enter():
#	player = get_tree().get_first_node_in_group("Player")
#	randomize_wander()
	pass	

func update(delta: float):
#	if wander_time > 0:
#		wander_time -= delta
#	else:
#		randomize_wander()
	pass

func Physics_Update(delta: float):
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	
	if enemy:
		enemy.velocity = move_direction * move_speed
		# Check if enemy has reached the limits and reverse direction
		if enemy.global_position.x < min_position or enemy.global_position.x > max_position:
			move_direction.x *= -1  # Reverse direction

		
		if direction.length() < 30:
			Transitioned.emit(self, "EnemyFollow")
		# Check for ground and walls
	#if ray_cast_2d_ground.is_colliding() and ray_cast_2d_wall.is_colliding():
	#	move_direction.x *= -1  # Reverse direction
	
	if player != null:
		var direction = player.global_position - enemy.global_position
	

func exit():
	# Add any cleanup code here
	pass
	
	
	
