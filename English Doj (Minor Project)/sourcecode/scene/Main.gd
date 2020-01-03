extends Node2D

signal playerout
var extralifetime = 10
var firstprevious = false
var curtime = 0
var answer = 0
var extralifepossible = true
var select = 0
var oselect = 0
var starlevel= null 
var highscore = 0
var stargame = 0
var first = true
var gameend = false
var last = false
var anspressed = false
var nextpressed = false
var settingpressed = true
var lifelinepressed = false
var helppressed = false
var audiencepressed = false
var earncoinpressed = false
var fiftypressed = false
var showpressed = false
var lifelineno = 0
var skippressed = false
var timeremain = 0
var qinlevel = 15
var timerout = false
var line = 3
var gqno =0
var pallow = true
var answerstr= null
var qs1= null
var qs2= null
var ans = [1,2]
var btnbig = Vector2(1.1,1.1)
var btnsmall = Vector2(1,1)
var btnbign = Vector2(0.55,0.55)
var btnsmalln = Vector2(0.5,0.5)
var btnbignn = Vector2(0.48,0.55)
var btnsmallnn = Vector2(0.46,0.5)
var q= null
var arp = []
var previous = false

var lifelinecoin = 100
var qno = 0
var anscorrect = 0
var addplaceno= null 
var qmax = 0
var score = 0
var lincrease = false
var gameadd = 0
var lifeline = 3
var wordno = 1
var wordnolimit = 5
var limit= null
var a = [3,0,2,4,1]
var ar = []
var ansr = [0,0,0,0]
var randqno = 0
var randq= null
var sentenceno = 1
var mode = false
signal addinter
signal addinter1
#
#onready var play = preload("res://image/play.png")
#onready var pause = preload("res://image/pause.png")

onready var ui = preload("res://scene/ui.tscn")








var gemp = 0
var canout = true

func _ready():
#	utils.network_error = null
#	CheckNConnection.check_timer.start()
#	utils.level = 509

	utils.connect("guideend", self, "_on_guideend") 
	utils.connect("englishhindi", self, "_on_englishhindi")
	utils.connect("givelife", self, "_on_givelife")
	_on_englishhindi()
	randomize()
#	selectqs()
#	for i in range(0,5):
#		var k = int(rand_range(0,5))
#		if a[k]==0:
#			a[k] = i
#		else:
#			while(a[k]!=0):
#				if k == 4:
#					k=0
#				else:
#					k += 1
#			a[k] = i
#	if utils.level == 1:
#		qinlevel = 5
#		get_node("ui/CanvasLayer/Popuplevel/Sprite/total").set_text("5")
	update_coin()
	
	if utils.first_time:
#		audio.get_node("SamplePlayer2D").play("spshield")
#		get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animin")
		get_node("ui/CanvasLayer/mode").show()
		
			
		mode = true
		utils.first_time = false
	else:
		if utils.indirect:
			get_node("ui/CanvasLayer/mode").hide()
			utils.indirect = false
		if utils.learnmode:
			calllevelinfo()
		elif utils.gamemode:
			gamestart()
		else:
			callsentencemode()
#	yield(utils.create_timer(3),"timeout")
	
	
	addplaceno = int(rand_range(1,4))
	

	
	
	

	
#	audio.get_node("bg").play()
	
#
func _on_backretry_pressed():
	timerout = false
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
	yield(utils.create_timer(0.2),"timeout")
	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.44,0.44))
	utils.coin -= utils.coinlimit
	update_coin()
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	level_change()
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	get_tree().reload_current_scene()
	
	pass # replace with function body






func select_level():
	curtime = 0
	
	yield(utils.create_timer(0.5),"timeout")
	
	
	getq()
#	get_node("ansbox/q1/Label").set_text(utils.result[levelfactor + qno*line + 2])
#	get_node("ansbox/q2/Label").set_text(utils.result[levelfactor + qno*line+ 3])
#	get_node("ansbox/q3/Label").set_text(utils.result[levelfactor + qno*line + 4])
#	get_node("ansbox/q4/Label").set_text(utils.result[levelfactor + qno*line + 5])
	
#	answer = int(utils.result[levelfactor + qno*line + 3])
	animin()
	
	get_node("upper/ProgressBar").set_value(100)
	anspressed = false
#	draw_curve()








func _on_Timer_timeout():
	
	curtime += 1
	var temptime = int(curtime)
	timeremain = utils.qtime - curtime/10
	if temptime % 10 == 0 :
		get_node("upper/uperpart2/Label").set_text(str(timeremain))
	get_node("upper/ProgressBar").set_value(get_node("upper/ProgressBar").get_value() - 0.46)
	
#var minute = temptime/60
#	var second = temptime % 60
#	if second < 10:
#		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":0" + str(second))
#	else:
#		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":" + str(second))
	if curtime == utils.qtime * 10: 
		
		get_node("Timer").stop()
		if lifelinepressed:
			_on_backlifeline_pressed()
		if settingpressed:
			get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animout")
			_on_backmain_pressed()
		if earncoinpressed:
			_on_backmenuearn_pressed()
			get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
		
		get_node("AnimationPlayer").play_backwards("New Anim")
		if utils.learnmode:
			
			timerout = true
			emit_signal("playerout")
		else:
			gamemodelose()
			gameend()
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
			utils.again = true
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
	if utils.learnmode:
		if qno == qmax:
			get_node("Timer").start()
	else:
		get_node("Timer").start()
