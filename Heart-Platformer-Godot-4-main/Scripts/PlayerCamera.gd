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
	pass

func set_screenSize():
	SCREEN_SIZE = get_window().size
	
	
