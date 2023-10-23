extends Node2D
@onready var collected_timer = $CollectedTimer
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var ORB_JUMP_VELOCITY = -300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		collected_timer.start()
		animated_sprite_2d.play("Collected")
		body.jump_count = 0
		body.JUMP_VELOCITY = ORB_JUMP_VELOCITY

func _on_collected_timer_timeout():
	queue_free()
