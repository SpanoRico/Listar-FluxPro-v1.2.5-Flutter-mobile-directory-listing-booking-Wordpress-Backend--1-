enum AuthenticationState {
  loading,
  success,
  fail,
  otpRequested,      // OTP has been requested
otpRequestFailed,  // Failed to request OTP
otpVerified,       // OTP has been verified
otpVerificationFailed, // OTP verification failed

}