#	get_node("upper/uperpart2/Label").set_text(str(30))
#	audio.get_node("SamplePlayer2D").play("swap")
	audio.get_node("SamplePlayer2D").play("spshield")
	get_node("qbox/AnimationPlayer").play("New Anim (2)")
#	yield(utils.create_timer(1),"timeout")
	
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
		if lifelinepressed:
			_on_backlifeline_pressed()
		
		elif timerout:
			_on_backretry_pressed()
			emit_signal("addinter")
		elif earncoinpressed:
			_on_backmenuearn_pressed()
			get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animout")
		elif settingpressed and not gameend and not first:
			get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animout")
			_on_backmain_pressed()
		else:
			if mode:
				emit_signal("addinter")
				utils.first_time = true
				get_tree().change_scene_to(ui)
			else:
				utils.first_time = true
				get_tree().reload_current_scene()
			
#		get_node("AnimationPlayer").play_backwards("New Anim")
#		get_node("ui/CanvasLayer/ConfirmationDialog").show()
#		anspressed = true







func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body


func _on_Node2D_answer():
	_on_Answerbtn_pressed()
	pass # replace with function body

func _on_setting_pressed():
	
	if !settingpressed:
		settingpressed = true
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("setting").set_scale(Vector2(0.35,0.35))
		get_node("ui/CanvasLayer/menuin/AnimationPlayer").play("animin")
		set_opacity(0.2)
		
	pass # replace with function body


func _on_setting_released():
	get_node("setting").set_scale(Vector2(0.3,0.3))
	pass # replace with function body

func update_coin():
	get_node("Coin/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/popupearn/Label1").set_text(str(utils.coin))
	var p = utils.loadfile()
	p[701] = utils.coin
	utils.save(p)
	


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
	audio.get_node("SamplePlayer2D").play("hit")
	settingpressed = false
	set_opacity(1)
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body


func _on_btnq1_pressed():
	if not anspressed :
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ansbox/q1").set_scale(btnbig)
		
		common()
		if answer != 1:
			get_node("ansbox/q1/pos/wrong").show()
			wrong_answer()
		else:
#			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			
			get_node("Timerparticle").start()
			increase_coin()
			right_answer()
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
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
	update_coin()
	pass # replace with function body
	
func increase_coin():
	var p = utils.loadfile()
	if get_node("ansbox/q" + str(answer)+ "/pos/right").is_visible() == false :
		increase_score()
		anscorrect += 1
		if utils.level > 0:
			print(timeremain)
			
			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(true)
			get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(true)
			var i = timeremain
			if utils.learnmode:
				if curtime/10 > 15:
					get_node("Timercoin").set_wait_time(0.16)
				elif curtime/10 > 5:
					get_node("Timercoin").set_wait_time(0.13)
				else:
					get_node("Timercoin").set_wait_time(0.10)
			else:
				get_node("Timercoin").set_wait_time(0.2)
			get_node("Timercoin").start()
			yield(utils.create_timer(1.5),"timeout")
			audio.get_node("SamplePlayer2D").play("coinget")
			yield(utils.create_timer(1),"timeout")
			audio.get_node("SamplePlayer2D").play("coinget")
#	yield(utils.create_timer(1),"timeout")
#	audio.get_node("SamplePlayer2D").play("coinget")


func _on_Timercoin_timeout():
	utils.coin += 1
	
	get_node("Coin/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/popupearn/Label1").set_text(str(utils.coin))
	pass # replace with function body


func _on_next_pressed():
	hidealltick()
	
	if utils.gamemode:
		nextbtngame()
	else:
		
		nextbtnlearn()
	
	pass # replace with function body
	
func hidealltick():
	get_node("ansbox/q" + str(answer)+ "/pos/right").hide()
	get_node("ansbox/q4/pos/wrong").hide()
	get_node("ansbox/q3/pos/wrong").hide()
	get_node("ansbox/q2/pos/wrong").hide()
	get_node("ansbox/q1/pos/wrong").hide()

func common():
	helppressed = true
	if qmax == qno:
		qmax += 1
	if utils.gamemode:
		get_node("down/next").set_opacity(1)
	get_node("Timer").stop()
	get_node("down/whatsapp/Label").show()


func _on_next_released():
	get_node("down/next").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_earncoinnext_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/Popuplevel/notok/earncoinnext").set_scale(Vector2(0.44,0.44))
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
	get_node("gamebtn/rateus").set_scale(btnbign)
	OS.shell_open("https://play.google.com/store/apps/details?id=org.studyquiz.learnenglish")
	pass # replace with function body


func _on_rateus_released():
	get_node("gamebtn/rateus").set_scale(btnsmalln)
	pass # replace with function body


func _on_backmenuearn_pressed():
	if utils.gamemode:
		settingpressed = false
		earncoinpressed = false
		get_node("AnimationPlayer").play("New Anim")
	else:
		yield(utils.create_timer(0.5),"timeout")
		get_tree().reload_current_scene()
		utils.first_time = true
	pass # replace with function body


func _on_no_pressed():
	anspressed = false
	get_node("AnimationPlayer").play("New Anim")
	pass # replace with function body

