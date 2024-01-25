import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:flutter/material.dart';

  showAlertDialog(BuildContext context, String imagePath,
 String headerTitle, String headerSubTitle, String labelButton, Function doneButtonFunc)async {
  await  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: 400,
            child: Column(
              children: [
                Image(
                  image: AssetImage(imagePath),
                  width: 130,
                  height: 130,
                ),
                Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: headerText(headerTitle,
                        Theme.of(context).primaryColor, FontWeight.bold, 20.0)),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Text(headerSubTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ),
                Spacer(),
                _buttonDone(context, labelButton,doneButtonFunc)
              ],
            ),
          ),
        );
      }
    );
}

Widget _buttonDone(BuildContext context, String labelButton, Function doneButtonFunc) {
  return Container(
    width: 350.0,
    height: 50.0,
    margin: EdgeInsets.only(top: 25.0),
    child: ElevatedButton(
      onPressed: () =>doneButtonFunc,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(labelButton,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(width: 10),
          Icon(Icons.done_all),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
  );
}
