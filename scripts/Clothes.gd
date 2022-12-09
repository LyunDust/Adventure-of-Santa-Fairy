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
	#If the number of clothes collected equals the total number of clothes, 
	#achieve one of the game's success conditions
	if numOfCollectedClothes == numOfClothes:
		isAllClothesCollected = true
	#When all the game success conditions are achieved, 
	#the story screen changes.
	if isAllClothesCollected == true and Global.presentNum == 0:
		BackGroundMusic.pause_level2SceneMusic()
		get_tree().change_scene("res://scenes/EndingStoryScene.tscn")

	
func set_child(): #Get children to specify a unique number and image
	var cloth_texture
	clothesList= get_children()
	numOfClothes=get_child_count()
	for i in numOfClothes:
		clothesList[i].setClothNum(i)
		cloth_texture = str("res://Images/SantaCloth", i,".png")
		clothesList[i].setSpriteTexture(cloth_texture)
		isClothCollected.append(false)
	

func checkBeforeClothCollected(i)->bool: 
	#Check if previous order clothes have been acquired
	#in order to obtain the clothes in the back
	#only when the clothes in the front are acquired
	if i < 1:
		return true
	else:
		return isClothCollected[i-1]
		
func setClothCollected(i): #If you get clothes, increase the total number of clothes you collected
	isClothCollected[i]=true
	numOfCollectedClothes += 1 


