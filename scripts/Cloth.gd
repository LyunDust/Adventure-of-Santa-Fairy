#Owner: ParkSinYoung

extends Area2D

var clothNum
var keyNum 
var key
var manageClothes
var windowSize 

func _ready(): #keyshape settings, importing clothes node
	$KeyShape.visible = false
	windowSize = get_viewport_rect().size
	manageClothes = get_node("/root/Level 2/Clothes")

func setClothNum(num): #Unique numbering for each cloth
	clothNum = num
	
func getClothNum()->int: #Find out what the cloth is by returning their unique number
	return clothNum
	
func setSpriteTexture(sprite_texture): #Load the corresponding image
	$Sprite.texture =load(sprite_texture) 
	
func setPosition():
	position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))
	

func set_key(): #Generate a random key each time the player accesses it
	keyNum = randi() % 4 + 1 #1-4
	if keyNum == 1:
		$KeyShape/Label.text = "Q"
		key = KEY_Q
	elif keyNum == 2:
		$KeyShape/Label.text = "T"
		key = KEY_T
	elif keyNum == 3:
		$KeyShape/Label.text = "E"
		key = KEY_E
	elif keyNum == 4:
		$KeyShape/Label.text = "R"
		key = KEY_R
	else:
		key = KEY_H

		
func _on_Cloth_body_entered(body):
	#if the player acesses to clothes, and have acquired the previous order of clothes,
	#enter a key to obtain them
	if body is player and manageClothes.checkBeforeClothCollected(clothNum):
		set_key()
		$KeyShape.visible = true
		$KeyShape/Label.visible = true
		
	
func _on_Cloth_body_exited(body):
	#Unable to enter key and obtain cloth when out of cloth
	if body is player:
		key= null
		$KeyShape.visible = false
	
func _input(event):
	#If the player type the right key, the player can get clothes
	if event is InputEventKey:
		if event.scancode == key:
			manageClothes.setClothCollected(clothNum)
			queue_free()		

