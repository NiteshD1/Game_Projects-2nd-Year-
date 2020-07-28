# script: utils

extends Node

var level 
var fileobj
var coin
var sharepressed = false
signal gemscore
var gem = 0
var qtime = 30
var coinlimit = 250
var result = {}
var ans = []
var network_error = false
var levelinfo = { 
			1 : "Speaking already" ,
			2 : "Drive carefully" ,
			3 : "Listen vs. Hear",
			4 : "Finish vs. End",
 
			5 : "Start vs. Begin",
			6 : "Modal Verbs",
			7 : "How to use the articles",
			8 : "Relative Pronouns",
			9 : "Present Tense",
			10 : "Conditionals" ,
			11: "We went on holiday" ,
			12 : "Grammar Questions" ,
			13 : "An Easy Question",
			14 : "Learn it by heart",
			15: "White Water Rafting" ,
			16 : "Where am I" ,
			17: "Remove the Spoon" ,
			18: "Weather Forecast" ,
			19: "On TV tonight " ,
			20: "The Bells" ,
			21: "Sailing" ,
			22: "Question Tags" ,
			23: "Object Pronoun" ,
			24: "Relative Pronoun Exercises " ,
			25: "Reflexive Pronouns",
			26: "Basic American English" ,
			27: "Basic English Grammar" ,
			28: "Basic Weather Expressions" ,
			29: "Basic English Expressions" ,
			30: "Elementary English Grammar" ,
			31: "Question Words",
			32: "Common Prepositions",
			33: "Modal Verb Questions" ,
			34: "Elementary Grammar Questions" ,
			35: "English Grammar Exercise " ,
			36: "Much, many, a lot, lots" ,
			37: "Elementary Adjectives",
			38: "Chit Chat: At the bus stop",
			39: "Chit Chat: Talking about the Doctor ",
			40: "Chit Chat: In the Aeroplane",
			41: "Chit Chat: At the pub",
			42: "Chit Chat: At the restaurant " ,
			43: "Chit Chat: On the phone",
			44: "Chit Chat: In the theatre",
			45: "Chit Chat: In the supermarket",
			46: "Chit Chat: In the train",
			47: "Other, another, others, the others ",
			48: "Adjective Prepositions Constructions ",
			49: "Anything, nothing, something, everything ",
			50: "American homophones",
			51 : "Pronouns: who, whose, whom, which" ,
			52 : "Some, any, few, little",
			53 : "Past Participle Sentences",
			54 : "ESL Prepositions",
			55 : "Common English Errors (1) ",
			56 : "Common English Errors (2) ",
			57 : "Common English Errors (3) ",
			58 : "Common English Errors (4) ",
			59 : "Common Quantity Nouns",
			60 : "Using Make and Do (1)",
			61: "Using Prepositions",
			62 : "Using Make and Do (2)" ,
			63 : "Why Questions",
			64 : "While, during and for",
			65: "auxiliary verbs: was, did, have ",
			66 : "prepositions of time: for, ago, since, on, at" ,
			67: "Common English phrases with prepositions " ,
			68: "Articles in English Grammar ",
			69: "a, some or any ",
			70: "Interrogative pronouns",
			71: "Possessive pronouns",
			72: "Phrasal verbs",
			73: "Agatha Christie test questions",
			74: "Conjunctions: and, but, or, so ",
			75: "Compound words with tooth",
			76: "Like a red rag",
			77: "If you tend to forget",
			78: "Easy Questions",
			79: "Do, make, get, take",
			80: "The Farmer and his Sons ",
			81: "A Holiday Report",
			82: "Going on foot" ,
			83: "Say vs. Tell" ,
			84: "Close vs. Shut" ,
			85: "At the Restaurant" ,
			86: "At the Theatre" ,
			87: "Popular Idioms" ,
			88: "Popular Garden Idioms",
			89: "Hot and Cold " ,
			90: "A Collision - Finish this Story",
			91: "Cross Questions",
			92: "Leave me alone",
			93: "What now?",
			94: "Wrapped round her finger ",
			95: "The Ants and the Grasshopper ",
			96: "The Two Dogs",
			97: "The Hare and the Tortoise",
			98: "",
			99: "",
			100: "" }
#var save = [1,1,3,2,1,1]
var save = { 0 : 1 ,
			500 : 1,
			501 : 0,
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


var maxlevel = 100

func _ready():
	print("hii")
#	var line = "(a) funniest "
#	var line1 = line.split(")")
#	print(line1[0])
#	print(line1)
	save_text()
	load_level_file()
#	save(save)
	fileobj = loadfile()
	level = fileobj[0]
	coin = fileobj[501]

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
const LEVEL_FILE = "user://level.txt"

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

func load_level_file():
	var index = 1
	var file = File.new()
#	var file1 = File.new()
	var data = null
	if file.file_exists(LEVEL_FILE):
        file.open(LEVEL_FILE, file.READ)
#	if file1.file_exists(LEVEL_FILE1):
#        file1.open(LEVEL_FILE1, file.WRITE)
        while not file.eof_reached():
         data = file.get_line()
#         data = file.get_csv_line("(")
#         for i in range(0,data.size()):
#          print(data[i])
#          file1.store_line(data[i])
         result[index] = data
         index += 1
        print(str(data))
        print(result[1])
        file.close()
func save_text():
	var dir = Directory.new()

	if !dir.file_exists(LEVEL_FILE):
		dir.copy("res://level.txt","user://level.txt")
	if !dir.file_exists(SAVE_GAME):
		dir.copy("res://save_ga.dat","user://save_ga.dat")


	
