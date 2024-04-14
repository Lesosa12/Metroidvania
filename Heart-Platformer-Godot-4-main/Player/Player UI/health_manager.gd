extends Node

var max_health : int = 3
var current_health : int

signal on_health_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func decrease_health(health_amount : int):
	current_health -= health_amount
	
	if current_health < 0:
		current_health = 0
	
	print("Decrease health")
	on_health_changed.emit()

func increase_health(health_amount : int):
	current_health += health_amount
	
	if current_health > max_health:
		current_health = max_health
	
	print("Increase health")
	on_health_changed.emit()
