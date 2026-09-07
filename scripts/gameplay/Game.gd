extends Node2D

const PlayerScene = preload("res://scenes/entities/Player.tscn")

@onready var board: Node2D = $Board

func _ready() -> void:
    if not board:
        return

    var player_scene = PlayerScene.instantiate()
    add_child(player_scene)
    player_scene.set_board(board)
    player_scene.spawn_at(board.spawn_player)
