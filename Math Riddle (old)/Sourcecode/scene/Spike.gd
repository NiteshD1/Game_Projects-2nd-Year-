tool
extends RigidBody2D

func _ready():
	

	
	pass


func _on_RigidBody2D_body_entered(body):
	var dir = body.get_pos() - get_global_pos()
	dir = dir.normalized() * 50
	body.apply_impulse(Vector2(),dir)
	pass # replace with function body


func _on_Timer_timeout():
	if get_parent().get_pos().x > 115:
		get_node("AnimationPlayer").play("New Anim (2)")
		get_node("Sprite").flip_v = true
	else:
		get_node("AnimationPlayer").play("New Anim")
	
	pass # replace with function body
