
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegisterSuccess;

  const RegisterScreen({
    super.key,
    required this.onRegisterSuccess,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final Color primaryBlue = const Color(0xFF2563EB);

  void register() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Veuillez remplir tous les champs');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      showMessage('Adresse e-mail invalide');
      return;
    }

    if (password.length < 6) {
      showMessage('Le mot de passe doit contenir au moins 6 caractères');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Les mots de passe ne correspondent pas');
      return;
    }

    widget.onRegisterSuccess();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool password = false,
    bool? obscure,
    VoidCallback? toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryBlue),
        suffixIcon: password
            ? IconButton(
                icon: Icon(
                  obscure! ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggleVisibility,
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text('Créer un compte'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Créez votre compte Transport App',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            buildField(
              label: 'Nom complet',
              icon: Icons.person_outline,
              controller: nameController,
            ),
            const SizedBox(height: 16),

            buildField(
              label: 'Adresse e-mail',
              icon: Icons.email_outlined,
              controller: emailController,
            ),
            const SizedBox(height: 16),

            buildField(
              label: 'Mot de passe',
              icon: Icons.lock_outline,
              controller: passwordController,
              password: true,
              obscure: obscurePassword,
              toggleVisibility: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
            const SizedBox(height: 16),

            buildField(
              label: 'Confirmer le mot de passe',
              icon: Icons.lock_outline,
              controller: confirmPasswordController,
              password: true,
              obscure: obscureConfirmPassword,
              toggleVisibility: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Vous avez déjà un compte ? Se connecter',
                  style: TextStyle(color: Color(0xFF2563EB)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
