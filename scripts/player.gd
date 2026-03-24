extends RigidBody3D

var mouse_sensitivity := 0.001
var twistinput := 0.0
var pitchinput := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.z = Input.get_axis("ui_up", "ui_down")
	apply_central_force(input* 1200 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("mouseclick"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$TwistPrivot.rotate_y(twistinput)
	$TwistPrivot.queue_free()
	$TwistPrivot/PitchPivot.rotate_x(pitchinput)
	$TwistPrivot/PitchPivot.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twistinput = -event.relative.x * mouse_sensitivity
			pitchinput = -event.relative.y * mouse_sensitivity
