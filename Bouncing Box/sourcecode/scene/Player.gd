
extends RigidBody2D

export(float) var velocity

func _ready():
	_on_Left_pressed()
	_on_Right_pressed()
	_on_Right2_pressed()
	_on_Left_pressed()
	_on_Right_pressed()
	_on_Right2_pressed()
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		set_linear_velocity(Vector2(0,-velocity))
		set_angular_velocity(8)
		print("j")
	if Input.is_action_just_pressed("ui_left"):
		set_linear_velocity(Vector2(-velocity,-velocity))
		set_angular_velocity(2)
	if Input.is_action_just_pressed("ui_right"):
		set_linear_velocity(Vector2(velocity,-velocity))
		set_angular_velocity(2)
	pass
	


func _input(event):
	pass

func _on_Player_body_entered(body):
	audio.get_node("hit").play()
#	if body == RigidBody2D:
#		apply_impulse(body.position, Vector2(10,10))
	print("fr")
	pass # replace with function body


func _on_Left_pressed():
	set_linear_velocity(Vector2(-velocity,-velocity))
	set_angular_velocity(2)
	audio.get_node("tap").play()
	pass # replace with function body


func _on_Right_pressed():
	set_linear_velocity(Vector2(velocity,-velocity))
	set_angular_velocity(2)
	audio.get_node("tap").play()
	pass # replace with function body


func _on_Right2_pressed():
	set_linear_velocity(Vector2(0,-velocity))
	set_angular_velocity(8)
	audio.get_node("tap").play()
	pass # replace with function body
