extends Camera2D

var cameraBounds = Vector2.ZERO

var SCREEN_SIZE = Vector2.ZERO
var stored_position = Vector2.ZERO
var stored_scale = Vector2.ZERO


@export var player : CharacterBody2D
# Player node (set in the editor)
#@onready var player = get_node("../Player")

# Camera parameters
var cameraOffset = Vector2(0, -22)
var cameraSpeed = 5.0

func _ready():
	Events.room_completed.connect(func(room):
		global_position = room.global_position
	)
	
	
	get_window().size_changed.connect(set_screenSize)
	#set_screenSize()
	
	for i in get_tree().get_nodes_in_group("roomDetector"):
		i.roomEntered.connect(setRoom)

func setRoom(roomposition, roomscale):
	setZoom(roomscale)
	setPosition(roomposition)

func setZoom(roomscale):
	#var nzoomVector = SCREEN_SIZE/roomscale
	#var nzoom = min(nzoomVector.x, nzoomVector.y)
	#nzoom = roundf(nzoom*10)/10
	
	var zoomTween = create_tween()
	#zoomTween.tween_property(self, "zoom", Vector2(nzoom, nzoom), 0.5)
	zoomTween.play()
	
	#zoom = Vector2(nzoom,nzoom)
	stored_scale = roomscale

func setPosition(roomposition):
	var positionTween = create_tween()
	positionTween.tween_property(self, "position", roomposition, 0.5)
	positionTween.play()
	
	
	#position = roomposition
	stored_position = roomposition

func _process(delta):
	if player:
		# Calculate the target position for the camera
		var targetPosition = player.global_position + cameraOffset

		# Interpolate the camera's position towards the target position
		global_position = global_position.lerp(targetPosition, delta * cameraSpeed)

func _physics_process(delta):
	if player != null:
		global_position = player.global_position

func set_screenSize():
	SCREEN_SIZE = get_window().size
	setZoom(stored_scale)
	
	