func level_change():
	if utils.level >= utils.maxlevel:
		utils.level = 1
		utils.again = true
	else:
		utils.level += 1
	
	var p = utils.loadfile()
	var previous = p[0]
	if utils.level > previous:
		p[0] = utils.level
		utils.save(p)
func wrong_answer():
	audio.get_node("SamplePlayer2D").play("wrong1")
	yield(utils.create_timer(1),"timeout")
	if utils.gamemode:
		if score >= 5 and extralifepossible:
			extralifepossible = false
			get_node("AnimationPlayer").play_backwards("New Anim")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animin")
			get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").play("New Anim")
			get_node("ui/CanvasLayer/extralife/extralifetimer").start()
		else:
			gamemodelose()
			gameend()

		
	
func right_answer():
	yield(utils.create_timer(0.5),"timeout")
	audio.get_node("SamplePlayer2D").play("right")

func _on_home_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/menuin/home").set_scale(Vector2(0.44,0.44))
	utils.first_time = true
	yield(utils.create_timer(0.2),"timeout")
	get_tree().reload_current_scene()
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
	answer = int(rand_range(1,5))
	var repeat = true
	if utils.gamemode:
		limit = 2545
	else:
		if utils.level<15:
			limit = 200
		else:
			limit = (utils.level-1)*wordnolimit 
	for i in range(0,4):
		repeat = true
#		ansr[i] = int(rand_range(1,limit+6))
		if i+1 == answer:
				if qno%2 == 0 and qno < 10 and utils.learnmode and wordno >= 0 :
					
					if !previous and qno >= qmax:
						firstprevious = false
						ansr[i] = a[wordno]+1+(utils.level-1)*5
						arp.append(ansr[i])
						wordno -= 1
					else:
							ansr[i] = arp[qno]
							previous = false
				else:
					 
					if randqno == 0:
						select = int(rand_range(1,limit))
						ar.append(select)
					else:
						var interval = int(rand_range(6,20))
						select = select + interval
						if select> limit:
							select = int(rand_range(1,limit))
						
						ar.append(select)
#						var n = 5
#						while repeat and n > 0:
#							var k = 0
#							ar[randqno] = int(rand_range(1,limit+1))
#							var m = 6
#							while ar[k]!=ar[randqno]:
#								k+=1
#							if k == randqno or randqno >= limit:
#								repeat = false
#							n -= 1
					if !previous and qno >= qmax:
						firstprevious = false
						ansr[i] = ar[randqno]
						arp.append(ansr[i])
						randqno += 1
					else:
						ansr[i] = arp[qno]
						previous = false
		oselect = int(rand_range(1,limit))
		var ointerval = int(rand_range(6,20))
		i = 0
		while i < 4:
			if i+1 != answer:
				if ansr[answer-1] != oselect: ##and ansr[answer-1] != oselect:
					ansr[i] = oselect
					i = i + 1
					print("hh")
			else:
				i+=1
			oselect = oselect+ointerval
			if oselect >= limit:
				oselect = int(rand_range(1,limit))
		
#		repeat = true
#		var n = 5
#		while repeat and n>0:
#			var j = 0
#			if i+1 != answer:
#				ansr[i] = int(rand_range(1,limit+6))
#			var m = 6
#			while ansr[j]!=ansr[i] and m>0:
#					j+=1
#					m-=1
#			if j == i:
#					repeat = false
#			n-=1
	if utils.englishtohindi:
		TranslationServer.set_locale("hi")
		tr("hi")
		for i in range(1,5):
			get_node("ansbox/q" + str(i)+ "/Label").add_font_override("font",load("res://font/mangal.fnt"))
	else:
		TranslationServer.set_locale("en")
		tr("en")
		for i in range(1,5):
			get_node("ansbox/q" + str(i)+ "/Label").add_font_override("font",load("res://lob1.fnt"))
	
	get_node("ansbox/q1/Label").set_text(tr("w" + str(ansr[0])))
	get_node("ansbox/q2/Label").set_text(tr("w" + str(ansr[1])))
	get_node("ansbox/q3/Label").set_text(tr("w" + str(ansr[2])))
	get_node("ansbox/q4/Label").set_text(tr("w" + str(ansr[3])))
	
	if qno%2 == 0 and qno < 10 and utils.learnmode and wordno >= 0:
		print("hii")
#		print(a[wordno]+1+(utils.level-1)*5)
#		get_node("ansbox/q" + str(answer)+ "/Label").set_text(tr( "w" + str(a[wordno]+1+(utils.level-1)*5)))
		if utils.englishtohindi:
			TranslationServer.set_locale("en")
			tr("en")
			get_node("qbox/Label").add_font_override("font",load("res://lob.fnt"))
		else:
			TranslationServer.set_locale("hi")
			tr("hi")
			
			get_node("qbox/Label").add_font_override("font",load("res://font/mangal1.fnt"))
		get_node("qbox/Label").set_text(tr( "w" + str(arp[qno])))
		
		
	else:
#		repeat = true
#		ar.append(int(rand_range(1,limit+1)))
#		if randqno > 0:
#			while repeat:
#				var i = 0
#				ar[randqno] = int(rand_range(1,limit+1))
#				while ar[i]!=ar[randqno]:
#					i+=1
#				if i == randqno or randqno >= limit:
#					repeat = false
#		print(ar[randqno])
#		get_node("ansbox/q" + str(answer)+ "/Label").set_text(tr( "w" + str(ar[randqno])))

		if utils.englishtohindi:
			TranslationServer.set_locale("en")
			tr("en")
			get_node("qbox/Label").add_font_override("font",load("res://lob.fnt"))
		else:
			TranslationServer.set_locale("hi")
			tr("hi")
			get_node("qbox/Label").add_font_override("font",load("res://font/mangal1.fnt"))
		get_node("qbox/Label").set_text(tr( "w" + str(arp[qno])))
		
