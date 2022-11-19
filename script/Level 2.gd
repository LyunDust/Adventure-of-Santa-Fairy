extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bluePresent
var ray
var rayList = []
var SantaBag
var windowSize
var bagBoom = false
var timerText
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	bluePresent = load("res://scene/bluePresent.tscn")
	ray = load("res://scene/ray.tscn")
	timerText = $Label
	timerText.text = String(2)+':00'
	windowSize = get_viewport_rect().size
	
	for i in range(10):
		var newPresent = bluePresent.instance()
		#newPresent.position = Vector2(rand_range(20, windowSize.x-20), rand_range(100, windowSize.y-30))
		randomPosition(newPresent)
		#Global.presentList.append(newPresent)
		add_child(newPresent)
		#Global.presentNum = Global.presentList.size()
		Global.presentNum += 1
		
	rayList.append($ray)
	rayList.append($ray2)
	rayList.append($ray3)
	rayList.append($ray4)
		
#	for i in range(4):
#		rayList.append(ray.instance())
#		if i == 0:
#			rayList[i].position = Vector2(163, 401)
#		elif i == 1:
#			rayList[i].position = Vector2(163+125, 401)
#		elif i == 2:
#			rayList[i].position = Vector2(163+510, 401)
#		elif i == 3:
#			rayList[i].position = Vector2(163+645, 401)
#		add_child(rayList[i])
	
	$stageTimer.start()
		
func presentReposition():
	for i in range(10 - Global.presentNum):
		var newPresent = bluePresent.instance()
		randomPosition((newPresent))
		#Global.presentList.append(newPresent)
		add_child(newPresent)
		#Global.presentNum = Global.presentList.size()
		Global.presentNum += 1

func onePresentReposition():
	if Global.presentNum < 10:
		var newPresent = bluePresent.instance()
		randomPosition((newPresent))
		#Global.presentList.append(newPresent)
		add_child(newPresent)
		#Global.presentNum = Global.presentList.size()
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
		print('game over!')
		get_tree().paused = true
	
func randomPosition(instance):
	instance.position = Vector2(rand_range(20, windowSize.x-20), rand_range(100, windowSize.y-30))
	if (instance.position.x > 408 and instance.position.x < 623 and instance.position.y > 141 and instance.position.y < 280)or(
instance.position.x > 706 and instance.position.x < 1026 and instance.position.y > 492 and instance.position.y < 556)or(
instance.position.x > 171 and instance.position.x < 282 and instance.position.y > 125 and instance.position.y < 272)or(
instance.position.x > 0 and instance.position.x < 187 and instance.position.y > 563 and instance.position.y < 597)or(
instance.position.x > 966 and instance.position.x < 1022 and instance.position.y > 518 and instance.position.y < 602):
		randomPosition(instance)


func _on_Santa_bag_catInterruption():
	onePresentReposition()
