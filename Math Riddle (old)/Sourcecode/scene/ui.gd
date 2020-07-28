extends Node2D

signal hidem

onready var main = load("res://scene/main.tscn")
onready var sound = preload("res://image/sound.png")
onready var mute = preload("res://image/mute.png")
var sha = null

func _ready():
#	if Globals.has_singleton("GodotLocalNotification"):
#		var ln = Globals.get_singleton("GodotLocalNotification")
#		ln.showLocalNotification("Message", "Title or application name", 20, 1)
#	print(utils.qtime)
#	if Globals.has_singleton("GodotShare"):
#		sha = Globals.get_singleton("GodotShare")
#	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
	get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
#	$AnimationPlayer2.play("New Anim (2) (copy)")
	audio.get_node("SamplePlayer2D").play("start1")
	set_sound_image()
	pass


func _on_Button3_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	yield(utils.create_timer(0.5),"timeout")
	get_tree().change_scene_to(main)
	pass # replace with function body


func _on_Button_pressed():
	audio.get_node("SamplePlayer2D").play("hit",1)
	get_node("Control").set_opacity(0.1)
	get_node("menuin/AnimationPlayer").play("animin")
	get_node("Control/HBoxContainer/AnimationPlayer").play_backwards("New Anim")
	get_node("Control/HBoxContainer/Button3").hide()



func _on_Label_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/AnimationPlayer").play("animin")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animout")
	pass # replace with function body










func _on_backmenu_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/AnimationPlayer").play("animout")
	get_node("menuin/AnimationPlayer").play("animin")




func _on_backmain_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("menuin/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.3),"timeout")
	get_node("Control/HBoxContainer/AnimationPlayer").play("New Anim")
	get_node("Control/HBoxContainer/Button3").show()
	get_node("Control").set_opacity(1)
	
	pass # replace with function body
	
	









	


func _on_back_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("controlinfo/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body


func _on_Button2_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	var s = utils.loadfile()
	if get_node("Control/HBoxContainer/Button2").normal == sound:
		s[500] = 0
		audio.sound = 0
	else:
		s[500] = 1
		audio.sound = 1
	utils.save(s)
	audio.set_sound()
#	audio.emit_signal("sound_change")
	set_sound_image()
	pass # replace with function body


func set_sound_image():
#	var sound = int(audio.loadfile())
	if audio.sound == 0:
		get_node("Control/HBoxContainer/Button2").normal = mute
	else:
		get_node("Control/HBoxContainer/Button2").normal = sound


func _on_LinkButton_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	OS.shell_open("https://bouncingbox2.blogspot.com/p/bouncing-box-privacy-policy.html")
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
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() + 130)
	pass # replace with function body


func _on_previous_pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("Popup2/ScrollContainer").set_h_scroll(get_node("Popup2/ScrollContainer").get_h_scroll() - 130)
	pass # replace with function body

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_node("ConfirmationDialog").popup_centered(Vector2(175,100))
 

func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
	pass # replace with function body


func _on_share_pressed():
	if sha != null:
		sha.share("hello -: https://www.youtube.com/watch?v=n2XgERPfMcU")
	pass # replace with function body


func _on_back__pressed():
	audio.get_node("SamplePlayer2D").play("hit")
	get_node("controlinfo/AnimationPlayer").play("animout")
	yield(utils.create_timer(0.15),"timeout")
	get_node("menuin/AnimationPlayer").play("animin")
	pass # replace with function body
