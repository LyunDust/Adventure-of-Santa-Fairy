extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bluePresent
var SantaBag
var windowSize
export var bagBoom = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	bluePresent = load("res://scene/bluePresent.tscn")
	windowSize = get_viewport_rect().size
	
	for i in range(10):
		var newPresent = bluePresent.instance()
		newPresent.position = Vector2(rand_range(20, windowSize.x-20), rand_range(100, windowSize.y-30))
		#Global.presentList.append(newPresent)
		add_child(newPresent)
		#Global.presentNum = Global.presentList.size()
		Global.presentNum += 1
		
		
func presentReposition():
	for i in range(10 - Global.presentNum):
		var newPresent = bluePresent.instance()
		newPresent.position = Vector2(rand_range(20, windowSize.x-20), rand_range(100, windowSize.y-30))
		#Global.presentList.append(newPresent)
		add_child(newPresent)
		#Global.presentNum = Global.presentList.size()
		Global.presentNum += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Santa_bag_bagBoom():
	presentReposition()
