extends KinematicBody2D

const UP = Vector2(0,-1) #floor

const GRAVITY = 10
const SPEED = 150
const JUMP_HEIGHT = -300
var jump_count = 0
var motion = Vector2() #velocity
var on_ground = false
var moedas = 0
var limite = 500

var verifica = 0
func morte():
	get_tree().reload_current_scene()
	pass
	

func _physics_process(delta):
	
	var jump = Input.is_action_just_pressed("ui_up")
	var jump_stop = Input.is_action_just_released("ui_up")
	
	#direita
	if Input.is_action_pressed("ui_right"):
		
		if $RayCast2D.is_colliding() and $Sprite.flip_h and not is_on_floor():
			motion.y = JUMP_HEIGHT
			
		motion.x = SPEED
		if is_on_floor():
			$AnimationPlayer.play("walk")
		$Sprite.flip_h = false
		$RayCast2D.rotation_degrees = -90
	#esquerda
	elif Input.is_action_pressed("ui_left"):
		
		if $RayCast2D.is_colliding() and not $Sprite.flip_h and not is_on_floor():
			motion.y = JUMP_HEIGHT
		
		motion.x = -SPEED
		if is_on_floor():
			$AnimationPlayer.play("walk")
		$Sprite.flip_h = true
		$RayCast2D.rotation_degrees = 90
	else:
		motion.x = 0
		if is_on_floor():
			$AnimationPlayer.play("idle")
	if jump:
		if jump_count <2:
			jump_count +=1
			motion.y = JUMP_HEIGHT
			on_ground = false
			verifica = 1
			
	elif jump_stop and motion.y < 0:
		motion.y *= 0.5
		
		
	motion.y += GRAVITY + delta
	motion = move_and_slide(motion, UP)
	
	
	if is_on_floor():
		if on_ground == false:
			jump_count = 0
			on_ground = true
	else:
		if on_ground == true:
			jump_count = 2
			on_ground = false
		else:
			if verifica == 1:
				$AnimationPlayer.play("jump")
				verifica=0
	if position.y > limite:
		morte()


func moeda():
	pass