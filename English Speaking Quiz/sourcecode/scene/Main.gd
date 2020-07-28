extends Node2D

signal playerout
var curtime = 0
var answer = 0
var starlevel
var anspressed = false
var nextpressed = false
var settingpressed = false
var timeremain = 0
var qinlevel = 10
var line = 3
var answerstr

var btnbig = Vector2(1.1,1.1)
var btnsmall = Vector2(1,1)
var q1 
var q2 
var q3 
var q4 = "None" 
var qno = 0
var anscorrect = 0
var addplaceno 

signal addinter

#
#onready var play = preload("res://image/play.png")
#onready var pause = preload("res://image/pause.png")

onready var ui = preload("res://scene/ui.tscn")








var gemp = 0
var canout = true

func _ready():
	randomize()
	print(utils.level)
	
	update_coin()
	calllevelinfo()
	yield(utils.create_timer(3),"timeout")
	addplaceno = int(rand_range(1,4))
	

	get_node("level/Label").set_text(str(utils.level))
	

	select_level()
	get_node("down/AnimationPlayer").play("New Anim")
#	audio.get_node("bg").play()
	

	
















#
func _on_backretry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/Popupdied/AnimationPlayer1").play("animout")
	get_node("ansbox/q" + str(answer)+ "/pos/right").show()
	pass # replace with function body








func _on_cross_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	set_opacity(0.2)
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play("animin")
#	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
#	get_tree().set_pause(true)
#	get_node("ui/CanvasLayer/Popuprestart").set_pause_mode(Node.PAUSE_MODE_PROCESS)
	pass # replace with function body




