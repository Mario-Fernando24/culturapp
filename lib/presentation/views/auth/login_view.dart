import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _emailValidate = false;
  bool _passwordValidate = false;
  bool loading = false;

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
          Image.asset("assets/images/INICIAR_SESION.png",
              width: double.infinity, fit: BoxFit.contain),
          _container(context)
        ],
      ),
    );
  }

  Widget _container(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          loading = false;
          state.user.rol == rolAdmin
              ? Navigator.pushNamed(context, homeAdminviewRoutes)
              : Navigator.pushNamed(context, homeUserviewRoutes);
        } else if (state is AuthenticationFailure) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red, // Color de fondo rojo
            behavior: SnackBarBehavior.floating, // Posición superior
          ));
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoading) {
          loading = true;
        }

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
                    _passwordInput(),
                    loadingFunctions(),
                    _buttonLogin(context),
                    Container(
                      margin: EdgeInsets.only(top: 80.0),
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
              onChanged: (value) => {
                setState(() {
                  _emailValidate = _emailController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Correo electronico",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _emailValidate
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _passwordInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  onChanged: (value) => {
                    setState(() {
                      _passwordValidate = _passwordController.text.isNotEmpty;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              _passwordValidate
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.check_circle, color: Colors.green),
                    )
                  : Container(),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingFunctions() {
    return loading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 7.0,
              color: kPrimaryColor,
            )),
          )
        : Container();
  }

  Widget _buttonLogin(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthenticationCubit>().loginCubit(
              _emailController.text.trim(), _passwordController.text.trim());
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
}
