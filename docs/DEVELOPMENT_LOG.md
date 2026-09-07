# COREBREAK — Development Log

**Projeto:** COREBREAK
**Engine:** Godot 4.x
**Linguagem:** GDScript
**Plataformas:** Android / iOS
**Status:** Sprint 0 concluída parcialmente

---

## 2026-09-07 — Sprint 0: Fundação técnica do projeto

### Tipo
Feature / Architecture / QA

### Alterações
- Verificado que o repositório já possuía documentação e base inicial do projeto, mas sem estrutura Godot completa para o MVP.
- Criada a estrutura de diretórios conforme a arquitetura proposta.
- Atualizada a configuration do Godot para orientação Portrait, viewport mobile e input map inicial.
- Criada a cena principal em `scenes/main/Main.tscn` com `SceneRouter`, `GameManager`, `AudioManager`, `HapticManager` e `UI`.
- Implementado `scripts/core/GameManager.gd` com estados iniciais e transições mínimas de partida.
- Implementado `scripts/core/GameConfig.gd` com os parâmetros principais do jogo.
- Criados os sistemas iniciais `AudioManager` e `HapticManager`.
- Criado teste mínimo de validação para `GameConfig`.
- Registrados os documentos de GDD, arquitetura, roadmap e prompt no diretório `docs/` do repositório.

### Motivo
- Preparar a fundação técnica do COREBREAK antes da implementação do gameplay real.
- Garantir que o projeto abra corretamente em Godot 4.x e fique pronto para a próxima sprint.

### Testes
- Execução do projeto em modo headless do Godot.
- Execução do script de teste unitário de configuração.

### Resultado
- O projeto abriu sem erros críticos no Godot 4.7.2.
- A cena principal inicializou corretamente.
- O GameManager entrou em estado READY e a sequência de boot executou sem falhas.
- O teste de `GameConfig` passou com sucesso.

### Problemas encontrados
- O repositório não possuía a estrutura completa exigida pela arquitetura do projeto.
- A documentação do projeto estava em um local complementar e não na raiz de `docs/`.
- O primeiro teste unitário exigia ajuste de assinatura do `SceneTree` para funcionar corretamente.

### Problemas pendentes
- Implementação do gameplay em sprint futura.
- Desenvolvimento da arena baseada em grid.
- Sistema de jogador e IA.
- Sistema de Core e Energy Wave.
- UI completa e menus.

### Próximo passo
- Implementar a sprint 1.1 de arena e grid, mantendo a arquitetura já preparada.
