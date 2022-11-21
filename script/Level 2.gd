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
signal changeItem

func _ready():
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
	
	for i in range(10):
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
	
	$stageTimer.start()
	
func _physics_process(delta):
	if aimMode == true and aimingPause == false:
		throwItem()

func throwItem():
	if Input.is_action_pressed("throw"):
		Global.aiming = true
	else:
		aimMode = false
		Global.aiming = false
		remove_child(cH)
		if itemType == 0:
			item1Instance = item1.instance()
			item1Instance.position = cH.position
			add_child(item1Instance)
			
		elif itemType == 1:
			item2Instance = item2.instance()
			item2Instance.position = cH.position
			add_child(item2Instance)
			
			
		if Global.target == true:
			print(Global.targetPos)
		else:
			print('aiming fail')
		
		
func _unhandled_input(event):
	if event.is_action_pressed("changeItem"):
		emit_signal("changeItem")
		if itemType == 0:
			itemType = 1
		elif itemType == 1:
			itemType = 0
	elif event.is_action_pressed("throw") and aimMode == false and aimingPause == false:
		cH = crossHair.instance()
		cH.position = $Player.position
		add_child(cH)
		aimMode = true
	
		
func presentReposition():
	for i in range(10 - Global.presentNum):
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

func _on_Santa_bag_bagBoom():
	presentReposition()


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


func _on_Santa_bag_catInterruption():
	onePresentReposition()


func _on_Timer_timeout():
	get_tree().change_scene("res://scene/GameOver.tscn")


func _on_Robot_vacuums_aimingPause():
	print('ouch')
	aimMode = false
	Global.aiming = false
	aimingPause = true
	$aimingPauseTimer.start()
	remove_child(cH)


func _on_Cat_aimingPause():
	print('ouch')
	aimMode = false
	Global.aiming = false
	aimingPause = true
	$aimingPauseTimer.start()
	remove_child(cH)


func _on_aimingPauseTimer_timeout():
	aimingPause = false
