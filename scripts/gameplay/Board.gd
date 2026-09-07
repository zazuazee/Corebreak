extends Node2D

const GameConfig = preload("res://scripts/core/GameConfig.gd")

enum CellType {
    FLOOR,
    WALL,
    BREAKABLE,
}

const BOARD_WIDTH: int = GameConfig.BOARD_WIDTH
const BOARD_HEIGHT: int = GameConfig.BOARD_HEIGHT
const CELL_SIZE: float = GameConfig.CELL_SIZE

var width: int = BOARD_WIDTH
var height: int = BOARD_HEIGHT
var cell_size: float = CELL_SIZE
var grid: Array = []
var spawn_player: Vector2i
var spawn_ai: Vector2i

func _init() -> void:
    _initialize_board()

func _ready() -> void:
    _initialize_board()
    queue_redraw()

func _initialize_board() -> void:
    if grid.size() == height and grid.size() > 0 and grid[0].size() == width:
        return
    _build_grid()
    _build_default_map()
    _setup_spawns()

func _draw() -> void:
    for y in range(height):
        for x in range(width):
            var cell = Vector2i(x, y)
            var rect_position = Vector2(x * cell_size, y * cell_size)
            var color := Color(0.18, 0.22, 0.28)

            match get_cell_type(cell):
                CellType.WALL:
                    color = Color(0.35, 0.48, 0.6)
                CellType.BREAKABLE:
                    color = Color(0.76, 0.61, 0.26)
                _:
                    color = Color(0.18, 0.22, 0.28)

            draw_rect(Rect2(rect_position, Vector2(cell_size, cell_size)), color)
            draw_rect(Rect2(rect_position, Vector2(cell_size, cell_size)), Color(0.12, 0.12, 0.12), false, 1.5)

func _build_grid() -> void:
    grid = []
    for y in range(height):
        var row: Array = []
        for x in range(width):
            row.append(CellType.FLOOR)
        grid.append(row)

func _build_default_map() -> void:
    for x in range(width):
        set_cell_type(Vector2i(x, 0), CellType.WALL)
        set_cell_type(Vector2i(x, height - 1), CellType.WALL)

    for y in range(height):
        set_cell_type(Vector2i(0, y), CellType.WALL)
        set_cell_type(Vector2i(width - 1, y), CellType.WALL)

    for x in range(1, width - 1):
        for y in range(1, height - 1):
            if x % 2 == 0 and y % 2 == 0:
                set_cell_type(Vector2i(x, y), CellType.WALL)

    var breakable_positions: Array[Vector2i] = [
        Vector2i(3, 3), Vector2i(4, 3), Vector2i(6, 3), Vector2i(7, 3),
        Vector2i(3, 6), Vector2i(4, 6), Vector2i(6, 6), Vector2i(7, 6),
        Vector2i(3, 9), Vector2i(4, 9), Vector2i(6, 9), Vector2i(7, 9),
        Vector2i(5, 12), Vector2i(2, 12), Vector2i(8, 12)
    ]

    for cell in breakable_positions:
        if is_inside_grid(cell):
            set_cell_type(cell, CellType.BREAKABLE)

func _setup_spawns() -> void:
    spawn_player = Vector2i(1, 1)
    spawn_ai = Vector2i(width - 2, height - 2)

    if get_cell_type(spawn_player) != CellType.FLOOR:
        set_cell_type(spawn_player, CellType.FLOOR)
    if get_cell_type(spawn_ai) != CellType.FLOOR:
        set_cell_type(spawn_ai, CellType.FLOOR)

func is_inside_grid(cell: Vector2i) -> bool:
    return cell.x >= 0 and cell.x < width and cell.y >= 0 and cell.y < height

func grid_to_world(cell: Vector2i) -> Vector2:
    return Vector2(cell.x * cell_size, cell.y * cell_size)

func world_to_grid(world_position: Vector2) -> Vector2i:
    return Vector2i(floor(world_position.x / cell_size), floor(world_position.y / cell_size))

func get_cell_type(cell: Vector2i) -> int:
    if not is_inside_grid(cell):
        return CellType.WALL

    return grid[cell.y][cell.x]

func set_cell_type(cell: Vector2i, type: int) -> void:
    if not is_inside_grid(cell):
        return

    grid[cell.y][cell.x] = type

func is_walkable(cell: Vector2i) -> bool:
    return is_inside_grid(cell) and get_cell_type(cell) == CellType.FLOOR

func get_spawn_points() -> Dictionary:
    return {
        "player": spawn_player,
        "ai": spawn_ai,
    }
