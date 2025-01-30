extends StaticBody2D  # The crate does NOT move

@export var health: int = 2  # Number of hits before breaking
@onready var sprite = $Sprite2D  # Reference to the crate sprite

func _ready():
	add_to_group("attachable")  # Ensure this object can be attached
	print("Crate ready! Health:", health)

func break_crate():
	health -= 1
	print("Crate hit! Remaining health:", health)

	if health <= 0:
		queue_free()  # Remove the crate from the game
		print("Crate destroyed!")
	else:
		sprite.modulate = Color(1, 0.5, 0.5)  # Change color to show damage
