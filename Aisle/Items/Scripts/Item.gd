extends Area2D

var itemXPos


func _ready():
	itemXPos = rand_range(80, 3700)	
	self.set_position(Vector2(itemXPos, 520))


func _on_Item_body_entered(body):
	if body is AislePlayer:
		queue_free()