#		answerstr = utils.result[levelfactor + qno*line + 2]
	


func calllevelinfo():
	print(utils.network_error)
	if !utils.network_error:
		if utils.level == 1 and utils.again:
			utils.guideno = 706
			TranslationServer.set_locale("hi_IN")
			tr("hi_IN")
	#		get_node("guide/Label").set_text(tr("gg1"))
			get_node("ui/CanvasLayer/guide/Label5").show()
			get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
		get_node("level/Label").set_text(str(utils.level))
		get_node("ui/CanvasLayer/levelinfo/level").set_text("Level " + str(utils.level))
		fillword()
		audio.get_node("SamplePlayer2D").play("spshield")
	#	get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animin")
	else:
		get_node("ui/CanvasLayer/networkerror").show()


func selectqs():
	qs1 = answer
	qs2 = answer
	while(qs2 == answer):
		qs2 = int(rand_range(1,5))
	print(qs1)
	print(qs2)


func _on_5050_pressed():
	if !helppressed and !fiftypressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/5050").set_scale(btnbign)
		commonlifeline()
		lifelineno = 2
	pass # replace with function body


func showall():
	for i in range(1,5):
		if get_node("ansbox/q" + str(i)).is_visible() == false:
			get_node("ansbox/q" + str(i)).show()



func _on_audience_pressed():
	if !helppressed and !audiencepressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/audience").set_scale(btnbign)
		commonlifeline()
		lifelineno = 1
#	get_node("ansbox/q4/percent/Label1"
	pass # replace with function body

func pecenthide():
	for i in range(1,5):
		get_node("ansbox/q" + str(i)+ "/percent/Label1").hide()
		get_node("ansbox/q" + str(i)+ "/percent/Label2").hide()

func _on_learningmode_pressed():
	mode = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/mode/learningmode").set_scale(btnbignn)
	utils.learnmode = true
	utils.gamemode = false
	get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animout")
#	get_node("ui/CanvasLayer/mode").hide()
	yield(utils.create_timer(0.2),"timeout")
	var g = utils.loadfile()
	if g[707] or (g[710] and utils.level % 10 == 0):
		
		utils.guide = true
		
		TranslationServer.set_locale("hi_IN")
		tr("hi_IN")
#		get_node("guide/Label").set_text(tr("gg1"))
		if g[707]:
			utils.guideno = 707
			get_node("ui/CanvasLayer/guide/Label1").show()
			
		else:
			utils.guideno = 710
			get_node("ui/CanvasLayer/guide/dontshowagain").hide()
			get_node("ui/CanvasLayer/guide/Label6").show()
		get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
	else:
		yield(utils.create_timer(0.15),"timeout")
		calllevelinfo()
	
	pass # replace with function body


func _on_gamemode_pressed():
	mode = false
	first = false
	extralifepossible = true
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/mode/gamemode").set_scale(btnbignn)
	get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animout")
	settingpressed = false
	var g = utils.loadfile()
	if g[709]:
		utils.guideno = 709
		utils.guide = true
		
		TranslationServer.set_locale("hi_IN")
		tr("hi_IN")
#		get_node("guide/Label").set_text(tr("gg1"))
		get_node("ui/CanvasLayer/guide/Label3").show()
		get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
	else:
		yield(utils.create_timer(0.15),"timeout")
		gamestart()
	
	pass # replace with function body


func _on_previous_pressed():
	if utils.learnmode and not nextpressed:
		nextpressed = true
		hidealltick()
		previous = true
		if !firstprevious:
			firstprevious = true
			qmax += 1
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("down/previous").set_scale(btnbign)
		
		get_node("Timer").stop()
		get_node("upper/uperpart2/Label").set_text(str(30))
		if qno != 0:
			qno -= 1
		animout()
		
		select_level()
		yield(utils.create_timer(1.8),"timeout")
		get_node("ansbox/q" + str(answer)+ "/pos/right").show()
	
		nextpressed = false
	pass # replace with function body
func increase_score():
	if utils.learnmode:
		get_node("upper/scorebar/ProgressBar").set_value(get_node("upper/scorebar/ProgressBar").get_value() + 90/15)
		score += 1
		get_node("upper/scorebar/Label1").set_text(str(score))
	else:
		get_node("upper/scorebar/ProgressBar").set_value(get_node("upper/scorebar/ProgressBar").get_value() + 4)
		score += 1
		get_node("upper/scorebar/Label1").set_text(str(score))

func select_game():
	curtime = 0
	if not anspressed:
		get_node("down/next").set_opacity(0.7)
	
	gameadd += 1
	yield(utils.create_timer(0.5),"timeout")
	
	get_node("level/Label").set_text(str(score + 1))
	getq()
	
	animin()
	
	get_node("upper/ProgressBar").set_value(100)
	anspressed = false
	
