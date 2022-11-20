extends Node2D

var bluePresent
var ray
var rayList = []
var SantaBag
var windowSize
var bagBoom = false
var timerText
var time = 0

func _ready():
	randomize()
	bluePresent = load("res://scene/bluePresent.tscn")
	ray = load("res://scene/ray.tscn")
	timerText = $Label
	timerText.text = String(2)+':00'
	Global.presentNum = 0
	windowSize = get_viewport_rect().size
	
	for i in range(10):
		var newPresent = bluePresent.instance()
		add_child(newPresent)
		Global.presentNum += 1
		
	rayList.append($ray)
	rayList.append($ray2)
	rayList.append($ray3)
	rayList.append($ray4)
	
	$stageTimer.start()
		
func presentReposition():
	for i in range(10 - Global.presentNum):
		var newPresent = bluePresent.instance()
		add_child(newPresent)
		Global.presentNum += 1

func onePresentReposition():
	if Global.presentNum < 10:
		var newPresent = bluePresent.instance()
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
