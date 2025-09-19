extends VehicleBody3D

var max_RMP = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

func _physics_process(delta):
	var dir = Input.get_action_strength("Gas") - Input.get_action_strength("Brake")
	var steering_dir = Input.get_action_strength("Left") - Input.get_action_strength("Right")
	
	var RMP_left = abs($wheel_back_left.get_rpm())
	var RMP_right = abs($wheel_back_right.get_rpm())
	var RMP = (RMP_left + RMP_right) / 2.0
	
	var torque = dir * max_torque * (1.0 - RMP / max_RMP)
	
	engine_force = torque
	steering = lerp(steering, steering_dir * turn_amount, turn_speed * delta)
	
	if dir == 0:
		brake = 2
