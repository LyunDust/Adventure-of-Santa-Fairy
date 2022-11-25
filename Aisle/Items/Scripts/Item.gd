extends Area2D

var itemXPos


func _ready():
	itemXPos = rand_range(100, 3700)	
	self.set_position(Vector2(itemXPos, 520))
	print("itemXPos: ", itemXPos)


func _on_Item_body_entered(body):
	if body is AislePlayer:
		queue_free()


func _on_Player_itemReset(itemReset):
	itemXPos = rand_range(100, 3700)	
	self.set_position(Vector2(itemXPos, 520))
	print("itemXPos: ", itemXPos)
