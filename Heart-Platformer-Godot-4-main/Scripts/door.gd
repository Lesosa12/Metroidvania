extends Area2D

# Export the next scene path
@export var nextScene: String = "" #fill with the scene path like: res://Scenes/level_two.tscn
# Export the door name
@export var connectedSpawnPoint: String = ""

func _ready():
	pass

func change_scene():
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	var nextSceneNode = nextSceneInstance.instance()
	if nextSceneNode == null:
		print("Error instancing scene:", nextScene)
		return

	# Find the connected spawn point in the next scene
	var spawnPointPath = "SpawnPoints/" + spawnPointName
	var spawnPoint = nextSceneNode.get_node(spawnPointPath)
	if spawnPoint == null:
		print("Error: Spawn point not found for door:", spawnPointName)
		return

	# Set the player's spawn point in the next scene
	var playerNode = nextSceneNode.get_node("PlayerNodeName")
	if playerNode != null:
		playerNode.global_position = spawnPoint.global_position
	else:
		print("Error: Player node not found in the scene")

	# Change the scene
	get_tree().change_scene_to_packed(nextSceneNode)
