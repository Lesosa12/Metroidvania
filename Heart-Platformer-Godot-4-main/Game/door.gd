extends Node2D

class_name Door

@export var next_scene : String
@export var destination_door_tag: String
@export var spawn_direction = "up"
@onready var player = get_node("/root/GlobalPlayer")

@export var cameraPosition: Vector2 = Vector2.ZERO
var playerSpawnPoint: Vector2 = Vector2(0, 0)  # Global variable to store spawn point
@onready var marker_2d = $Spawn

func _ready():
	var exit_area = $ExitArea2D
	if exit_area == null:
		print("ExitArea2D node is not found!")
		return
	exit_area.connect("body_entered", Callable(self, "_on_body_entered"))
	print("ExitArea2D node connected successfully.")
	# Set the player's initial position to the spawn point
	#if spawnNode != null:
		#player.global_position = spawnNode.global_position
	#else:
		#print("Spawn node is null!")
	pass

func _on_exit_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		Global.set_spawn_point(marker_2d.global_position)
		emit_signal("door_entered", "door_name")  # Assuming you want to pass door_name as a string
		get_tree().change_scene_to_file("res://path_to_next_scene.tscn")  # Replace with your scene path
		var player = body as CharacterBody2D
		body.global_position = marker_2d.global_position
		player.queue_free()
		NavigationManager.go_to_level(next_scene, destination_door_tag)
		#change_room()
		
		# Save player position before exiting
		playerSpawnPoint = body.global_position
		await get_tree().create_timer(3.0).timeout
		#print("scene transition")
		SceneManager.transition_to_scene(next_scene)

func change_room():
	var globalCamera = get_node("/root/Camera2D")
	var tween = globalCamera.tween
	# Set player position to the stored spawn point
	tween.interpolate_property(globalCamera, "position", globalCamera.global_position, cameraPosition, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	# Optionally, you can change the room after the camera has finished moving
	tween.connect("tween_completed", self, "_on_camera_movement_completed")

func _on_camera_movement_completed(what: Variant, key: NodePath):
	# Change to the next room
	get_tree().call_group("rooms", "set_visible", false)
	get_tree().call_group(next_scene, "set_visible", true)
