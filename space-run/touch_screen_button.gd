extends TouchScreenButton

var TouchPos = Vector2(50 , 50)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TouchPos = $"../Player".position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	#$"../Joystick/Knob".pressing = true
	#$"../Joystick".position = get_viewport().get_mouse_position()
	TouchPos = get_viewport().get_mouse_position()
	$"../Player".FireBullet()


func _on_released() -> void:
	$"../Joystick/Knob".pressing = false
