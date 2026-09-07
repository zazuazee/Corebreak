# COREBREAK

## Game Design Document — MVP v0.1

**Status:** Desenvolvimento inicial
**Versão:** 0.1
**Plataformas:** Android / iOS
**Engine:** Godot Engine
**Linguagem:** GDScript
**Gênero:** Arcade competitivo / Arena
**Modo inicial:** Single-player contra IA
**Modo futuro:** PvP online 1v1
**Orientação:** Portrait
**Duração alvo da partida:** 2–3 minutos

---

### 1. Visão geral

COREBREAK é um jogo arcade competitivo de arena em visão superior, baseado em movimentação sobre uma grade, destruição de obstáculos, gerenciamento de energia e posicionamento estratégico.

O jogador controla um pequeno piloto tecnológico dentro de uma arena fechada.

Seu principal recurso é o **Core**, um dispositivo capaz de criar cargas de energia que percorrem a arena em quatro direções.

As ondas de energia podem:

* destruir obstáculos;
* abrir caminhos;
* revelar recursos;
* causar dano;
* controlar áreas;
* limitar as opções de movimentação do adversário.

O jogo deve ser fácil de aprender, mas apresentar profundidade suficiente para recompensar planejamento e domínio do espaço.

---

### 2. Princípios de design

O jogo deve ser construído sobre cinco princípios:

#### 2.1 Fácil de aprender

O jogador deve entender o funcionamento básico em poucos segundos.

#### 2.2 Difícil de dominar

A simplicidade dos controles não deve significar simplicidade estratégica.

#### 2.3 Partidas rápidas

Uma partida deve durar aproximadamente 2–3 minutos.

#### 2.4 Decisões importantes

O jogador deve tomar decisões relacionadas a:

* posicionamento;
* tempo;
* risco;
* recursos;
* ataque;
* defesa.

#### 2.5 Mobile first

Toda a experiência deve ser projetada para smartphones.

---

### 3. Público-alvo

Jogadores que gostam de:

* jogos arcade;
* partidas rápidas;
* competição;
* estratégia simples;
* jogos casuais competitivos;
* partidas 1v1;
* progressão baseada em habilidade.

O jogo deve poder ser jogado em sessões curtas.

---

### 4. Referência de gênero

COREBREAK pertence ao mesmo grande espaço de jogos de arena com:

* movimentação em grid;
* obstáculos;
* área limitada;
* ataques direcionais;
* posicionamento;
* power-ups;
* eliminação.

Essas características são tratadas como referências de gênero e não como elementos visuais ou narrativos a serem copiados de franquias existentes.

COREBREAK deve possuir identidade visual, personagens, efeitos, nomes, sons, mapas e sistemas próprios.

---

### 5. Core Loop

O loop principal:

```text
ENTRAR NA ARENA
       ↓
MOVIMENTAR-SE
       ↓
DESTRUIR OBSTÁCULOS
       ↓
OBTER RECURSOS
       ↓
POSICIONAR CARGAS
       ↓
CONTROLAR O ESPAÇO
       ↓
ATACAR
       ↓
VENCER
       ↓
RECOMPENSA
       ↓
NOVA PARTIDA
```

---

### 6. Visão da câmera

Utilizar câmera:

**Top-down / visão superior.**

Características:

* câmera fixa;
* arena centralizada;
* sem rotação;
* sem zoom durante o MVP;
* personagem sempre claramente visível;
* grid claramente perceptível.

A câmera deve mostrar toda a arena durante a partida.

---

### 7. Arena

A arena utiliza uma grade lógica.

Tamanho inicial recomendado:

**11 × 15 células.**

ou outra dimensão equivalente que mantenha boa leitura em portrait.

A implementação deve permitir alterar facilmente o tamanho posteriormente.

---

### 8. Tipos de célula

#### 8.1 Boundary

Limite externo da arena.

Indestrutível.

#### 8.2 Solid Wall

Parede permanente.

Indestrutível.

#### 8.3 Breakable Block

Bloco destrutível.

Pode conter recompensas.

#### 8.4 Floor

Espaço livre.

Permite movimentação.

#### 8.5 Special Tile

Reservado para futuras versões.

Não precisa ser implementado no MVP.

---

### 9. Geração da arena

A arena inicial pode utilizar um mapa pré-definido.

Não é necessário gerar mapas proceduralmente no MVP.

O mapa deve possuir:

* simetria razoável;
* áreas de spawn seguras;
* corredores;
* obstáculos;
* caminhos alternativos;
* espaço suficiente para movimentação.

Criar pelo menos **um mapa oficial**.

