extends Area2D

# Export the next scene path
@export var nextScene: String = "" #fill with the scene path like: res://Scenes/level_two.tscn
# Export the door name
@export var spawnPointName: String = ""
@export var doorName = ""
@export var spawnPointPath: NodePath


func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		change_scene(nextScene, doorName)
		var spawnPointPath = get_node(spawnPointPath)
		# Change scene and spawn player at the spawnPointPath

func change_scene(nextScene: String, doorName: String):
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	var spawnPointPath = spawnPoints.get(nextScene, {}).get(doorName, "")
	if spawnPointPath == "":
		print("Spawn point path not found for scene:", nextScene, "and door:", doorName)
		return

	var nextSceneNode = nextSceneInstance.instance()
	var spawnPoint = nextSceneNode.get_node_or_null(spawnPointPath)
	if spawnPoint == null:
		print("Spawn point not found at path:", spawnPointPath)
		return

	# Change the scene
	get_tree().paused = false
	get_tree().change_scene_to_packed(nextSceneInstance)
	spawn_player_at_spawn_point(spawnPoint)

func spawn_player_at_spawn_point(spawnPointNode):
	if spawnPointNode != null:
		# Spawn the player at the spawn point
		# For example:
		$Player.global_position = spawnPointNode.global_position
	else:
		print("Spawn point is null!")

