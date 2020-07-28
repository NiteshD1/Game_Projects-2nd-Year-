# script: utils

extends Node

var level 
var fileobj
var menupressed = false
signal gemscore
var gem = 0
var qtime = 2
#var save = [1,1,3,2,1,1]
var save = { 0 : 1 ,
			500 : 1,
			1 : 0 ,
			2 : 0 ,
			3 : 0 ,
			4 : 0 ,
			5 : 0 ,
			6 : 0 ,
			7 : 0 ,
			8 : 0 ,
			9 : 0 ,
			10 : 0 ,
			11: 0 ,
			12 : 0 ,
			13 : 0 ,
			14 : 0 ,
			15: 0 ,
			16 : 0 ,
			17: 0 ,
			18: 0 ,
			19: 0 ,
			20: 0 ,
			21: 0 ,
			22: 0 ,
			23: 0 ,
			24: 0 ,
			25: 0 ,
			26: 0 ,
			27: 0 ,
			28: 0 ,
			29: 0 ,
			30: 0 ,
			31: 0 ,
			32: 0 ,
			33: 0 ,
			34: 0 ,
			35: 0 ,
			36: 0 ,
			37: 0 ,
			38: 0 ,
			39: 0 ,
			40: 0 ,
			41: 0 ,
			42: 0 ,
			43: 0 ,
			44: 0 ,
			45: 0 ,
			46: 0 ,
			47: 0 ,
			48: 0 ,
			49: 0 ,
			50: 0 ,
			51 : 0 ,
			52 : 0 ,
			53 : 0 ,
			54 : 0 ,
			55 : 0 ,
			56 : 0 ,
			57 : 0 ,
			58 : 0 ,
			59 : 0 ,
			60 : 0 ,
			61: 0 ,
			62 : 0 ,
			63 : 0 ,
			64 : 0 ,
			65: 0 ,
			66 : 0 ,
			67: 0 ,
			68: 0 ,
			69: 0 ,
			70: 0 ,
			71: 0 ,
			72: 0 ,
			73: 0 ,
			74: 0 ,
			75: 0 ,
			76: 0 ,
			77: 0 ,
			78: 0 ,
			79: 0 ,
			80: 0 ,
			81: 0 ,
			82: 0 ,
			83: 0 ,
			84: 0 ,
			85: 0 ,
			86: 0 ,
			87: 0 ,
			88: 0 ,
			89: 0 ,
			90: 0 ,
			91: 0 ,
			92: 0 ,
			93: 0 ,
			94: 0 ,
			95: 0 ,
			96: 0 ,
			97: 0 ,
			98: 0 ,
			99: 0 ,
			100: 0 }


var maxlevel = 54

func _ready():
#	save(save)
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
		




var status_init = { 0 : 1 ,
			500 : 1,
			1 : 0 ,
			2 : 0 ,
			3 : 0 ,
			4 : 0 ,
			5 : 0 ,
			6 : 0 ,
			7 : 0 ,
			8 : 0 ,
			9 : 0 ,
			10 : 0 ,
			11: 0 ,
			12 : 0 ,
			13 : 0 ,
			14 : 0 ,
			15: 0 ,
			16 : 0 ,
			17: 0 ,
			18: 0 ,
			19: 0 ,
			20: 0 ,
			21: 0 ,
			22: 0 ,
			23: 0 ,
			24: 0 ,
			25: 0 ,
			26: 0 ,
			27: 0 ,
			28: 0 ,
			29: 0 ,
			30: 0 ,
			31: 0 ,
			32: 0 ,
			33: 0 ,
			34: 0 ,
			35: 0 ,
			36: 0 ,
			37: 0 ,
			38: 0 ,
			39: 0 ,
			40: 0 ,
			41: 0 ,
			42: 0 ,
			43: 0 ,
			44: 0 ,
			45: 0 ,
			46: 0 ,
			47: 0 ,
			48: 0 ,
			49: 0 ,
			50: 0 ,
			51 : 0 ,
			52 : 0 ,
			53 : 0 ,
			54 : 0 ,
			55 : 0 ,
			56 : 0 ,
			57 : 0 ,
			58 : 0 ,
			59 : 0 ,
			60 : 0 ,
			61: 0 ,
			62 : 0 ,
			63 : 0 ,
			64 : 0 ,
			65: 0 ,
			66 : 0 ,
			67: 0 ,
			68: 0 ,
			69: 0 ,
			70: 0 ,
			71: 0 ,
			72: 0 ,
			73: 0 ,
			74: 0 ,
			75: 0 ,
			76: 0 ,
			77: 0 ,
			78: 0 ,
			79: 0 ,
			80: 0 ,
			81: 0 ,
			82: 0 ,
			83: 0 ,
			84: 0 ,
			85: 0 ,
			86: 0 ,
			87: 0 ,
			88: 0 ,
			89: 0 ,
			90: 0 ,
			91: 0 ,
			92: 0 ,
			93: 0 ,
			94: 0 ,
			95: 0 ,
			96: 0 ,
			97: 0 ,
			98: 0 ,
			99: 0 ,
			100: 0 }
const SAVE_GAME = "user://save_ga.dat"
const SAVE_BAK = "user://save_ga.bak"

func loadfile():

    var file = File.new()
    var data = null
    if file.file_exists(SAVE_GAME):
        file.open(SAVE_GAME, file.READ)
        data = file.get_var()
        file.close()
        
    if data == null:
        if file.file_exists(SAVE_BAK):
            file.open(SAVE_BAK, file.READ)
            data = file.get_var()
            file.close()
            print("Status backup loaded from "+SAVE_BAK)

    if (data == null):
        return status_init
        
    else:
            
            return data
            save(data,SAVE_BAK)


func save(var status ,file_name = SAVE_GAME):
    var file = File.new()
    file.open(file_name, file.WRITE)
    file.store_var(status)
    file.close()
    print("Status saved to: "+file_name)
