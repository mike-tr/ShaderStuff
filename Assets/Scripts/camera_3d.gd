extends Node3D

@export var speedx:float = 10.0
@export var speedy:float = 10.0
@export var move_speed:float = 10.0

var screen_scale:float = 1.0

func _ready() -> void:
	get_viewport().size_changed.connect(windows_rescaled)
	screen_scale = 100.0 / get_viewport().size.x

func windows_rescaled():
	screen_scale = 100.0 / get_viewport().size.x
	# print(screen_scale, " " , get_viewport().size.x)

var time_accumulator := 0.0
func _process(delta: float) -> void:
	#time_accumulator += delta
	#if time_accumulator >= 0.1:	
		#var fps = Engine.get_frames_per_second()
		#print("FPS:", fps)
		#time_accumulator = 0.
	
	if Input.is_action_pressed("move_right"):
		position += transform.basis.x * move_speed * delta
	if Input.is_action_pressed("move_left"):
		position -= transform.basis.x * move_speed * delta
	if Input.is_action_pressed("move_up"):
		position -= transform.basis.z * move_speed * delta
	if Input.is_action_pressed("move_down"):
		position += transform.basis.z * move_speed * delta
		
	if rclick:
		var mpos = get_viewport().get_mouse_position()
		var xr = oldp.x - mpos.x
		var yr = oldp.y - mpos.y
		oldp = mpos
		
		var z = rotation.z
		rotate_object_local(Vector3(0, 1, 0), xr * speedx * delta * screen_scale)
		rotate_object_local(Vector3(1, 0, 0), yr * speedx * delta * screen_scale)
		rotation.z = z
		
		# print(get_viewport().size)
		#rotate_y(xr * speedx * delta)
		#rotate_x(yr * speedy * delta)
	## Rotate the transform around the X axis by 0.1 radians.
	#transform.basis = Basis(axis, rotation_amount) * transform.basis
	## shortened
	#transform.basis = transform.basis.rotated(axis, rotation_amount)
	
	# Mouse in viewport coordinates.
	
var rclick = false
var oldp = Vector2();
func _input(event):
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_W:
			#position += transform.basis.z * move_speed
				
	if event is InputEventMouseButton:
		if event.button_index == 2:
			rclick = !rclick
			if rclick == true:
				oldp = event.position
	#elif event is InputEventMouseMotion:
		#if rclick:
			#var xr = oldp.x - event.position.x
			#var yr = oldp.y - event.position.y
			##rotate_object_local(Vector3(0, 1, 0), xr * 0.001 * speedx)
			##
			#
			##rotate_object_local(Vector3(1, 0, 0), yr * 0.001 * speedy)
			##
		 	##var z = rotation.z
			#rotate_y(xr * 0.001 * speedx)
			#rotate_x(yr * 0.001 * speedy)
			##rotation.z = z
		#oldp = event.position
