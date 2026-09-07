# COREBREAK — Development Roadmap

**Versão do documento:** 0.1
**Projeto:** COREBREAK
**Engine:** Godot 4.x
**Plataformas:** Android / iOS
**Status atual:** Pré-desenvolvimento

---

## 1. Objetivo

Este documento define o roadmap de desenvolvimento do COREBREAK, desde a implementação do primeiro protótipo jogável até uma futura versão comercial com multiplayer competitivo.

O roadmap é dividido em versões e sprints independentes.

A regra principal é:

> Nenhuma etapa deve avançar enquanto a funcionalidade essencial da etapa anterior não estiver funcional e testada.

O roadmap não deve ser interpretado como obrigação de implementar todas as funcionalidades futuras.

Funcionalidades futuras podem ser alteradas, removidas ou substituídas conforme os resultados dos testes.

---

## 2. Visão geral

```text
v0.1  → MVP Jogável
v0.2  → Protótipo Polido
v0.3  → Multiplayer Online
v0.4  → Competitivo / MMR
v0.5  → Progressão
v0.6  → Personalização / Cosméticos
v1.0  → Lançamento Comercial
```

Fluxo:

```text
IDEIA
  ↓
MVP
  ↓
GAMEPLAY VALIDATION
  ↓
POLISH
  ↓
ONLINE
  ↓
COMPETITIVE
  ↓
PROGRESSION
  ↓
MONETIZATION
  ↓
RELEASE
```

---

## 3. Fase 0 — Preparação

## Objetivo

Preparar o repositório e a documentação antes da implementação.

## Documentação

```text
[✓] GDD.md
[✓] ARCHITECTURE.md
[✓] AUTOPILOT_MVP_PROMPT.md
[✓] ROADMAP.md
[✓] DEVELOPMENT_LOG.md
```

## Estrutura inicial

```text
[ ] Criar projeto Godot
[ ] Configurar resolução base
[ ] Configurar orientação Portrait
[ ] Configurar renderer
[ ] Configurar input map
[ ] Configurar estrutura de diretórios
[ ] Criar cena Main
[ ] Criar sistema inicial de configuração
```

### Checkpoint

O projeto deve:

* abrir no Godot;
* executar sem erros;
* possuir estrutura de diretórios organizada;
* possuir documentação disponível.

---

## 4. Fase 1 — MVP Core Gameplay

### 4.1 Objetivo

Criar a primeira versão realmente jogável do COREBREAK.

Esta é a fase mais importante do projeto.

## Sprint 1.1 — Arena

Implementar:

* grid;
* arena;
* paredes;
* chão;
* blocos destrutíveis;
* conversão Grid ↔ World;
* colisões;
* mapa inicial.

Configuração inicial:

```text
Grid: 11 × 15
```

### 4.2 Checkpoint

O jogador deverá conseguir visualizar e interagir com uma arena funcional.

---

## 5. Sprint 1.2 — Player

Implementar:

* entidade Player;
* HP;
* movimento;
* colisões;
* alinhamento ao grid;
* estados do jogador;
* eliminação.

Valores iniciais:

```text
HP = 3
```

### 5.1 Checkpoint

O jogador deve conseguir:

* mover-se;
* atravessar áreas livres;
* ser bloqueado por paredes;
* ser bloqueado por blocos;
* receber dano;
* ser eliminado.

---

## 6. Sprint 1.3 — Core

Implementar:

* CoreCharge;
* colocação;
* estados;
* timer de ativação;
* disponibilidade;
* associação ao jogador.

Valor inicial:

```text
Activation Time = 1.5s
```

### 6.1 Checkpoint

O jogador deve conseguir colocar um Core em uma posição válida.

---

## 7. Sprint 1.4 — Energy Wave

Implementar:

* propagação vertical;
* propagação horizontal;
* quatro direções;
* alcance configurável;
* interrupção por parede;
* destruição de blocos;
* interação com jogadores.

Valor inicial:

```text
Blast Range = 2
```

### 7.1 Checkpoint

O Core deve produzir uma Energy Wave funcional.

A Wave deve:

* atingir células válidas;
* parar em paredes;
* destruir blocos;
* interromper-se após bloco destrutível;
* causar dano ao jogador.

---

## 8. Sprint 1.5 — Game Rules

Implementar:

* dano;
* invulnerabilidade;
* eliminação;
* pontuação;
* timer;
* vitória;
* derrota;
* empate;
* encerramento da partida.

Valores:

```text
Match Duration = 120s

Breakable Block = +10
Energy Pickup = +25
Elimination = +100
```

### 8.1 Checkpoint

Uma partida completa deve ser possível do início ao fim.

---

## 9. Sprint 1.6 — AI

Implementar:

### Easy

* movimentação simples;
* decisões básicas;
* Core ocasional.

### Normal

* percepção de ameaças;
* destruição de blocos;
* perseguição;
* uso razoável do Core.

