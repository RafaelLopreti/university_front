import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/controllers/recovery_controller.dart';
import 'package:university_front/pages/password_reset_page.dart';

class CodeRecoveryPage extends StatefulWidget {
  final String code;
  final VoidCallback? onClose;

  const CodeRecoveryPage({
    super.key,
    required this.code,
    this.onClose,
  });

  @override
  _CodeRecoveryPageState createState() => _CodeRecoveryPageState();
}

class _CodeRecoveryPageState extends State<CodeRecoveryPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  late String originalCode;

  @override
  void initState() {
    super.initState();
    originalCode = widget.code;
    _preFillCode(widget.code);
  }

  void _preFillCode(String code) {
    for (int i = 0; i < code.length; i++) {
      _controllers[i].text = code[i];
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _resendCode() async {
    try {
      String newCode = RecoveryController.success();
      originalCode = newCode;
      _preFillCode(newCode);
    } catch (e) {
      rethrow;
    }
  }

  bool _validateCode() {
    String enteredCode =
        _controllers.map((controller) => controller.text).join();
    if (enteredCode == originalCode) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.60,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Center(
                        child: Container(
                          width: 120,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Enter 6 digits code',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Enter the 6 digits code that you received.',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 50,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                onChanged: (value) {
                                  _onChanged(value, index);
                                },
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      Button(
                        text: 'Continue',
                        onTap: () {
                          if (_validateCode()) {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return const PasswordResetPage();
                              },
                            );
                          } else {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Invalid code!',
                              text:
                                  'The code may be invalid or expired, try again.',
                              confirmBtnText: 'RETRY',
                              confirmBtnColor:
                                  const Color.fromARGB(255, 44, 111, 255),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Button(
                        text: 'Resend',
                        onTap: _resendCode,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
