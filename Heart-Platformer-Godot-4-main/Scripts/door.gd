extends Area2D

# Export the next scene path
@export var nextScene: String = "" #fill with the scene path like: res://Scenes/level_two.tscn
# Export the door name
@export var spawnPointName: String = ""
@export var doorName = ""

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()
		var globalDataNode = get_node("res://Scenes/global.tscn")
		var spawnPointPath = globalDataNode.spawnPoints.get(nextScene, {}).get(doorName, "")
		# Change scene and spawn player at spawnPointPath
func change_scene():
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	# Change the scene
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextSceneInstance)
