import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
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

    // ignore: unused_local_variable
    double sizeH = SizeConfig.blockSizeH!;
    // ignore: unused_local_variable
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
                    itemBuilder: (context, index) => Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 00),
                                child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(
                            //         10.0), // Ajusta el valor según lo redondo que desees los bordes
                            //   ),
                            //   child:  Image.asset(
                            //       onboardingContents[index].image,
                            //       fit: BoxFit.contain,
                            //     ),

                            // ),
                            Positioned(
                              top: 40,
                              left: 0,
                              right: 0,
                              child: Text(
                                onboardingContents[index].title,
                                style: kTitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.blockSizeH! * 130,
                              left: 10,
                              right: 10,
                              child: Text(
                                onboardingContents[index].description,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.justify,
                              ),
                            )
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
                              height: SizeConfig.blockSizeH! * 13.5,
                              width: SizeConfig.blockSizeV! * 100,
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, loginViewRoutes),
                                child: Text('Empezar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.blockSizeH! * 4.5,
                                      fontWeight: FontWeight.bold,
                                    )),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
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
