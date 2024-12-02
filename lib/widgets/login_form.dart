import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _sendingForm = false, _passwordVisible = false, _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 12);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.isEmail) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          spacer,
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              suffix: InkWell(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _passwordVisible
                      ? Icons.visibility_off_rounded
                      : Icons.remove_red_eye_rounded,
                ),
              ),
            ),
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: _setRememberMe,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
              ),
              const Text("Remember me"),
            ],
          ),
          spacer,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _sendingForm ? () {} : _submitForm,
                  child: _sendingForm
                      ? LoadingAnimationWidget.beat(
                          color: Get.theme.colorScheme.onPrimary,
                          size: 24,
                        )
                      : const Text('Sign in'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _setRememberMe(bool? value) {
    setState(() {
      _rememberMe = value!;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _sendingForm = true;
      });
      String? result = await widget.onSubmit(
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _sendingForm = false;
      });
      if (result != null) {
        Get.showSnackbar(GetSnackBar(
          message: result,
          duration: const Duration(seconds: 3),
          backgroundColor: Get.theme.colorScheme.error,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        ));
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
