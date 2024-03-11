extends Node

static var nextSceneSpawnPoint = {}
static var currentDoor = ""

func _ready():
	var spawnPoint = Global.nextSceneSpawnPoint.get(Global.currentDoor, Vector2.ZERO)
	var playerNode = $Player
	if playerNode != null:
		playerNode.global_position = spawnPoint
	else:
		print("PlayerNodeName not found in the scene.")
