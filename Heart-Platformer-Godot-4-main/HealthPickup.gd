extends Node2D

@export var pickup_amount : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_pickup_box_body_entered(body):
	if body.is_in_group("Player"):
		HealthManager.increase_health(pickup_amount)
		queue_free()
