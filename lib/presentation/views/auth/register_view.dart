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
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _usersValidate = false;
  bool _lastNameValidate = false;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  bool _passwordValidate = false;
  bool _password_confirm_Validate = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            loading = false;

            if (state.user.rol == rolUser)
              Navigator.pushNamed(context, homeUserviewRoutes);
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
                Image.asset(
                  "assets/images/REGISTRATE.png",
                  width: double.infinity,
                  height: 179,
                  // height: MediaQuery.of(context).size.height * 0.62,
                  fit:
                      BoxFit.contain, // Ajusta el BoxFit según tus preferencias
                ),
                Container(
                    margin: EdgeInsets.only(left: 5, top: 10),
                    child: backButton(context, Colors.white))
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
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userInput(context),
              _lastNameInput(context),
              _emailInput(context),
              _phoneInput(context),
              _passwordInput(context),
              _passwordConfirmInput(context),
              loadingFunctions(),
              _buttonSign_up(context)
              //_phoneInput(context)
            ],
          ),
        ),
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

  Widget _userInput(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        padding: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
            color: inputColors, borderRadius: BorderRadius.circular(40.0)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _usersController,
                keyboardType: TextInputType.text,
                onChanged: (value) => {
                  setState(() {
                    _usersValidate = _usersController.text.isNotEmpty;
                  })
                },
                decoration: InputDecoration(
                  hintText: "Nombre",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            _usersValidate
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.check_circle, color: Colors.green),
                  )
                : Container(),
          ],
        ));
  }

  Widget _lastNameInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _lastNameController,
              onChanged: (value) => {
                setState(() {
                  _lastNameValidate = _lastNameController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Apellido",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _lastNameValidate
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _emailInput(BuildContext context) {
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

  Widget _phoneInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _phoneController,
              onChanged: (value) => {
                setState(() {
                  _phoneValidate = _phoneController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Telefono",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _phoneValidate
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _passwordInput(BuildContext context) {
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

  Widget _passwordConfirmInput(BuildContext context) {
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
                  obscureText: _obscureText2,
                  onChanged: (value) => {
                    setState(() {
                      _password_confirm_Validate =
                          _password_confirm_Controller.text.isNotEmpty;
                    })
                  },
                  controller: _password_confirm_Controller,
                  decoration: InputDecoration(
                    hintText: "Confirmar contraseña",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              _password_confirm_Validate
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
                _obscureText2 = !_obscureText2;
              });
            },
            icon: Icon(
              _obscureText2 ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ],
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
