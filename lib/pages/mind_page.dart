import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:SecondSpin/pages/welcome_page.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import 'package:SecondSpin/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // late File _selectedImage;
  // late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    // _loadPrefs();
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    Navigator.of(context).push(WelcomeView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              children: [
                // future: _loadPrefs(),

                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Choose an avatar'),
                          actions: [
                            TextButton(
                              child: Text('Choose from album'),
                              onPressed: () async {},
                            ),
                            TextButton(
                              child: Text('Take a photo'),
                              onPressed: () {},
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                ),

                SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'User ID: 123456',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Row(
              children: [
                Icon(Icons.person_outline, color: Colors.black),
                SizedBox(width: 16),
                Text('Personal Information',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Row(
              children: [
                Icon(Ionicons.heart_outline, color: Colors.black),
                SizedBox(width: 16),
                Text('My Favor', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Row(
              children: [
                Icon(Icons.history_outlined, color: Colors.black),
                SizedBox(width: 16),
                Text('Transaction record',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Row(
              children: [
                Icon(Icons.lock_outline, color: Colors.black),
                SizedBox(width: 16),
                Text('Account & Security',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: const Row(
              children: [
                Icon(Icons.language, color: Colors.black),
                SizedBox(width: 16),
                Text('Language', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => {signOut()},
            child: const Row(
              children: [
                Icon(Icons.exit_to_app_outlined, color: Colors.black),
                SizedBox(width: 16),
                Text('Log out', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
