extends Node2D

const GameConfig = preload("res://scripts/core/GameConfig.gd")

signal core_placed(core: Node2D)
signal core_resolving(core: Node2D)
signal core_consumed(core: Node2D)

enum State {
	AVAILABLE,
	ACTIVE,
	RESOLVING,
	CONSUMED,
}

var state: State = State.AVAILABLE
var grid_position: Vector2i = Vector2i.ZERO
var board: Node = null
var activation_time: float = GameConfig.CORE_ACTIVATION_TIME

var _activation_timer: Timer

func _init() -> void:
	_activation_timer = Timer.new()
	_activation_timer.one_shot = true
	_activation_timer.timeout.connect(_on_activation_timeout)
	add_child(_activation_timer)
	queue_redraw()

func _draw() -> void:
	var color := Color(0.95, 0.78, 0.2, 1.0)
	if state == State.RESOLVING:
		color = Color(1.0, 0.35, 0.18, 1.0)
	elif state == State.CONSUMED:
		color = Color(0.45, 0.45, 0.45, 0.65)

	draw_circle(Vector2.ZERO, 18.0, color)
	draw_circle(Vector2.ZERO, 24.0, Color(color, 0.85), false, 3.0)
	if state == State.ACTIVE:
		var progress := 1.0 - (_activation_timer.time_left / activation_time)
		draw_arc(Vector2.ZERO, 28.0, -PI * 0.5, -PI * 0.5 + TAU * progress, 32, Color.WHITE, 4.0)

func activate_at(target_board: Node, target_cell: Vector2i) -> bool:
	if state != State.AVAILABLE:
		return false
	if target_board == null or not target_board.has_method("is_walkable"):
		return false
	if not target_board.is_walkable(target_cell):
		return false

	board = target_board
	grid_position = target_cell
	position = board.grid_to_world(target_cell) + Vector2(board.cell_size, board.cell_size) * 0.5
	state = State.ACTIVE
	_activation_timer.start(activation_time)
	queue_redraw()
	core_placed.emit(self)
	return true

func consume() -> bool:
	if state != State.RESOLVING:
		return false

	state = State.CONSUMED
	queue_redraw()
	core_consumed.emit(self)
	return true

func _on_activation_timeout() -> void:
	if state != State.ACTIVE:
		return

	state = State.RESOLVING
	queue_redraw()
	core_resolving.emit(self)