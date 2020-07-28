 extends Control




onready var play = preload("res://image/play.png")
onready var pause = preload("res://image/pause.png")
#onready var ui = preload("res://scene/ui.tscn")


func _ready():
	utils.connect("gemscore",self,"score_changed")
	
	pass


func _on_TouchScreenButton_pressed():
		audio.get_node("click").play()
		if $CanvasLayer/TouchScreenButton.normal == play:
			audio.get_node("bg").play()
			get_tree().paused = false
			$CanvasLayer/TouchScreenButton.normal = pause
		else:
			$CanvasLayer/TouchScreenButton.normal = play
			audio.get_node("bg").stop()
			get_tree().paused = true
			$CanvasLayer/TouchScreenButton.set_pause_mode(Node.PAUSE_MODE_PROCESS)




#func _on_Popup_popup_hide():
#	get_tree().paused = false
#	$CanvasLayer/TouchScreenButton.normal = pause
#	pass # replace with function body


func _on_main_playerout():
	audio.get_node("lose").play()
	audio.get_node("bg").stop()
	$CanvasLayer/Popupdied.show()
	$CanvasLayer/Popupdied/AnimationPlayer.play("New Anim")
	pass # replace with function body
	
func score_changed():
	utils.gem += 1
	$CanvasLayer/HBoxContainer/Container/Label.set_text(str(utils.gem))
	


func _on_retry_pressed():
	audio.get_node("click").play()
	get_tree().paused = false
	
	get_tree().reload_current_scene()
	
	pass # replace with function body


func _on_backtoui_pressed():
	audio.get_node("click").play()
	get_tree().paused = false
	get_tree().change_scene("res://scene/ui.tscn")
	pass # replace with function body


func _on_back_pressed():
	audio.get_node("click").play()
	get_tree().paused = false
	$CanvasLayer/TouchScreenButton.normal = pause
	$CanvasLayer/Popup.hide()
	pass # replace with function body





#func _on_backretry_pressed():
#	$CanvasLayer/Popuprestart.show()
#	$CanvasLayer/Popupdied.hide()
#	pass # replace with function body
