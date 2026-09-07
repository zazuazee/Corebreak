extends SceneTree

func _initialize() -> void:
    var config = load("res://scripts/core/GameConfig.gd").new()
    assert(config.PLAYER_SPEED == 180.0)
    assert(config.PLAYER_MAX_HP == 3)
    assert(config.CORE_ACTIVATION_TIME == 1.5)
    assert(config.BLAST_RANGE == 2)
    assert(config.MATCH_DURATION == 120.0)
    assert(config.INVULNERABILITY_TIME == 0.5)
    assert(config.OVERCHARGE_RANGE == 4)
    print("GameConfig validation passed")
