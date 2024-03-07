extends Area2D

@export var scene_to_load: PackedScene

func _on_body_entered(body):
	print("Player collided with the door")
	$CollisionShape2D.set_deferred("disabled", true)
	load_scene(scene_to_load)

func load_scene(path):
	var scene = ResourceLoader.load(path)
	if scene:
		get_tree().change_scene(scene)
