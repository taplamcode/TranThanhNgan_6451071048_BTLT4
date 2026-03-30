import 'package:flutter/material.dart';

import '../models/register_form_model.dart';
import '../utils/validators.dart';
import '../widget/app_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isSubmitEnabled {
    final fullNameError = Validators.requiredField(
      _nameController.text,
      'ho va ten',
    );
    final emailError = Validators.email(_emailController.text);
    final passwordError = Validators.password(_passwordController.text);

    return fullNameError == null &&
        emailError == null &&
        passwordError == null &&
        _agreedToTerms;
  }

  void _submit() {
    if (!_isSubmitEnabled) {
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final data = RegisterFormModel(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      agreedToTerms: _agreedToTerms,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đăng ký cho ${data.fullName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Đăng ký tài khoản")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Họ và Tên',
                hint: 'Nguyễn Văn A',
                validator: (value) =>
                    Validators.requiredField(value, 'ho va ten'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'example@domain.com',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _passwordController,
                label: 'Mật khẩu',
                hint: '******',
                obscureText: _obscurePassword,
                validator: Validators.password,
                onChanged: (_) => setState(() {}),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _agreedToTerms,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _agreedToTerms = value ?? false;
                  });
                },
                title: const Text('Tôi đồng ý với điều khoản và chính sách'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitEnabled ? _submit : null,
                  child: const Text("Đăng ký"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
