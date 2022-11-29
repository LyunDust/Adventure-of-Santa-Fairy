# Owner: Kim Hyeri

extends Area2D

class_name Item

var itemXPos
var itemYPos


func _init():
	itemXPos = 0
	itemYPos = 520


func _ready():
	itemXPos = rand_range(100, 3700)	
	self.set_position(Vector2(itemXPos, itemYPos))
	print("itemXPos: ", itemXPos)


func _on_Item_body_entered(body):
	if body is AislePlayer:
		self.set_position(Vector2(-100, -100))


func _on_Player_itemReset(itemReset):
	itemXPos = rand_range(100, 3700)	
	self.set_position(Vector2(itemXPos, itemYPos))
	print("itemXPos: ", itemXPos)


func _on_Player_isHeAlived(isHeAlive):
	if isHeAlive:
		self._ready()
