extends StaticBody2D

@onready var self_sprite = $AnimatedSprite2D

var latched = false
var powered = false
@onready var disabled = !is_in_group("attachable")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_sprite.play("default_disabled" if disabled else "default")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attached():
	self_sprite.play("powered_attached" if powered else "attached")
	latched = true

func detached():
	self_sprite.play("powered" if powered else "default")
	latched = false

func power_on():
	self_sprite.play("powered_attached" if latched else ("powered_disabled" if disabled else "powered"))
	powered = true
	
func power_off():
	self_sprite.play("default_attached" if latched else ("default_disabled" if disabled else "default"))
	powered = false
