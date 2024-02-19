import 'package:e_commerce/models/on_board_model.dart';
import 'package:e_commerce/modules/login/login_screen.dart';
import 'package:e_commerce/network/local/cach_helper.dart';
import 'package:e_commerce/shared/components/boarding_item.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var controller = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CachHelper.setData(key: 'onBoard', value: true).then(
                (value) {
                  print(value);
                  navigateAndFinish(context, const LoginScreen());
                },
              );
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == onBoardItems.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) =>
                    buildBoardingItem(onBoardItems[index]),
                itemCount: onBoardItems.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: onBoardItems.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (isLast) {
                      CachHelper.setData(key: 'onBoard', value: true).then(
                        (value) =>
                            navigateAndFinish(context, const LoginScreen()),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
