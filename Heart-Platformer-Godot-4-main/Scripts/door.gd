extends Area2D

# Export the next scene path
@export var nextScene: String = "" #fill with the scene path like: res://Scenes/level_two.tscn
# Export the door name
@export var doorName: String = "" #name door and spawn point something unique to link

func _ready():
	pass

func _on_body_entered(body):
	print("Body Entered:", body.name)
	if body.name == "Player":
		change_scene()

func change_scene():
	print("Changing Scene to:", nextScene)
	var nextSceneInstance = load(nextScene)
	if nextSceneInstance == null:
		print("Error loading scene:", nextScene)
		return

	var nextSceneNode = nextSceneInstance.instance()
	if nextSceneNode == null:
		print("Error instancing scene:", nextScene)
		return

	# Set the spawn point for the player in the next scene
	nextSceneNode.set_spawn_point(doorName, global_position)

	# Change the scene
	get_tree().change_scene_to_packed(nextSceneNode)
