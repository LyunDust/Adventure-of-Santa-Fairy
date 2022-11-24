extends Area2D

class_name Cloth

var clothNum 
var key
var entered = false
var collectedClothes 
var totalClothes = 4
var isClothCollected = false

func _ready():
	collectedClothes = 0
	$KeyShape.visible = false


func set_key():
	clothNum = randi() % 4 + 1 #1-4
	if clothNum == 1:
		key ="Q"
	elif clothNum == 2:
		key ="W"
	elif clothNum == 3:
		key ="E"
	elif clothNum == 4:
		key ="R"
	else:
		key = "H"
		

func _on_Cloth_body_entered(body):
	if body is Player:
		set_key()
		$KeyShape.visible = true
		$KeyShape/Label.text = key
		entered = true
	
func _on_Cloth_body_exited(body):
	if body is Player:
		key=""
		$KeyShape.visible = false
		entered = false
	
func _input(event):
	if event is InputEventKey:
		if key == "Q" and event.scancode == KEY_Q:
			isClothCollected = true
			queue_free()
		elif key == "W" and event.scancode == KEY_W:
			isClothCollected = true
			queue_free()
		elif key == "E" and event.scancode == KEY_E:
			isClothCollected = true
			queue_free()
		elif key == "R" and event.scancode == KEY_R:
			isClothCollected = true
			queue_free()

func chechClothCollected() ->bool:
	return isClothCollected
