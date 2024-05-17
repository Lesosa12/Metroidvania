extends Node2D

static var nextSceneSpawnPoint = {}
static var currentDoor = ""

var last_world_position = Vector2(0,0)
var playerSpawnPoint: Vector2 = Vector2.ZERO
var player_spawn_point: Vector2

var player : Node2D = null
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

# Player script
func _on_Player_body_entered(body):
	if body.name == "PlayerSpawnArea":
		get_node("/root/Global").playerSpawnPoint = body.global_position
		get_tree().change_scene("res://Player.tscn")

# Function to get the spawn point for a given scene and door
func get_spawn_point(scene: String, door: String) -> String:
	return spawnPoints.get(scene, {}).get(door, "")

func set_spawn_point(position: Vector2):
	player_spawn_point = position

func save_player_position(position: Vector2):
	playerSpawnPoint = position

# Call this function when the player reenters a room
func set_player_spawn_position():
	#$Player.global_position = playerSpawnPoint
	pass

func _ready():
	if get_node("/root/Global").playerSpawnPoint != Vector2(0, 0):
		global_position = get_node("/root/Global").playerSpawnPoint
	player = get_node("/root/GlobalPlayer")
	var spawnPoint = Global.nextSceneSpawnPoint.get(Global.currentDoor, Vector2.ZERO)
	var playerNode = Player

	#if playerNode != null:
		#playerNode.global_position = spawnPoint
	#else:
		#print("PlayerNode not found in the scene.")
