import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadian/models/onboarding_info.dart';
import 'package:gadian/screens/onboarding/onboarding_view_model.dart';

import '../../constants.dart';

//Todo:test if this breaks page navigation.
final currentIndex = StateProvider<int>((ref) => 0);

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  AnimatedContainer _dotsBuilder(index, WidgetRef ref) => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: ref.watch(currentIndex) == index
            ? const EdgeInsets.symmetric(horizontal: 2)
            : EdgeInsets.zero,
        height: 8,
        width: ref.watch(currentIndex) == index ? 20 : 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ref.watch(currentIndex) == index
              ? Theme.of(context).primaryColor
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
    final indexNotifier = ref.watch(currentIndex.notifier);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: _controller,
              itemCount: kOnboardingInfo.length,
              onPageChanged: (index) =>
                  indexNotifier.update((state) => state = index),
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
                              style: kHeadlineText(context),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      index + 1 == kOnboardingInfo.length
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: FilledButton(
                                onPressed: () => onGetStarted(),
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
                (index) => _dotsBuilder(index, ref),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future<void> onGetStarted() async {
    final onBoardingProvider = ref.watch(onBoardingViewModelProvider.notifier);
    await onBoardingProvider.setOnBoardingComplete();
  }
}
