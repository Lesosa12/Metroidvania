extends Node

var main_menu_screen = preload("res://Game UI/start_menu.tscn")
#var pause_menu_screen = preload("add path for menu screen")

func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	SceneManager.transition_to_scene("Level1")

func exit_game():
	get_tree().quit()

func pause_game():
	get_tree().pasued = true
	
	#var pause_menu_screen_instance = pasue_menu_screen.instantiate()
	#get_tree().get_root()add_child(pause_menu_screen_instance)

func continue_game():
	get_tree().paused = false

func main_menu():
	var main_menu_screen_instance = main_menu_screen.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)

