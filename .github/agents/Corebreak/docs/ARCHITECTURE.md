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

Seu objetivo é estabelecer:

* estrutura de diretórios;
* organização das cenas;
* responsabilidades dos scripts;
* fluxo de execução;
* comunicação entre sistemas;
* estados do jogo;
* modelo de dados;
* regras de dependência;
* padrões de implementação;
* estratégia de testes;
* preparação para futura implementação multiplayer.

Este documento deve ser utilizado em conjunto com:

* `docs/GDD.md`
* `docs/AUTOPILOT_MVP_PROMPT.md`

O `GDD.md` define **o que o jogo deve ser**.

O `AUTOPILOT_MVP_PROMPT.md` define **como o agente deve trabalhar**.

Este documento define **como o software deve ser estruturado**.

---

## 2. Princípios arquiteturais

O projeto deve seguir os seguintes princípios.

## 2.1 Gameplay antes de apresentação

As regras do jogo não devem depender da interface gráfica.

O jogo deve continuar funcionando mesmo que:

* HUD seja removido;
* menus sejam removidos;
* efeitos visuais sejam substituídos;
* sons sejam desativados.

---

## 2.2 Separação entre regras e apresentação

Não colocar regras importantes de gameplay em:

* scripts de HUD;
* scripts de menus;
* animações;
* efeitos visuais;
* componentes de input visual.

Exemplo incorreto:

```gdscript
func _on_core_button_pressed():
    player.hp -= 1
```

O botão não deve conhecer as regras do jogo.

Exemplo correto:

```text
CoreButton
    ↓
PlayerController
    ↓
Player
    ↓
GameRules
```

---

## 2.3 IA não deve controlar diretamente as regras

A IA deve tomar decisões através das mesmas interfaces utilizadas pelo jogador.

A IA não deve:

* modificar HP diretamente;
* destruir blocos diretamente;
* teletransportar o personagem;
* ignorar colisões;
* acessar informações ocultas;
* criar Core sem respeitar cooldown/estado;
* aplicar dano diretamente.

A IA deve solicitar ações.

Exemplo:

```text
AIController
      ↓
PlayerController
      ↓
Player
      ↓
GameRules
```

---

## 2.4 Preparação para multiplayer

O MVP será exclusivamente local.

Entretanto, a arquitetura deve permitir futuramente:

```text
LocalPlayer
AIPlayer
NetworkPlayer
```

sem modificar profundamente:

* Board;
* GameRules;
* CoreCharge;
* EnergyWave;
* sistema de dano;
* sistema de pontuação.

---

## 3. Estrutura do projeto

Estrutura recomendada:

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

## 4.1 Core

```text
scripts/core/
```

Responsável por infraestrutura e gerenciamento geral.

Exemplos:

```text
GameManager.gd
GameConfig.gd
EventBus.gd
```

---

## 4.2 Gameplay

```text
scripts/gameplay/
```

Responsável pelas regras específicas do jogo.

Exemplos:

```text
Board.gd
GameRules.gd
MatchState.gd
ScoreSystem.gd
```

---

## 4.3 Entities

```text
scripts/entities/
```

Responsável pelas entidades existentes na arena.

Exemplos:

```text
Player.gd
CoreCharge.gd
EnergyWave.gd
BreakableBlock.gd
PowerUp.gd
```

---

## 4.4 Systems

```text
scripts/systems/
```

Responsável por sistemas transversais.

Exemplos:

```text
AudioManager.gd
HapticManager.gd
SaveManager.gd
StatisticsManager.gd
TutorialManager.gd
```

---

## 4.5 UI

```text
scripts/ui/
```

Responsável exclusivamente pela apresentação e interação da interface.

Exemplos:

```text
HUD.gd
MainMenu.gd
ResultScreen.gd
SettingsScreen.gd
VirtualJoystick.gd
```

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

O Main não deve conter regras específicas de combate.

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

O GameManager não deve implementar diretamente:

* movimentação;
* IA;
* cálculo da Energy Wave;
* lógica de dano.

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

No MVP, PAUSED pode existir estruturalmente, mas não precisa necessariamente ser exposto na interface.

---

## 9. Board

Arquivo:

