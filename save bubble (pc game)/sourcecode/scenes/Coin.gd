extends Area2D

func _ready():
	pass


func _on_Coin_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("end")
		utils.emit_signal("sgcoin")
		audio.get_node("Coin").play()
#		yield(utils.create_timer(0.5),"timeout")	
		queue_free()
	pass # replace with function body
