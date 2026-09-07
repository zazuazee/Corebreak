extends SceneTree

func _initialize() -> void:
    var board_script = load("res://scripts/gameplay/Board.gd")
    var board = board_script.new()
    var player_script = load("res://scripts/entities/Player.gd")
    var player = player_script.new()

    player.set_board(board)
    player.spawn_at(board.spawn_player)

    assert(player.grid_position == board.spawn_player)
    assert(board.get_cell_type(board.spawn_player) == board.CellType.FLOOR)

    var valid_move = Vector2i.ZERO
    var invalid_move = Vector2i.ZERO
    var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

    for direction in directions:
        var target = board.spawn_player + direction
        if board.is_inside_grid(target) and board.get_cell_type(target) == board.CellType.FLOOR:
            valid_move = direction
            break

    assert(valid_move != Vector2i.ZERO)
    assert(player.try_move(valid_move))
    assert(player.grid_position == board.spawn_player + valid_move)

    for direction in directions:
        var target = player.grid_position + direction
        if not board.is_inside_grid(target) or board.get_cell_type(target) != board.CellType.FLOOR:
            invalid_move = direction
            break

    assert(invalid_move != Vector2i.ZERO)
    assert(not player.try_move(invalid_move))
    assert(player.grid_position == board.spawn_player + valid_move)

    print("Player movement validation passed")
    quit()
