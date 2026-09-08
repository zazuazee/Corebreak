extends Node2D

const GameConfig = preload("res://scripts/core/GameConfig.gd")

var board: Node
var grid_position: Vector2i = Vector2i.ZERO
var max_hp: int = 3
var current_hp: int = 3
var score: int = 0
var has_core_available: bool = true
var is_eliminated: bool = false
var game: Node = null

var movement_speed: float = GameConfig.PLAYER_SPEED
var world_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	if board == null:
		return

func set_board(target_board: Node) -> void:
	board = target_board

func set_game(target_game: Node) -> void:
	game = target_game

func spawn_at(spawn_cell: Vector2i) -> void:
	if board == null:
		return

	if not board.has_method("is_inside_grid"):
		return

	if not board.is_inside_grid(spawn_cell):
		return

	if board.get_cell_type(spawn_cell) != board.CellType.FLOOR:
		return

	grid_position = spawn_cell
	world_position = board.grid_to_world(spawn_cell)
	global_position = world_position + Vector2(board.cell_size, board.cell_size) * 0.5

func try_move(direction: Vector2i) -> bool:
	if board == null:
		return false

	var target_cell: Vector2i = grid_position + direction
	if not board.is_inside_grid(target_cell):
		return false

	var target_type = board.get_cell_type(target_cell)
	if target_type != board.CellType.FLOOR:
		return false

	grid_position = target_cell
	world_position = board.grid_to_world(target_cell)
	global_position = world_position + Vector2(board.cell_size, board.cell_size) * 0.5
	return true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		try_move(Vector2i.UP)
	elif event.is_action_pressed("move_down"):
		try_move(Vector2i.DOWN)
	elif event.is_action_pressed("move_left"):
		try_move(Vector2i.LEFT)
	elif event.is_action_pressed("move_right"):
		try_move(Vector2i.RIGHT)
	elif event.is_action_pressed("place_core"):
		if game != null and has_core_available and game.has_method("request_core_placement"):
			game.request_core_placement(self)
