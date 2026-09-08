# COREBREAK — Development Log

**Projeto:** COREBREAK
**Engine:** Godot 4.x
**Linguagem:** GDScript
**Plataformas:** Android / iOS
**Status:** Sprint 0 concluída parcialmente

---

## 2026-09-07 — Sprint 0: Fundação técnica do projeto

### 0.1 Tipo

Feature / Architecture / QA

### 0.1 Alterações

- Verificado que o repositório já possuía documentação e base inicial do projeto, mas sem estrutura Godot completa para o MVP.
- Criada a estrutura de diretórios conforme a arquitetura proposta.
- Atualizada a configuration do Godot para orientação Portrait, viewport mobile e input map inicial.
- Criada a cena principal em `scenes/main/Main.tscn` com `SceneRouter`, `GameManager`, `AudioManager`, `HapticManager` e `UI`.
- Implementado `scripts/core/GameManager.gd` com estados iniciais e transições mínimas de partida.
- Implementado `scripts/core/GameConfig.gd` com os parâmetros principais do jogo.
- Criados os sistemas iniciais `AudioManager` e `HapticManager`.
- Criado teste mínimo de validação para `GameConfig`.
- Registrados os documentos de GDD, arquitetura, roadmap e prompt no diretório `docs/` do repositório.

### 0.1 Motivo

- Preparar a fundação técnica do COREBREAK antes da implementação do gameplay real.
- Garantir que o projeto abra corretamente em Godot 4.x e fique pronto para a próxima sprint.

### 0.1 Testes

- Execução do projeto em modo headless do Godot.
- Execução do script de teste unitário de configuração.

### 0.1 Resultado

- O projeto abriu sem erros críticos no Godot 4.7.2.
- A cena principal inicializou corretamente.
- O GameManager entrou em estado READY e a sequência de boot executou sem falhas.
- O teste de `GameConfig` passou com sucesso.

### 0.1 Problemas encontrados

- O repositório não possuía a estrutura completa exigida pela arquitetura do projeto.
- A documentação do projeto estava em um local complementar e não na raiz de `docs/`.
- O primeiro teste unitário exigia ajuste de assinatura do `SceneTree` para funcionar corretamente.

### 0.1 Problemas pendentes

- Implementação do gameplay em sprint futura.
- Desenvolvimento da arena baseada em grid.
- Sistema de jogador e IA.
- Sistema de Core e Energy Wave.
- UI completa e menus.

### 0.1 Próximo passo

- Implementar a sprint 1.1 de arena e grid, mantendo a arquitetura já preparada.

---

## 2026-09-07 — Sprint 1.1: Arena e Grid

### 1.1 Tipo

Feature / Architecture / QA

### 1.1 Alterações

- Implementado o sistema `Board` em `scripts/gameplay/Board.gd`.
- Definido o enum `CellType` com `FLOOR`, `WALL` e `BREAKABLE`.
- Criado mapa oficial do MVP em grid 11 × 15 com bordas, paredes internas e blocos destrutíveis.
- Definidas as posições de spawn do jogador e da IA.
- Adicionadas conversões `grid_to_world()` e `world_to_grid()`.
- Incluída verificação de caminhabilidade e limites do grid.
- Criada a cena `scenes/gameplay/Game.tscn` carregando o Board.
- Adicionados parâmetros do Board em `scripts/core/GameConfig.gd`.
- Criados testes unitários para validar dimensões, conversão, caminhabilidade e spawns.

### 1.1 Motivo

- Preparar a base da arena conforme o GDD e a arquitetura do projeto.
- Garantir que a próxima sprint possa receber o player e o sistema de combate sem refatorações amplas.

### 1.1 Testes

- Execução do projeto em modo headless do Godot.
- Execução dos testes unitários do Board e do GameConfig relacionados à arena.

### 1.1 Resultado

- A arena foi criada corretamente no Grid 11 × 15.
- Os spawns são FLOOR válidos e dentro do mapa.
- O Board passou nos testes de dimensões, conversão e caminhabilidade.
- A scene de gameplay foi criada sem erros críticos de carga.

### 1.1 Problemas encontrados

- O Board precisou ser ajustado para Node2D para permitir visualização funcional na cena de gameplay.
- O primeiro teste de sprint exigiu correção de assinatura em scripts de teste para funcionar corretamente.

### 1.1 Problemas pendentes

