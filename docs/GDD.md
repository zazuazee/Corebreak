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

Seu principal recurso é o Core, um dispositivo capaz de criar cargas de energia que percorrem a arena em quatro direções.

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

---

### 5. Core Loop

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

### 7. Arena

A arena utiliza uma grade lógica.

Tamanho inicial recomendado:

**11 × 15 células.**

---

### 8. Tipos de célula

#### 8.1 Boundary

Limite externo da arena.

#### 8.2 Solid Wall

Parede permanente.

#### 8.3 Breakable Block

Bloco destrutível.

#### 8.4 Floor

Espaço livre.

---

### 9. Geração da arena

A arena inicial pode utilizar um mapa pré-definido.

---

### 10. Spawn

O mapa deve possuir spawns seguros e corredores.

---

### 11. Player

O jogador possui:

* 3 HP;
* movimentação por grid;
* ataque de longa distância via Core;
* linha de visão curta e posicionamento estratégico.

---

### 12. Core e Energy Wave

O Core é o núcleo principal.

A Energy Wave é disparada após aproximadamente 1,5 segundos e percorre em quatro direções até uma parede, destruindo blocos e causando dano.

---

### 13. Vitória e derrota

A partida termina quando um jogador perde todos os HP ou quando o tempo acabar.

---

### 14. Meta do MVP

O projeto v0.1 deve ser um protótipo funcional e jogável que demonstre a ideia core do jogo em ambiente mobile.
