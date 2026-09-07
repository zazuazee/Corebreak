extends RefCounted

const PLAYER_SPEED: float = 180.0
const PLAYER_MAX_HP: int = 3
const CORE_ACTIVATION_TIME: float = 1.5
const BLAST_RANGE: int = 2
const MATCH_DURATION: float = 120.0
const INVULNERABILITY_TIME: float = 0.5
const OVERCHARGE_RANGE: int = 4

static func as_dictionary() -> Dictionary:
    return {
        "player_speed": PLAYER_SPEED,
        "player_max_hp": PLAYER_MAX_HP,
        "core_activation_time": CORE_ACTIVATION_TIME,
        "blast_range": BLAST_RANGE,
        "match_duration": MATCH_DURATION,
        "invulnerability_time": INVULNERABILITY_TIME,
        "overcharge_range": OVERCHARGE_RANGE,
    }
