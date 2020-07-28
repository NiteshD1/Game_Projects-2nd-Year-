extends Node2D

signal hidem

onready var main = load("res://scene/main.tscn")
var btnbig = Vector2(0.43,0.43)
var btnsmall = Vector2(0.4,0.4)
var quitpressed = false


func _ready():
	print(utils.qtime)

	animin()

	audio.get_node("SamplePlayer2D").play("start1")
	
	pass



















func _on_backmenu_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/backmenu").set_scale(Vector2(0.58,0.58))
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	get_node("Popup2/AnimationPlayer").play("animout")




#

	
	









	


func _on_back_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("controlinfo/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body















func _on_Label2_pressed():
	print("hello")
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("menuin/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.02),"timeout")
	get_node("controlinfo/AnimationPlayer").play("animin")
	pass # replace with function body





func _on_next_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/next").set_scale(Vector2(0.33,0.33))
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() + 130)
	pass # replace with function body


func _on_previous_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/previous").set_scale(Vector2(0.33,0.33))
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() - 130)
	pass # replace with function body
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quitpressed = true
		get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
		get_node("confirm/ConfirmationDialog").show()






func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body

func _on_start_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/start").set_scale(btnbig)
	yield(utils.create_timer(0.5),"timeout")
	get_tree().change_scene_to(main)
	pass # replace with function body

func animin():
	get_node("Control/HBoxContainer/start/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.2),"timeout")
	get_node("Control/HBoxContainer/level/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.2),"timeout")
	get_node("Control/HBoxContainer/earncoin/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.1),"timeout")
	get_node("Control/HBoxContainer/menu/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.1),"timeout")
	get_node("Control/HBoxContainer/rate/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.05),"timeout")
	get_node("Control/HBoxContainer/share/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.05),"timeout")
	get_node("Control/HBoxContainer/moreapps/AnimationPlayer").play("New Anim")


func _on_start_released():
	get_node("Control/HBoxContainer/start").set_scale(btnsmall)
	pass # replace with function body


func _on_level_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
	get_node("Control/HBoxContainer/level").set_scale(btnbig)
	get_node("Popup2/AnimationPlayer").play("animin")
	

	pass # replace with function body


func _on_level_released():
	get_node("Control/HBoxContainer/level").set_scale(btnsmall)
	
	pass # replace with function body


func _on_earncoin_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
	get_node("Control/HBoxContainer/earncoin").set_scale(btnbig)
	get_node("popupearn/AnimationPlayer").play("animin")
	pass # replace with function body









func _on_menu_pressed():
	
	if !quitpressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
		get_node("Control/HBoxContainer/menu").set_scale(btnbig)
		get_node("menuin/AnimationPlayer").play("animin")
		pass # replace with function body


func _on_menu_released():
	get_node("Control/HBoxContainer/menu").set_scale(btnsmall)
	pass # replace with function body


func _on_rate_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/rate").set_scale(btnbig)
	OS.shell_open("https://play.google.com/store/apps/details?id=org.godotengine.englishspeaking")
	pass # replace with function body


func _on_rate_released():
	get_node("Control/HBoxContainer/menu").set_scale(btnsmall)
	pass # replace with function body


func _on_backmain_pressed():
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	pass # replace with function body


func _on_backmenuearn_pressed():
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	pass # replace with function body


func _on_backmenu_released():
	get_node("Popup2/backmenu").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_next_released():
	get_node("Popup2/next").set_scale(Vector2(0.3,0.3))
	pass # replace with function body


func _on_previous_released():
	get_node("Popup2/previous").set_scale(Vector2(0.3,0.3))
	pass # replace with function body


func _on_earncoin_released():
	get_node("Control/HBoxContainer/earncoin").set_scale(btnsmall)
	pass # replace with function body


func _on_moreapps_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/moreapps").set_scale(btnbig)
	OS.shell_open("https://play.google.com/store/apps/developer?id=Study+Quiz")
	pass # replace with function body


func _on_moreapps_released():
	get_node("Control/HBoxContainer/moreapps").set_scale(btnsmall)
	pass # replace with function body


func _on_share_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/share").set_scale(btnbig)
	pass # replace with function body


func _on_share_released():
	get_node("Control/HBoxContainer/share").set_scale(btnsmall)
	pass # replace with function body


func _on_no_released():
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	quitpressed = false
	pass # replace with function body
