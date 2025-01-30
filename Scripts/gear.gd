extends StaticBody2D

@onready var self_sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_power() -> void:
	# is there a gear to the side? if so, power
	pass

func attached():
	self_sprite.set_frame(3)

func detached():
	self_sprite.set_frame(1)

func power_on():
	self_sprite.set_frame(5)
	
func power_off():
	self_sprite.set_frame(1)
