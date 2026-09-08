extends SceneTree

const CoreScript = preload("res://scripts/entities/Core.gd")

func _initialize() -> void:
	var board_script = load("res://scripts/gameplay/Board.gd")
	var board = board_script.new()
	var core = CoreScript.new()
	root.add_child(core)
	await process_frame

	assert(core.state == core.State.AVAILABLE)
	assert(core.activate_at(board, board.spawn_player))
	assert(core.state == core.State.ACTIVE)
	assert(core.grid_position == board.spawn_player)
	assert(core.position == board.grid_to_world(board.spawn_player) + Vector2(board.cell_size, board.cell_size) * 0.5)
	assert(not core.activate_at(board, board.spawn_player))

	await create_timer(core.activation_time + 0.1).timeout
	assert(core.state == core.State.RESOLVING)
	assert(is_instance_valid(core))
	await create_timer(0.2).timeout
	assert(core.state == core.State.RESOLVING)

	var invalid_core = CoreScript.new()
	root.add_child(invalid_core)
	await process_frame
	assert(not invalid_core.activate_at(board, Vector2i(0, 0)))
	assert(invalid_core.state == invalid_core.State.AVAILABLE)

	var game_scene = load("res://scenes/gameplay/Game.tscn")
	var game = game_scene.instantiate()
	root.add_child(game)
	await process_frame
	var player = game.player
	var placed_core = game.request_core_placement(player)
	assert(placed_core != null)
	assert(not player.has_core_available)
	assert(game.request_core_placement(player) == null)

	print("Core validation passed")
	quit()