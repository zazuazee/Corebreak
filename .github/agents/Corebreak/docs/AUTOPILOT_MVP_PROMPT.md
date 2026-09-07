# COREBREAK — AUTOPILOT MASTER PROMPT

## ROLE

Você é o principal desenvolvedor do projeto COREBREAK.

Atue como:

* Senior Godot Developer
* Gameplay Programmer
* Game Designer
* UI/UX Developer
* QA Engineer
* Mobile Developer

Sua responsabilidade é construir o MVP funcional do jogo descrito neste documento.

Você deve trabalhar diretamente no repositório, criando e modificando arquivos quando necessário.

O resultado esperado é um **jogo funcional**, não um conjunto de exemplos ou pseudocódigo.

---

## 1. OBJETIVO

Construir o MVP v0.1 de COREBREAK.

O MVP deve ser:

* jogável;
* estável;
* offline;
* mobile-first;
* executável em Godot;
* preparado para Android;
* preparado para iOS;
* arquiteturalmente preparado para expansão futura.

O MVP é single-player contra IA.

**Não implementar multiplayer online neste ciclo.**

---

## 2. REGRA FUNDAMENTAL

Antes de escrever código:

1. examine o repositório;
2. identifique se já existe projeto Godot;
3. leia README e documentação;
4. examine a estrutura de diretórios;
5. preserve trabalho existente;
6. identifique código reutilizável;
7. somente então comece a implementar.

Nunca substitua arquivos existentes sem necessidade.

Nunca apague funcionalidades funcionais para simplificar o projeto.

---

## 3. TECNOLOGIA

Utilize:

**Godot Engine.**

Preferencialmente:

**GDScript.**

Não adicione dependências externas sem justificativa.

Não migre o projeto para outro engine.

---

## 4. ESTRATÉGIA DE IMPLEMENTAÇÃO

Implemente incrementalmente.

Não tente construir tudo em uma única alteração.

Use esta ordem:

```text
FASE 1
Projeto base
↓
FASE 2
Arena
↓
FASE 3
Player
↓
FASE 4
Core
↓
FASE 5
Energy Wave
↓
FASE 6
Game Rules
↓
FASE 7
IA
↓
FASE 8
UI
↓
FASE 9
Power-up
↓
FASE 10
Persistence
↓
FASE 11
Audio/Vibration
↓
FASE 12
Polish
↓
FASE 13
Tests
↓
FASE 14
Mobile export
```

Após cada fase:

1. execute o projeto;
2. procure erros;
3. corrija problemas;
4. valide o comportamento;
5. somente depois continue.

---

## 5. PRIMEIRA ENTREGA

Sua primeira tarefa é criar uma versão mínima jogável contendo:

* arena;
* jogador;
* movimentação;
* obstáculos;
* Core;
* onda de energia;
* dano;
* IA básica;
* vitória/derrota.

Não implemente menus inicialmente.

Primeiro prove que o gameplay funciona.

---

## 6. GAMEPLAY

A arena utiliza uma grade.

O jogador movimenta-se:

```text
UP
DOWN
LEFT
RIGHT
```

O jogador possui 3 HP.

O Core pode ser colocado em uma célula.

Após aproximadamente 1,5 segundo:

```text
Energy Wave
```

é criada.

A onda percorre:

```text
UP
DOWN
LEFT
RIGHT
```

até atingir uma parede.

Blocos destrutíveis são removidos.

Jogadores atingidos recebem dano.

---

## 7. BOARD SYSTEM

Crie um sistema de board independente da UI.

O board deve saber:

* tamanho;
* células;
* paredes;
* blocos destrutíveis;
* células livres;
* posições de spawn.

Evite colocar a lógica do board dentro do PlayerController.

---

## 8. GAME RULES

Centralize regras importantes.

GameRules deve determinar:

* jogador vivo;
* IA viva;
* vitória;
* derrota;
* empate;
* fim do tempo.

Não espalhe essas regras entre vários scripts.

---

## 9. PLAYER

Criar PlayerController.

Responsabilidades:

* entrada;
* movimento;
* colisão;
* HP;
* dano;
* invulnerabilidade;
* eliminação;
* colocação do Core.

Não coloque lógica de IA dentro dele.

---

## 10. AI

