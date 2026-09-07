# COREBREAK — Development Log

**Projeto:** COREBREAK
**Engine:** Godot 4.x
**Linguagem:** GDScript
**Plataformas:** Android / iOS
**Status:** Pré-desenvolvimento

---

## 1. Objetivo

Este documento registra o histórico real de desenvolvimento do COREBREAK.

Deve registrar:

* funcionalidades implementadas;
* alterações arquiteturais;
* decisões técnicas;
* problemas encontrados;
* bugs corrigidos;
* testes realizados;
* alterações de balanceamento;
* mudanças de escopo;
* versões e builds;
* decisões relevantes para o futuro.

Este documento é um histórico.

O `ROADMAP.md` é o plano.

Não utilizar este documento como substituto do GDD ou da arquitetura.

---

## 2. Regras de utilização

O Development Log deve ser atualizado quando ocorrer:

* conclusão de uma sprint;
* alteração importante de arquitetura;
* correção de bug relevante;
* mudança de gameplay;
* mudança de escopo;
* criação de sistema importante;
* criação de uma build;
* descoberta de problema relevante.

Não é necessário registrar cada pequena alteração de código.

---

## 3. Formato das entradas

Utilizar:

```text
## YYYY-MM-DD — Título

### Tipo
Feature / Bug Fix / Architecture / Balance / QA / Build / Decision

### Alterações
- ...

### Motivo
- ...

### Testes
- ...

### Resultado
- ...

### Próximo passo
- ...
```

---

## 4. Estado inicial

## 2026-09-07 — Inicialização da documentação

### Tipo

Architecture / Planning

### Alterações

* Definido o conceito COREBREAK.
* Criado o GDD.
* Criado o documento de arquitetura.
* Criado o prompt principal para o Autopilot.
* Criado o roadmap.
* Criado este Development Log.

### Documentação

```text
docs/
├── GDD.md
├── ARCHITECTURE.md
├── AUTOPILOT_MVP_PROMPT.md
├── ROADMAP.md
└── DEVELOPMENT_LOG.md
```

### Decisões

O projeto será desenvolvido inicialmente como um jogo:

```text
Competitive Arcade Arena
```

com:

```text
Android
iOS
Portrait
Offline
Player vs AI
```

### Próximo passo

Criar o projeto Godot e iniciar a implementação do núcleo jogável.

---

## 5. MVP inicial

## Estado planejado

O primeiro MVP deverá conter:

```text
Arena
Player
Movement
Walls
Breakable Blocks
Core
Energy Wave
Damage
Score
Timer
AI
Victory
Defeat
```

### Fora do MVP

Não implementar nesta fase:

```text
Online Multiplayer
Matchmaking
MMR
Leaderboard
Accounts
Chat
Clans
Seasons
Battle Pass
Shop
Ads
IAP
Cloud Save
Server Infrastructure
```

---

## 6. Registro de decisões

As decisões abaixo devem ser mantidas enquanto não houver motivo concreto para alterá-las.

| Decisão          | Estado        |
| ---------------- | ------------- |
| Engine           | Godot 4.x     |
| Linguagem        | GDScript      |
| Plataforma       | Android / iOS |
| Orientação       | Portrait      |
| Câmera           | Top-down      |
| Partida inicial  | Player vs AI  |
| Duração          | 120 segundos  |
| HP               | 3             |
| Blast Range      | 2             |
| Core Activation  | 1.5s          |
| Overcharge Range | 4             |
| Arena inicial    | 11 × 15       |
| Multiplayer      | Futuro        |
| MMR              | Futuro        |
| Monetização      | Futuro        |
| Pay-to-win       | Não           |

---

## 7. Histórico de versões

| Versão | Estado       | Descrição            |
| ------ | ------------ | -------------------- |
| 0.0.1  | Planejamento | Documentação inicial |
| 0.1.0  | Planejado    | MVP jogável          |
| 0.2.0  | Planejado    | Protótipo polido     |
| 0.3.0  | Futuro       | Multiplayer          |
| 0.4.0  | Futuro       | Competitivo          |
| 0.5.0  | Futuro       | Progressão           |
| 0.6.0  | Futuro       | Cosméticos           |
| 1.0.0  | Futuro       | Release              |

