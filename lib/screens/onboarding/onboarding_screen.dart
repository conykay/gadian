import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadian/models/onboarding_info.dart';
import 'package:gadian/screens/authentication/registration_screen.dart';

import '../../constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  AnimatedContainer _dotsBuilder(index) => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: _currentIndex == index
            ? const EdgeInsets.symmetric(horizontal: 2)
            : EdgeInsets.zero,
        height: 8,
        width: _currentIndex == index ? 20 : 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _currentIndex == index
              ? Colors.red
              : Colors.grey.withOpacity(0.5),
        ),
        curve: Curves.easeIn,
      );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: _controller,
              itemCount: kOnboardingInfo.length,
              onPageChanged: (index) => setState(() {
                _currentIndex = index;
              }),
              itemBuilder: (context, index) {
                OnboardingInfo current = kOnboardingInfo[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SvgPicture.asset(
                          current.image,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              current.title,
                              style: kHeadlineText,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              current.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      index + 1 == kOnboardingInfo.length
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await SharedPrefs()
                                      .setSharedPrefs('new', false);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen()),
                                  );
                                },
                                child: const Text('Get Started'),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => _controller.animateToPage(
                                    kOnboardingInfo.length - 1,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.decelerate,
                                  ),
                                  child: const Text('SKIP'),
                                ),
                                IconButton(
                                  onPressed: () => _controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  ),
                                  icon: const Icon(Icons.navigate_next),
                                )
                              ],
                            )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                kOnboardingInfo.length,
                (index) => _dotsBuilder(index),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
