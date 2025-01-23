extends CharacterBody2D

@export var speed = 300
@export var grid_size = 64
var target_position = Vector2.ZERO
var moving = false

func _ready():
	target_position = position

func _physics_process(delta: float) -> void:
	if not moving:
			var direction = Vector2.ZERO
			
			if Input.is_action_just_pressed("Down"):
				direction = Vector2.DOWN
			elif Input.is_action_just_pressed("Up"):
				direction = Vector2.UP
			elif Input.is_action_just_pressed("Left"):
				direction = Vector2.LEFT
			elif Input.is_action_just_pressed("Right"):
				direction = Vector2.RIGHT
			
			if direction != Vector2.ZERO:
				# Update the target position based on the direction and grid size
				target_position += direction * grid_size
				moving = true
				
	if moving:
		# Move the character towards the target position
		position = position.move_toward(target_position, speed * delta)
		# Check if we are close enough to our target to snap and stop
		if position.distance_to(target_position) < speed * delta:
			position = target_position
			moving = false
