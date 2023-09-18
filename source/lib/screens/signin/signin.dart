import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final String from;
  const SignIn({Key? key, required this.from}) : super(key: key);

  @override
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String? _errorID;
  String? _errorPass;

  @override
  void initState() {
    super.initState();
    _textIDController.text = "paul";
    _textPassController.text = "y33S^xO%BQV8**@";
  }

  @override
  void dispose() {
    _textIDController.dispose();
    _textPassController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  ///On navigate forgot password
  void _forgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  ///On navigate sign up
  void _signUp() {
    Navigator.pushNamed(context, Routes.signUp);
  }

  ///On login
  void _login() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorID == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textIDController.text,
        password: _textPassController.text,
      );
    }
    if (_errorID == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textIDController.text,
        password: _textPassController.text,
      );
      // Ici, vérifiez la réponse du serveur pour voir si un OTP est nécessaire
      bool otpRequired = true; // Ceci est juste un exemple, vous devriez vérifier la réponse réelle du serveur
      if (otpRequired) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen(email: _textIDController.text)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_in'),
        ),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, login) {
            if (state == LoginState.success) {
                // Ici, vérifiez si un OTP est nécessaire
                bool otpRequired = true; // Ceci est juste un exemple, vous devriez vérifier la réponse réelle du serveur
                if (otpRequired) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPScreen(email: _textIDController.text)),
                    );
                } else {
                    Navigator.pop(context);
                }
            } else if (state == LoginState.fail) {
                // Gérez l'échec de la connexion ici, par exemple en affichant un message d'erreur
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Échec de la connexion. Veuillez réessayer."))
                );
            }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppTextInput(
                    hintText: Translate.of(context).translate('account'),
                    errorText: _errorID,
                    controller: _textIDController,
                    focusNode: _focusID,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      setState(() {
                        _errorID = UtilValidator.validate(
                          _textIDController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(context, _focusID, _focusPass);
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate('password'),
                    errorText: _errorPass,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      setState(() {
                        _errorPass = UtilValidator.validate(
                          _textPassController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      _login();
                    },
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    obscureText: !_showPassword,
                    controller: _textPassController,
                    focusNode: _focusPass,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, login) {
                      return AppButton(
                        Translate.of(context).translate('sign_in'),
                        mainAxisSize: MainAxisSize.max,
                        onPressed: _login,
                        loading: login == LoginState.loading,
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AppButton(
                        Translate.of(context).translate('forgot_password'),
                        onPressed: _forgotPassword,
                        type: ButtonType.text,
                      ),
                      AppButton(
                        Translate.of(context).translate('sign_up'),
                        onPressed: _signUp,
                        type: ButtonType.text,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
