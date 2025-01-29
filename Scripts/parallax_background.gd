extends ParallaxBackground

var CLOUD_1_SPEED = -20
var CLOUD_2_SPEED = -15
var CLOUD_3_SPEED = -10
var CLOUD_4_SPEED = -5

signal next_level()

@onready var layer1: ParallaxLayer = $CloudLayer1
@onready var layer2: ParallaxLayer = $CloudLayer2
@onready var layer3: ParallaxLayer = $CloudLayer3
@onready var layer4: ParallaxLayer = $CloudLayer4

@onready var CityBase: Sprite2D = $CityBase
@onready var Level1Base: Sprite2D = $Level1Base
@onready var Level1Button: Button = $Level1
#@onready var Level2Base: Sprite2D = $CityBase
#@onready var Level2Base: Sprite2D = $CityBase

@onready var CityForground: Sprite2D = $CityForeground

@onready var CityMidground: Sprite2D = $CityMidground

@onready var CityBackground: Sprite2D = $CityBackground

@onready var CityBackdrop: Sprite2D = $CityBackdrop

# for levels
var current_level = 0

func _ready() -> void:
	Level1Base.hide()
	Level1Button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	layer1.motion_offset.x += CLOUD_1_SPEED * delta
	layer2.motion_offset.x += CLOUD_2_SPEED * delta
	layer3.motion_offset.x += CLOUD_3_SPEED * delta
	layer4.motion_offset.x += CLOUD_4_SPEED * delta

func _on_title_pressed() -> void:
	current_level += 1
	if current_level == 1:
		CityBase.hide()
		Level1Base.show()
		Level1Button.disabled = false


func _on_level_1_pressed() -> void:
	print("Eeeee")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
