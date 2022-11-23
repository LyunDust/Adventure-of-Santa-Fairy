extends Area2D

var windowSize
var setPosition = false

func _ready():
	windowSize = get_viewport_rect().size
	visible  = false
	position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))
	

func _physics_process(delta):
	if setPosition == false:
		if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding() or $RayCast2D4.is_colliding() or $RayCast2D5.is_colliding() or $RayCast2D6.is_colliding() or $RayCast2D7.is_colliding() or $RayCast2D8.is_colliding():
			position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))
		else:
			setPosition = true
			visible = true
	

func _on_redPresent_body_entered(body):
	if setPosition == true:
		print('get red!!')
		queue_free()
		Global.presentNum -= 1
		print(Global.presentNum)
	
		if Global.presentNum == 0:
			get_tree().paused = true
			print('game clear!!')
