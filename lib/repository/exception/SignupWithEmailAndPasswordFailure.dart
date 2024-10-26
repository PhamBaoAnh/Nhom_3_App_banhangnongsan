class SignupWithEmailAndPasswordFailure {
  final String message;
  const SignupWithEmailAndPasswordFailure(
      [this.message = "An Unkhown error eccurred."]);
  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignupWithEmailAndPasswordFailure(
            "Please enter a strong password.");
      case 'invalid-email':
        return const SignupWithEmailAndPasswordFailure("Email is not valid.");
      case 'email-already-in-use':
        return const SignupWithEmailAndPasswordFailure(
            "An account already exists for that emails.");
      case 'operation-not-allowed':
        return const SignupWithEmailAndPasswordFailure(
            "Operation is not allowed. Please contact support..");
      case 'user-disabled':
        return const SignupWithEmailAndPasswordFailure(
            "This user has been disabled. Please contact support for help.");
      default:
        return const SignupWithEmailAndPasswordFailure();
    }
  }
}
