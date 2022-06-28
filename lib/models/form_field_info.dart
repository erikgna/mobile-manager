class FormFieldInfo {
  final String label;
  final String hint;
  bool isPassword;

  FormFieldInfo(
      {required this.label, required this.hint, this.isPassword = false});
}
