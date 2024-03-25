extends Area2D

# Export the next room name and camera position
@export var nextRoomName: String = ""
@export var cameraPosition: Vector2 = Vector2.ZERO

func _on_body_entered(body):
	if body.name == "Player":
		change_room()

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
