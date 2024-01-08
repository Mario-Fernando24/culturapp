import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usersController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password_confirm_Controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            if (state.user.rol == rolUser)
              Navigator.pushNamed(context, homeUserviewRoutes);
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return _registerForm(context);
        },
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/onbording2.jpg",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.22,
                    fit:
                        BoxFit.cover, // Ajusta el BoxFit según tus preferencias
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: backButton(context, kPrimaryColor))
              ],
            ),
            _container(context)
          ],
        ),
      ),
    );
  }

  // @override
  Widget _container(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerText('Crear cuenta', kPrimaryColor, FontWeight.bold, 30.0),
              _userInput(context),
              _lastNameInput(context),
              _emailInput(context),
              _phoneInput(context),
              _passwordInput(context),
              _passwordConfirmInput(context),
              _buttonSign_up(context)
              //_phoneInput(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _usersController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: "Nombre",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _lastNameInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _lastNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: "Apellido",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _emailInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Correo electronico",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _phoneInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: "Telefono",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _passwordInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _passwordConfirmInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: TextField(
        controller: _password_confirm_Controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Confirmar contraseña",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buttonSign_up(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          final userss = Users(
              username: _usersController.text.trim(),
              lastname: _lastNameController.text.trim(),
              email: _emailController.text.trim(),
              telefono: _phoneController.text.trim(),
              password: _passwordController.text.trim());
          context.read<AuthenticationCubit>().register(userss);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrarse',
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
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
  }
}
