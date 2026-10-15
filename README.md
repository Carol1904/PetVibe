Markdown
# 🐾 Minha Carteira (Projeto & Design System)

Este repositório armazena a evolução dos projetos desenvolvidos para a disciplina, integrando o **Design System** criado inicialmente no projeto *PetVibe* para a construção da aplicação **Minha Carteira**.

> **Nota:** Por razões de acompanhamento acadêmico e preservação do link enviado para avaliação, o repositório mantém o nome original `PetVibe`.

---

## 📱 Sobre o Projeto

O projeto consiste em um ecossistema mobile desenvolvido em **Flutter** que combina:
1. **Design System Personalizado:** Conjunto de tokens de design (cores, tipografia, espaçamentos e componentes) construído na primeira etapa para padronização visual.
2. **Aplicativo Minha Carteira:** Aplicação mobile de gestão financeira/carteira digital que consome os tokens e componentes do Design System desenvolvido.

---

## 🛠️ Tecnologias e Arquitetura

* **Framework:** Flutter & Dart
* **Arquitetura:** MVVM (Model-View-ViewModel) + Coordinator Pattern
* **Design System:** Tokens customizados aplicados nas telas (*Home*, *Login*, etc.)
* **Organização de Código:** Separação por cenários, componentes e internacionalização (L10n)

---

## 🏗️ Estrutura do Repositório

```text
carteira/
 └── apps/
      └── mobile/
           ├── lib/
           │    ├── features/      # Módulos de autenticação e utilitários
           │    ├── l10n/          # Textos e internacionalização
           │    ├── scenes/        # Módulos do app (Home, Login, etc.)
           │    └── main.dart      # Ponto de entrada
           └── pubspec.yaml        # Dependências e assets
🚀 Como Executar a Aplicação
Pré-requisitos
Flutter SDK (versão 3.x ou superior)

Emulador Android/iOS ou dispositivo físico configurado

Execução:
Navegue até o diretório do app mobile:

Bash
cd carteira/apps/mobile
Instale as dependências:

Bash
flutter pub get
Execute o aplicativo:

Bash
flutter run
📌 Histórico de Desenvolvimento
Fase 1: Construção da estrutura inicial do Design System e conceito do projeto PetVibe.

Fase 2: Transição e desenvolvimento do app Minha Carteira.

Fase 3: Aplicação completa dos tokens do Design System na tela inicial (Home) e refatoração do fluxo de autenticação.

