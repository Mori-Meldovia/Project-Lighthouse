extends StaticBody2D

@onready var self_sprite = $AnimatedSprite2D

var latched = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_sprite.play("default")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attached():
	self_sprite.play("attached")
	latched = true
	

func detached():
	self_sprite.play("default")
	latched = false

func power_on():
	if !latched:
		self_sprite.play("powered")
	
func power_off():
	self_sprite.play("default")
