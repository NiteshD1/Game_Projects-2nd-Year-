extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	pass
func _init():
	TranslationServer.set_locale("hi_IN")
	tr("hi_IN")
	