```text
scripts/gameplay/Board.gd
```

Responsabilidade:

Representar a arena baseada em grid.

O Board deve conhecer:

* largura;
* altura;
* tamanho das células;
* posição das células;
* tipo de cada célula;
* obstáculos;
* blocos destrutíveis;
* áreas ocupadas.

---

## 10. Grid

O sistema deve utilizar coordenadas discretas.

Exemplo:

```text
(0,0) (1,0) (2,0) (3,0)
(0,1) (1,1) (2,1) (3,1)
(0,2) (1,2) (2,2) (3,2)
```

Conversões necessárias:

```text
Grid → World
World → Grid
```

Exemplo conceitual:

```gdscript
func grid_to_world(cell: Vector2i) -> Vector2
```

e:

```gdscript
func world_to_grid(position: Vector2) -> Vector2i
```

Essas funções devem existir em um único local.

Não duplicar cálculos de conversão em diferentes scripts.

---

## 11. Tipos de célula

Criar enum:

```gdscript
enum CellType {
    FLOOR,
    WALL,
    BREAKABLE
}
```

Futuras extensões podem incluir:

```text
HAZARD
BOOST
TELEPORT
SPECIAL
```

mas não devem ser implementadas no MVP.

---

## 12. Board e regras de destruição

O Board deve responder perguntas como:

```text
A célula está livre?
Existe parede?
Existe bloco destrutível?
Posso atravessar?
Posso colocar Core?
```

Exemplos conceituais:

```gdscript
func is_walkable(cell: Vector2i) -> bool
func is_blocking(cell: Vector2i) -> bool
func is_breakable(cell: Vector2i) -> bool
func destroy_breakable(cell: Vector2i) -> void
```

---

## 13. Player

Arquivo:

```text
scripts/entities/Player.gd
```

O Player representa o estado da entidade.

Responsabilidades:

* HP;
* score;
* posição;
* estado de invulnerabilidade;
* disponibilidade do Core;
* power-ups ativos;
* eliminação.

O Player não deve decidir sozinho qual direção seguir.

---

## 14. PlayerController

Arquivo conceitual:

```text
scripts/gameplay/PlayerController.gd
```

Responsabilidade:

Transformar uma intenção de controle em movimento/ação.

Entradas possíveis:

```text
MOVE_UP
MOVE_DOWN
MOVE_LEFT
MOVE_RIGHT
PLACE_CORE
```

No jogador humano:

```text
Touch Input
    ↓
PlayerController
```

Na IA:

```text
AI Decision
    ↓
AIController
    ↓
PlayerController
```

---

## 15. Separação Player / Controller

A entidade:

```text
Player
```

representa **quem é o jogador**.

O controller representa:

**o que o jogador quer fazer**.

Isso é fundamental para o multiplayer futuro.

Arquitetura:

```text
                 ┌── LocalInput
                 │
PlayerController ├── AIController
                 │
                 └── NetworkController
                         ↓
                       Player
```

---

## 16. Movimento

O movimento deve ser compatível com a lógica baseada em grid.

O jogador pode se mover em quatro direções:

```text
UP
DOWN
LEFT
RIGHT
```

Não utilizar movimento diagonal no MVP.

O sistema deve:

1. receber direção;
2. verificar colisão;
3. determinar célula alvo;
4. verificar se pode atravessar;
5. mover;
6. manter o personagem alinhado ao grid quando necessário.

---

## 17. CoreCharge

Arquivo:

```text
scripts/entities/CoreCharge.gd
```

Representa o dispositivo colocado pelo jogador.

Estados:

```gdscript
enum CoreState {
    AVAILABLE,
    ACTIVE,
    RESOLVING,
    CONSUMED
}
```

Fluxo:

```text
AVAILABLE
    ↓
ACTIVE
    ↓
RESOLVING
    ↓
CONSUMED
```

Depois da resolução, o jogador poderá receber novamente disponibilidade de Core conforme as regras do MVP.

---

## 18. Colocação do Core

Fluxo:

```text
Player Input
     ↓
PlayerController
     ↓
Player.can_place_core()
     ↓
GameRules
     ↓
CoreCharge
```

O botão de Core nunca deve instanciar diretamente a Energy Wave.

