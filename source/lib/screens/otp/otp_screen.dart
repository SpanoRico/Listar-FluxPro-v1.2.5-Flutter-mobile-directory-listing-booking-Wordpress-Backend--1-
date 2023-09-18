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

  void _submitOTP() {
    final otp = _otpController.text;
    AppBloc.authenticationCubit.verifyOTP(widget.email, otp);
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
            ElevatedButton(
              onPressed: _submitOTP,
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
