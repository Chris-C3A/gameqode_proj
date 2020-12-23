extends Entity



onready var is_facing_right := true

var direction := 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	# self._get_input()
	var direction := self.get_direction()
	
	if direction.x > 0:
		is_facing_right = true
		$AnimatedSprite.play("walk")		
	elif direction.x < 0:
		is_facing_right = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
		
	if not is_on_floor():
		print("jumping")
		$AnimatedSprite.play("jump")
		
	$AnimatedSprite.set_flip_h(not is_facing_right)
	
	_velocity = calculate_move_velocity(_velocity, direction, is_jump_interrupted)
	
	move_and_slide(_velocity, FLOOR_NORMAL)
	

func get_direction() -> Vector2:
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	); # return a val between 1 and -1


func calculate_move_velocity(vel: Vector2, direction: Vector2, is_jump_interrupted: bool) -> Vector2:
	var new_velocity := vel
	new_velocity.x = speed.x * direction.x
	if direction.y < 0.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

"""
func _get_input() -> void:
	if Input.is_action_pressed("ui_right"):
		direction = 1
		is_facing_right = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		is_facing_right = false
		$AnimatedSprite.play("walk")
	else:
		direction = 0
		$AnimatedSprite.play("idle")"""
	


	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