---

## 19. Energy Wave

Arquivo:

```text
scripts/entities/EnergyWave.gd
```

A Energy Wave deve ser baseada em quatro direções:

```text
UP
DOWN
LEFT
RIGHT
```

Ela percorre a arena célula por célula.

Fluxo:

```text
CoreCharge
    ↓
EnergyWave
    ↓
Direction
    ↓
Board
    ↓
Cell
    ↓
Interaction
```

---

## 20. Algoritmo da Energy Wave

Para cada direção:

```text
posição inicial
      ↓
próxima célula
      ↓
verificar célula
      ↓
WALL?
 ├── sim → parar
 └── não
      ↓
BREAKABLE?
 ├── sim → destruir e parar
 └── não
      ↓
aplicar efeitos
      ↓
continuar
```

A parede interrompe completamente a propagação.

O bloco destrutível é destruído e também interrompe a propagação naquela direção.

---

## 21. Blast Range

O alcance padrão é:

```text
2 células
```

Cada direção deve respeitar o valor configurável.

Exemplo:

```gdscript
blast_range = 2
```

O Power-up Overcharge poderá modificar temporariamente esse valor.

---

## 22. Dano

O dano deve ser processado por um sistema de regras.

Não permitir que:

```text
EnergyWave.gd
```

modifique arbitrariamente:

```text
player.hp
```

Preferir:

```text
EnergyWave
    ↓
DamageRequest
    ↓
GameRules
    ↓
Player.apply_damage()
```

---

## 23. Player Damage

O Player deve possuir:

```text
HP
MAX_HP
INVULNERABLE
ELIMINATED
```

No MVP:

```text
MAX_HP = 3
```

Após receber dano:

```text
HP -= 1
```

e inicia-se o período de invulnerabilidade.

Valor configurável:

```text
invulnerability_time ≈ 0.75–1.0 s
```

---

## 24. Eliminação

Quando:

```text
HP <= 0
```

o Player entra em:

```text
ELIMINATED
```

Depois:

```text
GameRules
    ↓
verifica condições de vitória
```

A UI não deve decidir se a partida terminou.

---

## 25. GameRules

Arquivo:

```text
scripts/gameplay/GameRules.gd
```

É uma das partes mais importantes da arquitetura.

Responsabilidades:

* vitória;
* derrota;
* empate;
* pontuação;
* dano;
* eliminação;
* interação entre entidades;
* regras do Core;
* regras da Energy Wave;
* término por tempo.

Não deve conter código de apresentação.

---

## 26. Sistema de pontuação

Valores do MVP:

```text
Breakable Block = +10
Energy Pickup   = +25
Elimination     = +100
```

A pontuação pertence ao Player, mas a aplicação da pontuação deve ser validada pelas regras do jogo.

Exemplo:

```gdscript
game_rules.add_score(player, 10)
```

---

## 27. Match Timer

Duração:

```text
120 segundos
```

O timer pertence ao estado da partida.

Fluxo:

```text
GameManager
     ↓
Match Timer
     ↓
GameRules
     ↓
check_match_end()
```

Ao chegar a zero:

```text
FINISHED
```

e o resultado é calculado.

---

## 28. Resultado da partida

Criar conceito:

```gdscript
enum MatchResult {
    VICTORY,
    DEFEAT,
    DRAW
}
```

O cálculo deve considerar:

1. eliminação;
2. sobrevivência;
3. pontuação;
4. tempo.

A regra final deve permanecer centralizada em `GameRules`.

---

## 29. AIController

Arquivo:

```text
scripts/gameplay/AIController.gd
```

A IA deve funcionar como um controlador.

Ela não deve ser responsável pelo estado do Player.

---

## 30. Máquina de decisão da IA

A IA pode utilizar o seguinte fluxo:

```text
PERCEIVE
   ↓
EVALUATE
   ↓
DECIDE
   ↓
ACT
   ↓
REASSESS
```

Exemplo:

```text
Existe perigo imediato?
    ↓
   SIM
    ↓
Mover para posição segura

   NÃO
    ↓
Existe oportunidade de destruir bloco?
    ↓
   SIM
    ↓
Colocar Core

   NÃO
    ↓
Perseguir jogador / explorar
```

