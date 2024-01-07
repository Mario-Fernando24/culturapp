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

  Container doIndicator(index){
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: currentPage==index? kPrimaryColor:kSecondaryColor,
        shape: BoxShape.circle
      ),
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
                    onPageChanged: (value){
                      setState(() {
                        currentPage =value;
                      });
                    },
                    itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: sizeV * 5),
                            Text(onboardingContents[index].title,
                                style: kTitle, textAlign: TextAlign.center),
                            SizedBox(height: sizeV * 5),
                            Container(
                                height: sizeV * 50,
                                child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.contain,
                                )),
                            SizedBox(height: sizeV * 5),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "WE CAN",
                                      style: TextStyle(color: kPrimaryColor)),
                                  TextSpan(
                                      text: "HELP YOU",
                                      style: TextStyle(color: kPrimaryColor)),
                                  TextSpan(
                                      text: "TO BE A BETTER",
                                      style: TextStyle(color: kPrimaryColor)),
                                  TextSpan(
                                      text: "VERSION OF",
                                      style: TextStyle(color: kPrimaryColor)),
                                  TextSpan(
                                      text: "YOURSELF",
                                      style: TextStyle(color: kPrimaryColor))
                                ])),
                            SizedBox(height: sizeV * 5),
                          ],
                      )
                    )
                  ),
                  Expanded(flex: 1, child: Row(
                    children: List.generate(onboardingContents.length, 
                    (index) => doIndicator(index)),
                  ))
          ],
        ),
      ),
    );
  }
}
