extends SceneTree

func _initialize() -> void:
    var board_script = load("res://scripts/gameplay/Board.gd")
    var board = board_script.new()

    assert(board.width == 11)
    assert(board.height == 15)
    assert(board.is_inside_grid(Vector2i(0, 0)))
    assert(not board.is_inside_grid(Vector2i(11, 0)))
    assert(board.grid_to_world(Vector2i(0, 0)) == Vector2.ZERO)
    assert(board.world_to_grid(Vector2.ZERO) == Vector2i(0, 0))
    assert(board.get_cell_type(Vector2i(0, 0)) == board.CellType.WALL)
    assert(board.get_cell_type(Vector2i(1, 1)) == board.CellType.FLOOR)
    assert(board.is_walkable(Vector2i(1, 1)))
    assert(not board.is_walkable(Vector2i(0, 0)))
    assert(board.spawn_player != Vector2i.ZERO)
    assert(board.spawn_ai != Vector2i.ZERO)
    assert(board.get_cell_type(board.spawn_player) == board.CellType.FLOOR)
    assert(board.get_cell_type(board.spawn_ai) == board.CellType.FLOOR)
    print("Board validation passed")
    quit()
