extends Node

signal state_changed(new_state)

enum MatchState {
    BOOT,
    READY,
    PLAYING,
    PAUSED,
    FINISHED,
}

@export var match_state: MatchState = MatchState.BOOT

func _ready() -> void:
    initialize()

func initialize() -> void:
    if match_state == MatchState.BOOT:
        set_match_state(MatchState.READY)
    else:
        set_match_state(match_state)

func set_match_state(new_state: MatchState) -> void:
    match_state = new_state
    state_changed.emit(match_state)
    print("GameManager state: %s" % MatchState.keys()[match_state])

func start_match() -> void:
    if match_state == MatchState.READY:
        set_match_state(MatchState.PLAYING)

func pause_match() -> void:
    if match_state == MatchState.PLAYING:
        set_match_state(MatchState.PAUSED)

func resume_match() -> void:
    if match_state == MatchState.PAUSED:
        set_match_state(MatchState.PLAYING)

func end_match() -> void:
    set_match_state(MatchState.FINISHED)
