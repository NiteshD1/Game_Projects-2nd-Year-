# script: utils

extends Node
var chooseball = null
var wordmode = true
var extralifetime = 10
var sentencelevel= null
var indirect = false
var level= null 
var image_save_path= null
var fileobj= null
var guide = false
var guideno= null 
var fileobj1= null
var wordstage = 1
var sentencestage = 1
var coin= null
var sharepressed = false
var englishtohindi = true
var varyfirst = true
var maxslevel = 300
var puzno = 1
var fiftypressed = false
var audiencepressed = false
var skippressed = false
var answerpressed = false
var helppressed = true
var extralifepossible = true
var lifeline = 4
var opaudience = 1
var op50 = 1
var opskip = 1
var opanswer = 1
var score =0
signal gemscore
signal guideend
signal levelshow
signal loadlevel
signal backlevel
signal englishhindi
signal givelife
signal networkerror

var lastq = 55
var lifereward = false
var arr = []
var gem = 0
var qtime = 20
var coinlimit = 300
var result = {}
var ans = []
var network_error = null
var gamemode = false
var learnmode = false
var first_time = true
var extralifegain = false
var retryq = null

#var save = [1,1,3,2,1,1]


var save = { 0 : 1 ,#wordlevel
			700 : 1,#sound
			701 : 200,#coin
			702 : 0,#highscore
			705 : true,#englishtohindi
			706 : true,#guide 1
			707 : true,#guide 2
			708 : true,#guide 3
			709 : true,#guide 4
			710 : true,
			711 : false, #image found
			712 : null, # image path
			713 : true ,#guide allow
			714 : true,#ratelast
			715 : 0 #addbeginno
			}

var maxlevel = 600

func _ready():
	CheckNConnection.connect("connection_success", self, "_on_success")
	CheckNConnection.connect("error_connection_failed", self, "_on_failure")
	CheckNConnection.connect("error_ssl_handshake", self, "_on_fail_ssl_handshake")
	setlevel()
	
#	print("hii")
#	var line = "(a) funniest "
#	var line1 = line.split(")")
#	print(line1[0])
#	print(line1)
	save_text()
#	load_level_file()
#	save(save)
#	save1(save1)
	fileobj = loadfile()
#	level = fileobj[0]
#	englishtohindi = fileobj[705]
#	
#	fileobj1 = loadfile1()
#	sentencelevel = fileobj1[0]
#	print(level)
	coin = fileobj[701]
	
#	utils.level = 38
#	image_save_path = fileobj[711]

	pass
 

func _on_success():
#	CheckNConnection.check_timer.stop()
	CheckNConnection.check_timer.wait_time = 1
	print("Connection Success!!")
	utils.network_error = false

func _on_failure(code, message):
#	CheckNConnection.check_timer.wait_time = 1
	utils.network_error = true
	print("Connection Failure!!\nCode: ", code, " Message: ", message)

func _on_fail_ssl_handshake():
	print("SSL Handshake Error!!")



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
			501 : 0,
			502 : 0,
			503 : 1,#word
			504 : 1,#sentence
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
#const SAVE_GAME1 = "user://save_ga1.dat"
#const SAVE_BAK1= "user://save_ga1.bak"
#const SAVE_GAME2 = "user://splash.png"
#const LEVEL_FILE = "user://level.txt"

func endgame():
		lastq = 55
		puzno = 1
		score = 0
		op50 = 1
		opskip = 1
		opaudience = 1
		opanswer = 1
		lifereward = false
		extralifegain = false
		extralifepossible = true
		audiencepressed = false
		skippressed = false
		fiftypressed = false
		answerpressed = false
		utils.lifeline = 4
		setlevel()
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
#            print("Status backup loaded from "+SAVE_BAK)

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

#func loadfile1():
#
#    var file = File.new()
#    var data = null
#    if file.file_exists(SAVE_GAME1):
#        file.open(SAVE_GAME1, file.READ)
#        data = file.get_var()
#        file.close()
#        
#    if data == null:
#        if file.file_exists(SAVE_BAK1):
#            file.open(SAVE_BAK1, file.READ)
#            data = file.get_var()
#            file.close()
#            print("Status backup loaded from "+SAVE_BAK1)
#
#    if (data == null):
#        return status_init
#        
#    else:
#            
#            return data
#            save1(data,SAVE_BAK1)
#
#
#func save1(var status ,file_name = SAVE_GAME1):
#    var file = File.new()
#    file.open(file_name, file.WRITE)
#    file.store_var(status)
#    file.close()
#    print("Status saved to: "+file_name)
#func load_level_file():
#	var index = 1
#	var file = File.new()
#	var file1 = File.new()
#	var data = null
#	if file.file_exists(LEVEL_FILE):
#        file.open(LEVEL_FILE, file.READ)
#	if file1.file_exists(LEVEL_FILE1):
#        file1.open(LEVEL_FILE1, file.WRITE)
#        while not file.eof_reached():
#         data = file.get_line()
#         data = file.get_csv_line("(")
#         for i in range(0,data.size()):
#          print(data[i])
#          file1.store_line(data[i])
#         result[index] = data
#         index += 1
#        print(str(data))
#        print(result[1])
#        file.close()
func save_text():
	var dir = Directory.new()

#	if !dir.file_exists(SAVE_GAME1):
#		dir.copy("res://save_ga1.dat","user://save_ga1.dat")
	if !dir.file_exists(SAVE_GAME):
		dir.copy("res://save_ga.dat","user://save_ga.dat")
#	if !dir.file_exists(SAVE_GAME2):
#		dir.copy("res://splash.png","user://splash.png")

func setlevel():
	for i in range(0,lastq):
		arr.append(i)
	


	
