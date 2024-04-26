extends Camera2D

var cameraBounds = Vector2.ZERO

var SCREEN_SIZE = Vector2.ZERO
var stored_position = Vector2.ZERO
var stored_scale = Vector2.ZERO

@export_category("Follow Character")
@export var player : CharacterBody2D

@export_category("Camera Smoothing")
@export var smoothing_enabled : bool
@export_range(1,10) var smoothing_distance : int = 8

# Player node (set in the editor)
#@onready var player = get_node("../Player")
# Camera parameters
var cameraOffset = Vector2(0, 0)
var cameraSpeed = 5.0
var weight : float

func _ready():
	weight = float(11 - smoothing_distance) / 100
	
	
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
		var camera_position : Vector2
		
		if smoothing_enabled:
			camera_position = lerp(global_position, player.global_position, weight)
		else:
			camera_position = player.global_position
		
		#print("Weight: ", weight, "Camera Position: ", camera_position, "Camera Pixel Floor", camera_position.floor())
		
		global_position = player.global_position.floor()

func set_screenSize():
	SCREEN_SIZE = get_window().size
	setZoom(stored_scale)
	
	
