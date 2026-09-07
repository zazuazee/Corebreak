# COREBREAK — Architecture

**Versão:** 0.1
**Status:** MVP
**Engine:** Godot 4.x
**Linguagem:** GDScript
**Plataformas-alvo:** Android / iOS
**Orientação:** Portrait
**Arquitetura:** Modular, orientada a componentes e preparada para futura substituição da IA por jogadores de rede

---

## 1. Objetivo

Este documento define a arquitetura técnica do COREBREAK MVP.

## 2. Princípios arquiteturais

### 2.1 Gameplay antes de apresentação

As regras do jogo não devem depender da interface gráfica.

### 2.2 Separação entre regras e apresentação

O jogo deve seguir fluxo de regras e controle em camadas.

### 2.3 IA não deve controlar diretamente as regras

A IA deve solicitar ações por interfaces semelhantes às do jogador.

### 2.4 Preparação para multiplayer

O MVP será local, mas a arquitetura deve permitir uma expansão para local player, AI e network player.

---

## 3. Estrutura do projeto

```text
COREBREAK/
│
├── project.godot
│
├── docs/
│   ├── GDD.md
│   ├── ARCHITECTURE.md
│   ├── AUTOPILOT_MVP_PROMPT.md
│   ├── ROADMAP.md
│   └── DEVELOPMENT_LOG.md
│
├── assets/
│   ├── characters/
│   ├── environments/
│   ├── ui/
│   ├── audio/
│   ├── vfx/
│   └── fonts/
│
├── scenes/
│   ├── main/
│   ├── gameplay/
│   ├── entities/
│   └── ui/
│
├── scripts/
│   ├── core/
│   ├── gameplay/
│   ├── entities/
│   ├── systems/
│   └── ui/
│
├── data/
│   ├── configs/
│   └── saves/
│
└── tests/
    ├── unit/
    └── integration/
```

---

## 4. Organização das responsabilidades

### 4.1 Core

```text
scripts/core/
```

Responsável por infraestrutura e gerenciamento geral.

### 4.2 Gameplay

```text
scripts/gameplay/
```

Responsável pelas regras específicas do jogo.

### 4.3 Entities

```text
scripts/entities/
```

Responsável por entidades existentes na arena.

### 4.4 Systems

```text
scripts/systems/
```

Responsável por sistemas transversais como áudio, vibração, save e gestão de dados.

### 4.5 UI

```text
scripts/ui/
```

Responsável exclusivamente pela apresentação e interação da interface.

---

## 5. Árvore principal de cenas

A cena principal deve ser:

```text
Main
├── SceneRouter
├── GameManager
├── AudioManager
├── HapticManager
└── UI
```

Durante uma partida:

```text
Game
├── Board
│   ├── Walls
│   ├── BreakableBlocks
│   └── Floor
│
├── Players
│   ├── LocalPlayer
│   │   ├── Visual
│   │   ├── CollisionShape
│   │   └── PlayerController
│   │
│   └── AIPlayer
│       ├── Visual
│       ├── CollisionShape
│       └── AIController
│
├── Cores
│
├── EnergyWaves
│
├── PowerUps
│
└── Effects
```

---

## 6. Main

Arquivo:

```text
scenes/main/Main.tscn
```

Responsabilidade:

* inicializar o jogo;
* carregar sistemas globais;
* encaminhar para menus;
* iniciar partidas;
* controlar transições de cena.

---

## 7. GameManager

Arquivo:

```text
scripts/core/GameManager.gd
```

Responsabilidades:

* iniciar partida;
* encerrar partida;
* controlar estado geral;
* criar jogadores;
* iniciar Board;
* iniciar timer;
* comunicar resultado à UI.

Estados:

```text
BOOT
MENU
LOADING_MATCH
PLAYING
MATCH_END
RESULT
```

---

## 8. Estado da partida

Criar enum conceitual:

```gdscript
enum MatchState {
    BOOT,
    READY,
    PLAYING,
    PAUSED,
    FINISHED
}
```

Fluxo:

```text
READY
  ↓
PLAYING
  ↓
FINISHED
```

---

## 9. Board

Arquivo:

```text
scripts/gameplay/Board.gd
```

Responsabilidade:

Representar a arena baseada em grid.

---

## 10. Grid

O sistema deve utilizar coordenadas discretas.

### Conversões necessárias

```gdscript
func grid_to_world(cell: Vector2i) -> Vector2
func world_to_grid(position: Vector2) -> Vector2i
```

---

## 11. Tipos de célula

```gdscript
enum CellType {
    FLOOR,
    WALL,
    BREAKABLE
}
```

---

## 12. Configuração central

Arquivo:

```text
scripts/core/GameConfig.gd
```

Parâmetros iniciais:

```text
player_speed = 180.0
player_max_hp = 3
core_activation_time = 1.5
blast_range = 2
match_duration = 120.0
invulnerability_time = 0.5
overcharge_range = 4
```

---

## 13. Input Map

Ações abstratas fundamentais:

```text
move_up
move_down
move_left
move_right
place_core
```

Estas ações devem ser agnósticas ao tipo de entrada.

---

## 14. Regra de implementação

Durante a Sprint 0, o objetivo é apenas preparar a fundação do projeto. O gameplay não deve ser implementado nesta etapa.
