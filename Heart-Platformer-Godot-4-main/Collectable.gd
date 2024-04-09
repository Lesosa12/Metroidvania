extends Node2D

@export var award_amount : int = 1

@onready var animated_sprite_2d = $Sprite2D
@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print(award_amount)
		
		animated_sprite_2d.hide()
		
		label.text = "%s" % award_amount
		CollectibleManager.give_pickup_award(award_amount)
		
		label.show()
		
		var tween = get_tree().create_tween()
		tween.tween_property(label, "position", Vector2(label.position.x, label.position.y + -10), 0.5).from_current()
		tween.tween_callback(queue_free)
