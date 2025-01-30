extends StaticBody2D  # The crate does NOT move

@export var health: int = 2  # Number of hits before breaking
@onready var unboundSprite = $Default  # Reference to the crate sprite
@onready var boundSprite = $Attached


func _ready():
	boundSprite.hide()

func break_crate():
	health -= 1
	print("Crate hit! Remaining health:", health)

	if health <= 0:
		queue_free()  # Remove the crate from the game
		print("Crate destroyed!")
	else:
		unboundSprite.modulate = Color(1, 0.5, 0.5)  # Change color to show damage

func attached():
	unboundSprite.hide()
	boundSprite.show()

func detached():
	unboundSprite.show()
	boundSprite.hide()