---

## 31. Percepção da IA

A IA pode acessar apenas informações que estejam disponíveis para um jogador legítimo.

Ela pode consultar:

* Board;
* posição própria;
* posição do adversário;
* Cores ativos;
* Energy Waves;
* power-ups;
* timer;
* score.

Não deve possuir:

* informação futura;
* visão através de paredes, caso isso não seja permitido ao jogador;
* conhecimento de eventos ainda não ocorridos;
* reação instantânea artificial.

---

## 32. Dificuldades da IA

## Easy

Características:

* decisões simples;
* reação mais lenta;
* uso ocasional do Core;
* movimentação parcialmente aleatória;
* baixa capacidade de antecipação.

## Normal

Características:

* identifica ameaças;
* evita algumas situações perigosas;
* usa Core com maior frequência;
* procura destruir blocos;
* tenta perseguir o jogador.

## Hard

Características:

* avalia posições;
* identifica zonas perigosas;
* procura encurralar o jogador;
* utiliza Power-ups;
* toma decisões estratégicas;
* reage de forma consistente, mas não instantânea.

Nenhuma dificuldade deve alterar:

* HP;
* dano;
* alcance;
* velocidade;
* regras físicas;

apenas a qualidade das decisões.

---

## 33. Power-ups

Arquivo:

```text
scripts/entities/PowerUp.gd
```

No MVP existe:

```text
Overcharge
```

Efeito:

```text
próxima Energy Wave:
2 células → 4 células
```

Após utilização:

```text
PowerUp = CONSUMED
```

O efeito deve ser temporário ou de próxima utilização conforme especificado no GDD.

---

## 34. Arquitetura futura de Power-ups

Utilizar uma estrutura que permita adicionar:

```text
Shield
Speed
Phase
Recall
Multi-Core
Magnet
Dash
```

sem modificar profundamente:

```text
Player
GameRules
EnergyWave
```

Uma possível arquitetura futura:

```text
PowerUp
├── Overcharge
├── Shield
├── SpeedBoost
├── Phase
└── Dash
```

No MVP, evitar criar sistemas complexos desnecessários.

---

## 35. UI

A UI não deve possuir lógica de gameplay.

Exemplo:

```text
HUD
    ↓
GameManager / Player State
```

e não:

```text
HUD
    ↓
modifica HP
```

---

## 36. HUD

Elementos:

```text
HP
Timer
Score
Core Available
Virtual Joystick
Core Button
```

A HUD deve observar o estado do jogo.

---

## 37. Input

Criar camada de abstração para entrada.

Conceito:

```text
Input
 ↓
InputCommand
 ↓
Controller
```

Comandos:

```text
MOVE_UP
MOVE_DOWN
MOVE_LEFT
MOVE_RIGHT
PLACE_CORE
```

Isso permite futuramente:

```text
Touch
Gamepad
Keyboard
Network
```

sem modificar as regras.

---

## 38. Mobile Input

MVP:

```text
Virtual Joystick / D-Pad
+
Core Button
```

A interface deve ser:

* responsiva;
* adequada a telas pequenas;
* utilizável com uma mão quando possível;
* livre de elementos excessivamente pequenos.

A área de toque deve ser maior que a representação visual do botão quando necessário.

---

## 39. AudioManager

Arquivo:

```text
scripts/systems/AudioManager.gd
```

Responsabilidades:

* música;
* efeitos;
* volume;
* ativação/desativação;
* reprodução centralizada.

Eventos:

```text
button_click
core_place
core_charge
energy_wave
block_break
player_hit
victory
defeat
```

Gameplay não deve depender da existência de áudio.

---

## 40. HapticManager

Arquivo:

```text
scripts/systems/HapticManager.gd
```

Responsável por vibração.

Eventos:

```text
CORE_PLACED
PLAYER_DAMAGED
VICTORY
DEFEAT
```

Haptics podem ser desligados nas configurações.

---

## 41. SaveManager

Arquivo:

```text
scripts/systems/SaveManager.gd
```

Responsabilidade:

Persistência local.

Dados:

```json
{
    "version": 1,
    "settings": {},
    "statistics": {},
    "last_difficulty": "normal"
}
```

