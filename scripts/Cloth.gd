extends Area2D

var clothNum
var keyNum 
var key
var manageClothes

func _ready():
	$KeyShape.visible = false
	manageClothes = get_node("/root/HumanWorld/Clothes")

func setClothNum(num):
	clothNum = num
	
func getClothNum()->int:
	return clothNum
	
func setSpriteTexture(sprite_texture):
	$Sprite.texture =load(sprite_texture) 

func set_key():
	keyNum = randi() % 4 + 1 #1-4
	if keyNum == 1:
		$KeyShape/Label.text = "Q"
		key = KEY_Q
	elif keyNum == 2:
		$KeyShape/Label.text = "W"
		key = KEY_W
	elif keyNum == 3:
		$KeyShape/Label.text = "E"
		key = KEY_E
	elif keyNum == 4:
		$KeyShape/Label.text = "R"
		key = KEY_R
	else:
		key = KEY_H

		
func _on_Cloth_body_entered(body):
	if body is Player and manageClothes.checkBeforeClothCollected(clothNum):
		set_key()
		$KeyShape.visible = true
		$KeyShape/Label.visible = true
		
	
func _on_Cloth_body_exited(body):
	if body is Player:
		key= null
		$KeyShape.visible = false
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == key:
			manageClothes.setClothCollected(clothNum)
			queue_free()		

