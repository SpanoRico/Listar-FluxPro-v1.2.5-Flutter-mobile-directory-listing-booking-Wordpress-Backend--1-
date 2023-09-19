import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  OTPScreen({required this.email});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _submitOTP() async {
    setState(() {
      _isLoading = true;
    });

    final otp = _otpController.text;
    final isSuccess = await AppBloc.authenticationCubit.verifyOTP(widget.email, otp);

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      // Rediriger vers l'écran principal ou tout autre écran approprié
      Navigator.pushReplacementNamed(context, '/home'); // Remplacez '/home' par la route appropriée
    } else {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid or expired OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter your OTP',
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitOTP,
                    child: Text('Submit'),
                  )
          ],
        ),
      ),
    );
  }
}
