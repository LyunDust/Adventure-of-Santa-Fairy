extends Sprite

var num
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ray
var rayInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	ray = load("res://scene/ray.tscn")
	rayInstance = ray.instance()
	add_child(rayInstance)
	
	randomize()
	visible = false
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	num = rand_range(0, 10)
	if num > 2:
		visible = true
	$Timer/smallTimer.start()


func _on_smallTimer_timeout():
	visible = false
	rayInstance.visible = true
