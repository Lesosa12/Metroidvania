extends Area2D

# Export the next scene path
@export var nextScene: String = "" #fill with the scene path like: res://Scenes/level_two.tscn
# Export the door name
@export var spawnPointName: String = ""

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	# Change the scene
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextSceneInstance)
