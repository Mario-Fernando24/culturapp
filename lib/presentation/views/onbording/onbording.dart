import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/onbording.dart';
import 'package:flutter/material.dart';

class OnbordingView extends StatefulWidget {
  const OnbordingView({super.key});

  @override
  State<OnbordingView> createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnbordingView> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer doIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : kSecondaryColor,
          shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingContents.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: sizeV * 5),
                            Text(onboardingContents[index].title,
                                style: kTitle, textAlign: TextAlign.center),
                            SizedBox(height: sizeV * 1),
                            Container(
                              height: sizeV * 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Ajusta el valor según lo redondo que desees los bordes
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                      text: onboardingContents[index].description,
                                      style: kBodyText2)
                            ),
                            SizedBox(height: sizeV * 5),
                          ],
                        ))),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    currentPage == onboardingContents.length - 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: SizeConfig.blockSizeH! * 15.5,
                              width: SizeConfig.blockSizeV! * 100,
                              child: TextButton(
                                onPressed: () {},
                                child: Text('Empezar', style: kBodyText1),
                                style: TextButton.styleFrom(
                                    backgroundColor: kPrimaryColor),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OnbordingNavBt(
                                  name: "Anterior",
                                  onPress: () {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );
                                  }),
                              Row(
                                children: List.generate(
                                    onboardingContents.length,
                                    (index) => doIndicator(index)),
                              ),
                              OnbordingNavBt(
                                  name: "Siguiente",
                                  onPress: () {
                                    _pageController.nextPage(
                                        duration: Duration(microseconds: 400),
                                        curve: Curves.easeInOut);
                                  })
                            ],
                          ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class OnbordingNavBt extends StatelessWidget {
  const OnbordingNavBt({
    super.key,
    required this.name,
    required this.onPress,
  });

  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(6),
        splashColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: kBodyText1,
          ),
        ));
  }
}
