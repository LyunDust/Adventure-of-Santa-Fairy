#Owner: LeeSoyoung
extends Area2D

var windowSize
var setPosition = false

#Position randomly within windowSize
func _ready():
	windowSize = get_viewport_rect().size
	visible  = false
	position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))


func _physics_process(_delta):
	#If the sensor collides with the background, wall, other presents, or Santa bag, it repositions.
	#If not, change the setPosition to true to confirm the location and make the presents visible
	if setPosition == false:
		if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding() or $RayCast2D4.is_colliding() or $RayCast2D5.is_colliding() or $RayCast2D6.is_colliding() or $RayCast2D7.is_colliding() or $RayCast2D8.is_colliding():
			position = Vector2(rand_range(18, windowSize.x-18), rand_range(100, windowSize.y-16))
		else:
			setPosition = true
			visible = true
	
#If the present collides with the player while the location is confirmed, the present 
#disappears and the presentNum is reduced by 1.
func _on_bluePresnet_body_entered(_body):		
	if setPosition == true:	
		Global.set_presentCollected(true)
		queue_free()
		Global.presentNum -= 1	
		

		
