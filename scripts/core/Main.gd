extends Node

@onready var game_manager: Node = $GameManager
@onready var audio_manager: Node = $AudioManager
@onready var haptic_manager: Node = $HapticManager

func _ready() -> void:
    print("COREBREAK boot sequence started")

    if game_manager and game_manager.has_method("initialize"):
        game_manager.initialize()

    if audio_manager and audio_manager.has_method("initialize"):
        audio_manager.initialize()

    if haptic_manager and haptic_manager.has_method("initialize"):
        haptic_manager.initialize()

    print("COREBREAK Main ready")
