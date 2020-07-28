extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play("animinvisible")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Invisiblepower_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("end")
		yield(utils.create_timer(0.5),"timeout")
		if utils.haspower :
			utils.emit_signal("spinvisible")
		else:
			utils.emit_signal("pinvisible")
	audio.get_node("Powers").play()
	queue_free()
	pass # replace with function body
