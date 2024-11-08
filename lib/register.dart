import 'package:flutter/material.dart';
import 'package:profile/services/api.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool _isPasswordEmpty = false;
  bool _isEmailEmpty = true;
  bool _isUserEmpty = true;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordEmpty = false;
  bool _isPasswordMismatch = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final Api api = Api(); // Inisialisasi instance API

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final isLengthValid = password.length >= 8;
    setState(() {
      _isPasswordValid = hasUpperCase && hasDigits && isLengthValid;
      _isPasswordEmpty = _passwordController.text.isEmpty;
    });
  }

  void _validateEmail() {
    setState(() {
      _isEmailEmpty = _emailController.text.trim().isEmpty;
    });
  }

  void _validateUser() {
    setState(() {
      _isUserEmpty = _userController.text.trim().isEmpty;
    });
  }

  void _validateConfirmPassword() {
    setState(() {
      _isConfirmPasswordEmpty = _confirmPasswordController.text.trim().isEmpty;
      _isPasswordMismatch = _passwordController.text.trim() != _confirmPasswordController.text.trim();
    });
  }

  void _checkFields() {
    setState(() {
      _isEmailEmpty = _emailController.text.trim().isEmpty;
      _isPasswordEmpty = _passwordController.text.trim().isEmpty;
      _isUserEmpty = _userController.text.trim().isEmpty;
      _isConfirmPasswordEmpty = _confirmPasswordController.text.trim().isEmpty;
      _isPasswordMismatch = _passwordController.text.trim() != _confirmPasswordController.text.trim();
    });
  }

  void _showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _register() async {
    _checkFields();
    if (_isEmailEmpty || _isPasswordEmpty || _isUserEmpty || _isConfirmPasswordEmpty || _isPasswordMismatch) {
      _showErrorMessage('Isi semua dengan benar');
    } else {
      if (_isPasswordValid) {
        final result = await api.register(
          email: _emailController.text,
          name: _userController.text,
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        );
        print("Register response: $result"); // Log the result for debugging
        if (result.containsKey('message') &&
            result['message'].toString().toLowerCase().contains('success')) {
          _showSuccessMessage(result['message']);
          _showRegistrationDialog();
        } else {
          print(result); // Log the entire result for debugging
          _showErrorMessage(result['message'] ?? 'Registrasi gagal');
        }
      } else {
        _showErrorMessage('Isi kembali dengan benar');
      }
    }
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registrasi Berhasil'),
          content: const Text('Akun anda telah berhasil dibuat'),
          actions: <Widget>[
            TextButton(
              child: const Text('Lanjutkan'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 40),
              _buildLogo(),
              const SizedBox(height: 24),
              _buildLoginText(),
              const SizedBox(height: 32),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildUserField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildConfirmPasswordField(),
              const SizedBox(height: 24),
              _buildRegisterButton(),
              const SizedBox(height: 24),
              _buildSignUpText(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 90,
      child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
    );
  }

  Widget _buildLoginText() {
    return const Column(
      children: [
        Text(
          'Register',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Buat akun anda sekarang',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        SizedBox(height: 6),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _emailController,
          onChanged: (value) {
            _validateEmail();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            hintText: 'Masukan Email',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: _isEmailEmpty
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blue),
            ),
          ),
        ),
        if (_isEmailEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Email Tidak Boleh Kosong',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildUserField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _userController,
          onChanged: (value) {
            _validateUser();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            hintText: 'Masukan Username',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: _isUserEmpty
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blue),
            ),
          ),
        ),
        if (_isUserEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Username Tidak Boleh Kosong',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _passwordController,
          onChanged: (value) {
            _validatePassword();
            _validateConfirmPassword(); // Validate confirm password when changing password
          },
          obscureText: _obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            hintText: 'Masukan Password',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: _isPasswordEmpty
                  ? const BorderSide(color: Colors.red)
                  : _isPasswordValid
                      ? const BorderSide(color: Colors.blue)
                      : const BorderSide(color: Colors.red),
            ),
          ),
        ),
        if (_isPasswordEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Password Tidak Boleh Kosong',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        if (!_isPasswordValid && !_isPasswordEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Password harus minimal 8 karakter, mengandung huruf besar dan angka',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _confirmPasswordController,
          onChanged: (value) {
            _validateConfirmPassword();
          },
          obscureText: _obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            hintText: 'Konfirmasi Password',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: _isConfirmPasswordEmpty || _isPasswordMismatch
                  ? const BorderSide(color: Colors.red)
                  : const BorderSide(color: Colors.blue),
            ),
          ),
        ),
        if (_isConfirmPasswordEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Konfirmasi Password Tidak Boleh Kosong',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        if (_isPasswordMismatch && !_isConfirmPasswordEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Password Tidak Cocok',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _register,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('Daftar', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Sudah punya akun? "),
        GestureDetector(
          onTap: () {
            // Navigate to login page
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