---

## 8. Bugs conhecidos

Nenhum bug conhecido no início do projeto.

Quando um bug for encontrado, registrar:

```text
ID
Descrição
Como reproduzir
Impacto
Status
Correção
Versão corrigida
```

Exemplo:

```text
BUG-001

Descrição:
Energy Wave atravessa paredes.

Status:
Open

Impacto:
Critical

Correção:
Pendente
```

---

## 9. Decisões arquiteturais

Alterações importantes na arquitetura devem ser registradas aqui.

Formato:

```text
## ADR-XXX — Título

### Contexto

...

### Decisão

...

### Consequência

...
```

---

## 10. ADR-001 — Separação entre Player e Controller

### Contexto

O COREBREAK terá inicialmente jogadores humanos e IA, mas futuramente poderá possuir jogadores conectados pela rede.

### Decisão

Separar:

```text
Player
PlayerController
AIController
NetworkController
```

O Player representa o estado da entidade.

O Controller representa a origem das decisões.

### Consequência

Será possível substituir:

```text
AIController
```

por:

```text
NetworkController
```

sem reconstruir o núcleo do gameplay.

---

## 11. ADR-002 — GameRules independente da UI

### 11.1 Contexto

As regras do jogo não devem depender da interface.

### 11.2 Decisão

Centralizar as regras em:

```text
GameRules
```

A UI apenas apresenta o estado.

### 11.3 Consequência

Será possível modificar ou substituir a interface sem alterar o gameplay.

---

## 12. ADR-003 — MVP offline

### 12.1 Contexto

O multiplayer aumenta significativamente a complexidade do projeto.

### 12.2 Decisão

O primeiro MVP será exclusivamente:

```text
Local Player vs AI
```

### 12.3 Consequência

Podemos validar:

* diversão;
* controles;
* balanceamento;
* arena;
* Core;
* Energy Wave;
* IA;

antes de introduzir infraestrutura de rede.

---

## 13. ADR-004 — Cosméticos sem vantagem competitiva

### 13.1 Contexto

O projeto poderá possuir monetização futura.

### 13.2 Decisão

Itens pagos deverão ser cosméticos.

Não vender:

* dano;
* HP;
* velocidade;
* alcance;
* vantagem de matchmaking.

### 13.3 Consequência

O jogo poderá possuir monetização sem transformar o competitivo em pay-to-win.

---

## 14. Balanceamento

Alterações de balanceamento devem ser registradas.

Parâmetros atuais:

```text
Player HP: 3
Player Speed: configurável
Core Activation: 1.5s
Blast Range: 2
Overcharge Range: 4
Match Duration: 120s
```

---

## 15. Playtesting

Quando playtesting começar, registrar:

```text
Data
Versão
Duração
Observações
Problemas
Sugestões
Alterações realizadas
```

Exemplo:

```text
## YYYY-MM-DD — Playtest #001

Versão:
0.1.x

Observações:
- ...

Problemas:
- ...

Decisões:
- ...
```

---

## 16. QA

Cada versão jogável deve registrar:

```text
Build:
Versão:
Plataforma:
Resultado:
```

Checklist:

```text
[ ] Inicialização
[ ] Arena
[ ] Movimento
[ ] Colisão
[ ] Core
[ ] Energy Wave
[ ] Dano
[ ] Invulnerabilidade
[ ] Pontuação
[ ] Timer
[ ] IA
[ ] Vitória
[ ] Derrota
[ ] UI
[ ] Save
[ ] Audio
[ ] Haptics
```

---

## 17. Builds

Registrar builds importantes.

Formato:

```text
## Build X

Data:
Versão:
Plataforma:

Principais alterações:
- ...

Bugs conhecidos:
- ...

Status:
Development / Internal Test / Beta / Release Candidate / Released
```