---

### 10. Spawn

Jogador e IA devem começar em posições opostas.

Cada spawn deve possuir uma pequena área inicial segura.

O jogador não pode começar imediatamente exposto a uma situação impossível.

---

### 11. Jogador

O jogador controla um personagem pequeno.

Características:

* movimento em quatro direções;
* velocidade constante;
* colisão com paredes;
* colisão com obstáculos;
* animação simples;
* estado normal;
* estado atingido;
* estado eliminado.

Controles mobile:

* joystick virtual ou D-pad virtual;
* botão para utilizar Core.

A implementação deve priorizar controles simples.

---

### 12. Movimento

Movimento permitido:

```text
↑
↓
←
→
```

Movimento diagonal não é necessário no MVP.

O personagem deve permanecer alinhado à lógica da grade.

O movimento pode ser contínuo visualmente, mas a lógica de colisão deve respeitar a estrutura da grade.

---

### 13. Core

Cada jogador possui um dispositivo chamado:

**Core.**

O Core permite colocar uma carga de energia.

No MVP:

**1 carga ativa por jogador.**

A carga possui:

* posição;
* tempo até ativação;
* estado ativo/inativo;
* alcance;
* referência ao jogador proprietário.

---

### 14. Energia

O jogador possui inicialmente:

**1 carga disponível.**

Após colocar a carga:

```text
Energia disponível = 0
```

Depois da resolução da carga:

```text
Energia disponível = 1
```

Isso garante um ritmo simples.

Posteriormente poderão existir upgrades que permitam múltiplas cargas.

---

### 15. Ativação

Quando uma carga é colocada:

```text
T = 0
```

Após aproximadamente:

**1,5 segundo.**

ocorre a ativação.

O tempo deve ser configurável.

Não utilizar valores fixos espalhados pelo código.

---

### 16. Onda de energia

Quando ativada, a carga cria uma onda em quatro direções:

```text
        ↑
        │
←───────◆───────→
        │
        ↓
```

A onda:

* percorre células;
* para ao atingir uma parede;
* destrói blocos destrutíveis;
* causa dano ao jogador;
* interage com power-ups;
* desaparece após seu tempo de vida.

---

### 17. Alcance

Alcance inicial:

**2 células em cada direção.**

O alcance deve ser configurável.

Posteriormente poderá ser alterado por power-ups.

---

### 18. Dano

Cada jogador possui:

**3 pontos de integridade.**

Representação:

```text
♥ ♥ ♥
```

Ao ser atingido:

```text
3 → 2
2 → 1
1 → 0
```

Ao chegar a zero:

**Jogador eliminado.**

---

### 19. Invulnerabilidade

Após sofrer dano, o jogador recebe um pequeno período de invulnerabilidade.

Objetivos:

* evitar múltiplos danos instantâneos;
* melhorar sensação de controle;
* reduzir frustração.

Duração sugerida:

**0,75–1 segundo.**

---

### 20. Vitória

No MVP existem três possíveis resultados:

#### Vitória

Adversário eliminado.

#### Derrota

Jogador eliminado.

#### Empate

O tempo termina e ambos possuem a mesma pontuação.

---

### 21. Temporizador

Partida:

**2 minutos.**

Mostrar na interface:

```text
01:42
```

Quando chegar a zero:

* interromper novas ações;
* calcular resultado;
* apresentar tela de resultado.

---

### 22. Sistema de pontuação

No MVP, utilizar:

#### 22.1 Eliminação

+100 pontos.

#### 22.2 Destruição de obstáculo

+10 pontos.

#### 22.3 Coleta de energia

+25 pontos.

#### 22.4 Vitória

Resultado final.

Se o tempo acabar, vence quem possuir maior pontuação.

---

### 23. Power-up inicial

Implementar apenas **um power-up** no MVP:

#### Overcharge

Efeito:

> aumenta temporariamente o alcance da próxima onda.

Exemplo:

```text
Normal:
2 células

Overcharge:
4 células
```

Após utilização, o efeito é consumido.

O power-up pode aparecer dentro de um bloco destrutível.

---

### 24. IA

A IA será implementada em três níveis.

#### Easy

Comportamento:

* movimentação simples;
* escolhas parcialmente aleatórias;
* coloca cargas ocasionalmente;
* baixa capacidade de previsão.

Objetivo:

permitir que jogadores iniciantes vençam.

---

#### Normal

A IA deve:

* detectar oportunidades;
* evitar perigos óbvios;
* perseguir o jogador ocasionalmente;
* destruir obstáculos;
* utilizar cargas de forma razoável.

