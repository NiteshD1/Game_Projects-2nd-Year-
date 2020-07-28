extends Node2D

signal playerout
var curtime = 0
var answer
var starlevel
var curvelevel
var curveno
var no
var arr
var schange = 0
var anspressed = true

var ans = "default"

signal addinter
onready var ui = preload("res://scene/ui.tscn")

onready var play = preload("res://image/play.png")
onready var pause = preload("res://image/pause.png")
onready var gball = preload("res://image/greenball.png")
onready var gem = preload("res://image/invisible.png")
onready var player = preload("res://image/player.png")
onready var star = preload("res://image/star1.png")
onready var square = preload("res://image/square.png")
#export(PackedScene) var Ball







onready var Ball = preload("res://scene/Ball.tscn")

var gemp = 0
var canout = true

func _ready():
	print(utils.level)
	get_node("Question/Label 2").set_text(str(utils.level))
	get_node("Question/AnimationPlayer 2").play("New Anim")
	animin()

	select_level()
#	audio.get_node("bg").play()
	randomize()

	
















#
func _on_backretry_pressed():
	yield(utils.create_timer(0.5),"timeout")
	audio.get_node("SamplePlayer2D").play("hit")
	set_opacity(0.2)
	get_node("ui").set_opacity(0.2)
	get_node("ui/CanvasLayer/Popupdied/AnimationPlayer1").play("animout")
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play("animin")
#	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
#	get_tree().set_pause(true)
#	get_node("ui/CanvasLayer/Popuprestart").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#	$ui/Node2D.set_pause_mode(Node.PAUSE_MODE_PROCESS)
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
	get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animout")
	yield(utils.create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
	
	pass # replace with function body






func select_level():
	if utils.level == 3:
		utils.qtime = 60
#		get_node("Question/Label").set_text("Complete the puzzle with correct number :")
		answer = 9
		curveno = 3
		no = 4
		arr = [4,9,7,12,1,4,1,4,2,5,6,0]
	if utils.level ==2:
		utils.qtime = 60
		answer = 19
		curveno = 1
		no = 6
		arr = [5,7,11,13,17,0]
	if utils.level == 1:
		utils.qtime = 60
		answer = 16
		curveno = 1
		no = 9
		arr = [0,25,36,49,64,81,1,4,9]
	if utils.level == 4:
		utils.qtime = 60
		answer = 39
		curveno = 1
		no = 6
		arr = [3,5,8,13,22,0]
	if utils.level == 5:
		utils.qtime = 60
		answer = 4
		curveno = 1
		no = 16
		arr = [7,3,6,2,4,5,8,2,1,1,2,4,0,1,2,4]
	if utils.level == 6:
		utils.qtime = 55
		answer = 6
		curveno = 1
		no = 9
		arr = [9,1,5,3,7,0,2,4,8]
	if utils.level == 7:
		utils.qtime = 55
		answer = 40
		curveno = 1
		no = 5
		arr = [26,28,31,35,0]
	if utils.level == 8:
		utils.qtime = 55
		answer = 16
		curveno = 1
		no = 10
		arr = [16,2,15,4,13,7,10,11,6,0]
	if utils.level == 9:
		utils.qtime = 55
		answer = 7
		curveno = 1
		no = 7
		arr = [9,8,4,0,6,2,2]
	if utils.level == 10:
		utils.qtime = 55
		answer = 13
		curveno = 4
		no = 6
		arr = [9,11,13,15,17,7,7,10,13,16,19,4,11,16,21,26,31,6,5,9,0,17,21,1]
	if utils.level == 11:
		utils.qtime = 50
		answer = 3
		curveno = 4
		no = 3
		arr = [7,3,5,8,6,7,2,10,6,4,2,0]
	if utils.level == 12:
		utils.qtime = 50
		answer = 1
		curveno = 1
		no = 9
		arr = [2,8,9,4,0,6,3,3,2]
	if utils.level == 13:
		utils.qtime = 50
		answer = 1
		curveno = 1
		no = 8
		arr = [3,6,4,9,4,6,8,0]
	if utils.level == 14:
		utils.qtime = 50
		answer = 4
		curveno = 1
		no = 9
		arr = [5,8,11,12,14,10,7,3,0]
	if utils.level == 15:
		utils.qtime = 50
		answer = 253
		curveno = 1
		no = 7
		arr = [1,5,13,29,0,125,61,29]
	if utils.level == 16:
		utils.qtime = 45
		answer = 51
		curveno = 1
		no = 5
		arr = [6,9,15,27,0]
	if utils.level == 17:
		utils.qtime = 45
		answer = 2 
		curveno = 1
		no = 9
		arr = [10,8,13,6,16,4,19,0,22]
	if utils.level == 18:
		utils.qtime = 45
		answer = 6 
		curveno = 1
		no = 9
		arr = [3,1,4,9,2,7,1,5,0]
	if utils.level == 19:
		utils.qtime = 45
		answer = 10
		curveno = 3
		no = 6
		arr = [2,7,1,3,4,9,3,5,2,4,3,5,9,2,3,4,6,0]
		schange = 0.6
	if utils.level == 20:
		utils.qtime = 45
		answer = 23
		curveno = 1
		no = 9
		arr = [2,7,17,19,11,3,5,13,0]
	if utils.level == 21:
		utils.qtime = 40
		answer = 10
		curveno = 3
		no = 6
		arr = [11,9,2,6,1,4,10,5,7,0,1,10,1,4,9,1,2,14]
	if utils.level == 22:
		utils.qtime = 40
		answer = 1143
		curveno = 1
		no = 6
		arr = [195,383,575,763,955,0]
	if utils.level == 23:
		utils.qtime = 40
		answer = 6
		curveno = 4
		no = 4
		arr = [1,3,7,2,6,5,1,6,5,2,0,4,7,8,8,8]
	if utils.level == 24:
		utils.qtime = 40
		answer = 4
		curveno = 3
		no = 4
		arr = [1,4,3,4,7,6,7,10,3,0,5,6]
	if utils.level == 25:
		utils.qtime = 40
		answer = 4
		curveno = 3
		no = 6
		arr = [1,6,2,3,4,8,4,9,8,2,11,6,10,7,5,5,2,0]
		schange = 0.6
	if utils.level == 26:
		utils.qtime = 40
		answer = 5
		curveno = 3
		no = 3
		arr = [5,3,7,6,10,2,5,0,5]
	if utils.level == 27:
		utils.qtime = 40
		answer = 22
		curveno = 3
		no = 3
		arr = [3,7,18,2,8,12,3,9,0]
	if utils.level == 28:
		utils.qtime = 40
		answer = 4
		curveno = 4
		no = 4
		arr = [10,1,6,3,14,9,1,4,7,1,4,2,12,3,0,5]
	if utils.level == 29:
		utils.qtime = 40
		answer = 5
		curveno = 4
		no = 7
		arr = [9,2,1,4,7,3,2,6,3,8,4,5,1,7,8,7,3,6,2,9,1,5,1,3,2,8,4,0]
	if utils.level == 30:
		utils.qtime = 40
		answer = 7
		curveno = 1
		no = 15
		arr = [1,7,9,3,6,3,5,4,2,5,7,2,2,6,0]
	if utils.level == 31:
		utils.qtime = 35
		answer = 22
		curveno = 5
		no = 5
		arr = [4,6,2,1,12,3,5,11,7,9,8,12,0,14,24,7,11,13,8,21,1,1,9,6,3]
	if utils.level == 32:
		utils.qtime = 35
		answer = 21
		curveno = 1
		no = 5
		arr = [1,5,9,15,0]
	if utils.level == 33:
		utils.qtime = 35
		answer = 6
		curveno = 4
		no = 4
		arr = [4,9,3,12,7,13,6,12,5,9,3,2,7,8,5,21,0,16,5,12]
	if utils.level == 34:
		utils.qtime = 35
		answer = 7
		curveno = 4
		no = 5
		arr = [3,12,6,15,18,2,7,5,9,12,11,4,8,15,12,8,3,4,11,0]
	
	if utils.level == 35:
		utils.qtime = 35
		answer = 96
		curveno = 1
		no = 5
		arr = [32,45,60,77,0]
	if utils.level == 36:
		utils.qtime = 35
		answer = 9
		curveno = 1
		no = 10
		arr = [3,5,1,4,4,7,3,5,5,0]
	if utils.level == 37:
		utils.qtime = 35
		answer = 3
		curveno = 1
		no = 9
		arr = [1,2,3,4,1,2,5,6,0]
	if utils.level == 38:
		utils.qtime = 35
		answer = 13
		curveno = 3
		no = 6
		arr = [7,3,6,9,2,17,5,2,4,10,6,11,9,4,6,7,5,0]
	if utils.level == 39:
		utils.qtime = 35
		answer = 6
		curveno = 3
		no = 6
		arr = [14,4,8,7,2,4,6,2,12,3,1,6,12,4,10,0,2,5]
	if utils.level == 40:
		utils.qtime = 35
		answer = 1
		curveno = 4
		no = 4
		arr = [7,2,9,5,3,10,7,13,6,1,5,7,4,5,0,9]
	if utils.level == 41:
		utils.qtime = 30
		answer = 9
		curveno = 3
		no = 3
		arr = [5,2,3,6,10,4,6,0,15]
	if utils.level == 42:
		utils.qtime = 30
		answer = 26
		curveno = 1
		no = 10
		arr = [8,12,15,17,21,24,0,30,33,35]
	if utils.level == 43:
		utils.qtime = 30
		answer = 4
		curveno = 3
		no = 4
		arr = [1,7,3,22,9,2,6,21,3,8,5,0]
	
	if utils.level == 44:
		utils.qtime = 30
		answer = 6
		curveno = 5
		no = 4
		arr = [3,1,7,2,6,5,2,2,3,7,4,1,9,6,9,4,9,12,0,3]
	if utils.level == 45:
		utils.qtime = 30
		answer = 10
		curveno = 3
		no = 3
		arr = [7,6,3,2,4,1,9,0,4]
	if utils.level == 46:
		utils.qtime = 30
		answer = 37
		curveno = 1
		no = 6
		arr = [72,69,64,57,48,0]
	if utils.level == 47:
		utils.qtime = 30
		answer = 11
		curveno = 1
		no = 9
		arr = [9,20,2,0,15,7,4,13,5]
	if utils.level == 48:
		utils.qtime = 30
		answer = 42
		curveno = 1
		no = 7
		arr = [2,4,6,0,26,16,10]
	if utils.level == 49:
		utils.qtime = 30
		answer = 3
		curveno = 1
		no = 9
		arr = [5,4,7,6,6,12,7,0,2]
	if utils.level == 50:
		utils.qtime = 30
		answer = 42
		curveno = 1
		no = 10
		arr = [5,7,3,2,8,5,9,6,4,0]
	if utils.level == 51:
		utils.qtime = 25
		answer = 2
		curveno = 4
		no = 3
		arr = [3,4,1,10,12,8,2,2,5,5,6,0]
	if utils.level == 52:
		utils.qtime = 25
		answer = 13
		curveno = 1
		no = 9
		arr = [5,8,11,10,9,4,7,6,0]
	if utils.level == 53:
		utils.qtime = 25
		answer = 90
		curveno = 1
		no = 6
		arr = [23,38,45,64,67,0]
	if utils.level == 54:
		utils.qtime = 25
		answer = 3
		curveno = 1
		no = 9
		arr = [5,4,1,2,2,6,3,4,0]
	if utils.level == 55:
		answer = 29
		curveno = 4
		no = 3
		arr = [6,4,34,8,5,53,11,3,47,9,2,0]
	if utils.level == 56:
		answer = 6
		curveno = 1
		no = 9
		arr = [11,2,18,0,14,5,12,5,2]
	if utils.level == 57:
		answer = 2
		curveno = 1
		no = 9
		arr = [6,8,3,1,4,0,7,9,5]
	if utils.level == 58:
		answer = 2
		curveno = 1
		no = 9
		arr = [9,3,3,3,0,4,8,6,2]
	if utils.level == 59:
		answer = 2
		curveno = 4
		no = 4
		arr = [7,4,8,2,6,5,]
	if utils.level == 60:
		answer = 10
		curveno = 1
		no = 12
		arr = [1,1,1,2,3,2,11,5,6,4,6,0]
	if utils.level == 61:
		answer = 10
		curveno = 1
		no = 16
		arr = [7,6,5,4,2,1,4,5,4,7,3,8,0,7,9,6]
	if utils.level == 62:
		answer = 3
		curveno = 3
		no = 4
		arr = [6,8,5,7,8,7,2,4,7,0,2,9]
	if utils.level == 63:
		answer = 8
		curveno = 1
		no = 9
		arr = [15,10,5,9,0,8,6,7,34]
	if utils.level == 64:
		answer = 9
		curveno = 1
		no = 16
		arr = [5,2,3,7,9,3,3,6,4,1,3,5,0,7,1,8]
	if utils.level == 65:
		answer = 52
		curveno = 3
		no = 3
		arr = [45,16,28,15,32,64,40,0,8]
	if utils.level == 66:
		answer = 9
		curveno = 3
		no = 6
		arr = [7,27,11,9,18,3,6,33,16,6,15,4,5,21,0,8,30,12]
	if utils.level == 67:
		answer = 3
		curveno = 3
		no = 4
		arr = [14,9,2,6,5,11,11,4,13,8,0,7]
	if utils.level == 68:
		answer = 6
		curveno = 3
		no = 5
		arr = [5,2,7,4,6,4,8,5,2,9,2,11,4,0,1]
	if utils.level == 69:
		answer = 5
		curveno = 3
		no = 5
		arr = [9,8,4,4,9,11,5,3,3,10,7,16,0,6,12]
	if utils.level == 70:
		answer = 51
		curveno = 1
		no = 12
		arr = [46,85,12,71,48,13,81,54,63,53,0,61]
	if utils.level == 71:
		answer = 11
		curveno = 1
		no = 9
		arr = [4,9,20,21,0,4,6,10,8]
	if utils.level == 72:
		answer = 6
		curveno = 1
		no = 9
		arr = [3,11,4,2,0,23,4,7,13]
	if utils.level == 73:
		answer = 4
		curveno = 1
		no = 16
		arr = [4,3,2,8,2,1,7,3,8,2,8,2,0,5,2,1]
	if utils.level == 74:
		answer = 2
		curveno = 3
		no = 5
		arr = [4,2,8,1,3,7,4,2,2,2,6,8,0,4,3]
	if utils.level == 75:
		answer = 236
		curveno = 1
		no = 12
		arr = [6,2,5,16,3,10,18,6,60,0,15,34]
	if utils.level == 76:
		answer = 3
		curveno = 1
		no = 9
		arr = [5,21,2,6,0,55,8,4,20]
	if utils.level == 77:
		answer = 4
		curveno = 3
		no = 4
		arr = [6,7,5,41,7,3,8,31,0,4,4,20]
	if utils.level == 78:
		answer = 4
		curveno = 1
		no = 9
		arr = [2,5,1,2,0,20,2,3,13]
	if utils.level == 79:
		answer = 7
		curveno = 1
		no = 9
		arr = [3,6,3,7,0,1,8,10,3]
	if utils.level == 80:
		answer = 14
		curveno = 3
		no = 4
		arr = [17,25,5,13,18,31,7,20,11,21,4,0]
	if utils.level == 81:
		answer = 14
		curveno = 3
		no = 3
		arr = [5,2,3,11,9,8,18,17,0]
	if utils.level == 82:
		answer = 7
		curveno = 1
		no = 9
		arr = [6,13,9,2,0,12,3,11,13]
	if utils.level == 83:
		answer = 7
		curveno = 3
		no = 3
		arr = [6,11,17,3,5,8,4,0,11]
	if utils.level == 84:
		answer = 23
		curveno = 1
		no = 9
		arr = [2,3,5,13,0,19,17,7,11]
	
	get_node("Timer").start()
	draw_curve()
	get_node("ui/CanvasLayer/Popup2/Container/Label4").set_text(":  " + str(answer))  
#	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(r,g,b))
	get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(utils.qtime/60) +":00")








