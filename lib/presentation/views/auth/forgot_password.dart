import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: loginForm(context)),
    );
  }

  Widget loginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/Recuperare.png",
              width: double.infinity, fit: BoxFit.contain),
          _container(context)
        ],
      ),
    );
  }

  Widget _container(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
     

        return Transform.translate(
          offset: Offset(0.0, 60.0),
          child: Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Center(
                child: Column(
                  children: [
                    _emailInput(),
                    _buttonLogin(context),
                    Container(
                      margin: EdgeInsets.only(top: 80.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Text(
                          'Ya tengo una cuenta',
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
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, registeriewRoutes),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Registrarse',
                                style: TextStyle(
                                    color: PrimaryBlackColors,
                                    fontWeight: FontWeight.bold,
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
      },
    );
  }

  Widget _emailInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _emailController,  
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Correo electronico",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buttonLogin(BuildContext context) {
    return Container(
      width: 350.0,
      height: 60.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {  
          if(_emailController.text.isNotEmpty){
         context.read<AuthenticationCubit>().resetPassword(_emailController.text.trim());
         toasMessage("Se envio un link a tu correo electronico ${_emailController.text.trim()} para que recuperes tu cuenta");
         setState(() {
           _emailController.text="";
         });
         }else{
          toasMessage("El campo no puede estar vacio");
         }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enviar enlace',
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
}
