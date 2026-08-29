import 'text_field_view_model.dart';
import 'text_field_delegate.dart';

class TextFieldFactory {
  static TextFieldViewModel create({
    required String label,
    required String hint,
    TextFieldDelegate? delegate,
  }) {
    return TextFieldViewModel(
      label: label,
      hint: hint,
      delegate: delegate,
    );
  }
}