func _on_Timer_timeout():
	
	curtime += 1
	var temptime = int(utils.qtime - curtime)
	var minute = temptime/60
	var second = temptime % 60
	if second < 10:
		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":0" + str(second))
	else:
		get_node("ui/CanvasLayer/Clock/Label").set_text("0" + str(minute) +":" + str(second))
	if curtime == utils.qtime:
		emit_signal("playerout")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()
	if curtime >= utils.qtime - 5 and curtime <= utils.qtime:
		audio.get_node("SamplePlayer2D").play("times up")
	pass # replace with function body














func _on_btndone_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	if answer == int(get_node("ui/CanvasLayer/Label").get_text()):
		yield(utils.create_timer(1),"timeout")
		audio.get_node("SamplePlayer2D").play("winsound")
		get_node("Question").hide()
		get_node("ui/CanvasLayer/Label").hide()
		animout()
		get_node("ui/CanvasLayer/Popuplevel/AnimationPlayer1").play("animin")
		get_node("ui/CanvasLayer/Popuplevel/anim/AnimationPlayer").play("New Anim")
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
	get_node("ui/CanvasLayer/Button/AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/Clock/AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/Keyboard/AnimationPlayer").play("New Anim")
	get_node("ui/CanvasLayer/Answerbtn/AnimationPlayer").play("New Anim")

