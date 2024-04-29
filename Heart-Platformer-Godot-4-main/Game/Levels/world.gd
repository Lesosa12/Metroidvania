extends Node2D

@export var next_level: PackedScene

var level_time = 0.0
var start_level_msec = 0.0
# Dictionary to store door names and their associated spawn points
var spawnPoints = {}


@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer
@onready var level_time_label = %LevelTimeLabel

func _ready():
	if Global.last_world_position != Vector2(0,0):
		$LevelTileMap/Player.position = Global.last_world_position + Vector2(0,5)
	
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	if not next_level is PackedScene:
		level_completed.next_level_button.text = "Victory Screen"
		next_level = load("res://victory_screen.tscn")
		
	Events.level_completed.connect(show_level_completed)
	get_tree().paused = true
	start_in.visible = true
	LevelTransition.fade_from_black()
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	start_in.visible = false
	start_level_msec = Time.get_ticks_msec()

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text = str(level_time / 1000.0)

func retry():
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)

func go_to_next_level():
	if not next_level is PackedScene: return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)

func show_level_completed():
	level_completed.show()
	level_completed.retry_button.grab_focus()
	get_tree().paused = true

func _on_level_completed_retry():
	retry()

func _on_level_completed_next_level():
	go_to_next_level()

# Add a method to set spawn points for each door
func set_spawn_point(doorName, spawnPoint):
	spawnPoints[doorName] = spawnPoint

# Add a method to get the spawn point for a specific door
func get_spawn_point(doorName):
	return spawnPoints.get(doorName, Vector2.ZERO)  # Default spawn point is Vector2.ZERO


func _on_player_detector_body_entered(body):
	Events.room_entered.emit(self)
