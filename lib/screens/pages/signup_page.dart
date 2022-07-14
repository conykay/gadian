import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.05)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Create an account to continue',
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => widget.pageController.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
