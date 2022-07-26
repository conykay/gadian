import 'package:flutter/material.dart';
import 'package:gadian/components/infoMaterialBanner.dart';
import 'package:gadian/models/providers/authentication_provider.dart';
import 'package:gadian/models/providers/profile_provider.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String src = 'https://stonegatesl.com/wp-content/uploads/2021/01/avatar.jpg';
  bool _loading = false;
  bool _resetLoading = false;
  late final Future? userInfoFuture;
  @override
  void initState() {
    super.initState();
    userInfoFuture = _userInfoFuture();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
          future: _userInfoFuture(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.data.runtimeType == UserModel) {
                UserModel? userData = snapshot.data as UserModel?;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildUserImage(image: userData?.imageUrl),
                        _buildUserInfoSection(user: userData),
                        Divider(
                          thickness: 4,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        _buildActionButtons()
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Column(children: [
                  const Icon(
                    Icons.error,
                    size: 30,
                  ),
                  Text(
                    ExceptionHandler.generateErrorMessage(snapshot.data),
                    style: const TextStyle(color: Colors.red),
                  ),
                ]),
              );
            } else {
              return Center(
                child: Column(children: [
                  const Icon(
                    Icons.error,
                    size: 30,
                  ),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ]),
              );
            }
          }),
    );
  }

  Future<dynamic> _userInfoFuture() {
    return Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
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
              onPressed: () =>
                  Provider.of<ProfileProvider>(context, listen: false)
                      .getUserInfo(),
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
            onPressed: () {
              setState(() => _loading = true);
              Provider.of<Authprovider>(context, listen: false)
                  .logout()
                  .then((value) {
                setState(() => _loading = false);
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: _loading
                ? CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Logout'), Icon(Icons.logout)],
                  ),
          ),
        )
      ],
    );
  }

  Widget _buildUserInfoSection({UserModel? user}) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userInfo(label: 'Name', info: user!.name),
          _userInfo(label: 'Email', info: user.email),
          _userInfo(label: 'Phone number', info: user.phoneNumber),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                var scaffold = ScaffoldMessenger.of(context);
                setState(() => _resetLoading = true);
                AuthStatus? status;
                await Provider.of<ProfileProvider>(context, listen: false)
                    .sendPasswordResetEmail()
                    .then((value) => status = value);
                if (status == AuthStatus.successful) {
                  setState(() => _resetLoading = false);
                  scaffold.showMaterialBanner(infoMaterialBanner(
                      content: 'Password Reset link sent , Check your inbox. ',
                      icon: Icons.done_all,
                      color: Colors.green,
                      onPressed: () => scaffold.hideCurrentMaterialBanner()));
                } else {
                  setState(() => _resetLoading = false);
                  scaffold.showMaterialBanner(infoMaterialBanner(
                      content:
                          AuthExceptionHandler.generateErrorMessage(status),
                      icon: Icons.error,
                      color: Colors.redAccent,
                      onPressed: () => scaffold.hideCurrentMaterialBanner()));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Change password'),
                  _resetLoading
                      ? const CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : const Text(''),
                ],
              ),
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

  Widget _buildUserImage({String? image}) {
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
