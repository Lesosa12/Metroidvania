extends Area2D

@export var scene_to_load: String
@export var spawn_point_path: NodePath

func _on_body_entered(body):
	print("Player collided with the door")
	$CollisionShape2D.set_deferred("disabled", true)
	load_scene(scene_to_load)

func load_scene(path):
	if path != "" and path != null:
		var scene_instance = ResourceLoader.load(path)
		if scene_instance:
			get_tree().change_scene_to_packed(scene_instance)
