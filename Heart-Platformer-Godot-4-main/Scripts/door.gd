extends Area2D

@export var scene_to_load: String


func _on_body_entered(body):
	print("Player collided with the door")
	$CollisionShape2D.set_deferred("disabled", true)
	load_scene(scene_to_load)
	

func load_scene(path):
	if path != "" and path != null:
		var scene_instance = ResourceLoader.load(path)
		if scene_instance:
			get_tree().change_scene_to_packed(scene_instance)

# In the previous scene (when player interacts with the door)
func _on_door_interaction():
	var nextScene = "res://next_scene.tscn"
	var spawnPoint = "spawn_point_name"
	Global.nextSceneSpawnPoint = spawnPoint
	get_tree().change_scene(nextScene)

# In the new scene (when the scene is loaded)
func _on_scene_loaded():
	if Global.nextSceneSpawnPoint:
		var playerSpawnPoint = get_node(Global.nextSceneSpawnPoint)
		player.position = playerSpawnPoint.global_position


