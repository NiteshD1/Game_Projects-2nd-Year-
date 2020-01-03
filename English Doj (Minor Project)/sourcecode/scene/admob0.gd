extends Node2D
var sbanner = true
var admob = null
var isReal = true
var isTop = false
var i = 0
signal coinupdate
var bannerappear = false

signal refresh


var adBannerId = "" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-4371541916347832/2890287109" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-4371541916347832/2537804014" # [There is no testing option for rewarded videos, so you can use this id for testing]
#var adInterstitialId = "ca-app-pub-3940256099942544/1033173712" # Fake[Replace with your Ad Unit ID and delete this message.]
#var adRewardedId = "ca-app-pub-3940256099942544/5224354917" #Fake
func _ready():
	
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(isReal, get_instance_ID())
		loadInterstitial()
		loadRewardedVideo()
#	yield(utils.create_timer(5),"timeout")
#	_on_rewarded_video_ad_closed()
	
	get_tree().connect("screen_resized", self, "onResize")

# Loaders

func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func loadInterstitial():
	if admob != null:
		admob.loadInterstitial(adInterstitialId)
		
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

# Events

#func _on_BtnBanner_toggled(pressed):
#	if admob != null:
#		if pressed: admob.showBanner()
#		else: admob.hideBanner()
#
#func _on_BtnInterstitial_pressed():
#	if admob != null:
#		admob.showInterstitial()
#		
#func _on_BtnRewardedVideo_pressed():
#	if admob != null:
#		admob.showRewardedVideo()

func _on_admob_network_error():
#	utils.network_error = true
	print("Network Error")

func _on_admob_ad_loaded():

	print("Ad loaded success")
	#get_node("CanvasLayer/BtnBanner").set_disabled(false)

func _on_interstitial_not_loaded():
	print("Error: Interstitial not loaded")

func _on_interstitial_loaded():
	print("Interstitial loaded")
	#get_node("CanvasLayer/BtnInterstitial").set_disabled(false)

func _on_interstitial_close():
	print("Interstitial closed")
	#get_node("CanvasLayer/BtnInterstitial").set_disabled(true)

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")
	#get_node("CanvasLayer/BtnRewardedVideo").set_disabled(false)
	
func _on_rewarded_video_ad_closed():
#	utils.network_error = false
#	if utils.lifereward:
#		utils.lifereward = false
#	get_node("Label").set_text("100")
#	emit_signal("lifegain")
	print("Rewarded closed")
	#get_node("CanvasLayer/BtnRewardedVideo").set_disabled(true)
	loadRewardedVideo()
	
func _on_rewarded(currency, amount):
#	if utils.lifereward:
#		utils.extralifegain = true
#	else:
	utils.coin += 100
	emit_signal("coinupdate")
	emit_signal("refresh")
	print("Reward: " + currency + ", " + str(amount))
	#get_node("CanvasLayer/LblRewarded").set_text("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()
















func _on_coinadd_pressed():
	if admob != null:
		admob.showRewardedVideo()
	pass # replace with function body




func _on_home_pressed():
#	yield(utils.create_timer(0.5),"timeout")
	if admob != null and (utils.level>2 or utils.sentencelevel>2):
		admob.showInterstitial()
	pass # replace with function body


func _on_main_addinter():
	if admob != null and (utils.level>2 or utils.sentencelevel>2):
		admob.showInterstitial()
	pass # replace with function body





func _on_bannertime_timeout():
	loadBanner()
	bannerappear = true
	pass # replace with function body


func _on_changelevel_pressed():
#	yield(utils.create_timer(0.5),"timeout")
	if admob != null and (utils.level>2 or utils.sentencelevel>2):
		admob.showInterstitial()
	pass # replace with function body
