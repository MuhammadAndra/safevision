import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    this.hintText = '',
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isObscured = true; // Untuk menyembunyikan atau menampilkan password

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured, // Mengatur apakah password tersembunyi atau tidak
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
         enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 1.0), // Warna border saat tidak fokus
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 3.0), // Warna border saat fokus
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Jika password tersembunyi, tampilkan ikon mata dengan garis
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Color(0XFF4D6D7A),
          ),
          onPressed: () {
            // Mengubah state untuk mengatur apakah password terlihat atau tersembunyi
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}