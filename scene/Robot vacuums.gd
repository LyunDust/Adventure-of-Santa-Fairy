extends KinematicBody2D


export (int) var speed = 80

var velocity = Vector2()
var direction = true
var isMoving = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity = velocity.normalized() * speed
	
	if is_on_wall():
		direction = !direction
	
	if isMoving == true:
		if direction == true:
			velocity.x += 1
		else:
			velocity.x -= 1
		
	velocity = move_and_slide(velocity)
		

func robotError():
	set_modulate(Color(0.5, 0.5, 0.5))
	isMoving = false
	visible = false
	velocity.x = 0
	$Timer.start()
	$Timer/blink.start()


func _on_blink_timeout():
	visible = !visible


func _on_Timer_timeout():
	$Timer/blink.stop()
	visible = true
	set_modulate(Color(1, 1, 1))
	isMoving = true
