extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var pickup = $pickup
@onready var pop = $pop
var hud = null


# Called when the node enters the scene tree for the first time.
func _ready():
	hud = get_parent().get_parent().get_node("HUD")

signal coin_collected

func _on_body_entered(body):
	# Check if the body is the player
	if body.is_in_group("Player"):
		# Emit the signal
		pickup.play()
		emit_signal("coin_collected")
		animated_sprite_2d.play("pickup")
		# Start the timer
		timer.start()
		
func _on_timer_timeout():
	pop.play()
	queue_free()

