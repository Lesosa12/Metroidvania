extends Node

static var total_award_amount : int

signal on_collectible_award_recivied

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func give_pickup_award(collectible_award : int):
	total_award_amount += collectible_award
	
	on_collectible_award_recivied.emit(total_award_amount)
