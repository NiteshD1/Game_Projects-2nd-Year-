extends Control



func _ready():
	update_coin()
	pass


func _on_backmenuearn_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("backmenuearn").set_scale(Vector2(0.58,0.58))
	get_node("AnimationPlayer").play("animout")
	pass # replace with function body


func _on_coinadd_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("coinadd").set_scale(Vector2(0.34,0.38))
	if utils.network_error :
		get_node("networkerror").show()
		yield(utils.create_timer(2),"timeout")
		get_node("networkerror").hide()
	pass # replace with function body


func update_coin():
	get_node("Label1").set_text(str(utils.coin))

func _on_backmenuearn_released():
	get_node("backmenuearn").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_share_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("share").set_scale(Vector2(0.34,0.38))
	yield(utils.create_timer(0.5),"timeout")
#	get_node("blank").show()
	pass # replace with function body


func _on_share_released():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("share").set_scale(Vector2(0.3,0.35))
	pass # replace with function body


func _on_coinadd_released():
	get_node("coinadd").set_scale(Vector2(0.3,0.35))
	pass # replace with function body






