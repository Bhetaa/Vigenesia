import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login.dart';
import 'vigenesia_theme.dart';
import 'package:vigenesia/Models/UserModel.dart';

class Register extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController profesiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Register({Key? key}) : super(key: key);

  void register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Get data from controllers
      String name = nameController.text.trim();
      String profesi = profesiController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Create User instance
      User newUser = User(
        name: name,
        profession: profesi,
        email: email,
        password: password,
      );

      bool success = await AuthService().registerUser(newUser);

      // Show snackbar based on registration result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(success
                ? 'Registrasi berhasil!'
                : 'Registrasi gagal! Coba lagi.')),
      );

      // If registration is successful, navigate to the login page
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Login()), // Ensure Login widget is defined
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VigenesiaTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Vigenesia - Register'),
        backgroundColor: VigenesiaTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to Vigenesia!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: VigenesiaTheme.primaryColor),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Create Your Account',
                  style: TextStyle(
                      fontSize: 20, color: VigenesiaTheme.accentColor),
                ),
              ),
              const SizedBox(height: 30),

              // Name Field
              _buildTextField(nameController, "Nama", false, (value) {
                if (value == null || value.isEmpty) {
                  return 'Silakan masukkan nama Anda';
                }
                return null;
              }),
              const SizedBox(height: 20),

              // Profession Field
              _buildTextField(profesiController, "Profesi", false, (value) {
                if (value == null || value.isEmpty) {
                  return 'Silakan masukkan profesi Anda';
                }
                return null;
              }),
              const SizedBox(height: 20),

              // Email Field
              _buildTextField(emailController, "Email", false, (value) {
                if (value == null || value.isEmpty) {
                  return 'Silakan masukkan email Anda';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Masukkan email yang valid';
                }
                return null;
              }),
              const SizedBox(height: 20),

              // Password Field
              _buildTextField(passwordController, "Password", true, (value) {
                if (value == null || value.isEmpty) {
                  return 'Silakan masukkan password Anda';
                }
                if (value.length < 6) {
                  return 'Password harus lebih dari 6 karakter';
                }
                return null;
              }),
              const SizedBox(height: 30),

              // Register Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: VigenesiaTheme.buttonColor,
                  ),
                  onPressed: () => register(context),
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      bool obscureText, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: VigenesiaTheme.primaryColor),
      ),
      validator: validator,
    );
  }
}