### Hard

* análise de risco;
* posicionamento;
* tentativa de encurralar;
* uso estratégico de Power-ups.

### 9.1 Checkpoint

O jogador deve conseguir jogar uma partida completa contra a IA.

A IA deve respeitar exatamente as mesmas regras do jogador.

---

## 10. MVP v0.1 — Critério de conclusão

O MVP estará concluído quando for possível:

```text
Abrir o jogo
   ↓
Iniciar partida
   ↓
Controlar jogador
   ↓
Explorar arena
   ↓
Colocar Core
   ↓
Gerar Energy Wave
   ↓
Destruir blocos
   ↓
Causar dano
   ↓
Lutar contra IA
   ↓
Vencer / perder
   ↓
Ver resultado
```

Critérios obrigatórios:

```text
[ ] Gameplay funcional
[ ] Arena funcional
[ ] Player funcional
[ ] Core funcional
[ ] Energy Wave funcional
[ ] Dano funcional
[ ] Pontuação funcional
[ ] Timer funcional
[ ] IA funcional
[ ] Vitória/derrota funcional
```

---

## 11. Fase 2 — Produto Jogável

## 11.1 Objetivo

Transformar o protótipo técnico em um pequeno jogo completo.

Implementar:

* Main Menu;
* Play;
* Training;
* Settings;
* Result Screen;
* HUD;
* dificuldade;
* tutorial;
* estatísticas;
* SaveManager.

---

## 12. Sprint 2.1 — Menus

Criar:

```text
Main Menu
 ├── Play
 ├── Training
 ├── Settings
 └── About
```

Fluxo:

```text
Main Menu
 ↓
Play
 ↓
Difficulty
 ↓
Match
 ↓
Result
 ↓
Play Again / Menu
```

---

## 13. Sprint 2.2 — HUD

Implementar:

```text
HP
Timer
Score
Core
Virtual Joystick
Core Button
```

A HUD deve ser responsiva para dispositivos móveis.

---

## 14. Sprint 2.3 — Tutorial

Implementar tutorial inicial:

```text
Movement
   ↓
Core
   ↓
Energy Wave
   ↓
Damage
   ↓
Victory
```

O tutorial deve ser curto e não intrusivo.

---

## 15. Sprint 2.4 — Settings

Implementar:

```text
Music
SFX
Vibration
```

As configurações devem persistir localmente.

---

## 16. Sprint 2.5 — Statistics

Implementar:

```text
Games Played
Wins
Losses
Draws
Win Rate
```

Training não deve contar para estatísticas competitivas.

---

## 17. Sprint 2.6 — Save

Implementar:

```text
SaveManager
Versioned Save
Settings
Statistics
Last Difficulty
```

### 17.1 Checkpoint

O usuário deve poder fechar e abrir o jogo sem perder suas configurações e estatísticas.

---

## 18. Fase 3 — Power-ups e Gameplay Polish

## 18.1 Objetivo

Aumentar profundidade e qualidade do gameplay.

## MVP+

Implementar:

### Overcharge

```text
Normal Range: 2
Overcharge: 4
```

O Power-up deve ser consumido na próxima utilização do Core.

---

## 19. Gameplay Polish

Avaliar:

* velocidade do jogador;
* tempo de ativação;
* alcance da Wave;
* tamanho da arena;
* posicionamento dos obstáculos;
* spawn dos Power-ups;
* dificuldade da IA;
* duração da partida.

Esses valores devem ser ajustados por playtesting.

Não alterar regras fundamentais sem registrar a decisão no `DEVELOPMENT_LOG.md`.

---

## 20. Fase 4 — Visual e Áudio

## 20.1 Objetivo

Transformar o protótipo em uma experiência visual consistente.

Implementar:

* personagens estilizados;
* arena futurista;
* efeitos de energia;
* partículas;
* animações;
* UI refinada;
* sons;
* música;
* haptics.

Direção visual:

```text
Futuristic Toy Arcade
```

Características:

* amigável;
* colorido;
* premium;
* geométrico;
* legível;
* sem realismo militar.

---

## 21. Fase 5 — Mobile Optimization

## 21.1 Objetivo

Garantir desempenho adequado em smartphones.

Avaliar:

* FPS;
* CPU;
* memória;
* draw calls;
* tamanho da build;
* tempo de carregamento;
* consumo de bateria;
* responsividade do input.

Testar em pelo menos:

```text
Low-end Android
Mid-range Android
High-end Android
iPhone
```

quando dispositivos de teste estiverem disponíveis.

---

## 22. Fase 6 — QA do MVP

Executar:

* testes unitários;
* testes de integração;
* testes manuais;
* testes de UI;
* testes de diferentes resoluções;
* testes de desempenho;
* testes de salvamento.

Criar uma build candidata:

```text
v0.1.0
```

---

## 23. Fase 7 — Prototype Release

Versão:

```text
v0.2.0
```