Criar AIController separado.

A IA deve implementar:

## Easy

Movimento simples e parcialmente aleatório.

## Normal

* procurar segurança;
* colocar Core;
* perseguir;
* destruir obstáculos.

## Hard

* avaliar ameaças;
* procurar oportunidades;
* tentar encurralar;
* utilizar power-up;
* tomar decisões estratégicas.

A IA deve obedecer exatamente às mesmas regras do jogador.

Não permitir cheating.

---

## 11. CORE SYSTEM

Criar CoreCharge.

Propriedades configuráveis:

```text
activation_time
blast_range
owner
```

O Core deve possuir estados:

```text
AVAILABLE
ACTIVE
RESOLVING
CONSUMED
```

Após a resolução, o jogador recupera a capacidade de utilizar outro Core.

---

## 12. ENERGY WAVE

Criar sistema reutilizável para EnergyWave.

Não criar quatro implementações separadas.

Utilizar lógica baseada em direção:

```text
Vector2i.UP
Vector2i.DOWN
Vector2i.LEFT
Vector2i.RIGHT
```

A onda deve:

1. iniciar na célula do Core;
2. avançar célula por célula;
3. verificar colisão;
4. destruir breakable block;
5. aplicar dano;
6. parar na parede;
7. terminar.

---

## 13. DAMAGE SYSTEM

Criar sistema consistente de dano.

Ao receber dano:

```text
HP -= damage
```

Aplicar:

* feedback visual;
* feedback sonoro;
* vibração, quando habilitada;
* invulnerabilidade temporária.

Quando:

```text
HP <= 0
```

eliminar o jogador.

---

## 14. SCORE

Criar ScoreManager.

Pontuação:

```text
Breakable Block = +10
Energy Pickup   = +25
Elimination     = +100
```

A pontuação deve ser independente da UI.

---

## 15. TIMER

Criar TimerManager.

Tempo padrão:

```text
120 segundos
```

Ao chegar a zero:

* interromper gameplay;
* determinar resultado;
* mostrar resultado.

---

## 16. POWER-UP

Implementar somente:

**Overcharge.**

Ao coletar:

```text
next_blast_range = 4
```

Após utilizar o Core:

```text
next_blast_range = default
```

O sistema deve ser extensível para outros power-ups posteriormente.

---

## 17. MENU

Depois que o gameplay estiver funcional, criar:

```text
MAIN MENU

COREBREAK

[ PLAY ]

[ TRAINING ]

[ SETTINGS ]

[ ABOUT ]
```

---

## 18. DIFFICULTY

Ao clicar em PLAY:

```text
EASY
NORMAL
HARD
```

A escolha deve configurar a IA.

---

## 19. TRAINING

Training:

* inicia imediatamente;
* utiliza IA Easy;
* não altera estatísticas competitivas futuras;
* permite reinício.

---

## 20. HUD

Criar HUD mobile.

Mostrar:

* HP;
* timer;
* score;
* Core disponível;
* joystick;
* botão Core.

Utilizar layout responsivo.

Não usar posições absolutas desnecessárias.

---

## 21. MOBILE CONTROLS

Implementar controles touch.

Preferência:

**virtual joystick + botão de Core.**

O joystick deve:

* possuir área de toque confortável;
* responder rapidamente;
* funcionar em diferentes tamanhos de tela.

O botão Core deve possuir tamanho apropriado para touch.

---

## 22. RESPONSIVE UI

Configurar projeto para portrait.

Utilizar:

* anchors;
* containers;
* safe areas;
* stretch settings.

Testar diferentes proporções.

Não assumir uma resolução específica.

---

## 23. VISUAL

Criar visual original.

Direção:

**futuristic toy arcade.**

Utilizar:

* formas geométricas;
* personagens pequenos;
* energia;
* partículas simples;
* UI limpa.

Não copiar assets de jogos existentes.

Não utilizar personagens ou elementos identificáveis de franquias existentes.

Placeholders são aceitáveis durante a implementação inicial.

---

## 24. ANIMAÇÕES

Adicionar:

* spawn;
* movimento;
* colocação do Core;
* countdown;
* Energy Wave;
* destruição;
* dano;
* eliminação;
* vitória;
* derrota;
* transições de menu.

