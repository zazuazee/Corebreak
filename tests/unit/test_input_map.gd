extends SceneTree

func _initialize() -> void:
    var actions = [
        "move_up",
        "move_down",
        "move_left",
        "move_right",
        "place_core"
    ]

    for action_name in actions:
        assert(InputMap.has_action(action_name), "Missing InputMap action: %s" % action_name)

    print("InputMap validation passed")
    quit()
