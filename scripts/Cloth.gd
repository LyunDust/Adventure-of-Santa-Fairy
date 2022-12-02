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
	position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))
	
func _physics_process(delta):
	if($RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding() or $RayCast2D4.is_colliding()):
		position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))

func setClothNum(num): #Unique numbering for each cloth
	clothNum = num
	
func getClothNum()->int: #Find out what the cloth is by returning their unique number
	return clothNum
	
func setSpriteTexture(sprite_texture): #Load the corresponding image
	$Sprite.texture =load(sprite_texture) 

func set_key(): #Generate a random key each time the player accesses it
	keyNum = randi() % 4 + 1 #1-4
	if keyNum == 1:
		$KeyShape/Label.text = "Y"
		key = KEY_Y
	elif keyNum == 2:
		$KeyShape/Label.text = "U"
		key = KEY_U
	elif keyNum == 3:
		$KeyShape/Label.text = "I"
		key = KEY_I
	elif keyNum == 4:
		$KeyShape/Label.text = "O"
		key = KEY_O
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

