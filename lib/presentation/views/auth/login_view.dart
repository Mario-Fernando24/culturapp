import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset("assets/images/onbording2.jpg",
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.50,
                        fit: BoxFit.cover),
                  ),
                  // Container(
                  //   child: backButton(context, Colors.white),
                  // ),
                ],
              ),
              _container(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _container(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -55.0),
      child: Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                headerText('Bienvenido', kPrimaryColor, FontWeight.bold, 30.0),
                Text("inicia sesión en tu cuenta",
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0)),
                _emailInput(),
                _passwordInput(),
                _buttonLogin(context),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Text(
                      'Olvidaste tu contraseña',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'no tengo una cuenta? ',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, registeriewRoutes),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _emailInput() {
  return Container(
    margin: EdgeInsets.only(top: 30.0),
    padding: EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: inputColors, borderRadius: BorderRadius.circular(30.0)),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo electronico',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _passwordInput() {
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    padding: EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: inputColors, borderRadius: BorderRadius.circular(30.0)),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _buttonLogin(BuildContext context) {
  return Container(
    width: 350.0,
    height: 50.0,
    margin: EdgeInsets.only(top: 25.0),
    child: ElevatedButton(
      onPressed: () {
        print("mario fernando");
        Navigator.pushNamed(context, "tabs");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ingresar',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(width: 10),
          Icon(Icons.login_outlined),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
  );
}
