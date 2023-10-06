extends Node2D

var velocity = Vector2()
var gravity = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(200, -500) # Initial velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
