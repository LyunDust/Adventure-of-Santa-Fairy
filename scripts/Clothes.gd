#Owner: ParkSinYoung

extends Node2D

var clothesList = []
var numOfClothes
var numOfCollectedClothes = 0 
var isClothCollected = []
var isAllClothesCollected = false

func _ready():	
	set_child()
	
func _process(delta):
	if numOfCollectedClothes == numOfClothes:
		isAllClothesCollected = true
	if isAllClothesCollected == true and Global.presentNum == 0:
		BackGroundMusic.pause_level2SceneMusic()
		get_tree().change_scene("res://scenes/EndingStoryScene.tscn")

	
func set_child(): #Get children to specify a unique number and image
	var cloth_texture
	#var windowSize = get_viewport_rect().size
	clothesList= get_children()
	numOfClothes=get_child_count()
	for i in numOfClothes:
		clothesList[i].setClothNum(i)
		cloth_texture = str("res://Images/SantaCloth", i,".png")
		clothesList[i].setSpriteTexture(cloth_texture)
		isClothCollected.append(false)
	

func checkBeforeClothCollected(i)->bool: #Check if previous order clothes have been acquired
	if i < 1:
		return true
	else:
		return isClothCollected[i-1]
		
func setClothCollected(i): #If you get clothes, increase the total number of clothes you collected
	isClothCollected[i]=true
	numOfCollectedClothes += 1 