- Implementação do jogador na Sprint 1.2.
- Implementação da Core e da Energy Wave.
- Sistema de dano e vitória/derrota.

### 1.1 Próximo passo

- Iniciar a Sprint 1.2 com a implementação do Player e do controle de movimentação, sem alterar a base da arena criada nesta tarefa.

---

## 2026-09-07 — Sprint 1.2: Player e movimento grid-based

### 1.2 Tipo

Feature / Architecture / QA

### 1.2 Alterações

- Criada a cena do Player em `scenes/entities/Player.tscn` com placeholder visual simples.
- Implementado `scripts/entities/Player.gd` com estado inicial do jogador, spawn e movimentação por célula.
- Integrado o Player à cena `scenes/gameplay/Game.tscn` via `scripts/gameplay/Game.gd`.
- Atualizado `Board` para consultar a configuração central do grid em `scripts/core/GameConfig.gd`.
- Preparado o Player para receber input de movimento das ações `move_up`, `move_down`, `move_left` e `move_right`.
- Implementada colisão lógica com `WALL`, `BREAKABLE` e limites do mapa.
- Criado teste automatizado de movimento em `tests/unit/test_player_movement.gd`.

### 1.2 Motivo

- Implementar o primeiro bloco funcional de gameplay, respeitando a arquitetura de separação entre Board, Player e Controller.
- Garantir que o jogador apareça no spawn e se movimente corretamente pela arena em grid.

### 1.2 Testes

- Execução do teste unitário do Player em modo headless do Godot.
- Execução do teste do Board e do teste de configuração da arena.

### 1.2 Resultado

- O teste de movimento do Player passou com sucesso: `Player movement validation passed`.
- O Board e a configuração da arena também passaram em testes anteriores.
- O projeto permaneceu sem erros críticos de compilação no ambiente headless.

### 1.2 Validação visual

- Não foi possível realizar uma validação visual completa em ambiente headless, pois o projeto foi executado sem interface gráfica.
- O personagem e a cena foram implementados e a lógica de posicionamento foi validada pelo teste, mas a observação visual direta deve ser confirmada no editor Godot em uma máquina com UI disponível.

### 1.2 Problemas encontrados

- O primeiro teste de Player falhou por usar células bloqueadas e exigiu ajuste do cenário para validar somente movimentos reais do mapa.
- O ambiente Godot headless emite avisos de recursos não liberados ao encerrar a execução, porém sem bloquear a lógica principal.

### 1.2 Problemas pendentes

- Implementação do Core e Energy Wave.
- Implementação de dano e HP funcional.
- IA e sistemas avançados.

### 1.2 Próximo passo

- Iniciar a Sprint 1.3 com a implementação do Core e da lógica de ativação, mantendo o Player e o Board já validados.

---

## 2026-09-07 — Sprint 1.2: Correção de InputMap e shadowing de position

### 1.2.1 Tipo

Bugfix / QA / Gameplay

### 1.2.1 Problema encontrado

- Durante a validação visual no editor Godot, o Player não respondia ao teclado.
- O Godot reportou que as ações esperadas não existiam no InputMap e apontou nomes no formato `input/move_up`, `input/move_down`, `input/move_left` e `input/move_right`.
- O problema foi identificado na configuração do projeto: as ações do InputMap estavam registradas com o prefixo `input/` em vez de nomes no formato esperado pela arquitetura: `move_up`, `move_down`, `move_left`, `move_right`, `place_core`.
- Também houve um warning de shadowing em `scripts/gameplay/Board.gd` porque o parâmetro `position` escondia a propriedade `Node2D.position`.

### 1.2.1 Causa identificada

- A fonte de verdade do projeto estava configurada com chaves `input/...`, enquanto o código do Player e a arquitetura esperavam `move_*`.
- O runtime do Godot automaticamente interpreta `InputMap` como ação nomeada exatamente pelo literal usado em `project.godot`.
- Como o Player usa `event.is_action_pressed("move_up")`, o engine não encontrava a ação e emitia o erro.
- O warning de shadowing acontecia porque `world_to_grid(position: Vector2)` recebia um nome que coincidia com a propriedade da classe base.

### 1.2.1 Arquivos modificados

- `project.godot`
- `scripts/gameplay/Board.gd`
- `docs/DEVELOPMENT_LOG.md`

### 1.2.1 Correção aplicada

