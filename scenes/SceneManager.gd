extends Node2D
class_name SceneManager
@onready var camera_2d = $Camera2D
@onready var die_sfx = $DieSFX
@onready var bg_player = $BGPlayer
@onready var win_sfx = $winSFX
@onready var ovani_player = $OvaniPlayer
@onready var hud = $CanvasLayer/HUD
@onready var player = $Player
@onready var reset_level_timer = $Reset_Level_Timer

signal toggle_paused(is_paused : bool)
signal toggle_game_over(is_paused : bool)

var levels = {
	1: preload("res://scenes/levels/level_1.tscn"),
	2: preload("res://scenes/levels/level_2.tscn"),
	3: preload(("res://scenes/levels/level_3.tscn")
	)
}
var current_level = null

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_paused", game_paused)

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.main_scene = self
	load_level(levels[1])
	
func load_level(level):
	if current_level != null:
		current_level.queue_free()

	current_level = level.instantiate()
	add_child(current_level)
	var spawn_point = current_level.get_node("level_start")
	player.global_position = spawn_point.global_position

	camera_2d.position.x = player.position.x
	camera_2d.position.y = player.position.y
	# Connect the signal after loading the new level
	current_level.connect("level_changed", Callable(self, "_on_level_changed"))
#	ovani_player.FadeVolume(-80, 5);
	# Get a reference to the HUD node
	var hud = get_node("CanvasLayer/HUD")
	# Connect coin_collected signal from each coin to _on_coin_collected method in HUD
	for coin in current_level.get_tree().get_nodes_in_group("coins"):
		coin.connect("coin_collected", Callable(hud, "_on_coin_collected"))
	for enemy in current_level.get_tree().get_nodes_in_group("Enemy"):
		enemy.connect("enemy_died", Callable(hud, "_on_enemy_death"))
		
	player.connect("player_health_update", Callable(hud, "_update_health"))
	current_level.connect("player_died", Callable(self, "_on_area_2d_body_entered"))



func _input(event : InputEvent):
	if(event.is_action_released("ui_cancel") or event.is_action_pressed("Pause")):
		game_paused = !game_paused

#for camrare out of bounds
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		camera_2d.speed = 0
		body.is_alive = false
		reset_level_timer.start(2.5)
		die_sfx.play()
		body.animation_player.play("die")
		await body.animation_player.animation_finished
		body.queue_free()
	
func _on_level_changed(current_level_name):
	var next_level_name
	#bug update ui with new health not working
	hud._update_health(100)
	player.Health = 100
	print(current_level_name)
	match current_level_name:
		"Level1":
			next_level_name = 2
			ovani_player.Intensity = 0
			camera_2d.speed += 10
			player.SPEED += 2.5
		"Level2":
			next_level_name = 3
			ovani_player.Intensity = .5
			camera_2d.speed += 10
			player.SPEED += 2.5
		"Level3":
			next_level_name = 1
			ovani_player.Intensity = 1
			camera_2d.speed += 10
			player.SPEED += 2.5
		_:
			return
	load_level(levels[next_level_name])
	
func _on_player_player_died_reload():
#	reset_level_timer.start(2.5)
	die_sfx.play()
	camera_2d.speed = 0
	ovani_player.Volume = -10
	player.animation_player.play("die")
	await player.animation_player.animation_finished
	player.queue_free()
	emit_signal("toggle_game_over")
	
func _on_reset_level_timer_timeout():
	get_tree().reload_current_scene()
