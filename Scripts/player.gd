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

func _process(_delta):
	if Input.is_action_pressed("Right"):
		sprite_map.play("right")
	elif Input.is_action_pressed("Left"):
		sprite_map.play("left")
	else:
		sprite_map.play("default")


# Calls the move function with the appropriate input key
# if any input map action is triggered
func _unhandled_input(event):
	for action in inputs.keys():
		if event.is_action_pressed(action):
			move(action, true)
	
	# Undo
	if event.is_action_pressed("Undo"):
		undo()
	
	# Restart
	if event.is_action("Restart"):
		restart()

# Updates the direction of the RayCast2D according to the input key
# and moves one grid if no collision is detected
func move(action, newMove):
	var destination = inputs[action] * grid_size
	ray_cast_2d.target_position = destination
	ray_cast_2d.force_raycast_update()
	if not ray_cast_2d.is_colliding():
		position += destination
		
		if (newMove):
			moves.append(destination);

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
