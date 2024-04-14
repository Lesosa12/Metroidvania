extends Node

static var nextSceneSpawnPoint = {}
static var currentDoor = ""


# Global scope
var spawnPoints = {
	"level_one.tscn": {
		"Door1": "SpawnPoints/SpawnPoint1",
		"Door2": "SpawnPoints/SpawnPoint2"
	},
	"level_two.tscn": {
		"Door1": "SpawnPoints/SpawnPoint1",
		"Door2": "SpawnPoints/SpawnPoint2"
	}
	# Add more scenes and doors as needed
}

# Function to get the spawn point for a given scene and door
func get_spawn_point(scene: String, door: String) -> String:
	return spawnPoints.get(scene, {}).get(door, "")

func _ready():
	var spawnPoint = Global.nextSceneSpawnPoint.get(Global.currentDoor, Vector2.ZERO)
	var playerNode = Player

	#if playerNode != null:
		#playerNode.global_position = spawnPoint
	#else:
		#print("PlayerNode not found in the scene.")
