import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool isConfidential;
  final bool enabled;
  final bool isFromProfilePage;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.isConfidential = false,
    this.enabled = true,
    this.isFromProfilePage = false,
    this.onChanged,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isTaxpayerField = widget.hintText == 'Taxpayer Registry';
    final fieldEnabled =
        isTaxpayerField && widget.isFromProfilePage ? false : widget.enabled;

    var defaultBorderRadius = BorderRadius.circular(25);
    var grey500 = Colors.grey[500];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isConfidential ? _obscureText : false,
            enabled: fieldEnabled,
            inputFormatters: isTaxpayerField
                ? [FilteringTextInputFormatter.digitsOnly, _cpfFormatter()]
                : [],
            onChanged: widget.onChanged,
            style: TextStyle(
              color: fieldEnabled ? Colors.black : grey500,
            ),
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: TextStyle(
                color: fieldEnabled ? grey500 : grey500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: defaultBorderRadius,
                borderSide: BorderSide(
                  color: fieldEnabled ? Colors.blue : grey500!,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: defaultBorderRadius,
                borderSide: BorderSide(color: grey500!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: defaultBorderRadius,
                borderSide: BorderSide(
                  color: fieldEnabled ? Colors.blue : grey500,
                ),
              ),
              fillColor: fieldEnabled ? Colors.white : Colors.grey[50],
              filled: true,
              suffixIcon: widget.isConfidential && fieldEnabled
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: grey500,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  TextInputFormatter _cpfFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'\D'), '');
      if (text.length <= 11) {
        StringBuffer buffer = StringBuffer();
        for (int i = 0; i < text.length; i++) {
          if (i == 3 || i == 6) buffer.write('.');
          if (i == 9) buffer.write('-');
          buffer.write(text[i]);
        }
        return TextEditingValue(
          text: buffer.toString(),
          selection: TextSelection.collapsed(offset: buffer.length),
        );
      }
      return oldValue;
    });
  }
}