func nextbtngame():
	if anspressed:
		get_node("Timer").stop()
		get_node("upper/uperpart2/Label").set_text(str(20))
		showall()
		pecenthide()
		anspressed = false
		
		helppressed = false
		yield(utils.create_timer(0.1),"timeout")
		qno += 1
			
		if gameadd % 7 == 0:
			emit_signal("addinter")
		animout()
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(false)
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(false)
		get_node("down/whatsapp/Label").hide()
		
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("down/next").set_scale(Vector2(0.55,0.55))
		select_game()
	#	if qno == qinlevel and !nextpressed:
	#		nextpressed = true
	#		sbox/q" + str(answer)+ "/pos/right").show()
	
func nextbtnlearn():
	if not nextpressed:
		nextpressed = true
		hidealltick()
		get_node("Timer").stop()
		get_node("upper/uperpart2/Label").set_text(str(20))
		qno += 1
		if qno > qmax:
			qmax = qno
		
		helppressed = false
		get_node("nexttime").start()
		yield(utils.create_timer(0.1),"timeout")
		
	
		
		if qno == 9:
			emit_signal("addinter")
		animout()
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D").set_emitting(false)
		get_node("ansbox/q" + str(answer)+ "/coinparticle/Particles2D1").set_emitting(false)
		get_node("down/whatsapp/Label").hide()
		
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("down/next").set_scale(Vector2(0.55,0.55))
		if qno == qinlevel and !last:
			last = true
	#		settingpressed = true
			var s = utils.loadfile()
			get_node("ui/CanvasLayer/Popuplevel/Sprite/gain").set_text(str(anscorrect))
			if utils.level == s[0]:
				if utils.coin >= utils.coinlimit:
					get_node("ui/CanvasLayer/Popuplevel/nextok").show()
				else:
					get_node("ui/CanvasLayer/Popuplevel/notok").show()
			else:
				get_node("ui/CanvasLayer/Popuplevel/tempok").show()
			audio.get_node("SamplePlayer2D").play("winsound")
			get_node("AnimationPlayer").play_backwards("New Anim")
			anspressed = true
			get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
			yield(utils.create_timer(0.5),"timeout")
			
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
			if qno < qmax:
				yield(utils.create_timer(1.5),"timeout")
				get_node("ansbox/q" + str(answer)+ "/pos/right").show()
	

func _on_retrygame_pressed():
	yield(utils.create_timer(0.2),"timeout")
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/gameend/retrygame").set_scale(Vector2(0.44,0.44))
	get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	get_tree().reload_current_scene()
	pass # replace with function body


func _on_skip_pressed():
	if !helppressed and !skippressed:
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("gamebtn/skip").set_scale(btnbign)
		commonlifeline()
		lifelineno = 3
	pass # replace with function body


func _on_paycoin_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/lifeline/ok/paycoin").set_scale(Vector2(0.44,0.44))
	utils.coin -= lifelinecoin
	update_coin()
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	get_node("AnimationPlayer").play("New Anim")
	yield(utils.create_timer(0.5),"timeout")
	if lifelineno == 1:
		audience()
	elif lifelineno == 2:
		fifty50()
	elif lifelineno == 3:
		skip()
	pass # replace with function body

func audience():
		audiencepressed = true
		get_node("gamebtn/audience").set_opacity(0.7)
		lifeline -= 1
		print("hellol")
		var percent = 100
		var arr = []
		arr = [1,2] 
		var third = 0
		var q1p = int(rand_range(30,41))
		percent -= q1p
		var q2p = int(rand_range(25,36))
		percent -= q2p
		arr[0] = int(rand_range(15,21))
		percent -= arr[0]
		arr[1] = percent
		var secondq = answer
		while(secondq == answer):
			secondq = int(rand_range(1,5))
		for i in range(1,5):
			if i == answer:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(q1p))
			elif i == secondq:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(q2p))
			else:
				get_node("ansbox/q" + str(i)+ "/percent/Label1").set_text(str(arr[third]))
				third += 1
			get_node("ansbox/q" + str(i)+ "/percent/Label1").show()
			get_node("ansbox/q" + str(i)+ "/percent/Label2").show()
			helppressed = true


func _on_earncoingame_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	earncoinpressed = true
#	settingpressed = false
	lifelinepressed = false
	get_node("ui/CanvasLayer/lifeline/notok1/earncoingame").set_scale(Vector2(0.44,0.44))
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/popupearn/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_backlifeline_pressed():
	settingpressed = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animout")
	lifelinepressed = false
	pass # replace with function body

func gameend():
#	if utils.gamemode:
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animin")
		audio.get_node("SamplePlayer2D").play("game over")
		var s = utils.loadfile()
		highscore = s[702]
		if score > highscore:
			highscore = score 
			s[702] = score
		utils.save(s)
		get_node("ui/CanvasLayer/gameend/score/current/Sprite/Label").set_text(str(score))
		get_node("ui/CanvasLayer/gameend/score/high/Sprite/Label").set_text(str(highscore))
#		audio.get_node("SamplePlayer2D").play("times up")
		
		anspressed = true
		
		yield(utils.create_timer(0.5),"timeout")
		
		if score > 15:
			stargame = 3
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Excellent")
		elif score > 10:
			stargame = 2
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Good")
		elif score > 3:
			stargame = 1
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Not Bad")
		else:
			stargame = 1
			get_node("ui/CanvasLayer/gameend/Labelgreet1").set_text("Poor")
		
		
		get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim")
		get_node("ui/CanvasLayer/gameend/AnimationPlayer 2").play("New Anim")
		
		yield(utils.create_timer(0.5),"timeout")
		if  stargame >= 2:
			print("hii")
			get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim (2)")
		yield(utils.create_timer(0.5),"timeout")
		if  stargame >= 3:
			print("hii")
			get_node("ui/CanvasLayer/gameend/AnimationPlayer").play("New Anim (3)")


