extends Camera2D

var cameraBounds = Vector2.ZERO
var SCREEN_SIZE = Vector2.ZERO
# Player node (set in the editor)
@onready var player = get_node("../Player")

# Camera parameters
var cameraOffset = Vector2(0, -22)
var cameraSpeed = 5.0
# Define initial camera boundaries for the first room
var minXRoom1 = -500
var maxXRoom1 = 500
var minYRoom1 = -500
var maxYRoom1 = 500

func _ready():
	get_window().size_changed.connect(set_screenSize)

func _process(delta):
	var playerCamera = get_node("PlayerCamera")
	if playerCamera:
		cameraBounds = playerCamera.global_position
		var cameraSize = playerCamera.rect_size

		# Clamp the camera's global position to stay within the boundaries
		global_position.x = clamp(global_position.x, cameraBounds.x, cameraBounds.x + cameraSize.x - get_viewport_rect().size.x)
		global_position.y = clamp(global_position.y, cameraBounds.y, cameraBounds.y + cameraSize.y - get_viewport_rect().size.y)

	if player:
		# Calculate the target position for the camera
		var targetPosition = player.global_position + cameraOffset

		# Interpolate the camera's position towards the target position
		global_position = global_position.lerp(targetPosition, delta * cameraSpeed)

	if player:
		# Check if the player collides with a door
		# For demonstration purposes, I'm using 'Input.is_action_pressed' to simulate door collision
		if Input.is_action_pressed("ui_accept"):
			# Assume the player has collided with a door and is transitioning to a new room
			update_camera_boundariesForRoom2()

		# Get the player's global position
		var playerPosition = player.global_position

		# Clamp the player's position within the current room boundaries
		var clampedPosition = playerPosition.clamp(Vector2(minXRoom1, minYRoom1), Vector2(maxXRoom1, maxYRoom1))

		# Set the camera's position to the clamped position
		global_position = clampedPosition

func set_screenSize():
	SCREEN_SIZE = get_window().size
	
