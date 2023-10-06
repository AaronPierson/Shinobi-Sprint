extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var player: CharacterBody2D

var move_direction : Vector2
var wander_time : float

@onready var ray_cast_2d_ground = $"../../RayCast2DGround"
@onready var ray_cast_2d_wall = $"../../RayCast2DWall"


func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), 0 ).normalized()
	wander_time = randf_range(1, 1.5)
	

func enter():
#	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()
	

func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()


func Physics_Update(delta: float):
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	
	if enemy:
		enemy.velocity = move_direction * move_speed
	if player != null
		var direction = player.global_position - enemy.global_position
	
		# Check for ground and walls
	if ray_cast_2d_ground.is_colliding() and ray_cast_2d_wall.is_colliding():
		move_direction.x *= -1  # Reverse direction
	
	if direction.length() < 30:
		Transitioned.emit(self, "EnemyFollow")
	

func exit():
	# Add any cleanup code here
	pass
	
	
	