---

## 18. Histórico de implementação

Utilizar esta seção para registrar a conclusão das grandes fases.

## Fase 1 — Core Gameplay

Status:

```text
NOT STARTED
```

Itens:

```text
[ ] Arena
[ ] Player
[ ] Movement
[ ] Breakable Blocks
[ ] Core
[ ] Energy Wave
[ ] Damage
[ ] Score
[ ] Timer
[ ] AI
[ ] Victory / Defeat
```

---

## Fase 2 — Product Layer

Status:

```text
NOT STARTED
```

Itens:

```text
[ ] Main Menu
[ ] Difficulty Selection
[ ] HUD
[ ] Result Screen
[ ] Training
[ ] Settings
[ ] Tutorial
[ ] Statistics
[ ] Save
```

---

## Fase 3 — Polish

Status:

```text
NOT STARTED
```

Itens:

```text
[ ] Visual identity
[ ] Animations
[ ] VFX
[ ] Audio
[ ] Haptics
[ ] Mobile polish
```

---

## Fase 4 — Multiplayer

Status:

```text
FUTURE
```

---

## Fase 5 — Competitive

Status:

```text
FUTURE
```

---

## 19. Autopilot Work Log

Quando o projeto estiver sendo desenvolvido por agente, cada sessão significativa deverá terminar com um registro resumido.

Formato:

```text
## YYYY-MM-DD — Autopilot Session

### Objetivo

...

### Implementado

- ...
- ...
- ...

### Arquivos criados

- ...
- ...

### Arquivos modificados

- ...
- ...

### Testes executados

- ...
- ...

### Problemas encontrados

- ...

### Problemas resolvidos

- ...

### Problemas pendentes

- ...

### Próximo passo

...
```

O agente não deve afirmar que algo foi implementado ou testado se não tiver realmente feito isso.

---

## 20. Regras para registros automáticos

O agente deve:

1. registrar somente fatos;
2. não inventar resultados;
3. não marcar testes como concluídos sem executá-los;
4. registrar decisões arquiteturais importantes;
5. registrar mudanças de escopo;
6. registrar bugs relevantes;
7. manter o histórico anterior;
8. nunca apagar entradas antigas sem motivo explícito.

---

## 21. Estado atual do projeto

```text
DOCUMENTAÇÃO
████████████████████ 100%

PROJETO GODOT
░░░░░░░░░░░░░░░░░░░░ 0%

GAMEPLAY
░░░░░░░░░░░░░░░░░░░░ 0%

AI
░░░░░░░░░░░░░░░░░░░░ 0%

UI
░░░░░░░░░░░░░░░░░░░░ 0%

AUDIO
░░░░░░░░░░░░░░░░░░░░ 0%

MOBILE
░░░░░░░░░░░░░░░░░░░░ 0%

MULTIPLAYER
░░░░░░░░░░░░░░░░░░░░ 0%

COMPETITIVO
░░░░░░░░░░░░░░░░░░░░ 0%
```

---

## 22. Próxima entrada esperada

A próxima entrada deverá ocorrer quando o desenvolvimento do projeto Godot começar.

Formato:

```text
## YYYY-MM-DD — Godot Project Initialization

### Tipo

Feature

### Alterações

- Projeto Godot criado.
- Estrutura inicial criada.
- Configurações iniciais aplicadas.
- Main.tscn criada.

### Testes

- Projeto executado com sucesso.

### Resultado

Projeto inicial funcional.

### Próximo passo

Implementar Board e Grid.
```

---

## 23. Princípio final

Este documento deve representar **o estado real do projeto**, não o estado desejado.

Se o roadmap disser:

```text
Energy Wave concluída
```

mas a implementação ainda não estiver funcionando, o Development Log deve refletir a realidade.

A diferença entre:

```text
PLANEJADO
```

e:

```text
IMPLEMENTADO
```

deve permanecer explícita durante todo o desenvolvimento.
