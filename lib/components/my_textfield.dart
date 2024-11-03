import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool isConfidential;
  final bool enabled;

  const MyTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.isConfidential = false,
    this.enabled = true,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.enabled)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                widget.hintText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isConfidential ? _obscureText : false,
            enabled: widget.enabled,
            inputFormatters: widget.hintText == 'Taxpayer Registry'
                ? [FilteringTextInputFormatter.digitsOnly, _cpfFormatter()]
                : [],
            decoration: InputDecoration(
              labelText: widget.enabled ? widget.hintText : null,
              labelStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.isConfidential
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[500],
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
