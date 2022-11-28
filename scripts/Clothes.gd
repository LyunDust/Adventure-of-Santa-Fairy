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
	if isAllClothesCollected == true:
		get_tree().change_scene("res://scenes/EndingStoryScene.tscn")

	
func set_child():
	var cloth_texture
	clothesList= get_children()
	numOfClothes=get_child_count()
	for i in numOfClothes:
		clothesList[i].setClothNum(i)
		cloth_texture = str("res://Images/SantaCloth", i,".png")
		clothesList[i].setSpriteTexture(cloth_texture)
		isClothCollected.append(false)
	

func checkBeforeClothCollected(i)->bool:
	if i < 1:
		return true
	else:
		return isClothCollected[i-1]
		
func setClothCollected(i):
	isClothCollected[i]=true
	numOfCollectedClothes += 1 


