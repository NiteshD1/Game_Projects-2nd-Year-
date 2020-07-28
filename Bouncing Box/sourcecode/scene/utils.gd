# script: utils

extends Node

var level 
var fileobj

signal gemscore
var gem = 0
var gemno = 10
#var save = [1,1,3,2,1,1]
var save = { 0 : 1 ,
			1 : 0 ,
			2 : 0 ,
			3 : 0 ,
			4 : 0 ,
			5 : 0 }


var maxlevel = 5

func _ready():
	fileobj = loadfile()
	level = fileobj[0]

	pass
 
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass
	
func getcurve(var string):
	var path = str("res://curves/curve" +string+ ".tres")
	var dir = Directory.new()
	if dir.file_exists(path):
		var cur = load(path)
		return cur
	else:
		return null
		




var status_init = { 
			0 : 1 ,
			1 : 0 ,
			2 : 0 ,
			3 : 0 ,
			4 : 0 ,
			5 : 0 }
const SAVE_GAME = "user://save_ga.dat"
const SAVE_BAK = "user://save_ga.bak"

func loadfile():

    var file = File.new()
    var data = null
    if file.file_exists(SAVE_GAME):
        file.open(SAVE_GAME, file.READ)
        data = file.get_var()
        file.close()
        print("Status loaded from "+SAVE_GAME)
    if data == null:
        if file.file_exists(SAVE_BAK):
            file.open(SAVE_BAK, file.READ)
            data = file.get_var()
            file.close()
            print("Status backup loaded from "+SAVE_BAK)

    if (data == null):
        return status_init
        print("Status new? -> Init")
    else:
            print("Status parsed ok")
            return data
            save(data,SAVE_BAK)


func save(var status ,file_name = SAVE_GAME):
    var file = File.new()
    file.open(file_name, file.WRITE)
    file.store_var(status)
    file.close()
    print("Status saved to: "+file_name)
