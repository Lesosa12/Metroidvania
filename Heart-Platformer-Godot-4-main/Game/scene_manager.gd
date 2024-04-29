extends Node2D

var scenes : Dictionary = { "Level1" : "res://Game/Levels/level_one.tscn",
							"Level2" : "res://Game/Levels/level_two.tscn",
							"Level3" : "res://Game/Levels/level_three.tscn"} #repeat as needed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition_to_scene(level : String):
	var scene_path : String = scenes.get(level)
	
	if scene_path != null:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(scene_path)
