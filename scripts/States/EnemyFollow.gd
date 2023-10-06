extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40
var player: CharacterBody2D
@onready var ray_cast_2d_ground = $"../../RayCast2DGround"
@onready var ray_cast_2d_wall = $"../../RayCast2DWall"
var move_direction := 1  # Add this line


func enter():
	pass


func Physics_Update(delta: float):
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
		
	var direction = player.global_position - enemy.global_position
	print(direction.length())
	direction.y = 0  # This will ensure the enemy only moves left or right
	
	# Check for ground and walls
	if ray_cast_2d_ground.is_colliding() and ray_cast_2d_wall.is_colliding():
		move_direction *= -1  # Reverse direction
		#direction.x *= -1  # Reverse direction
	
	if direction.length() < 90:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
	if direction.length() > 91:
		Transitioned.emit(self, "EnemyIdle")
		

func exit():
	# Add any cleanup code here
	pass
