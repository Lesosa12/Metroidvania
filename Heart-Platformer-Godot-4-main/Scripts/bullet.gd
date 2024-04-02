extends AnimatedSprite2D

var speed  : int = 600
var direction : int


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	move_local_x(direction * speed * delta)


func _on_timer_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	print("Bullet area entered")



func _on_hitbox_body_entered(body):
	print("Bullet body entered")
