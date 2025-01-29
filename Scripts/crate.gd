extends StaticBody2D  # The crate does NOT move

@export var health: int = 2  # Number of hits before breaking
@onready var sprite = $Sprite2D  # Reference to the crate sprite

func break_crate():
	health -= 1
	if health <= 0:
		queue_free()  # Remove the crate from the game
		print("Crate destroyed!")  # Debug message
	else:
		sprite.modulate = Color(1, 0.5, 0.5)  # Change color to show damage
