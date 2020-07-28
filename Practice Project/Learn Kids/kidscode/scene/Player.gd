
extends RigidBody2D

export(float) var move


func _ready():

	pass
	
func _physics_process(delta):
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and get_global_mouse_position().x<112:
		position.x -= move*delta
		audio.get_node("tap").play()
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and get_global_mouse_position().x>112:
		position.x += move*delta
		audio.get_node("tap").play()
	pass
	


func _input(event):
	
	pass

func _on_Player_body_entered(body):
	audio.get_node("hit").play()
#	if body == RigidBody2D:
#		apply_impulse(body.position, Vector2(10,10))
	print("fr")
	pass # replace with function body