- Ajustado o bloco `[input]` em `project.godot` para utilizar exatamente as ações `move_up`, `move_down`, `move_left`, `move_right` e `place_core`.
- Mantidos os bindings de teclado W/A/S/D e setas já validos.
- Renomeado o parâmetro `position` para `world_position` em `world_to_grid()` para evitar o shadowing da propriedade `Node2D.position`.
- Mantida a arquitetura de uso do Player conforme o esperado para esta sprint, sem criar refatoração grande ou indicar sprint futura.

### 1.2.1 Testes executados

- Execução do teste do Player em modo headless.
- Execução do teste do Board.
- Execução do teste de configuração do Board.
- Execução do projeto em modo headless para confirmar que a inicialização não gera erro crítico.
- Adição do teste de InputMap para garantir que as ações existam.

### 1.2.1 Resultado

- O Player passou a procurar ações válidas no InputMap.
- O warning de shadowing foi removido.
- Os testes de movimento e de InputMap passaram após a correção.
- A inicialização do projeto em headless continuou estável sem falha crítica.

### 1.2.1 Validação visual

- A validação visual no ambiente do Autopilot não foi executada porque o ambiente disponibilizado não inclui interface gráfica do Godot.
- A correção foi validada por execução headless e por verificação das ações do InputMap, mas a inspeção visual manual do movimento em cena deve ser confirmada em um ambiente com UI disponível.

### 1.2.1 Próximo passo

- Validar visualmente o Player e o movimento em `scenes/gameplay/Game.tscn` em ambiente gráfico com teclado conectado.
- Manter o escopo restrito à Sprint 1.2 e não avançar para Sprint 1.3.

---

## 2026-09-08 — Sprint 1.3: Core

### 1.3 Tipo

Feature / Gameplay / QA

### 1.3 Alterações

- Criada a entidade independente `Core` em `scripts/entities/Core.gd` e sua cena em `scenes/entities/Core.tscn`.
- Implementados os estados `AVAILABLE`, `ACTIVE`, `RESOLVING` e `CONSUMED`.
- Reutilizada a configuração `GameConfig.CORE_ACTIVATION_TIME` com valor de 1.5 segundos.
- Integrado o container `Cores` e a criação coordenada pelo `Game.gd`.
- Atualizado o `Player.gd` para solicitar a colocação via ação `place_core`, mantendo uma única carga disponível.
- Adicionada representação visual temporária e indicador circular de progresso no próprio Core.
- Criado `tests/unit/test_core.gd` para validar ciclo de vida, posição, bloqueio de duplicidade e posição inválida.

### 1.3 Escopo preservado

- Não foi criada `EnergyWave.gd` nem `EnergyWave.tscn`.
- O estado `RESOLVING` permanece ativo e não dispara onda, dano, destruição de BREAKABLE ou consumo automático.

### 1.3 Próximo passo

- Validação automatizada concluída; manter o escopo sem implementar a Sprint 1.4.

### 1.3 Testes executados

- `test_input_map.gd`: passou com `InputMap validation passed`.
- `test_player_movement.gd`: passou com `Player movement validation passed`.
- `test_board.gd`: passou com `Board validation passed`.
- `test_board_config.gd`: passou com `Board config validation passed`.
- `test_core.gd`: passou com `Core validation passed`.
- Projeto iniciado em modo headless com `--quit`: Main, GameManager, Board e Game carregaram sem erro crítico.

### 1.3 Validação visual

- A execução gráfica interativa não foi comprovada pelo ambiente de automação desta sessão.
- A integração foi exercitada pela cena real `Game.tscn` dentro de `test_core.gd`, incluindo criação do Player, container `Cores` e colocação coordenada do Core.
- A confirmação manual de pressionar Espaço/clique, movimentar após a colocação e observar a mudança visual para `RESOLVING` deve ser feita no editor ou executável Godot com interface gráfica.

### 1.3 Resultado

- Core independente criado e integrado ao fluxo `Player -> Game -> Core`.
- Estados e timer de 1.5 segundos validados.
- Core permanece em `RESOLVING` sem gerar Energy Wave ou ser destruído automaticamente.
- Uma segunda colocação e posições inválidas são bloqueadas sem erro crítico.
- Warnings restantes são apenas leaks de CanvasItem/ObjectDB e resources still in use emitidos pelo encerramento headless dos testes de Node2D.