func gamestart():
	if !utils.network_error:
		utils.gamemode = true
		utils.learnmode = false
		settingpressed = false
		get_node("down/previous").set_opacity(0.7)
		get_node("gamebtn").show()
		get_node("AnimationPlayer").play("New Anim")
#		audio.get_node("SamplePlayer2D").play("start1")
		audio.get_node("SamplePlayer2D").play("spshield")
		select_game()
	else:
		get_node("ui/CanvasLayer/networkerror").show()

func set_lifeline():
	get_node("ui/CanvasLayer/lifeline/coin/Sprite/Label").set_text(str(utils.coin))
	get_node("ui/CanvasLayer/lifeline/liferemain/Sprite/Label").set_text(str(lifeline))

func commonlifeline():
		lifelinepressed = true
		settingpressed = true
		set_lifeline()
		if utils.coin >= lifelinecoin:
			get_node("ui/CanvasLayer/lifeline/ok").show()
			get_node("ui/CanvasLayer/lifeline/notok1").hide()
		else:
			get_node("ui/CanvasLayer/lifeline/notok1").show()
			get_node("ui/CanvasLayer/lifeline/ok").hide()
		if lifeline == 0:
			get_node("ui/CanvasLayer/lifeline/notok1").hide()
			get_node("ui/CanvasLayer/lifeline/ok").hide()
		get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/lifeline/AnimationPlayer1").play("animin")
		
func fifty50():
	fiftypressed = true
	get_node("gamebtn/5050").set_opacity(0.7)
	lifeline -= 1
	selectqs()
	yield(utils.create_timer(0.5),"timeout")
	get_node("ansbox/q1").hide()
	get_node("ansbox/q2").hide()
	get_node("ansbox/q3").hide()
	get_node("ansbox/q4").hide()
	
	get_node("ansbox/q" + str(answer)).show()
	get_node("ansbox/q" + str(qs2)).show()
	helppressed = true

func skip():
	skippressed = true
	get_node("gamebtn/skip").set_opacity(0.7)
	lifeline -= 1
	anspressed = true
	get_node("down/next").set_opacity(1)
	helppressed = true

func _on_backtouifromgame_pressed():
	
	yield(utils.create_timer(0.2),"timeout")
	utils.first_time = true
	get_node("ui/CanvasLayer/gameend/backtoui").set_scale(Vector2(0.44,0.44))
	get_node("ui/CanvasLayer/gameend/AnimationPlayer1").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
	pass # replace with function body


func _on_previous_released():
	get_node("down/previous").set_scale(btnsmalln)
	pass # replace with function body


func _on_audience_released():
	get_node("gamebtn/audience").set_scale(btnsmalln)
	pass # replace with function body


func _on_5050_released():
	
	get_node("gamebtn/5050").set_scale(btnsmalln)
	pass # replace with function body


func _on_skip_released():
	
	get_node("gamebtn/skip").set_scale(btnsmalln)
	pass # replace with function body


func _on_changelevel_released():
	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_earncoinnext_released():
	get_node("ui/CanvasLayer/Popuplevel/notok/earncoinnext").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_retrygame_released():
	get_node("ui/CanvasLayer/gameend/retrygame").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_backtoui_released():
	get_node("ui/CanvasLayer/gameend/backtoui").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_earncoingame_released():
	get_node("ui/CanvasLayer/lifeline/notok1/earncoingame").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_paycoin_released():
	get_node("ui/CanvasLayer/lifeline/ok/paycoin").set_scale(Vector2(0.4,0.4))
	pass # replace with function body


func _on_gamemode_released():
	get_node("ui/CanvasLayer/mode/gamemode").set_scale(btnsmallnn)
	pass # replace with function body


func _on_learningmode_released():
	get_node("ui/CanvasLayer/mode/learningmode").set_scale(btnsmallnn)
	pass # replace with function body



func _on_changeleveltemp_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	yield(utils.create_timer(0.2),"timeout")
#	get_node("ui/CanvasLayer/Popuplevel/nextok/changelevel").set_scale(Vector2(0.44,0.44))
#	utils.coin -= utils.coinlimit
#	update_coin()
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
#	level_change()
	if utils.level >= utils.maxlevel:
		utils.level = 1
		utils.again = true
	else:
		utils.level += 1
	yield(utils.create_timer(0.5),"timeout")
	utils.indirect = true
	get_tree().reload_current_scene()
	pass # replace with function body
	
func gamemodelose():
	gameend = true
	settingpressed = true
	audiencepressed = true
	fiftypressed = true
	skippressed = true


func _on_nexttime_timeout():
	nextpressed = false
	pass # replace with function body

