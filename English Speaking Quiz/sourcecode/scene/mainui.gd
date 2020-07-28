 extends Control

signal animout
signal qshow
signal qhide
#export(PackedScene) var ui

#onready var play = preload("res://image/play.png")
#onready var pause = preload("res://image/pause.png")
onready var ui = preload("res://scene/ui.tscn")


func _ready():
	print(utils.qtime)
	utils.connect("gemscore",self,"score_changed")

	pass


#func _on_TouchScreenButton_pressed():
#		audio.get_node("SamplePlayer2D").play("hit")
#		if get_node("CanvasLayer/TouchScreenButton").normal == play:
#			get_node("CanvasLayer/Popup/AnimationPlayer").play_backwards("animin")
#			audio.get_node("bg").play()
#			get_tree().set_pause(false)
#			emit_signal("qshow")
#			get_node("CanvasLayer/TouchScreenButton").normal = pause
#		else:
#			get_node("CanvasLayer/TouchScreenButton").normal = play
#			get_node("CanvasLayer/Popup/AnimationPlayer").play("animin")
#			emit_signal("qhide")
#			yield(utils.create_timer(0.5),"timeout")
#			audio.get_node("bg").stop()
#			get_tree().set_pause(true)
#			get_node("CanvasLayer/TouchScreenButton").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#			get_node("CanvasLayer/Popup").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#




#func _on_Popup_popup_hide():
#	get_tree().paused = false
#	$CanvasLayer/TouchScreenButton.normal = pause
#	pass # replace with function body


func _on_main_playerout():
	audio.get_node("SamplePlayer2D").play("player died")
	get_node("CanvasLayer/Popupdied/AnimationPlayer1").play("animin")
	yield(utils.create_timer(0.5),"timeout")
	get_node("CanvasLayer/Popupdied/AnimationPlayer").play("New Anim")
	pass # replace with function body
	

	


func _on_retry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("CanvasLayer/Popuprestart/retry").set_scale(Vector2(0.44,0.44))
	get_node("CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	yield(utils.create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
	
	pass # replace with function body


func _on_backtoui_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("CanvasLayer/Popuplevel/backtoui").set_scale(Vector2(0.44,0.44))
	get_node("CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	
	yield(utils.create_timer(0.5),"timeout")
	get_tree().change_scene_to(ui)
	pass # replace with function body















func _on_retry_released():
	get_node("CanvasLayer/Popuprestart/retry").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_backtoui_released():
	get_node("CanvasLayer/Popuprestart/backtoui").set_scale(Vector2(0.44,0.44))
	pass # replace with function body