func animout():
	get_node("ui/CanvasLayer/Button/AnimationPlayer").play_backwards("New Anim")
	get_node("ui/CanvasLayer/Clock/AnimationPlayer").play_backwards("New Anim")
	get_node("ui/CanvasLayer/Keyboard/AnimationPlayer").play_backwards("New Anim")
	get_node("ui/CanvasLayer/Answerbtn/AnimationPlayer").play_backwards("New Anim")







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

func draw_curve():
	audio.get_node("SamplePlayer2D").play("spshield")
	var choose = int(rand_range(0,4))
	var waittime = rand_range(0.1,0.4)
	var ball 
	if choose == 0:
		ball = square
	if choose == 1:
		ball= gem
	if choose == 2:
		ball = star
	if choose == 3:
		ball = player
	
	var cur = utils.level
	var curve = utils.getcurve(str(cur))
	if schange > 0:
		get_node("Question/Path2D0").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D1").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D2").set_scale(Vector2(schange,schange))
		get_node("Question/Path2D3").set_scale(Vector2(schange,schange))
	if curveno == 1:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/mid").get_global_pos())
	if curveno == 2:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/tmid").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/bmid").get_global_pos())
	if curveno == 3:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/bmid").get_global_pos())
	if curveno == 4:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/bleft").get_global_pos())
		get_node("Question/Path2D3").set_global_pos(get_node("Question/Container/bright").get_global_pos())
	if curveno == 5:
		get_node("Question/Path2D0").set_global_pos(get_node("Question/Container/left").get_global_pos())
		get_node("Question/Path2D1").set_global_pos(get_node("Question/Container/right").get_global_pos())
		get_node("Question/Path2D2").set_global_pos(get_node("Question/Container/mid").get_global_pos())
		get_node("Question/Path2D3").set_global_pos(get_node("Question/Container/bleft").get_global_pos())
		get_node("Question/Path2D4").set_global_pos(get_node("Question/Container/bright").get_global_pos())
		
	for i in range(0,curveno):
		if curve != null:
			get_node("Question/Path2D"+str(i)).set_curve(curve)
		for j in range(0,no):
			print(j)
			
			var item =Ball.instance()
			
			get_node("Question/Path2D"+str(i)).add_child(item)
			item.get_child(0).set_texture(ball)
			if schange > 0:
				item.set_scale(Vector2(1.3,1.3))
			item.set_pos(get_node("Question/Path2D"+str(i)).get_curve().get_point_pos(j))
			if arr[i*no + j] == 0:
				get_node("ui/CanvasLayer/Label").set_pos(item.get_child(3).get_global_pos())
			else:
				item.get_child(1).set_text(str(arr[i*no + j]))