func fillword():
	get_node("ui/CanvasLayer/levelinfo/Container/wnumber").set_text(str(wordno) + "." )
	TranslationServer.set_locale("en")
	tr("en")
	get_node("ui/CanvasLayer/levelinfo/Container/wenglish").set_text(tr( "w" + str(wordno + (utils.level-1)*5)))
	get_node("ui/CanvasLayer/levelinfo/Container/senglish").set_text(tr( "ws" + str(wordno + (utils.level-1)*5)))
	TranslationServer.set_locale("hi_IN")
	tr("hi_IN")
	get_node("ui/CanvasLayer/levelinfo/Container/whindi").set_text(tr( "w" + str(wordno + (utils.level-1)*5)))
	get_node("ui/CanvasLayer/levelinfo/Container/shindi").set_text(tr( "ws" + str(wordno + (utils.level-1)*5)))
	
func _on_nextw_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/levelinfo/button/nextw").set_scale(Vector2(0.5,0.5))
	wordno = wordno+1
	if wordno == wordnolimit +1:
		emit_signal("addinter")
		wordno = 4
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer").play("animout")
		get_node("AnimationPlayer").play("New Anim")
		select_level()
		first = false
		get_node("down/AnimationPlayer").play("New Anim")
		settingpressed = false
	else:
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer 2").play("New Anim")
		yield(utils.create_timer(0.3),"timeout")
		audio.get_node("SamplePlayer2D").play("swap")
		fillword()
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer 2").play("New Anim (2)")
#	if not utils.fileobj[710]:
#		var view_port = get_viewport()
#		view_port.queue_screen_capture()
#		
#		# wait two frames for the capture be ready
#		yield(get_tree(), "idle_frame")
#		yield(get_tree(), "idle_frame")
#		
#		# The file must be saved at user:// root
#		var image_save_path = OS.get_data_dir() + "/tmp.png"
#		
#		# actually takes the caputure
#		var capture = view_port.get_screen_capture()
#		# saves the capture as user://tmp.png
#		capture.save_png(image_save_path)
#		utils.fileobj[710] = true
#		utils.save(utils.save)
	pass # replace with function body


func _on_nextw_released():
	get_node("ui/CanvasLayer/levelinfo/button/nextw").set_scale(Vector2(0.45,0.45))
	pass # replace with function body


func _on_previousw_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/levelinfo/button/previousw").set_scale(Vector2(0.5,0.5))
	wordno = wordno-1
	if wordno > 0:
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer 2").play("New Anim")
		yield(utils.create_timer(0.3),"timeout")
		fillword()
		get_node("ui/CanvasLayer/levelinfo/AnimationPlayer 2").play("New Anim (2)")
	pass # replace with function body


func _on_previousw_released():
	get_node("ui/CanvasLayer/levelinfo/button/previousw").set_scale(Vector2(0.5,0.5))
	pass # replace with function body


func _on_sentencemode_pressed():
	mode = false
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/mode/sentencemode").set_scale(btnbignn)
	utils.learnmode = false
	utils.gamemode = false
	get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.2),"timeout")
	var g = utils.loadfile()
	if g[708]:
		utils.guideno = 708
		utils.guide = true
		
		TranslationServer.set_locale("hi_IN")
		tr("hi_IN")
#		get_node("guide/Label").set_text(tr("gg1"))
		get_node("ui/CanvasLayer/guide/Label2").show()
		get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animin")
	else:
		yield(utils.create_timer(0.15),"timeout")
		callsentencemode()
	
	pass # replace with function body
	
func callsentencemode():
	if !utils.network_error:
		set_opacity(0)
		get_node("ui/CanvasLayer/sentencemode/level").set_text("Level " + str(utils.sentencelevel))
		fillsentence()
		audio.get_node("SamplePlayer2D").play("spshield")
	#	get_node("AnimationPlayer").play_backwards("New Anim")
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer").play("animin")
	else:
		get_node("ui/CanvasLayer/networkerror").show()
func fillsentence():
	get_node("ui/CanvasLayer/sentencemode/Container/wnumber").set_text(str(sentenceno) + "." )
	if utils.englishtohindi:
		get_node("ui/CanvasLayer/sentencemode/sentence").set_text("English")
		get_node("ui/CanvasLayer/sentencemode/sentence1").set_text("Hindi")
		TranslationServer.set_locale("en")
		tr("en")
		get_node("ui/CanvasLayer/sentencemode/Container/senglish").set_text(tr( "wss" + str(sentenceno + (utils.sentencelevel-1)*20)))
		TranslationServer.set_locale("hi")
		tr("hi")
		get_node("ui/CanvasLayer/sentencemode/Container2/shindi").set_text(tr( "wss" + str(sentenceno + (utils.sentencelevel-1)*20)))
		
#	get_node("ui/CanvasLayer/sentencemode/Container/senglish").add_font_override("font",load("res://lob.fnt"))
	else:
		get_node("ui/CanvasLayer/sentencemode/sentence").set_text("Hindi")
		get_node("ui/CanvasLayer/sentencemode/sentence1").set_text("English")
		TranslationServer.set_locale("en")
		tr("en")
		get_node("ui/CanvasLayer/sentencemode/Container2/senglish1").set_text(tr( "wss" + str(sentenceno + (utils.sentencelevel-1)*20)))
		TranslationServer.set_locale("hi")
		tr("hi")
		get_node("ui/CanvasLayer/sentencemode/Container/shindi1").set_text(tr( "wss" + str(sentenceno + (utils.sentencelevel-1)*20)))
#		get_node("ui/CanvasLayer/sentencemode/Container/senglish").add_font_override("font",load("res://font/mangal.fnt"))
	
	
	

