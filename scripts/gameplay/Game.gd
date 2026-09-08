extends Node2D

const PlayerScene = preload("res://scenes/entities/Player.tscn")
const CoreScene = preload("res://scenes/entities/Core.tscn")

@onready var board: Node2D = $Board
@onready var cores: Node2D = $Cores

var player: Node2D

func _ready() -> void:
    if not board:
        return

    var player_scene = PlayerScene.instantiate()
    player = player_scene
    add_child(player_scene)
    player_scene.set_board(board)
    player_scene.set_game(self)
    player_scene.spawn_at(board.spawn_player)

func request_core_placement(requesting_player: Node2D) -> Node2D:
    if requesting_player != player or not requesting_player.has_core_available:
        return null
    if not board.is_walkable(requesting_player.grid_position):
        return null
    if _has_core_at(requesting_player.grid_position):
        return null

    var core = CoreScene.instantiate()
    cores.add_child(core)
    if not core.activate_at(board, requesting_player.grid_position):
        core.queue_free()
        return null

    requesting_player.has_core_available = false
    return core

func _has_core_at(cell: Vector2i) -> bool:
    for core in cores.get_children():
        if core.state != core.State.CONSUMED and core.grid_position == cell:
            return true
    return false