Nunca salvar dados críticos de gameplay em locais arbitrários.

---

## 42. Versionamento do Save

O save deve possuir:

```text
version
```

Exemplo:

```text
version = 1
```

Futuras versões devem possuir migração.

Exemplo:

```text
v1 → v2
```

Não apagar saves simplesmente porque a estrutura mudou.

---

## 43. StatisticsManager

Responsável por:

```text
games_played
wins
losses
draws
win_rate
```

Training não deve alterar estatísticas competitivas.

---

## 44. TutorialManager

Responsável pelo tutorial inicial.

O tutorial deve ensinar:

1. movimento;
2. Core;
3. Energy Wave;
4. dano;
5. vitória.

Deve ser:

* simples;
* curto;
* interrompível;
* reapresentável através das configurações, se desejado.

---

## 45. EventBus

É recomendável possuir um sistema central de eventos para reduzir acoplamento.

Exemplos:

```text
match_started
match_finished
player_damaged
player_eliminated
core_placed
core_resolved
block_destroyed
powerup_collected
score_changed
```

Exemplo conceitual:

```gdscript
signal player_damaged(player)
signal player_eliminated(player)
signal match_finished(result)
```

Atenção:

Não utilizar EventBus para esconder dependências importantes.

Eventos devem ser usados principalmente para comunicação desacoplada.

---

## 46. Dependências permitidas

A direção das dependências deve ser:

```text
UI
 ↓
GameManager
 ↓
GameRules
 ↓
Entities / Board
```

Sistemas auxiliares:

```text
AudioManager
HapticManager
SaveManager
StatisticsManager
```

podem observar eventos.

---

## 47. Dependências proibidas

Evitar:

```text
GameRules → HUD
Player → HUD
Board → HUD
AIController → HUD
EnergyWave → MainMenu
```

Também evitar:

```text
UI → modifica diretamente entidades
```

---

## 48. Comunicação recomendada

Exemplo de início de partida:

```text
Main
 ↓
GameManager.start_match()
 ↓
Board.initialize()
 ↓
PlayerFactory
 ↓
Players
 ↓
GameRules.start_match()
 ↓
HUD.observe_match()
```

---

## 49. Fluxo de Core

```text
Player
 ↓
PlayerController
 ↓
request_place_core()
 ↓
GameRules.validate_core()
 ↓
CoreCharge.spawn()
 ↓
ACTIVE
 ↓
activation_timer
 ↓
RESOLVING
 ↓
EnergyWave
 ↓
damage / destruction / powerups
 ↓
CONSUMED
```

---

## 50. Fluxo de dano

```text
EnergyWave
 ↓
detect target
 ↓
GameRules.process_damage()
 ↓
Player.apply_damage()
 ↓
HP updated
 ↓
invulnerability
 ↓
if HP <= 0
 ↓
Player eliminated
 ↓
GameRules.check_match_end()
```

---

## 51. Fluxo de vitória

```text
Player eliminated
        ↓
GameRules
        ↓
check_match_end()
        ↓
calculate result
        ↓
GameManager.finish_match()
        ↓
StatisticsManager
        ↓
SaveManager
        ↓
ResultScreen
```

---

## 52. Factory Pattern

Quando apropriado, utilizar factories para criação de entidades.

Exemplo:

```text
PlayerFactory
CoreFactory
PowerUpFactory
```

Benefícios:

* padronização;
* testes;
* substituição futura;
* menor acoplamento.

Não criar abstrações excessivas no MVP.

---

## 53. Configuração central

Criar configuração centralizada.

Exemplo:

```gdscript
class_name GameConfig
extends Resource
```

Valores:

```text
player_speed
player_max_hp
core_activation_time
blast_range
match_duration
invulnerability_time
overcharge_range
```

Valores iniciais:

```text
player_max_hp = 3
core_activation_time = 1.5
blast_range = 2
match_duration = 120
invulnerability_time ≈ 0.75–1.0
overcharge_range = 4
```

Os valores devem ser fáceis de alterar sem procurar constantes espalhadas pelo projeto.

---

## 54. Dados versus lógica

Sempre que possível:

