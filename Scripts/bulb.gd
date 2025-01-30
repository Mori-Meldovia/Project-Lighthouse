extends Sprite2D

@onready var self_sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func power_on():
	self_sprite.set_frame(2)
	
func power_off():
	self_sprite.set_frame(1)
