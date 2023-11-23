extends Node2D
@export var path_follow : PathFollow2D = get_parent()
@export var speed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	path_follow.rotates = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress_ratio += speed * delta