#			item.get_child(2).play("New Anim")
			print(i*no + j)
			yield(utils.create_timer(waittime),"timeout")
	
	
		

#func _on_TouchScreenButton_pressed():
#	audio.get_node("SamplePlayer2D").play("hit")
#	if get_node("ui/CanvasLayer/TouchScreenButton").normal == play:
#		get_node("ui/CanvasLayer/Popup/AnimationPlayer").play("animout")
#			audio.get_node("bg").play()
#		get_tree().set_pause(false)
#		_on_ui_qshow()
#		get_node("ui/CanvasLayer/TouchScreenButton").normal = pause
#	else:
#		get_node("ui/CanvasLayer/TouchScreenButton").normal = play
#		get_node("ui/CanvasLayer/Popup/AnimationPlayer").play("animin")
#		_on_ui_qhide()
#			audio.get_node("bg").stop()
#		get_tree().set_pause(true)
#		get_node("ui/CanvasLayer/TouchScreenButton").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#		get_node("ui/CanvasLayer/Popup").set_pause_mode(Node.PAUSE_MODE_PROCESS)
#
#	pass # replace with function body


func _on_retry_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	
	get_node("ui/CanvasLayer/Popuprestart/AnimationPlayer").play_backwards("animin")
	yield(utils.create_timer(0.5),"timeout")
	print("uuu")
	get_tree().reload_current_scene()
	pass # replace with function body


