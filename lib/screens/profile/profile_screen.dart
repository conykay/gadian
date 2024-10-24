import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:gadian/components/info_material_banner.dart';
import 'package:gadian/models/user_model.dart';
import 'package:gadian/screens/authentication/authentication_view_model.dart';
import 'package:gadian/services/error_handler.dart';
import 'package:gadian/services/firebase/firebase_user_profile.dart';

final resetLoading = StateProvider((ref) => false);

final userDataProvider = StreamProvider<UserModel>(
    (ref) => ref.read(userProfileProvider).getUserInfo());

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //? is it possible to use riverpods future notifier ?
    final userModelProvider = ref.watch(userDataProvider);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: userModelProvider.when(
        data: (userData) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildUserImage(image: userData.imageUrl),
              _buildUserInfoSection(user: userData),
              Divider(
                thickness: 4,
                color: Colors.grey.withOpacity(0.1),
              ),
              _buildActionButtons()
            ],
          ),
        ),
        error: (e, stackTrace) => _errorWidget(e),
        loading: () => const Center(
          child: LoadingIndicator(
            indicatorType: Indicator.ballScaleMultiple,
            colors: [
              Colors.red,
              Colors.lightBlueAccent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorWidget(e) {
    return Center(
      child: Column(children: [
        const Icon(
          Icons.error,
          size: 30,
        ),
        Text(
          e.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ]),
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
              onPressed: () =>
                  throw UnimplementedError('Incomplete Implementation'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invite Friend'),
                  Icon(Icons.person_add_alt),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              ref.read(authenticationViewModelProvider.notifier).logOut();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child:
                ref.watch(authenticationViewModelProvider) is AsyncLoading<bool>
                    ? const CircularProgressIndicator()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Logout'),
                          Icon(Icons.logout),
                        ],
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
          _userInfo(label: 'Name', info: user!.name!),
          _userInfo(label: 'Email', info: user.email!),
          _userInfo(label: 'Phone number', info: user.phoneNumber!),
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
                _toggleReset;
                AuthStatus? status;
                await ref
                    .watch(authenticationViewModelProvider.notifier)
                    .resetPassword(email: user.email!);
                if (status == AuthStatus.successful) {
                  _toggleReset;
                  String message =
                      'Password Reset link sent , Check your inbox.';
                  _showBanner(scaffold, message, Icons.done_all, Colors.green);
                } else {
                  _toggleReset;
                  String error =
                      AuthExceptionHandler.generateErrorMessage(status);
                  _showBanner(scaffold, error, Icons.error, Colors.redAccent);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Change password'),
                  ref.watch(resetLoading)
                      ? const CircularProgressIndicator()
                      : const Text(''),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _toggleReset() =>
      ref.watch(resetLoading.notifier).update((state) => !state);

  void _showBanner(ScaffoldMessengerState scaffold, String message,
      IconData icon, Color color) {
    scaffold.showMaterialBanner(infoMaterialBanner(
        content: message,
        icon: icon,
        color: color,
        onPressed: () => scaffold.hideCurrentMaterialBanner()));
  }

  Widget _userInfo({required String label, required String info}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        title: Text(
          label,
        ),
        subtitle: Text(
          info,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildUserImage({String? image}) {
    String src =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9ZNYnEdpW6Io--tnEw80mAgRGLOn2oNYNFQ&usqp=CAU';
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 80,
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