Priorizar animações simples.

---

## 25. ÁUDIO

Adicionar sons originais ou assets compatíveis com licença.

Sons mínimos:

* button_click;
* core_place;
* core_charge;
* explosion/energy_wave;
* block_break;
* hit;
* victory;
* defeat.

Criar AudioManager.

---

## 26. VIBRATION

Criar interface de feedback tátil.

Não chamar diretamente APIs de vibração espalhadas pelo projeto.

Utilizar:

```text
HapticManager
```

Permitir:

```text
enabled = true/false
```

---

## 27. SAVE SYSTEM

Criar SaveManager.

Salvar localmente:

```text
settings
statistics
last_difficulty
```

Utilizar formato simples e versionável.

Exemplo:

```json
{
    "version": 1,
    "settings": {},
    "statistics": {},
    "last_difficulty": "normal"
}
```

---

## 28. SETTINGS

Implementar:

```text
Music ON/OFF
SFX ON/OFF
Vibration ON/OFF
```

As configurações devem persistir após fechar o aplicativo.

---

## 29. STATISTICS

Registrar:

```text
games_played
wins
losses
draws
```

Não registrar Training.

Calcular:

```text
win_rate
```

---

## 30. RESULT SCREEN

Criar tela de resultado.

Deve apresentar:

* resultado;
* pontuação;
* botão replay;
* botão menu.

---

## 31. TUTORIAL

Criar tutorial simples para primeira execução.

Ensinar:

1. movimento;
2. Core;
3. Energy Wave;
4. dano;
5. vitória.

Não criar tutorial complexo.

---

## 32. TESTES

Criar testes automatizados sempre que possível.

Prioridade:

### Board

* geração;
* colisão;
* destruição.

### Core

* cooldown;
* ativação;
* alcance.

### Energy Wave

* quatro direções;
* paredes;
* blocos;
* jogadores.

### Rules

* vitória;
* derrota;
* empate;
* timeout.

### Save

* salvar;
* carregar;
* reset.

---

## 33. TESTE MANUAL

Depois da implementação, execute o jogo.

Verifique:

```text
[ ] App inicia
[ ] Menu abre
[ ] Play funciona
[ ] Difficulty funciona
[ ] Player move
[ ] Touch funciona
[ ] Core funciona
[ ] Energy Wave funciona
[ ] Walls bloqueiam
[ ] Blocks quebram
[ ] Power-up funciona
[ ] Player recebe dano
[ ] Player morre
[ ] AI funciona
[ ] Victory funciona
[ ] Defeat funciona
[ ] Draw funciona
[ ] Timer funciona
[ ] Replay funciona
[ ] Settings funcionam
[ ] Save funciona
[ ] Statistics funcionam
[ ] Tutorial funciona
```

---

## 34. DEBUG

Se encontrar bug:

```text
REPRODUZIR
↓
IDENTIFICAR CAUSA
↓
CORRIGIR
↓
TESTAR
↓
VERIFICAR REGRESSÃO
```

Não apenas esconda o erro.

Corrija a causa quando possível.

---

## 35. CODE QUALITY

Evitar:

* scripts monolíticos;
* singletons excessivos;
* variáveis globais;
* hardcoding;
* código duplicado;
* dependências circulares.

Utilizar:

* composição;
* sinais;
* recursos configuráveis;
* constantes;
* sistemas independentes.

---

## 36. CONFIGURAÇÕES CENTRALIZADAS

Valores como:

```text
player_speed
player_hp
core_activation_time
blast_range
match_duration
invulnerability_time
powerup_duration
```

devem ser configuráveis.

Evite números mágicos espalhados pelo código.

---

## 37. FUTURE-PROOFING

Não implemente sistemas futuros.

Mas não bloqueie sua implementação futura.

A arquitetura deve permitir posteriormente:

```text
Player
├── LocalPlayer
├── AIPlayer
└── NetworkPlayer
```

E:

```text
MatchManager
├── LocalMatch
└── OnlineMatch
```

Não implementar NetworkPlayer ou OnlineMatch agora.

---

## 38. NÃO IMPLEMENTAR

Explicitamente fora do MVP:

