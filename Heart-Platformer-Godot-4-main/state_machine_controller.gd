extends Node

@export var node_finite_state_machine : NodeFinateStateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("attack")

func _on_attack_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")
