extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var btnbig = Vector2(1,1)
var btnsmall = Vector2(0.8,0.8)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_yes_pressed():
	
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("yes").set_scale(btnbig)
	var p = utils.loadfile()
	p[501] = utils.coin
	utils.save(p)
	yield(utils.create_timer(0.5),"timeout")
	get_tree().quit()
	pass # replace with function body


func _on_no_pressed():
	audio.get_node("SamplePlayer2D").play("hit")

	hide()
	pass # replace with function body


func _on_yes_released():
	get_node("yes").set_scale(btnsmall)
	pass # replace with function body