#func _on_Answerbtn_pressed():
#	if utils.level == 1:
#		get_node("ui/CanvasLayer/Popup/Label").set_text("
#	pass # replace with function body




func _on_Answerbtn_pressed():
	if anspressed:
		
		audio.get_node("SamplePlayer2D").play("hit")
		get_node("ui/CanvasLayer/Popup2/AnimationPlayer").play("animin")
		_on_ui_qhide()
		get_node("Timer").stop()
		if utils.level == 3:
			ans = "The number at the centre of each triangle equals the sum of the lower two numbers minus the top number."
		if utils.level == 2:
			ans = "As you move diagonally down, numbers follow the sequence of Prime Numbers."
		if utils.level == 1:
			ans = "Starting bottom left and moving clockwise around the triangle, numbers follow the sequence of Square Numbers."
		if utils.level == 4:
			ans = "Working from top to bottom, double each number and subtract 1, then 2, then 3 etc."
		if utils.level == 5:
			ans = "Working in columns, the sum of the numbers in each column is always 14."
		if utils.level == 6:
			ans = "The numbers in each row and column add up to 15."
		if utils.level == 7:
			ans = "Moving from left to right, numbers increase by 2,3,4 and 5."
		if utils.level == 8:
			ans = "Moving clockwise, around alternate segments in the chain, one sequence decreases by 1, 2, 3 and 4 each time, while the other increases by 2, 3, 4 and 5."
		if utils.level == 9:
			ans = "Starting with the numbers in the top row, and following straight lines through the centre of the diagram, subtract the middle number from the top number to give the corresponding value on the bottom row."
		if utils.level == 10:
			ans = "In each circle, starting at the top left segment, numbers increase, as you move clockwise, by 2 for the upper left circle, 3 for the upper right, 4 for the lower right and 5 for the lower left."
		if utils.level == 11:
			ans = "In each group of 3 numbers, the lower number equals the average of the top two numbers."
		if utils.level == 12:
			ans = "Reading each row as a 3 digit number, the rows follow the sequence of square numbers, from 17 to 19."
		if utils.level == 13:
			ans = "Reading each pair of numbers as a 2 digit number, they follow the sequence of square numbers from 6 to 9."
		if utils.level == 14:
			ans = "In each row of the diagram, the sum of the left and right hand digits, minus the central digit is always 8."
		if utils.level == 15:
			ans = "Starting at the top left, and moving through the diagram in a Z shape, double each number and add 3 to give the next number along."
		if utils.level == 16:
			ans = "Moving to the right, double each number and subtract 3 to give the next number along."
		if utils.level == 17:
			ans = "Starting with the 10 at the top, one set of numbers increases by 3 each time, written in alternate boxes as you move down the diagram, and the other set of numbers decreases by 2, written in the boxes remaining"
		if utils.level == 18:
			ans = "On each row, add the values of the left hand and central boxes to give the value in the right hand box."
		if utils.level == 19:
			ans = "In each star diagram, the number in the centre equals the sum of the top three numbers, subtracting the sum of the bottom two numbers."
		if utils.level == 20:
			ans = "Starting top left, and moving down in columns from left to right, the numbers follow the sequence of Prime Numbers from 2 to 23."
		if utils.level == 21:
			ans = "Numbers in the segments of the left hand circle equal the difference between numbers in corresponding segments of the two right hand circles."
		if utils.level == 22:
			ans = "Starting with the top 3 digit number, the first digit increases by 2 as you descend, from 1 to 11. The middle digit decreases by 1 each time, and the right hand digit alternates between 5 and 3."
		if utils.level == 23:
			ans = "Numbers in the lower left circle equal the sum of the numbers in corresponding segments of the top two circles, and numbers in the lower right circle equal the difference of the numbers in corresponding segments of the top two circles."
		if utils.level == 24:
			ans = "In each triangle, the central number equals the sum of the three outer numbers divided by two."
		if utils.level == 25:
			ans = "In each star, the central number equals the difference between the sum of the even numbers and the sum of the odd numbers from the points of the star."
		if utils.level == 26:
			ans = "In each triangle, the number at the apex of the triangle equals the average of the two numbers at the bottom."
		if utils.level == 27:
			ans = "In each circle, the lower number equals the product of the top two numbers, subtracting 3 for the left hand circle, 4 for the middle, and 5 for the right hand circle."
		if utils.level == 28:
			ans = "In each diamond, add the left and right hand numbers together, and subtract this sum from the top number to give the value at the bottom."
		if utils.level == 29:
			ans = "In each H shape, the central number is equal to the difference between the sum of the 3 left hand numbers and the sum of the 3 right hand numbers."
		if utils.level == 30:
			ans = "Reading each row of the diagram as a series of 3 digit numbers, the centre 3 digit number equals the sum of the top 2 numbers, and the sum of the lower 2 numbers."
		if utils.level == 31:
			ans = "Add together values in corresponding positions of the top two crosses, and put the results in the lower left cross.Calculate the difference between values in corresponding positions of the top two crosses, and put the results in the lower right cross.Finally, add together the values in corresponding positions of the lower two crosses to give the values in the central cross."
		if utils.level == 32:
			ans = "Each number represents the numerical value of the vowels in the alphabet."
		if utils.level == 33:
			ans = "In each group of circles, the centre number equals the average of the four surrounding numbers."
		if utils.level == 34:
			ans = "In each diagram, the sum of the upper left and upper middle numbers is written in the centre box, and the sum of the upper right and upper middle numbers is written in the lower central box."
		if utils.level == 35:
			ans = "Moving from left to right, numbers follow the sequence of square numbers, from 6 to 10, subtracting 4 each time."
		if utils.level == 36:
			ans = "Reading each pair of numbers in a row as a 2 digit number, values increase by 6 each time."
		if utils.level == 37:
			ans = "Reading each column as a 3 digit number, moving from left to right, the columns follow the sequence of cube numbers of 5, 6 and 7."
		if utils.level == 38:
			ans = "In each star, the central value equals the sum of the upper and lower digits on each star, subtracting the sum of the left and right hand digits."
		if utils.level == 39:
			ans = "In each circle, double the numbers on the left hand side and put the result in the opposite segment on the right hand side."
		if utils.level == 40:
			ans = "In each circle, the number in the lower left segment equals the sum of the numbers in the top two segments, and the number in the lower right circle equals the difference between the numbers in the top two segments."
		if utils.level == 41:
			ans = "Working from left to right, the sum of the two smaller numbers on each triangle equals the third number."
		if utils.level == 42:
			ans = "Moving clockwise around the chain, numbers increase by 4, then 3, then 2, before repeating this pattern."
		if utils.level == 43:
			ans = "In each triangle, multiply the lower two numbers together and add the upper number to give the value at the centre."
		if utils.level == 44:
			ans = "Numbers in the segments of the lower left circle equal the sum of the numbers in the upper left and central circles. Numbers in the segments of the lower right circle equal the sum of the numbers in corresponding segments of the upper right and central circles."
		if utils.level == 45:
			ans = "The numbers on the points of the lower triangle equal the sum of the numbers on corresponding points of the upper two triangles."
		if utils.level == 46:
			ans = "As you move down, subtract 3 from the previous number, then 5, 7, 9 and 11."
		if utils.level == 47:
			ans = "Taking any side of the triangle, the sum of the two corner digits is written in one of the circles on that side, and the difference is written in the other circle."
		if utils.level == 48:
			ans = "Starting in the top left and moving in a Z shape around the diagram, each number equals the sum of the previous 2 numbers."
		if utils.level == 49:
			ans = "Working in rows, the number in the central oval equals the sum of the left and right hand numbers, divided by 3."
		if utils.level == 50:
			ans = "Starting with the bottom line of the triangle and moving up, the sum of the digits in each line decreases by 5 each time, from 20 to 5."
		if utils.level == 51:
			ans = "Numbers in the squares of the top middle figure equal the sum of the numbers in corresponding squares of the other 3 figures."
		if utils.level == 52:
			ans = "Starting at the top left and working down, then to the right and up, and finally to the right and down in a zig-zag shape, numbers follow the repeated sequence, subtracting 1 then adding 3 etc."
		if utils.level == 53:
			ans = "As you move down, the numbers represent multiples of 12, subtracting 1, for the first step, adding 2 for the second, subtracting 3 for the third, adding 4 for the next etc. etc."
		if utils.level == 54:
			ans = "In each row, the sum of the digits is 10."
		get_node("ui/CanvasLayer/Popup2/ScrollContainer/Label").set_text(ans)
		anspressed = false
	pass # replace with function body





func _on_back2_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	anspressed = true
	get_node("ui/CanvasLayer/Popup2/AnimationPlayer").play("animout")
	_on_ui_qshow()
	get_node("Timer").start()
	pass # replace with function body
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if utils.menupressed:
			utils.menupressed = false
			audio.get_node("SamplePlayer2D").play("hit")
			get_node("ui/menuin/AnimationPlayer").play("animout")
		elif not anspressed:
			_on_back2_pressed()
		else:
			get_tree().change_scene_to(ui)






func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body


func _on_Node2D_answer():
	_on_Answerbtn_pressed()
	pass # replace with function body



