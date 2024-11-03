import 'package:flutter/material.dart';
import 'package:university_front/pages/your_profile_page.dart';
import 'package:university_front/services/prefs_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadProfileImage();
  }

  Future<void> _loadUserName() async {
    String? name = await PrefsService.getFromData('name');
    setState(() {
      userName = name;
    });
  }

  Future<void> _loadProfileImage() async {
    String? imageUrl = await PrefsService.getProfileImage();
    setState(() {
      profileImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage!)
                        : const NetworkImage(
                            'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                userName ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            _buildListTile(context, 'Your Profile', 0),
            const SizedBox(height: 10),
            _buildListTile(context, 'Settings', 1),
            const SizedBox(height: 10),
            _buildListTile(context, 'Payment Method', 2),
            const SizedBox(height: 10),
            _buildListTile(context, 'Help Center', 3),
            const SizedBox(height: 10),
            _buildListTile(context, 'Privacy Policy', 4),
            const SizedBox(height: 10),
            _buildListTile(context, 'Log out', 5),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YourProfilePage(
                  initialProfileImage: profileImage,
                ),
              ),
            );
            break;
          case 1:
            print('$index tapped');
            break;
          case 2:
            print('$index tapped');
            break;
          case 3:
            print('$index tapped');
            break;
          case 4:
            print('$index tapped');
            break;
          case 5:
            PrefsService.logout();
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(title),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
