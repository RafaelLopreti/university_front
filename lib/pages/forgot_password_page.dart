import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:university_front/pages/code_recovery_page.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/services/notify_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  final TextEditingController recoverEmailController;

  const ForgotPasswordPage({
    super.key,
    required this.recoverEmailController,
  });

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _showCodeRecovery = false;

  @override
  void initState() {
    super.initState();
    NotificationService().initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 225, 225, 225),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
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
                    'Forgot password',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your email to receive a 6-digit verification code.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyTextField(
                    controller: widget.recoverEmailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    isConfidential: false,
                  ),
                  const SizedBox(height: 30),
                  SignButton(
                    removeDefaultShadow: true,
                    text: 'Continue',
                    onTap: () {
                      if (widget.recoverEmailController.text.isEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'ERROR',
                          text: 'Email must not be empty.',
                          confirmBtnText: 'OK',
                          confirmBtnColor:
                              const Color.fromARGB(255, 44, 111, 255),
                        );
                      } else {
                        //RecoveryController.consult(context, widget.recoverEmailController.text);
                        setState(() {
                           _showCodeRecovery = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_showCodeRecovery)
            Align(
              alignment: Alignment.bottomCenter,
              child: CodeRecoveryPage(
                onClose: () {
                  setState(() {
                    _showCodeRecovery = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
