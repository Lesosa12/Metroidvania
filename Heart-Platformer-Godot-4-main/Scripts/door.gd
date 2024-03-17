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
		change_scene(nextScene, doorName)
		
func change_scene(nextScene: String, doorName: String):
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	var nextSceneNode = nextSceneInstance.instance()
	if nextSceneNode == null:
		print("Error instancing scene:", nextScene)
		return

	var spawnPointPath = spawnPoints.get(nextScene, {}).get(doorName, "")
	var spawnPoint = nextSceneNode.get_node_or_null(spawnPointPath)
	if spawnPoint == null:
		print("Error: Spawn point not found for door:", doorName)
		return

	# Set player's position to the spawn point
	var playerNode = nextSceneNode.get_node_or_null("PlayerNodeName")
	if playerNode != null:
		playerNode.global_position = spawnPoint.global_position
	else:
		print("Error: Player node not found in the scene")

	# Change the scene
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextSceneInstance)
