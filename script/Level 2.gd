#Owner: LeeSoyoung
extends Node2D

var bluePresent
var greenPresent
var redPresent
var SantaBag
var windowSize
var bagBoom = false
var timerText
var time = 0
var presentNum
var crossHair
var cH
var aimMode = false
var aimingPause = false
var item1
var item2
var item1Instance
var item2Instance
var itemType = 0
var vacuumPos
signal changeItem
signal toyArrive(pos)
signal pauseRay
signal startRay

func _ready():
	BackGroundMusic.pause_storySceneMusic()
	BackGroundMusic.play_level2SceneMusic()
	randomize()
	bluePresent = load("res://scene/bluePresent.tscn")
	greenPresent = load("res://scene/greenPresent.tscn")
	redPresent = load("res://scene/redPresent.tscn")
	crossHair = load("res://scene/crossHair.tscn")
	item1 = load("res://scene/item.tscn")
	item2 = load("res://scene/item2.tscn")
	timerText = $Label
	timerText.text = String(2)+':00'
	Global.presentNum = 0
	windowSize = get_viewport_rect().size
	aimingPause = false
	aimMode = false
	time = 0
	Global.aiming = false
	
	#Create 10 Random Kinds of present
	for _i in range(10):
		var newPresent
		presentNum = randi() % 3
		match presentNum:
			0:
				newPresent = redPresent.instance()
			1:
				newPresent = greenPresent.instance()
			2:
				newPresent = bluePresent.instance()	
		
		add_child(newPresent)
		Global.presentNum += 1
	
	#Start Timeout Timer for Stage
	$stageTimer.start()
	
func _physics_process(_delta):
	#Call only if the aim is not paused and in aimMode
	if aimMode == true and aimingPause == false:
		throwItem()
	#If the player succeeds in aiming the robot vacuum, it continues to store the robot vacuum's position
	if Global.target == true:
			Global.vaccumsPos = vacuumPos
			
	if Global.get_presentCollected() == true:
		if !$EffectSound/CollectItem.is_playing():
			$EffectSound/CollectItem.play()
			Global.set_presentCollected(false)

func throwItem():
	#When the key to throw is pressed, stop the ray and make the global variable 'aiming' true
	if Input.is_action_pressed("throw"):
		emit_signal("pauseRay")
		Global.aiming = true
	#If not, allow the rays to operate again, eliminate the crosshair, and create an item that fits the type of item
	else:
		emit_signal("startRay")
		if !$EffectSound/ThrowItem.is_playing():
			$EffectSound/ThrowItem.play()
		aimMode = false
		Global.aiming = false
		remove_child(cH)
		if itemType == 0:
			item1Instance = item1.instance()
			item1Instance.position = $Player.position
			item1Instance.targetPos(cH.position)
			add_child(item1Instance)
			
		elif itemType == 1:
			if Global.toyCount > 0:
				remove_child(item2Instance)
				Global.toyCount -= 1
			
			item2Instance = item2.instance()
			item2Instance.position = $Player.position
			item2Instance.targetPos(cH.position)
			add_child(item2Instance)
			Global.toyCount += 1
			emit_signal("toyArrive", cH.position)
		
		
func _unhandled_input(event):
	#Change the type of item to throw
	if event.is_action_pressed("changeItem"):
		emit_signal("changeItem")
		if itemType == 0:
			itemType = 1
		elif itemType == 1:
			itemType = 0
	#If the aimMode is false and the aiming is not paused, create a crosshair and change the aimMode to true
	elif event.is_action_pressed("throw") and aimMode == false and aimingPause == false:
		cH = crossHair.instance()
		cH.position = $Player.position
		add_child(cH)
		aimMode = true
	
#If there are fewer than 10 presents, create them again until there are 10
func presentReposition():
	for _i in range(10 - Global.presentNum):
		var newPresent
		presentNum = randi() % 3
		match presentNum:
			0:
				newPresent = redPresent.instance()
			1:
				newPresent = greenPresent.instance()
			2:
				newPresent = bluePresent.instance()	
		add_child(newPresent)
		Global.presentNum += 1

#If there are fewer than 10 presents, create one present again
func onePresentReposition():
	if Global.presentNum < 10:
		var newPresent
		presentNum = randi() % 3
		match presentNum:
			0:
				newPresent = redPresent.instance()
			1:
				newPresent = greenPresent.instance()
			2:
				newPresent = bluePresent.instance()	
		add_child(newPresent)
		Global.presentNum += 1

#Execute when Santa's bag and robot vacuum collide
func _on_Santa_bag_bagBoom():
	presentReposition()

#Change labels that display time-outs or move on to game over
func _on_stageTimer_timeout():
	time += 1
	if(time <= 50):
		timerText.text = String(1)+':'+String(60-time)
	elif(time <= 60):
		timerText.text = String(1)+':0'+String(60-time)
	elif(time <= 110):
		timerText.text = String(0)+':'+String(120-time)
	elif(time <= 120):
		timerText.text = String(0)+':0'+String(120-time)
	if time == 120:
		$Timer.start()

#Execute when Santa's bag and cat collide
func _on_Santa_bag_catInterruption():
	onePresentReposition()

#When the time limit for the stage is over, change to Game Over Scene
func _on_Timer_timeout():
	if !$EffectSound/GameOver.is_playing():
		$EffectSound/GameOver.play()
	BackGroundMusic.pause_level2SceneMusic()
	get_tree().change_scene("res://scene/GameOver.tscn")

##Stop aiming if a robot vacuum collides with a player or Santa bag
func _on_Robot_vacuums_aimingPause():
	aimMode = false
	if Global.aiming == true:
		remove_child(cH)
	Global.aiming = false
	aimingPause = true
	$aimingPauseTimer.start()

#Stop aiming if a cat collides with a player or Santa bag
func _on_Cat_aimingPause():
	aimMode = false
	if Global.aiming == true:
		remove_child(cH)
	Global.aiming = false
	aimingPause = true
	$aimingPauseTimer.start()

#Enables aiming at the end of the timer
func _on_aimingPauseTimer_timeout():
	aimingPause = false

#Location from robot vacuums
func _on_Robot_vacuums_sendPos(pos):
	vacuumPos = pos
