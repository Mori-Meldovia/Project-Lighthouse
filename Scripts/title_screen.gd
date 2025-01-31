extends Control

@onready var title_button = $Title

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainAudio.play_music_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_title_pressed() -> void:
	title_button.hide()


func _on_exit_pressed() -> void:
	get_tree().quit()
