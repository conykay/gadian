import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String src = 'https://stonegatesl.com/wp-content/uploads/2021/01/avatar.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserImage(),
              _buildUserInfoSection(),
              Divider(
                thickness: 4,
                color: Colors.grey.withOpacity(0.1),
              ),
              _buildActionButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 200,
            child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Invite Friend'),
                  Icon(Icons.person_add_alt)
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Logout'), Icon(Icons.logout)],
              )),
        )
      ],
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userInfo(label: 'Name', info: 'Cornelius k'),
          _userInfo(label: 'Email', info: 'coneKorir@gmail.com'),
          _userInfo(label: 'Phone number', info: '0707964271'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              onPressed: () {},
              child: const Text('Change password'),
            ),
          )
        ],
      ),
    );
  }

  Widget _userInfo({required String label, required String info}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          info,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(src),
          ),
          Positioned(
            right: 15,
            bottom: 10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                iconSize: 25,
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
