extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():

	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Silvercoin_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("end")
		utils.emit_signal("sscoin")
#		yield(utils.create_timer(0.5),"timeout")
		audio.get_node("Coin").play()
		queue_free()
	pass # replace with function body