func _on_nexts_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/sentencemode/button/nexts").set_scale(Vector2(0.5,0.5))
	sentenceno +=1
	if showpressed:
		showpressed = false
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer3").play_backwards("New Anim")
	if sentenceno % 7 == 0:
			emit_signal("addinter")
	if sentenceno == 21:
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer").play("animout")
		sentenceno = 1
		if utils.sentencelevel >= utils.maxslevel:
			utils.sentencelevel = 1
		else:
			utils.sentencelevel += 1
		var p = utils.loadfile1()
		if utils.sentencelevel > p[0]:
			p[0] = utils.sentencelevel
		p[utils.sentencelevel-1] = 3
		utils.save1(p)
		yield(utils.create_timer(0.3),"timeout")
		callsentencemode()
	else:
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer 2").play("New Anim")
		yield(utils.create_timer(0.5),"timeout")
		audio.get_node("SamplePlayer2D").play("swap")
		fillsentence()
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer 2").play("New Anim (2)")
	pass # replace with function body


func _on_previouss_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("ui/CanvasLayer/sentencemode/button/previouss").set_scale(Vector2(0.5,0.5))
	if sentenceno > 1:
		sentenceno = sentenceno - 1
	if sentenceno > 0:
		
		if showpressed:
			showpressed = false
			get_node("ui/CanvasLayer/sentencemode/AnimationPlayer3").play_backwards("New Anim")
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer 2").play("New Anim")
		yield(utils.create_timer(0.3),"timeout")
		fillsentence()
		get_node("ui/CanvasLayer/sentencemode/AnimationPlayer 2").play("New Anim (2)")
	pass # replace with function body


func _on_nexts_released():
	get_node("ui/CanvasLayer/sentencemode/button/nexts").set_scale(Vector2(0.45,0.45))
	pass # replace with function body


func _on_previouss_released():
	get_node("ui/CanvasLayer/sentencemode/button/previouss").set_scale(Vector2(0.45,0.45))
	pass # replace with function body


func _on_show_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	showpressed = true
	get_node("ui/CanvasLayer/sentencemode/button/show").set_scale(Vector2(0.48,0.48))
	get_node("ui/CanvasLayer/sentencemode/AnimationPlayer3").play("New Anim")
	pass # replace with function body


func _on_crossguide_pressed():
	get_node("ui/CanvasLayer/guide/AnimationPlayer").play("animout")
	pass # replace with function body


func _on_Button_pressed():
	if !utils.network_error:
		get_node("ui/CanvasLayer/networkerror").hide()
		audio.get_node("SamplePlayer2D").play("spshield")
#		get_node("ui/CanvasLayer/mode").show()
#		get_node("AnimationPlayer").play("New Anim")
		get_node("ui/CanvasLayer/mode").show()
		get_node("ui/CanvasLayer/mode/AnimationPlayer").play("animin")
	pass # replace with function body
	
func _on_guideend():
	if utils.guideno == 707 or utils.guideno == 710:
		calllevelinfo()
	if utils.guideno == 709:
		gamestart()
	if utils.guideno == 708:
		callsentencemode()


func _on_sentencemode_released():
	get_node("ui/CanvasLayer/mode/sentencemode").set_scale(btnsmallnn)
	
	pass # replace with function body

func _on_englishhindi():
	if utils.englishtohindi:
		get_node("ui/CanvasLayer/sentencemode/Container2/shindi").show()
		get_node("ui/CanvasLayer/sentencemode/Container/senglish").show()
		get_node("ui/CanvasLayer/sentencemode/Container/shindi1").hide()
		get_node("ui/CanvasLayer/sentencemode/Container2/senglish1").hide()
	else:
		get_node("ui/CanvasLayer/sentencemode/Container2/shindi").hide()
		get_node("ui/CanvasLayer/sentencemode/Container/senglish").hide()
		get_node("ui/CanvasLayer/sentencemode/Container/shindi1").show()
		get_node("ui/CanvasLayer/sentencemode/Container2/senglish1").show()

func _on_show_released():
	get_node("ui/CanvasLayer/sentencemode/button/show").set_scale(Vector2(0.45,0.45))
	pass # replace with function body


func _on_extralifetimer_timeout():
	extralifetime -= 1
	get_node("ui/CanvasLayer/extralife/ltime/Label1").set_text(str(extralifetime))
	if extralifetime <= 0:
		endextralife()
	pass # replace with function body

func endextralife():
		get_node("ui/CanvasLayer/extralife/extralifetimer").stop()
		get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").stop(true)
		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
		gamemodelose()
		gameend()





func _on_Node2D_2_lifegain():
	print("100000")
	get_node("ui/CanvasLayer/extralife/extralifetimer").stop()
	get_node("ui/CanvasLayer/extralife/AnimationPlayer 2").stop(true)
	if utils.extralifegain:
		utils.extralifegain = false
		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
		get_node("AnimationPlayer").play("New Anim")
		yield(utils.create_timer(0.3),"timeout")
		get_node("Particles2D").set_emitting(true)
		audio.get_node("SamplePlayer2D").play("spshield")
		yield(utils.create_timer(1),"timeout")
		get_node("Particles2D").set_emitting(false)
	else:
		get_node("ui/CanvasLayer/extralife/AnimationPlayer").play("animout")
		gamemodelose()
		gameend()
	pass # replace with function body
