extends SceneTree

func _initialize() -> void:
    var config = load("res://scripts/core/GameConfig.gd").new()
    assert(config.BOARD_WIDTH == 11)
    assert(config.BOARD_HEIGHT == 15)
    assert(config.CELL_SIZE == 64.0)
    print("Board config validation passed")
    quit()
