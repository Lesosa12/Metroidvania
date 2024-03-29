extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Spawn

@export var nextRoomName: String = ""
@export var cameraPosition: Vector2 = Vector2.ZERO

@onready var marker_2d = $Marker2D

func _on_body_entered(body):
	body.global_position = marker_2d.global_position
	if body is Player:
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		#change_room()

func change_room():
	var globalCamera = get_node("/root/Camera2D")
	var tween = globalCamera.tween

	tween.interpolate_property(globalCamera, "position", globalCamera.global_position, cameraPosition, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	# Optionally, you can change the room after the camera has finished moving
	tween.connect("tween_completed", self, "_on_camera_movement_completed")

func _on_camera_movement_completed(what: Variant, key: NodePath):
	# Change to the next room
	get_tree().call_group("rooms", "set_visible", false)
	get_tree().call_group(nextRoomName, "set_visible", true)
