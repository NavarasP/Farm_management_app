import 'package:flutter/material.dart';

class GlassInputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;

  const GlassInputField({super.key, required this.hintText, this.isPassword = false, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xffebeaea).withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

class UserTypeButton extends StatefulWidget {
  final String userType;

  const UserTypeButton({super.key, required this.userType, required bool isSelected, required void Function(String role) onSelect});

  @override
  // ignore: library_private_types_in_public_api
  _UserTypeButtonState createState() => _UserTypeButtonState();
}

class _UserTypeButtonState extends State<UserTypeButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(isSelected ? Colors.blue : Colors.grey),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          widget.userType,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
