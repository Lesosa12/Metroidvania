extends Node

const scene_level1 = preload("res://Game/Levels/level_one.tscn")
const scene_level2 = preload("res://Game/Levels/level_two.tscn")

signal  on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"level_1":
			scene_to_load = scene_level1
		"level_2":
			scene_to_load = scene_level2
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
