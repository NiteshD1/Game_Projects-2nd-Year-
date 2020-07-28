extends Node2D

signal hidem

onready var main = load("res://scene/main.tscn")
var btnbig = Vector2(0.53,0.53)
var btnsmall = Vector2(0.5,0.5)
var guidepressed = false
var quitpressed = false
var startpressed = false
var popuppressed = false
var menupressed = false
#var levelpressed = false
#var stagepressed = false
#var stagewordpressed = false
#var stagesentencepressed = false
var earncoinpressed = false
var ratetime = false

func _ready():


	audio.get_node("SamplePlayer2D").play("start1")
	randomize()
	var choose = int(rand_range(0,3))
	if choose == 0:
		ratetime = true
	pass





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




func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if menupressed:
			yield(utils.create_timer(0.02),"timeout")
#			get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
			get_node("menuin/AnimationPlayer").play("animout")
			_on_backmain_pressed()
		elif guidepressed:
			_on_guideback_pressed()
#		elif levelpressed:
#			yield(utils.create_timer(0.02),"timeout")
#			_on_backmenu_pressed()
#		elif stagewordpressed:
#			yield(utils.create_timer(0.02),"timeout")
#			_on_backmainwords_pressed()
#		elif stagesentencepressed:
#			yield(utils.create_timer(0.02),"timeout")
#			_on_backmainsentence_pressed()
#		elif stagepressed:
#			yield(utils.create_timer(0.02),"timeout")
#			_on_backmainword_pressed()
		elif earncoinpressed:
			yield(utils.create_timer(0.02),"timeout")
			_on_backmenuearn_pressed()
			audio.get_node("SamplePlayer2D").play("hit")
			get_node("popupearn/AnimationPlayer").play("animout")
		else:
#			if Globals.has_singleton("GodotLocalNotification"):
#				TranslationServer.set_locale("hi_IN")
#				tr("hi_IN")
#				var ln = Globals.get_singleton("GodotLocalNotification")
#				if utils.level%3 == 0:
#					ln.showLocalNotification( "Remind your today's words whenever you open your mobile","Reminder", 1, 1)
			get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
			if ratetime and utils.fileobj[714]:
				get_node("confirm/ratelast").show()
				
			else:
				get_node("confirm/ConfirmationDialog").show()






func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body

func _on_start_pressed():
	if !startpressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("Control/HBoxContainer/start").set_scale(btnbig)
		yield(utils.create_timer(0.5),"timeout")
		get_tree().change_scene_to(main)
		startpressed = true
		pass # replace with function body

func animin():
	

	get_node("Control/HBoxContainer/start/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.3),"timeout")
#	get_node("Control/HBoxContainer/level/AnimationPlayer").play("New Anim")
#	yield(utils.create_timer(0.2),"timeout")
	get_node("Control/HBoxContainer/menu/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.2),"timeout")
	get_node("Control/HBoxContainer/earncoin/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.1),"timeout")
	get_node("Control/HBoxContainer/moreapps/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.1),"timeout")
	get_node("Control/HBoxContainer/rate/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.05),"timeout")
	get_node("Control/HBoxContainer/share/AnimationPlayer").play("New Anim")


func _on_start_released():
	get_node("Control/HBoxContainer/start").set_scale(btnsmall)
	pass # replace with function body




func _on_earncoin_pressed():
	earncoinpressed = true
	CheckNConnection.check_timer.start()
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
	get_node("Control/HBoxContainer/earncoin").set_scale(btnbig)
	get_node("popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_menu_pressed():
		menupressed = true
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
	OS.shell_open("https://play.google.com/store/apps/details?id=org.studyquiz.mathpuzzle")
	pass # replace with function body


func _on_rate_released():
	get_node("Control/HBoxContainer/menu").set_scale(btnsmall)
	pass # replace with function body


func _on_backmain_pressed():
	menupressed = false
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	pass # replace with function body


func _on_backmenuearn_pressed():
	earncoinpressed = false
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	pass # replace with function body


func _on_backmenu_released():
	get_node("Popup2/backmenu").set_scale(Vector2(0.5,0.5))
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


func _on_no_pressed():
	popuppressed = false
	
	pass # replace with function body


func _on_guide_pressed():
	menupressed = false
	guidepressed = true
	get_node("menuin/AnimationPlayer").play("animout")
	
	get_node("btnguide/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_guideback_pressed():
	guidepressed = false
	get_node("btnguide/AnimationPlayer").play("animout")
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	pass # replace with function body


func _on_ratetime_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	OS.shell_open("https://play.google.com/store/apps/details?id=org.studyquiz.mathpuzzle")
	var p = utils.loadfile()
	p[501] = utils.coin
	p[714] = false
	
	utils.save(p)
	
	
	pass # replace with function body


func _on_quit_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var p = utils.loadfile()
	p[501] = utils.coin
	p[715] += 1
	utils.save(p)
	
	yield(utils.create_timer(0.5),"timeout")
	get_tree().quit()
	pass # replace with function body