Objetivo:

> Fazer o COREBREAK parecer um jogo pequeno e completo, mesmo ainda sendo offline.

Deve incluir:

* gameplay refinado;
* menus;
* tutorial;
* áudio;
* efeitos;
* Power-up;
* estatísticas;
* save;
* UX mobile.

---

## 24. Fase 8 — Multiplayer

Versão:

```text
v0.3.0
```

Somente iniciar após o gameplay offline estar validado.

Objetivo:

```text
1v1 Online
```

Arquitetura:

```text
Client
 ↓
Network
 ↓
Match Server
 ↓
Opponent
```

Implementar:

* conexão;
* criação de partida;
* sincronização;
* reconexão;
* latência;
* validação;
* encerramento de partida.

---

## 25. Multiplayer — Primeira versão

Inicialmente:

```text
Casual 1v1
```

Sem:

* ranking;
* MMR;
* temporadas;
* leaderboard.

O objetivo será validar:

> "O COREBREAK continua divertido quando o adversário é um jogador real?"

---

## 26. Fase 9 — Competitivo

Versão:

```text
v0.4.0
```

Implementar:

* MMR;
* matchmaking;
* ranking;
* divisões;
* histórico de partidas.

Possível sistema:

```text
Elo
```

ou:

```text
Glicko
```

A decisão deverá ocorrer após testes do multiplayer.

---

## 27. Divisões planejadas

Possível estrutura:

```text
Bronze
Silver
Gold
Platinum
Diamond
Master
Core Master
```

Os nomes podem ser revisados durante o desenvolvimento.

---

## 28. Fase 10 — Progressão

Versão:

```text
v0.5.0
```

Implementar:

* XP;
* nível da conta;
* recompensas;
* desafios;
* histórico;
* progressão.

MMR e XP devem permanecer independentes.

---

## 29. Fase 11 — Personalização

Versão:

```text
v0.6.0
```

Implementar:

```text
Character Skins
Core Skins
Energy Effects
Victory Effects
Emotes
Arena Themes
```

Nenhum item deve fornecer vantagem competitiva.

---

## 30. Fase 12 — Monetização

Somente após o gameplay e a retenção estarem validados.

Possibilidades:

* cosméticos;
* passes;
* conteúdo sazonal;
* itens visuais.

Princípio:

> Nunca vender vantagem competitiva.

---

## 31. Fase 13 — Beta

Objetivo:

Validar:

* estabilidade;
* retenção;
* balanceamento;
* matchmaking;
* economia;
* UX;
* desempenho.

Criar versões:

```text
Beta 1
Beta 2
Beta 3
Release Candidate
```

---

## 32. Fase 14 — Release Candidate

Versão:

```text
v1.0.0-rc
```

Checklist:

```text
[ ] Sem bugs críticos
[ ] Gameplay balanceado
[ ] Multiplayer estável
[ ] Save funcional
[ ] Performance adequada
[ ] UI finalizada
[ ] Áudio finalizado
[ ] Tutorial finalizado
[ ] Privacy / Terms preparados
[ ] Android build final
[ ] iOS build final
```

---

## 33. v1.0 — Lançamento

Objetivo:

Publicar o COREBREAK.

Plataformas:

```text
Android
iOS
```

Após o lançamento:

```text
Monitoramento
 ↓
Correções
 ↓
Balanceamento
 ↓
Conteúdo
 ↓
Novas temporadas
```

---

## 34. Roadmap resumido

```text
FASE 0
Preparação
     ↓
FASE 1
MVP Core Gameplay
     ↓
FASE 2
Produto Jogável
     ↓
FASE 3
Power-ups / Balanceamento
     ↓
FASE 4
Visual / Áudio
     ↓
FASE 5
Mobile Optimization
     ↓
FASE 6
QA
     ↓
v0.2
Protótipo Polido
     ↓
v0.3
Multiplayer
     ↓
v0.4
MMR / Competitivo
     ↓
v0.5
Progressão
     ↓
v0.6
Cosméticos
     ↓
v1.0
Release
```

---

## 35. Regra de mudança de escopo

Qualquer alteração significativa deve ser registrada no:

```text
docs/DEVELOPMENT_LOG.md
```

Exemplos:

* mudança no tamanho da arena;
* alteração do HP;
* mudança do alcance;
* mudança do tempo de partida;
* novo Power-up;
* remoção de sistema;
* alteração da IA;
* alteração da estratégia de monetização.

---

## 36. Princípio final

O objetivo não é simplesmente completar uma lista de funcionalidades.

O objetivo é validar progressivamente:

```text
COREBREAK é divertido?
        ↓
COREBREAK funciona bem?
        ↓
COREBREAK funciona no mobile?
        ↓
COREBREAK funciona online?
        ↓
COREBREAK consegue sustentar uma comunidade?
```

Cada fase deve responder uma dessas perguntas antes de aumentar significativamente o escopo.
