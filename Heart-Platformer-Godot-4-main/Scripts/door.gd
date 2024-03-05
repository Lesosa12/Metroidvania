extends Area2D




func _on_body_entered(body):
	if body.is_in_group("player"):
		$CollisionShape2D.set_deferred("disabled", true)
		get_tree().get_root().get_node("/root/World").go_to_next_room()
	if body_entered:
		print("entered")

