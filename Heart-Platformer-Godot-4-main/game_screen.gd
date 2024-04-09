extends CanvasLayer

@onready var collectible_label = $MarginContainer/VBoxContainer/HBoxContainer/CollectibleLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	CollectibleManager.on_collectible_award_recivied.connect(on_collectable_award_recieved)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_collectable_award_recieved(total_award : int):
	collectible_label.text = str(total_award)
	#repeat with different collectibles with different award vairables 
