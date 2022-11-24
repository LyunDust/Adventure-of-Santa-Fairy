extends Node2D

var collectedClothes = []
var cloth
var totalClothes = 4

func _ready():
	collectedClothes = 0
	$Hat/Sprite.texture = load("res://Images/SantaHat.png")
	$Muffler/Sprite.texture = load("res://Images/SantaMuffler.png")
	$Jacket/Sprite.texture = load("res://Images/SantaJacket.png")
	$Glove/Sprite.texture = load("res://Images/SantaGlove.png")
	
	
func _process(delta):
	if $Hat == null and $Muffler == null and $Jacket == null and $Glove == null:
		print("yyyyyy")



