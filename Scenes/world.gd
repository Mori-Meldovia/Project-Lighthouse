extends Node2D


const DIRS = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for y in range(H):
		var row = []
		for x in range(W):
			row.push_back(0);
		power.push_back(row)
	power_tick()
	print(power)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



const GRID_SIZE = 16
const W = 15
const H = 11

# Converts grid coordinate to position vector
func coord2pos(coord: Vector2i) -> Vector2:
	return GRID_SIZE * (Vector2(coord) + Vector2.ONE / 2)

# Converts position vector to grid position. Used to fetch starting positions of movables
func pos2coord(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos / GRID_SIZE))


func getComponentAt(coord: Vector2i):
	for child in get_children():
		if pos2coord(child.position) == coord:
			return child
	return null


var power = []

# updates power levels of everything
func power_tick():
	var new_power = []
	var updated = []
	for y in range(H):
		var row = []
		var row2 = []
		for x in range(W):
			row.push_back(0)
			row2.push_back(false)
		new_power.push_back(row)
		updated.push_back(row2)
	
	# check from the player
	
	# find the player
	var player_pos = pos2coord(get_tree().get_nodes_in_group("player")[0].position)
	# fire an update to all sides of the player
	power[player_pos.y][player_pos.x] = 1
	updated[player_pos.y][player_pos.x] = true
	for dir in DIRS:
		power_update(player_pos + dir, "source", new_power, updated)
		
	
	# check from the spawnpoint
	# TODO
	# if spawnpoint_active: 
		# power_update(spawnpoint_pos, new_power, updated)
	
	
	for y in range(H):
		for x in range(W):
			power[y][x] = max(new_power[y][x], power[y][x] - 1)
	

const can_power = {
	"source": {
		"bulb": 0,
		"gear": 1,
		"axle": 0,
		"gearbox": 1,
	},
	"gear": {
		"bulb": 0,
		"gear": 1,
		"axle": 0,
		"gearbox": 1,
	},
	"axle": {
		"bulb": 0,
		"gear": 0,
		"axle": 1,
		"gearbox": 1,
	},
	"gearbox": {
		"bulb": 1,
		"gear": 1,
		"axle": 1,
		"gearbox": 0,
	}
}

func power_update(pos, source, power, updated):
	# if out of bounds or updated or no component
	if (updated[pos.y][pos.x] || pos.x < 0 || pos.x >= W || pos.y < 0 || pos.y >= H || !getComponentAt(pos) || getComponentAt(pos).get_groups().size() < 1):
		return
	
	updated[pos.y][pos.x] = true
	
	var group = getComponentAt(pos).get_groups()[0];
	
	if (!group):
		return
	
	if can_power[source][group]:
		power[pos.y][pos.x] = can_power[source][group]
		
		# recursively power, if it can power
		if can_power.has(group):
			for dir in DIRS:
				power_update(pos + dir, group, power, updated)