---

#### Hard

A IA deve:

* analisar perigos;
* identificar posições seguras;
* tentar encurralar o jogador;
* utilizar o Core estrategicamente;
* aproveitar power-ups;
* prever movimentos simples.

A IA não precisa ser perfeita.

O objetivo é parecer competitiva, não trapacear.

A IA nunca deve:

* acessar informações ocultas;
* ignorar regras;
* agir instantaneamente sem tempo de reação;
* mover-se através de paredes;
* utilizar recursos que o jogador não possui.

---

### 25. Menu principal

Tela:

```text
COREBREAK

[ JOGAR ]

[ TREINO ]

[ CONFIGURAÇÕES ]

[ SOBRE ]
```

---

### 26. JOGAR

No MVP, "Jogar" inicia uma partida contra IA.

Fluxo:

```text
JOGAR
 ↓
Escolher dificuldade
 ↓
Arena
 ↓
Resultado
```

---

### 27. TREINO

O modo treino permite jogar sem pressão.

No MVP:

* IA fácil;
* sem estatísticas competitivas;
* possibilidade de reiniciar.

---

### 28. Escolha de dificuldade

Tela:

```text
ESCOLHA A DIFICULDADE

[ FÁCIL ]

[ NORMAL ]

[ DIFÍCIL ]
```

Mostrar pequena descrição.

Exemplo:

```text
Fácil
Ideal para aprender.

Normal
Desafio equilibrado.

Difícil
Para jogadores experientes.
```

---

### 29. HUD

Durante a partida:

```text
┌─────────────────────┐
│ ♥ ♥ ♥      01:42    │
│                     │
│                     │
│       ARENA         │
│                     │
│                     │
│                     │
│  ◉              ⚡  │
└─────────────────────┘
```

Elementos:

* integridade;
* temporizador;
* indicador de energia;
* botão Core;
* joystick;
* pontuação.

A HUD deve ser minimalista.

---

### 30. Tela de resultado

#### 30.1 Vitória

```text
VITÓRIA!

Pontuação
1250

[ JOGAR NOVAMENTE ]

[ MENU ]
```

#### 30.2 Derrota

```text
DERROTA

Pontuação
980

[ JOGAR NOVAMENTE ]

[ MENU ]
```

#### 30.3 Empate

```text
EMPATE

Pontuação
1100

[ JOGAR NOVAMENTE ]

[ MENU ]
```

---

### 31. Progressão

A progressão competitiva não faz parte do MVP.

Entretanto, a arquitetura deve permitir futuramente:

* MMR;
* ligas;
* ranking;
* temporadas;
* XP;
* níveis;
* recompensas;
* cosméticos.

---

### 32. Multiplayer

Não implementar multiplayer online no MVP.

Porém, separar a lógica de gameplay da interface para permitir posteriormente:

```text
LocalPlayer
AIPlayer
NetworkPlayer
```

O sistema de jogo não deve depender diretamente da IA.

---

### 33. MMR futuro

Planejamento:

```text
MMR
1000
 ↓
Matchmaking
 ↓
Partida
 ↓
Resultado
 ↓
Novo MMR
```

Sistema futuro preferencial:

**Elo ou Glicko.**

Não implementar ainda.

---

### 34. Monetização futura

Não implementar monetização no MVP.

Planejar arquitetura para futuros itens cosméticos:

* skins;
* efeitos;
* emotes;
* temas;
* efeitos de vitória.

Nenhum item futuro deve conceder vantagem competitiva.

---

### 35. Identidade visual

Direção:

**Arcade futurista + brinquedo tecnológico.**

Características:

* personagens pequenos;
* formas geométricas;
* energia visual;
* partículas;
* cores vivas;
* visual amigável;
* acabamento premium;
* pouca complexidade visual.

Evitar estética militar realista.

Evitar copiar personagens, mapas, sons ou elementos visuais de jogos existentes.

---

### 36. Áudio

MVP:

* som de movimento opcional;
* colocação do Core;
* ativação;
* destruição;
* dano;
* vitória;
* derrota;
* botões.

Música:

uma faixa simples em loop é suficiente.

O jogador poderá desativar:

* efeitos;
* música.

---

### 37. Vibração

Implementar feedback tátil opcional:

* colocar Core;
* receber dano;
* vencer;
* perder.

Permitir desativação.

---

### 38. Configurações

```text
CONFIGURAÇÕES

Música      ON/OFF
Efeitos     ON/OFF
Vibração    ON/OFF

[ VOLTAR ]
```

Salvar localmente.

---

### 39. Salvamento