```text
Dados configuráveis → Resources / Data
Regras → Scripts
Apresentação → Scenes/UI
```

Evitar hardcode de parâmetros em múltiplos arquivos.

---

## 55. Performance

O MVP deve ser desenvolvido pensando em dispositivos móveis.

Prioridades:

1. baixo custo de CPU;
2. baixo número de objetos;
3. baixo número de chamadas de renderização;
4. evitar processamento por frame desnecessário;
5. evitar criação/destruição excessiva de objetos;
6. evitar loops caros.

---

## 56. `_process()` e `_physics_process()`

Não utilizar `_process()` indiscriminadamente.

Usar:

```text
_physics_process()
```

para:

* movimento;
* física;
* colisões.

Usar:

```text
_process()
```

quando necessário para:

* timers visuais;
* animações não físicas;
* lógica não determinística.

Sempre questionar se a lógica precisa realmente executar a cada frame.

---

## 57. Object Pooling

Não é obrigatório no MVP.

Entretanto, Energy Waves e efeitos visuais podem futuramente utilizar pooling caso o profiling demonstre necessidade.

Não implementar prematuramente.

---

## 58. Determinismo

O gameplay deve ser o mais determinístico possível.

Especialmente:

* movimentação;
* Board;
* Energy Wave;
* dano;
* pontuação;
* regras de vitória.

Isso facilitará:

* testes;
* reprodução de bugs;
* replay futuro;
* multiplayer futuro.

---

## 59. Randomização

Randomização deve utilizar uma fonte controlada quando possível.

Evitar randomização irreprodutível durante testes.

A seed poderá futuramente ser registrada para reprodução de partidas.

Não é obrigatório implementar replay no MVP.

---

## 60. Testes unitários

Priorizar testes para:

```text
Board
Grid conversion
GameRules
Damage
Score
Core
EnergyWave
Victory conditions
PowerUp
SaveManager
```

---

## 61. Testes importantes

Exemplos:

### Board

```text
Wall blocks movement
Breakable blocks block movement
Floor allows movement
```

### Energy Wave

```text
Wave stops at wall
Wave destroys breakable block
Wave stops after breakable block
Wave reaches configured range
Wave damages player
```

### Player

```text
HP starts at 3
Damage decreases HP
Invulnerability prevents immediate repeated damage
HP 0 causes elimination
```

### Core

```text
Player can place Core when available
Player cannot place multiple active Cores
Core activates after configured delay
Core generates Energy Wave
```

### Match

```text
Match starts
Timer decreases
Player elimination can end match
Timer reaching zero ends match
Correct result is calculated
```

---

## 62. Testes de integração

Testar fluxos completos:

```text
Player → Core → Wave → Block
```

```text
Player → Core → Wave → Enemy
```

```text
Player → PowerUp → Core → Wave
```

```text
Enemy eliminated → Match End
```

```text
Timer → Match End → Result
```

---

## 63. QA manual

Cada build jogável deve verificar:

```text
[ ] Jogo inicia
[ ] Arena aparece corretamente
[ ] Jogador se movimenta
[ ] Colisões funcionam
[ ] Core pode ser colocado
[ ] Core respeita delay
[ ] Energy Wave aparece
[ ] Wave respeita paredes
[ ] Blocos são destruídos
[ ] Jogador recebe dano
[ ] Invulnerabilidade funciona
[ ] IA funciona
[ ] Vitória funciona
[ ] Derrota funciona
[ ] Timer funciona
[ ] Pontuação funciona
[ ] Power-up funciona
[ ] HUD funciona
[ ] Botões funcionam
[ ] Configurações funcionam
[ ] Save funciona
```

---

## 64. Arquitetura futura de multiplayer

O MVP não implementará multiplayer.

Entretanto, o sistema deve evoluir de:

```text
LocalPlayer
AIPlayer
```

para:

```text
LocalPlayer
NetworkPlayer
```

O objetivo é:

```text
                    ┌── LocalController
Player
                    ├── AIController
                    │
                    └── NetworkController
```

O `GameRules` deve permanecer independente da origem dos comandos.

---

## 65. Futuro servidor autoritativo

Para multiplayer competitivo, a arquitetura recomendada será:

