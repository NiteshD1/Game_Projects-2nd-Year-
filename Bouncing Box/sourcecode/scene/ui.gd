extends Node2D

signal hidem

onready var main = preload("res://scene/main.tscn")
onready var sound = preload("res://image/sound.png")
onready var mute = preload("res://image/mute.png")

func _ready():
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(0.11,0.05,0.23))
	$AnimationPlayer.play("New Anim")
	$AnimationPlayer2.play("New Anim (2) (copy)")
#	audio.get_node("start").play()
	set_sound_image()
	pass


func _on_Button3_pressed():
	audio.get_node("click").play()
	get_tree().change_scene_to(main)
	pass # replace with function body


func _on_Button_pressed():
	audio.get_node("click").play()
	$Control.set_modulate(Color(1,1,1,0.1))
	$menuin.show()
	$Control/HBoxContainer.hide()



func _on_Label_pressed():
	audio.get_node("click").play()
	$Popup2.show()
	$menuin.hide()
	pass # replace with function body










func _on_backmenu_pressed():
	audio.get_node("click").play()
	$Popup2.hide()
	$menuin.show()




func _on_backmain_pressed():
	audio.get_node("click").play()
	$Control/HBoxContainer.show()
	$Control.set_modulate(Color(1,1,1,1))
	yield(utils.create_timer(0.1),"timeout")
	$menuin.hide()
	pass # replace with function body
	
	









func _on_Label4_pressed():
	audio.get_node("click").play()
	$control.show()
	yield(utils.create_timer(0.1),"timeout")
	$menuin.hide()
	
	pass # replace with function body


func _on_back_pressed():
	audio.get_node("click").play()
	$control.hide()
	$menuin.show()
	pass # replace with function body


func _on_Button2_pressed():
	audio.get_node("click").play()
	if $Control/HBoxContainer/Button2.normal == sound:
		audio.save("0")
	else:
		audio.save("1")
	audio.sound = int(audio.loadfile())
	audio.emit_signal("sound_change")
	set_sound_image()
	pass # replace with function body


func set_sound_image():
#	var sound = int(audio.loadfile())
	if audio.sound == 0:
		$Control/HBoxContainer/Button2.normal = mute
	else:
		$Control/HBoxContainer/Button2.normal = sound


func _on_LinkButton_pressed():
	OS.shell_open("https://bouncingbox2.blogspot.com/p/bouncing-box-privacy-policy.html")
	pass # replace with function body
