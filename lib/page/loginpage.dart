import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/page/homepage.dart';
import 'package:test_flutter/page/registrationpage.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final storage = new FlutterSecureStorage();




  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse('http://localhost:8080/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.text, 'password': password.text}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];

      // Decode JWT to get 'sub' and 'role'
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String sub = payload['sub'];
      String role = payload['role'];

      // Store token, sub, and role securely
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'sub', value: sub);
      await storage.write(key: 'role', value: role);

      print('Login successful. Sub: $sub, Role: $role');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

    } else {
      print('Login failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password)),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  loginUser(context);


                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily:GoogleFonts.lato().fontFamily
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                )
            ),
            SizedBox(height: 20),

            // Login Text Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text(
                'Registration',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