func _on_changelevel_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	utils.coin -= utils.coinlimit
	update_coin()
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	level_change()
	yield(utils.create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
	
	pass # replace with function body






func select_level():
	animin()
	yield(utils.create_timer(0.5),"timeout")
	var levelfactor = (utils.level - 1)*qinlevel*line
	get_node("qbox/Label").set_text(utils.result[levelfactor + qno*line + 1])
	answerstr = utils.result[levelfactor + qno*line + 2]
	getq()
#	get_node("ansbox/q1/Label").set_text(utils.result[levelfactor + qno*line + 2])
#	get_node("ansbox/q2/Label").set_text(utils.result[levelfactor + qno*line+ 3])
#	get_node("ansbox/q3/Label").set_text(utils.result[levelfactor + qno*line + 4])
#	get_node("ansbox/q4/Label").set_text(utils.result[levelfactor + qno*line + 5])
	get_node("ansbox/q1/Label").set_text(q1)
	get_node("ansbox/q2/Label").set_text(q2)
	get_node("ansbox/q3/Label").set_text(q3)
	get_node("ansbox/q4/Label").set_text(q4)
	answer = int(utils.result[levelfactor + qno*line + 3])
	
	qno += 1
	
	get_node("upper/ProgressBar").set_value(100)
	anspressed = false
	curtime = 0

#	draw_curve()








func _on_Timer_timeout():
	
	curtime += 1
	var temptime = int(curtime)
	timeremain = utils.qtime - curtime/10
	if temptime % 10 == 0 :
		get_node("upper/uperpart2/Label").set_text(str(timeremain))
	get_node("upper/ProgressBar").set_value(get_node("upper/ProgressBar").get_value() - 0.3)
#	var minute = temptime/60
#	var second = temptime % 60
#	if second < 10:
#		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":0" + str(second))
#	else:
#		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":" + str(second))
	if curtime == utils.qtime * 10: 
		get_node("Timer").stop()
		emit_signal("playerout")
		get_node("AnimationPlayer").play_backwards("New Anim")
#		set_opacity(0.2)
	if timeremain >= 0 and timeremain <= 5 and temptime % 10 == 0:
		audio.get_node("SamplePlayer2D").play("times up")
	pass # replace with function body














func _on_btndone_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Keyboard/HBoxContainer 2/btndone").set_scale(Vector2(1.1,1.1))
	if answer == int(get_node("ui/CanvasLayer/Label").get_text()):
		yield(utils.create_timer(0.5),"timeout")
		audio.get_node("SamplePlayer2D").play("winsound")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()
		animout()
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
		
		var s = utils.loadfile()
		if curtime < 0.5* utils.qtime:
			s[utils.level] = 3
		elif curtime < 0.7 * utils.qtime:
			s[utils.level] = 2
		else:
			s[utils.level] = 1
		starlevel = utils.level
		utils.save(s)
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim")
		
		if utils.level >= utils.maxlevel:
			utils.level = 1
		else:
			utils.level += 1
	
		var p = utils.loadfile()
	
		
		var previous = p[0]
		if utils.level > previous:
			p[0] = utils.level
			utils.save(p)
		get_node("Timer").stop()
	
#		get_tree().set_pause(true)
#		get_node("ui/CanvasLayer/Popuplevel").set_pause_mode(Node.PAUSE_MODE_PROCESS)
		yield(utils.create_timer(0.5),"timeout")
		print(p[starlevel])
		if  p[starlevel] >= 2:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (2)")
		yield(utils.create_timer(0.5),"timeout")
		if  p[starlevel] >= 3:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (3)")
	else:
		emit_signal("playerout")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()

func animin():
#	get_node("level/AnimationPlayer").play("New Anim")
	yield(utils.create_timer(1),"timeout")
	audio.get_node("SamplePlayer2D").play("spshield")
	get_node("qbox/AnimationPlayer").play("New Anim (2)")
#	yield(utils.create_timer(1),"timeout")
	get_node("Timer").start()
	get_node("ansbox/q1/AnimationPlayer").play("New Anim")

	get_node("ansbox/q2/AnimationPlayer").play("New Anim")

	get_node("ansbox/q3/AnimationPlayer").play("New Anim")

	get_node("ansbox/q4/AnimationPlayer").play("New Anim")
	
	


func animout():
	get_node("qbox/AnimationPlayer").play_backwards("New Anim (2)")
	get_node("ansbox/q1/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q2/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q3/AnimationPlayer").play_backwards("New Anim")
	get_node("ansbox/q4/AnimationPlayer").play_backwards("New Anim")








func _on_back_pressedtouch():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Timer").stop()
	pass # replace with function body


func _on_AnimationPlayer_animation_started( name ):
	get_node("Question").hide()
	get_node("ui/CanvasLayer/Label").hide()
	pass # replace with function body



func _on_ui_qhide():
#	yield(utils.create_timer(0.5),"timeout")
	get_node("Question/AnimationPlayer").play_backwards("New Anim")
	
	pass # replace with function body


func _on_ui_qshow():
	yield(utils.create_timer(0.5),"timeout")
	get_node("Question/AnimationPlayer").play("New Anim")
	
	pass # replace with function body



func _on_retry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	yield(utils.create_timer(0.5),"timeout")
	print("uuu")
	get_tree().reload_current_scene()
	pass # replace with function body












func _on_back2_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
#	anspressed = true
	get_node("ui/CanvasLayer/Popup2/AnimationPlayer").play("animout")
	_on_ui_qshow()
	get_node("Timer").start()
	pass # replace with function body
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/ConfirmationDialog").show()
		anspressed = true







func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body


func _on_Node2D_answer():
	_on_Answerbtn_pressed()
	pass # replace with function body

func _on_setting_pressed():
	
	if !settingpressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("setting").set_scale(Vector2(0.35,0.35))
		get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animin")
		set_opacity(0.2)
		settingpressed = true
	pass # replace with function body


func _on_setting_released():
	get_node("setting").set_scale(Vector2(0.3,0.3))
	pass # replace with function body

func update_coin():
	get_node("Coin/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/popupearn/Label1").set_text(str(utils.coin))
	


func _on_earncoin_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Popup/earncoin").set_scale(Vector2(0.38,0.38))
	get_node("popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_earncoin_released():
	get_node("ui/CanvasLayer/Popup/earncoin").set_scale(Vector2(0.35,0.35))
	pass # replace with function body


func _on_Answerbtnfirst_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Answerbtn").set_scale(Vector2(0.38,0.38))
	get_node("Popup/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_Answerbtn_released():
	get_node("ui/CanvasLayer/Answerbtn").set_scale(Vector2(0.35,0.35))
	pass # replace with function body


func _on_backmain_pressed():
	settingpressed = false
	set_opacity(1)
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body


func _on_btnq1_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q1").set_scale(btnbig)
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
		common()
		if answer != 1:
			get_node("ansbox/q1/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		anspressed = true
	pass # replace with function body


func _on_btnq1_released():
	get_node("ansbox/q1").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq2_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q2").set_scale(btnbig)
		common()
		if answer != 2:
			get_node("ansbox/q2/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq2_released():
	get_node("ansbox/q2").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq3_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q3").set_scale(btnbig)
		common()
		if answer != 3:
			get_node("ansbox/q3/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq3_released():
	get_node("ansbox/q3").set_scale(btnsmall)
	pass # replace with function body


func _on_btnq4_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q4").set_scale(btnbig)
		common()
		if answer != 4:
			get_node("ansbox/q4/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
		anspressed = true
	pass # replace with function body


func _on_btnq4_released():
	get_node("ansbox/q4").set_scale(btnsmall)
	pass # replace with function body


func _on_Timerparticle_timeout():
	get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(false)
	get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(false)
	yield(utils.create_timer(1),"timeout")
	get_node("Timercoin").stop()
	pass # replace with function body
	
func increase_coin():
	var p = utils.loadfile()
	if utils.level == p[0]:
		print(timeremain)
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(true)
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
		var i = timeremain
		anscorrect += 1
		if curtime/10 > 20:
			get_node("Timercoin").set_wait_time(0.1)
		elif curtime/10 > 10:
			get_node("Timercoin").set_wait_time(0.09)
		else:
			get_node("Timercoin").set_wait_time(0.07)
		
		get_node("Timercoin").start()
		yield(utils.create_timer(1.5),"timeout")
		audio.get_node("SamplePlayer2D").play("coinget")
		yield(utils.create_timer(1),"timeout")
		audio.get_node("SamplePlayer2D").play("coinget")
#	yield(utils.create_timer(1),"timeout")
#	audio.get_node("SamplePlayer2D").play("coinget")


func _on_Timercoin_timeout():
	utils.coin += 1
	
	update_coin()
	pass # replace with function body


func _on_next_pressed():
	yield(utils.create_timer(0.1),"timeout")
	if qno == 4 or qno == 8:
		emit_signal("addinter")
	animout()
	get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(false)
	get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(false)
	get_node("down/whatsapp/Label").hide()
	hidealltick()
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("down/next").set_scale(Vector2(0.55,0.55))
	if qno == qinlevel and !nextpressed:
		nextpressed = true
		get_node("ui/CanvasLayer/Popuplevel/Sprite/gain").set_text(str(anscorrect))
		if utils.coin >= utils.coinlimit:
			get_node("ui/CanvasLayer/Popuplevel/nextok").show()
		else:
			get_node("ui/CanvasLayer/Popuplevel/notok").show()
		audio.get_node("SamplePlayer2D").play("winsound")
		get_node("AnimationPlayer").play_backwards("New Anim")
		anspressed = true
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
		yield(utils.create_timer(0.5),"timeout")
		var s = utils.loadfile()
		if anscorrect > qinlevel * 0.8:
			s[utils.level] = 3
			get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Excellent")
		elif anscorrect > qinlevel * 0.4:
			s[utils.level] = 2
			get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Good")
		else:
			s[utils.level] = 1
			get_node("ui/CanvasLayer/Popuplevel/Labelgreet").set_text("Poor")
		starlevel = utils.level
		utils.save(s)
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim")
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer 2").play("New Anim")
		
		
		get_node("Timer").stop()
		
	
#		get_tree().set_pause(true)
#		get_node("ui/CanvasLayer/Popuplevel").set_pause_mode(Node.PAUSE_MODE_PROCESS)
		yield(utils.create_timer(0.5),"timeout")
		print(s[starlevel])
		if  s[starlevel] >= 2:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (2)")
		yield(utils.create_timer(0.5),"timeout")
		if  s[starlevel] >= 3:
			print("hii")
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer").play("New Anim (3)")
		
	elif qno < qinlevel:
		select_level()
	
	pass # replace with function body
	
func hidealltick():
	get_node("ansbox/q" + str(answer)+ "/pos/right").hide()
	get_node("ansbox/q4/pos/wrong").hide()
	get_node("ansbox/q3/pos/wrong").hide()
	get_node("ansbox/q2/pos/wrong").hide()
	get_node("ansbox/q1/pos/wrong").hide()

func common():
	get_node("Timer").stop()
	get_node("down/whatsapp/Label").show()


func _on_next_released():
	get_node("down/next").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_earncoinnext_pressed():
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_whatsapp_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("down/whatsapp").set_scale(Vector2(0.55,0.55))
	hidealltick()
	pass # replace with function body


func _on_whatsapp_released():
	get_node("down/whatsapp").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_rateus_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("down/rateus").set_scale(Vector2(0.37,0.53))
	OS.shell_open("https://play.google.com/store/apps/details?id=org.godotengine.englishspeaking")
	pass # replace with function body


func _on_rateus_released():
	get_node("down/rateus").set_scale(Vector2(0.34,0.5))
	pass # replace with function body


func _on_backmenuearn_pressed():
	pass # replace with function body


func _on_no_pressed():
	anspressed = false
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body

func level_change():
	if utils.level >= utils.maxlevel:
		utils.level = 1
	else:
		utils.level += 1
	
	var p = utils.loadfile()
	
		
	var previous = p[0]
	if utils.level > previous:
		p[0] = utils.level
		utils.save(p)
func wrong_answer():
	audio.get_node("SamplePlayer2D").play("wrong1")
	
func right_answer():
	yield(utils.create_timer(0.5),"timeout")
	audio.get_node("SamplePlayer2D").play("right")

func _on_home_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/menuin/home").set_scale(Vector2(0.44,0.44))
	
	yield(utils.create_timer(0.2),"timeout")
	get_tree().change_scene_to(ui)
	pass # replace with function body


func _on_Node2D_refresh():
	get_node("ui/CanvasLayer/popupearn/Tonextlevel").show()
	pass # replace with function body


func _on_share_refresh():
	get_node("ui/CanvasLayer/popupearn/Tonextlevel").show()
	pass # replace with function body


func _on_Tonextlevel_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if utils.coin >= utils.coinlimit :
		utils.coin -= utils.coinlimit
		level_change()
		update_coin()
		get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
		
		yield(utils.create_timer(0.5),"timeout")
		get_tree().reload_current_scene()
	else:
		get_node("ui/CanvasLayer/popupearn/morecoin").show()
		yield(utils.create_timer(2),"timeout")
		get_node("ui/CanvasLayer/popupearn/morecoin").hide()
	

func getq():
	var arr 
	arr = answerstr.split("(")
	q1 = str(arr[1])
	q1.erase(0,3)
	q2 = str(arr[2])
	q2.erase(0,3)
	q3 = str(arr[3])
	q3.erase(0,3)
	
	if arr.size() == 5:
		q4 = str(arr[4])
		q4.erase(0,3)
		print(arr[4])

func calllevelinfo():
	if utils.level <= 35:
		get_node("ui/CanvasLayer/levelinfo/level2").set_text("Elementary Level")
	elif utils.level <= 70:
		get_node("ui/CanvasLayer/levelinfo/level2").set_text("Intermediate Level")
	else:
		get_node("ui/CanvasLayer/levelinfo/level2").set_text("Advanced Level")
	get_node("ui/CanvasLayer/levelinfo/level1").set_text(str(utils.level))
	get_node("ui/CanvasLayer/levelinfo/level3").set_text(utils.levelinfo[utils.level])
	audio.get_node("SamplePlayer2D").play("spshield")
#	get_node("AnimationPlayer").play_backwards("New Anim")
	get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animin")
	yield(utils.create_timer(3),"timeout")
	get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animout")
	get_node("AnimationPlayer").play("New Anim")
