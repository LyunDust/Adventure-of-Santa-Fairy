extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 200
var isMoving = true
var blinking = false
var life = 3
signal playerDamage

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if isMoving == true:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		velocity = velocity.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func pausePlayer():
	isMoving = false
	$Timer.start()
	$Timer/blink.start()
	life -= 1
	emit_signal("playerDamage")
	
	if life == 0:
		Global.playerDie = true
		print('game over')
		$Timer2.start()
		
		
func _on_Timer_timeout():
	isMoving = true
	$Timer/blink.stop()
	set_modulate(Color(1, 1, 1))

func _on_blink_timeout():
	if blinking == false:
		set_modulate(Color(0.5, 0.5, 0.5))
		blinking = !blinking
	else: 
		set_modulate(Color(1, 1, 1))
		blinking = !blinking


func _on_Timer2_timeout():
	get_tree().paused = true
	

func _on_Santa_bag_playerPause():
	isMoving = false
	$Timer.start()
