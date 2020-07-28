extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
#	TranslationServer.set_locale("hi")
#	tr("hi")
	
	# Called every time the node is added to the scene.
	# Initialization here

	pass

#func _init():
#		TranslationServer.set_locale("hi")
#		tr("hi")
#	
func _on_cross_pressed():
#	utils.guide = false
	audio.get_node("SamplePlayer2D").play("hit")
	
	get_node("AnimationPlayer").play("animout")
	utils.emit_signal("guideend")
	var g = utils.loadfile()
	if g[utils.guideno] != 710:
		yield(utils.create_timer(0.5),"timeout")
		get_node("dontshowagain").show()
	pass # replace with function body


func _on_dontshowagain_pressed():
#	utils.guide = false
	get_node("AnimationPlayer").play("animout")
	audio.get_node("SamplePlayer2D").play("hit")
	
	utils.emit_signal("guideend")
	var g = utils.loadfile()
	g[utils.guideno] = false
	utils.save(g)
	pass # replace with function body


func _on_rateuss_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	OS.shell_open("https://play.google.com/store/apps/details?id=org.studyquiz.learnenglish")
#	utils.emit_signal("guideend")
	var g = utils.loadfile()
	g[utils.guideno] = false
	utils.save(g)
	pass # replace with function body
