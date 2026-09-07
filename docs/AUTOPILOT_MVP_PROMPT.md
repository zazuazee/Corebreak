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

O resultado esperado é um jogo funcional.

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

---

## 3. TECNOLOGIA

Utilize:

**Godot Engine.**

Preferencialmente:

**GDScript.**

---

## 4. ESTRATÉGIA DE IMPLEMENTAÇÃO

Implemente incrementalmente.

Fase 1: Projeto base

Fase 2: Arena

Fase 3: Player

Fase 4: Core

Fase 5: Energy Wave

Fase 6: Game Rules

Fase 7: IA

Fase 8: UI

Fase 9: Power-up

Fase 10: Persistence

Fase 11: Audio/Vibration

Fase 12: Polish

Fase 13: Tests

Fase 14: Mobile export

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

---

## 6. GAMEPLAY

A arena utiliza uma grade.

O jogador movimenta-se em quatro direções.

O jogador possui 3 HP.

O Core pode ser colocado em uma célula.

Após aproximadamente 1,5 segundo, a Energy Wave é criada.

A onda percorre em quatro direções até atingir uma parede.

Blocos destrutíveis são removidos.

Jogadores atingidos recebem dano.

---

## 7. BOARD SYSTEM

Crie um sistema de board independente da UI.

---

## 8. GAME RULES

O sistema deve controlar vitória/derrota e resultados finais da partida.

---

## 9. Sprint 0

Nesta sprint NÃO implementar:

- arena;
- grid;
- player;
- movimento;
- Core;
- Energy Wave;
- dano;
- IA;
- power-ups;
- menus;
- HUD;
- tutorial;
- áudio final;
- multiplayer.

O objetivo é exclusivamente preparar a fundação do projeto.