Salvar:

```text
settings
statistics
last_difficulty
```

As estatísticas podem conter:

```text
games_played
wins
losses
draws
```

---

### 40. Estatísticas

Tela:

```text
ESTATÍSTICAS

Partidas       0
Vitórias       0
Derrotas       0
Empates        0

Taxa de vitória: 0%

[ ZERAR ]
```

---

### 41. Tutorial

Criar tutorial extremamente simples.

Primeira vez que o jogador entra:

```text
MOVIMENTE-SE
```

Depois:

```text
USE SEU CORE
```

Depois:

```text
EVITE A ONDA DE ENERGIA
```

Depois:

```text
ELIMINE O ADVERSÁRIO
```

O tutorial deve ser opcional após a primeira execução.

---

### 42. Performance

Objetivo:

* 60 FPS quando possível;
* baixo uso de CPU;
* baixo uso de memória;
* carregamento rápido;
* poucos assets;
* poucos objetos simultâneos.

Não utilizar sistemas complexos desnecessários.

---

### 43. Plataforma

Configurar projeto para:

#### Android

* portrait;
* resolução adaptativa;
* touch;
* safe areas;
* pacote configurável;
* versão configurável.

#### iOS

* portrait;
* resolução adaptativa;
* safe areas;
* bundle identifier configurável.

---

### 44. Privacidade

O MVP:

* funciona offline;
* não requer conta;
* não coleta dados pessoais;
* não utiliza localização;
* não utiliza câmera;
* não utiliza microfone;
* não necessita de conexão permanente.

---

### 45. Arquitetura

Estrutura sugerida:

```text
assets/
├── characters/
├── arena/
├── ui/
├── audio/
└── vfx/

scenes/
├── main/
├── menus/
├── game/
├── player/
├── arena/
└── ui/

scripts/
├── core/
├── gameplay/
├── ai/
├── entities/
├── ui/
└── persistence/

data/
tests/
docs/
```

---

### 46. Sistemas

Criar componentes independentes:

```text
GameManager
MatchManager
BoardManager
GameRules
PlayerController
AIController
CoreCharge
EnergyWave
PowerUp
ScoreManager
TimerManager
SaveManager
AudioManager
UIManager
```

Não é obrigatório que cada item seja uma classe separada se isso gerar complexidade desnecessária. A regra é manter responsabilidades claras.

---

### 47. Testes

Testar:

#### Board

* geração;
* colisão;
* destruição.

#### GameRules

* vitória;
* derrota;
* empate;
* fim do tempo.

#### Core

* colocação;
* cooldown;
* ativação;
* alcance.

#### EnergyWave

* quatro direções;
* colisão;
* destruição;
* dano.

#### Player

* movimentação;
* colisão;
* dano;
* invulnerabilidade;
* morte.

#### IA

* Fácil;
* Normal;
* Difícil.

#### Save

* salvar;
* carregar;
* resetar.

---

### 48. Critérios de aceitação

O MVP só será considerado concluído quando:

* o jogo inicia sem erros;
* o menu funciona;
* o jogador pode iniciar uma partida;
* o jogador pode movimentar-se;
* o jogador pode utilizar o Core;
* a onda funciona;
* blocos podem ser destruídos;
* power-up funciona;
* jogador pode sofrer dano;
* jogador pode ser eliminado;
* IA funciona;
* vitória funciona;
* derrota funciona;
* empate funciona;
* temporizador funciona;
* reinício funciona;
* configurações funcionam;
* estatísticas funcionam;
* salvamento funciona;
* tutorial funciona;
* interface é responsiva;
* o projeto pode ser exportado para Android;
* a configuração para iOS está preparada;
* não existem erros conhecidos relevantes.

---

### 49. Fora do escopo do MVP

Não implementar:

* multiplayer online;
* matchmaking;
* MMR;
* ranking;
* contas;
* servidores;
* chat;
* clãs;
* temporadas;
* Battle Pass;
* anúncios;
* compras;
* loja;
* dezenas de personagens;
* múltiplos mapas;
* geração procedural;
* replay;
* espectador.

Esses sistemas serão desenvolvidos somente após validar o gameplay.

---

### 50. Roadmap

#### v0.1 — Prototype

Gameplay básico.

#### v0.2 — Polished Prototype

Arte, áudio e UX.

#### v0.3 — Online

PvP 1v1.

#### v0.4 — Competitive

MMR + matchmaking.

#### v0.5 — Progression

XP + níveis + recompensas.

#### v0.6 — Customization

Cosméticos.

#### v1.0 — Commercial Release

Produto completo.