```text
Client
   ↓
Input / Command
   ↓
Network
   ↓
Authoritative Server
   ↓
Game Simulation
   ↓
State Replication
   ↓
Clients
```

Não implementar no MVP.

---

## 66. Futuro MMR

O MMR deverá ser completamente separado do gameplay local.

Arquitetura futura:

```text
Match Result
     ↓
Competitive Service
     ↓
MMR Calculation
     ↓
Player Rating
```

Possível sistema:

```text
Elo
```

ou:

```text
Glicko
```

A escolha será feita quando o multiplayer for desenvolvido.

---

## 67. Futuro matchmaking

Não implementar no MVP.

Posteriormente:

```text
Player
 ↓
Matchmaking Queue
 ↓
Matchmaking Service
 ↓
Opponent
 ↓
Match Server
```

---

## 68. Progressão futura

A progressão deverá permanecer separada do resultado de gameplay.

Conceito:

```text
Match
 ↓
Result
 ├── Competitive Rating
 ├── XP
 └── Statistics
```

MMR não deve ser confundido com XP.

---

## 69. Monetização futura

Não implementar no MVP.

A arquitetura futura deverá permitir:

```text
Cosmetics
├── Character skins
├── Core skins
├── Energy effects
├── Victory effects
├── Emotes
└── Arena themes
```

Nenhum item cosmético deve modificar atributos competitivos.

---

## 70. Segurança futura

No multiplayer:

* cliente nunca deve ser autoridade final;
* score deve ser validado pelo servidor;
* resultado deve ser validado pelo servidor;
* MMR deve ser calculado no servidor;
* recompensas devem ser validadas no servidor.

Isso não precisa ser implementado no MVP.

---

## 71. Convenções de código

Usar:

```text
snake_case
```

para variáveis e funções.

Exemplo:

```gdscript
var blast_range: int = 2

func apply_damage(amount: int) -> void:
    pass
```

Classes:

```text
PascalCase
```

Exemplo:

```gdscript
class_name EnergyWave
```

Constantes:

```text
UPPER_SNAKE_CASE
```

---

## 72. Tipagem

Preferir GDScript tipado.

Exemplo:

```gdscript
var hp: int = 3
var score: int = 0
var grid_position: Vector2i
var is_eliminated: bool = false
```

Funções devem possuir tipos sempre que possível:

```gdscript
func calculate_score() -> int:
    return score
```

---

## 73. Signals

Signals devem ser utilizados para eventos.

Exemplo:

```gdscript
signal health_changed(current_hp: int)
signal eliminated()
signal core_placed()
```

Não utilizar signals para substituir chamadas diretas que exigem retorno ou resultado.

---

## 74. Erros e validações

Sistemas devem validar estados inválidos.

Exemplo:

```text
Não colocar Core se:
- jogador eliminado;
- Core já ativo;
- partida encerrada;
- célula inválida.
```

Nunca assumir que a UI enviará somente comandos válidos.

---

## 75. Logging

Durante desenvolvimento, utilizar logs claros.

Exemplo:

```text
[MATCH] Started
[CORE] Placed at (5,7)
[WAVE] Resolved
[PLAYER] Damage received
[MATCH] Player eliminated
[MATCH] Finished
```

Logs excessivos devem ser removidos ou desativados na build final.

---

## 76. Debug Mode

Criar, quando útil, ferramentas de debug que possam:

* mostrar grid;
* mostrar coordenadas;
* mostrar células bloqueadas;
* mostrar alcance da Wave;
* mostrar áreas de decisão da IA;
* mostrar estado da partida.

Esses elementos não devem aparecer na build final.

---

## 77. Scene Ownership

Cada sistema deve possuir claramente seus objetos.

Exemplo:

```text
Game
 ├── Board
 ├── Players
 ├── Cores
 ├── EnergyWaves
 └── Effects
```

O Game é responsável pelo ciclo de vida dessas entidades.

Evitar entidades criando nós diretamente em locais arbitrários da árvore.

---

## 78. Regras para o Autopilot

Antes de modificar qualquer código:

