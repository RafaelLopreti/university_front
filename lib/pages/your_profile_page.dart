import 'package:flutter/material.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/services/prefs_service.dart';

class ProfileField {
  final String label;
  final TextEditingController controller;
  final TextInputType type;

  ProfileField({
    required this.label,
    required this.controller,
    required this.type,
  });
}

class YourProfilePage extends StatefulWidget {
  final String? initialProfileImage;

  const YourProfilePage({super.key, this.initialProfileImage});

  @override
  _YourProfilePageState createState() => _YourProfilePageState();
}

class _YourProfilePageState extends State<YourProfilePage> {
  late List<ProfileField> _fields;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _fields = _initializeFields();
    _loadUserData();
    profileImage = widget.initialProfileImage;
  }

  List<ProfileField> _initializeFields() {
    return [
      ProfileField(
          label: 'Name',
          controller: TextEditingController(),
          type: TextInputType.name),
      ProfileField(
          label: 'Email',
          controller: TextEditingController(),
          type: TextInputType.emailAddress),
      ProfileField(
          label: 'Taxpayer Registry',
          controller: TextEditingController(),
          type: TextInputType.text),
      ProfileField(
          label: 'Street',
          controller: TextEditingController(),
          type: TextInputType.text),
      ProfileField(
          label: 'Number',
          controller: TextEditingController(),
          type: TextInputType.number),
      ProfileField(
          label: 'City',
          controller: TextEditingController(),
          type: TextInputType.text),
      ProfileField(
          label: 'Neighborhood',
          controller: TextEditingController(),
          type: TextInputType.text),
      ProfileField(
          label: 'Zipcode',
          controller: TextEditingController(),
          type: TextInputType.text),
      ProfileField(
          label: 'Country',
          controller: TextEditingController(),
          type: TextInputType.text),
    ];
  }

  Future<void> _loadUserData() async {
    final dataSources = [
      () => PrefsService.getFromData('name'),
      () => PrefsService.getFromUser('email'),
      () => PrefsService.getFromData('taxpayerRegistry'),
      () => PrefsService.getFromAddress('street'),
      () => PrefsService.getFromAddress('number'),
      () => PrefsService.getFromAddress('city'),
      () => PrefsService.getFromAddress('neighborhood'),
      () => PrefsService.getFromAddress('zipCode'),
      () => PrefsService.getFromAddress('country'),
    ];

    for (int i = 0; i < _fields.length; i++) {
      _fields[i].controller.text = await dataSources[i]() ?? '';
    }

    setState(() {});
  }

  Future<void> _updateProfile() async {
    // Lógica para atualizar os dados
    setState(() {});
  }

  Future<void> _pickImage() async {
    // Lógica para selecionar e atualizar a imagem de perfil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage!)
                      : const NetworkImage(
                          'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    ..._fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: MyTextField(
                          controller: field.controller,
                          keyboardType: field.type,
                          hintText: field.label,
                          isConfidential: false,
                          isFromProfilePage: field.label == 'Taxpayer Registry',
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Button(
              onTap: _updateProfile,
              text: 'Save Changes',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
