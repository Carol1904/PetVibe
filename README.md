# PetVibe 🐾

Aplicação mobile desenvolvida em Flutter para cadastro e gerenciamento de pets, utilizando padrões de arquitetura e Design System baseados no Material 3 Design Kit.

---

## 🎨 Design System e Protótipo no Figma

O layout e os componentes visuais da aplicação foram prototipados utilizando as diretrizes do Material 3:
* **Link do Protótipo no Figma:** https://www.figma.com/design/K0HbyveoXl7NEXTvVchyZM/Material-3-Design-Kit--Community-?node-id=60795-114&t=m2uciyCp5I2x2Juf-1

---

## 🏗️ Arquitetura e Padrões de Projeto

O projeto adota uma estrutura modular focada em reusabilidade e separação de responsabilidades:

1. **MVVM (Model-View-ViewModel):**
   * **View (Widget):** Responsável estritamente pela renderização da interface gráfica.
   * **ViewModel:** Gerencia o estado e as regras de exibição do componente.
2. **Factory Pattern:**
   * Utilizado em `ActionButtonFactory` e `TextFieldFactory` para centralizar a criação dos componentes de UI.
3. **Delegate Pattern:**
   * Implementado via `TextFieldDelegate` para desacoplar a escuta e tratamento dos eventos de edição de texto.

---

## 📂 Estrutura de Pastas

```text
lib/
├── components/
│   ├── action_button/
│   │   ├── action_button_factory.dart
│   │   ├── action_button_view_model.dart
│   │   └── action_button_widget.dart
│   └── text_field/
│       ├── text_field_delegate.dart
│       ├── text_field_factory.dart
│       ├── text_field_view_model.dart
│       └── text_field_widget.dart
├── screens/
│   ├── main_pet_vibe_screen.dart
│   ├── sample_action_button_screen.dart
│   └── sample_text_field_screen.dart
└── main.dart
