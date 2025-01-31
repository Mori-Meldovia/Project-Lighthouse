extends StaticBody2D

@onready var self_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_sprite.play("default")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attached():
	self_sprite.play("attached")

func detached():
	self_sprite.play("default")

func power_on():
	self_sprite.play("powered")

func power_off():
	self_sprite.play("default")