```text
NO ONLINE MULTIPLAYER
NO MATCHMAKING
NO MMR
NO LEADERBOARD
NO ACCOUNTS
NO CHAT
NO CLANS
NO SEASONS
NO BATTLE PASS
NO ADS
NO IAP
NO SHOP
NO CLOUD SAVE
NO SERVER
```

Não implementar esses sistemas mesmo que sejam tecnicamente interessantes.

---

## 39. PERFORMANCE

Priorizar:

* 60 FPS;
* baixa memória;
* poucos draw calls;
* poucos objetos;
* assets leves;
* ausência de processos desnecessários por frame.

Não otimizar prematuramente.

Quando possível, medir antes de otimizar.

---

## 40. ANDROID

Preparar exportação:

* portrait;
* package ID configurável;
* app name configurável;
* version configurável;
* ícone;
* splash;
* release configuration.

Não criar certificados ou chaves fictícias.

---

## 41. IOS

Preparar:

* portrait;
* bundle identifier configurável;
* app name;
* version;
* icon configuration.

Não criar certificados ou provisioning profiles fictícios.

---

## 42. DOCUMENTAÇÃO

Criar:

```text
README.md
docs/GDD.md
docs/ARCHITECTURE.md
docs/ROADMAP.md
```

README deve explicar:

* o jogo;
* requisitos;
* instalação;
* execução;
* exportação;
* testes.

ARCHITECTURE deve explicar os sistemas.

ROADMAP deve conter:

```text
v0.1 MVP
v0.2 Polish
v0.3 Multiplayer
v0.4 MMR
v0.5 Progression
v0.6 Cosmetics
v1.0 Release
```

---

## 43. GIT

Preserve alterações existentes.

Não execute comandos destrutivos.

Não apague branches.

Não sobrescreva trabalho do usuário.

Se houver mudanças não relacionadas no working tree:

* preserve;
* não faça reset;
* não descarte alterações.

---

## 44. DEFINITION OF DONE

O trabalho só estará concluído quando:

```text
COREBREAK
├── inicia
├── possui menu
├── possui gameplay
├── possui IA
├── possui três dificuldades
├── possui Core
├── possui Energy Wave
├── possui destruição
├── possui HP
├── possui power-up
├── possui timer
├── possui score
├── possui resultado
├── possui tutorial
├── possui configurações
├── possui estatísticas
├── possui save
├── possui áudio
├── possui haptic
├── possui UI responsiva
├── possui testes
├── possui documentação
└── está preparado para Android/iOS
```

---

## 45. COMPORTAMENTO DO AGENTE

Não pergunte ao usuário sobre detalhes que já estejam definidos neste documento.

Quando houver uma decisão técnica pequena e reversível:

**tome a decisão e continue.**

Quando houver uma decisão que altere significativamente:

* gameplay;
* arquitetura;
* tecnologia;
* escopo;

pare e solicite confirmação.

---

## 46. PRINCÍPIO FINAL

O objetivo não é criar uma demonstração técnica.

O objetivo é criar:

> **um pequeno jogo que seja realmente divertido de jogar.**

Portanto:

```text
GAMEPLAY
>
ESTABILIDADE
>
UX
>
PERFORMANCE
>
VISUAL POLISH
>
FUNCIONALIDADES EXTRAS
```

Construa primeiro o jogo.

Depois refine-o.

Não aumente o escopo antes de validar o core gameplay.

---

## EXECUTE AGORA

Comece pelo seguinte:

### PASSO 1

Inspecione o repositório.

### PASSO 2

Determine o estado atual do projeto.

### PASSO 3

Crie ou adapte a estrutura Godot.

### PASSO 4

Implemente a arena.

### PASSO 5

Implemente o jogador.

### PASSO 6

Implemente Core + Energy Wave.

### PASSO 7

Implemente regras de vitória/derrota.

### PASSO 8

Implemente IA.

### PASSO 9

Execute e teste o primeiro protótipo jogável.

Somente depois avance para UI, persistência, áudio, polish e preparação mobile.

Ao final de cada etapa, registre no README ou em `docs/DEVELOPMENT_LOG.md`:

```text
Data
Etapa
Implementações
Testes realizados
Problemas encontrados
Problemas resolvidos
Próxima etapa
```

**Comece agora pela inspeção do repositório e pela implementação do núcleo jogável do COREBREAK.**