1. Ler `GDD.md`.
2. Ler `AUTOPILOT_MVP_PROMPT.md`.
3. Ler `ARCHITECTURE.md`.
4. Inspecionar o estado atual do repositório.
5. Identificar o que já foi implementado.
6. Não duplicar sistemas existentes.
7. Não quebrar funcionalidades existentes.
8. Fazer mudanças incrementais.
9. Testar após cada etapa relevante.
10. Atualizar documentação quando necessário.

---

## 79. Regra de compatibilidade

Se houver conflito entre arquivos:

```text
GDD
↓
ARCHITECTURE
↓
AUTOPILOT_MVP_PROMPT
↓
Código existente
```

Entretanto, se uma decisão arquitetural for necessária para corrigir uma inconsistência, o agente deve:

1. identificar o conflito;
2. escolher a solução mais simples;
3. preservar o comportamento definido no GDD;
4. registrar a decisão;
5. evitar alterações arbitrárias de design.

---

## 80. Não criar abstrações prematuras

O agente não deve criar:

* frameworks internos;
* sistemas genéricos desnecessários;
* dezenas de interfaces;
* padrões complexos;
* dependências externas;

sem necessidade concreta.

O MVP deve ser:

```text
simples
modular
testável
expansível
```

e não excessivamente complexo.

---

## 81. Definition of Architecture Done

A arquitetura inicial estará concluída quando:

```text
[ ] Projeto abre no Godot
[ ] Main funciona
[ ] Board possui grid
[ ] Player é independente da UI
[ ] Controller é separado do Player
[ ] AIController é separado do Player
[ ] Core é entidade independente
[ ] EnergyWave é entidade independente
[ ] GameRules controla regras
[ ] UI não controla gameplay
[ ] Configurações estão centralizadas
[ ] Sistemas de áudio/haptics são desacoplados
[ ] SaveManager é independente
[ ] Estrutura permite futuro NetworkController
[ ] Testes básicos existem
```

---

## 82. Arquitetura resumida

A arquitetura geral do COREBREAK deve ser entendida assim:

```text
                         ┌──────────────┐
                         │     Main     │
                         └──────┬───────┘
                                │
                         ┌──────▼───────┐
                         │ GameManager  │
                         └──────┬───────┘
                                │
                    ┌───────────▼───────────┐
                    │       GameRules       │
                    └───────────┬───────────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
        ┌─────▼─────┐     ┌────▼────┐      ┌─────▼─────┐
        │   Board   │     │ Players │      │   Cores   │
        └───────────┘     └────┬────┘      └─────┬─────┘
                               │                  │
                    ┌──────────┼──────────┐       │
                    │          │          │       │
              LocalController AIController NetworkController
                    │          │          │
                    └──────────┴──────────┘
                               │
                            Player
                               │
                         ┌─────▼─────┐
                         │ EnergyWave│
                         └───────────┘


          ┌───────────────┐
          │   UI / HUD    │
          └───────┬───────┘
                  │
          observa o estado


          ┌───────────────┐
          │ AudioManager  │
          ├───────────────┤
          │HapticManager  │
          ├───────────────┤
          │ SaveManager   │
          └───────────────┘
```

---

## 83. Regra arquitetural principal

A regra mais importante de todo o projeto é:

> **O COREBREAK deve ser capaz de executar suas regras de gameplay sem depender da IA, da UI, do áudio ou de qualquer sistema de apresentação.**

Isso garante que:

```text
MVP
Local Player + AI
```

possa posteriormente evoluir para:

```text
PvP Online
Local Player + Network Player
```

sem reconstruir o núcleo do jogo.

---

## 84. Próxima implementação

Após a criação deste documento, o próximo passo de desenvolvimento deve ser:

```text
FASE 1
Projeto Godot
        ↓
Board
        ↓
Player
        ↓
Movement
        ↓
Breakable Blocks
        ↓
Core
        ↓
Energy Wave
        ↓
Damage
        ↓
Basic AI
        ↓
Victory / Defeat
```

Somente após esse núcleo estar funcional devem ser implementados:

```text
Menus
HUD completo
Settings
Save
Statistics
Tutorial
Audio
Haptics
Polish
Mobile optimization
```

O objetivo da primeira build não é parecer um jogo comercial.

O objetivo é provar que o **COREBREAK é divertido e tecnicamente funcional**.
