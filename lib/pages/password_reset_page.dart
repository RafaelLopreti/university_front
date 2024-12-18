import 'package:flutter/material.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/controllers/recovery_controller.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool hasUpperCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void _validatePassword(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasSpecialCharacter =
          password.contains(RegExp(r'[@#$%^&+=()\-\[\]{}*_]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasMinLength = password.length >= 8 && password.length <= 20;
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              color: Colors.white,
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
                    'Change password',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Please enter your new password.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildValidPassword('At least 8-20 characters', hasMinLength),
                  _buildValidPassword(
                      'At least one uppercase letter', hasUpperCase),
                  _buildValidPassword(
                      'At least one special character', hasSpecialCharacter),
                  _buildValidPassword('At least one number', hasNumber),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _newPasswordController,
                    keyboardType: TextInputType.text,
                    hintText: 'Password',
                    isConfidential: true,
                    onChanged: _validatePassword,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    hintText: 'Confirm password',
                    isConfidential: true,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: 'Continue',
                    onTap: () {
                      RecoveryController().updateUser(context,
                          _newPasswordController, _confirmPasswordController);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidPassword(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: isValid ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isValid ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
