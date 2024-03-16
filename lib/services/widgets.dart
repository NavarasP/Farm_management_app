import 'package:flutter/material.dart';

class GlassInputField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const GlassInputField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
  }) : super(key: key);

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
        controller: controller, // Assign the controller here
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


class RectangleCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final bool customImageSize;

  const RectangleCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    this.customImageSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, 
      height: 200,

      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: const Color(0xfff2f4f6),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: customImageSize
                      ? 100
                      : 80,
                  width: customImageSize
                      ? 100
                      : 80, 
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}