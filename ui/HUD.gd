extends Control
class_name HUD
@onready var score_label = $MarginContainer/VBoxContainer/HBoxContainer/Score
@onready var health_bar = $MarginContainer/VBoxContainer/HBoxContainer/Health

var score = 0:
	set(new_score):
		score = new_score
		_update_score_label()

var health = 50:
	set(new_health):
		health = new_health
		_update_health(health)

func _update_score_label():
	score_label.text = str(score)

func _update_health(new_health):
	health_bar.value = health
	if new_health <= 0:
		# Perform your additional code here
		health_bar.value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_score_label() 


func _on_enemy_death(points):
	score += points

func _on_coin_collected():
		print("coin taken")
		score += 100
