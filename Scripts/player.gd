extends CharacterBody2D

# Reference to the RayCast2D node
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_map: AnimatedSprite2D = $AnimatedSprite2D

# A dictionary that maps input map actions to direction vectors
const inputs = {
	"Right": Vector2.RIGHT,
	"Left": Vector2.LEFT,
	"Down": Vector2.DOWN,
	"Up": Vector2.UP
}

# {Destination: Ray_Cast_2d_Direction}
var moves = []

# Stores the grid size, which is 16 (same as one tile)
var grid_size = 16

# Tracks the attached object (e.g., crate)
var attached_object = null
var attachment_offset = Vector2.ZERO

func _process(_delta):
	if Input.is_action_pressed("Right"):
		sprite_map.play("right")
	elif Input.is_action_pressed("Left"):
		sprite_map.play("left")
	else:
		sprite_map.play("default")
	
	# Consistently check for Q (ui_cancel) input when an object is attached
	if attached_object and Input.is_action_pressed("detach_object"):
		detach_object()

# Calls the move function with the appropriate input key
# if any input map action is triggered
func _input(event):
	for action in inputs.keys():
		if event.is_action_pressed(action):
			move(action, true)
	
	# Undo
	if event.is_action_pressed("Undo"):
		undo()
	
	# Restart
	if event.is_action("Restart"):
		restart()
	
	# Attach object
	if event.is_action_pressed("ui_accept"):
		attempt_attachment()

# Updates the direction of the RayCast2D according to the input key
# and moves one grid if no collision is detected
func move(action, newMove):
	var destination = inputs[action] * grid_size
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()
	
	if attached_object:
		var new_player_pos = position + destination
		var new_object_pos = attached_object.position + attachment_offset
		
		if not ray_cast_2d.is_colliding():
			position = new_player_pos
			attached_object.position = new_player_pos + attachment_offset
			
			if newMove:
				moves.append(destination)
	else:
		if not ray_cast_2d.is_colliding():
			position += destination
			if newMove:
				moves.append(destination)

func attempt_attachment():
	var directions = {
		"right": Vector2.RIGHT,
		"left": Vector2.LEFT,
		"down": Vector2.DOWN,
		"up": Vector2.UP
	}
	
	for dir in directions.keys():
		ray_cast_2d.target_position = directions[dir] * grid_size
		ray_cast_2d.force_raycast_update()
		
		if ray_cast_2d.is_colliding():
			var collider = ray_cast_2d.get_collider()
			
			if collider.is_in_group("attachable"):
				attached_object = collider
				attachment_offset = directions[dir] * grid_size
				return

func detach_object():
	if attached_object:
		attached_object.global_position = position + attachment_offset  # Keep the object in its place
		attached_object = null
		attachment_offset = Vector2.ZERO

func undo():
	if (!moves.is_empty()):
		var destination = moves.pop_back()
		position -= destination

func restart():
	if (!moves.is_empty()):
		moves.reverse()
		for destination in moves:
			position -= destination
	
	moves.clear()
