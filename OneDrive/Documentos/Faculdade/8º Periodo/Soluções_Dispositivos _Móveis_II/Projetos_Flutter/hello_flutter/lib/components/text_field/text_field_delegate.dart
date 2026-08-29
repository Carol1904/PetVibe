import 'text_field_widget.dart';

abstract class TextFieldDelegate {
  void onBeginEditing(TextFieldWidget widget, String text);
  void onEditing(TextFieldWidget widget, String text);
  void onEndEditing(TextFieldWidget widget, String text);
}