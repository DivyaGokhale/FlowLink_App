import 'package:flutter/material.dart';

// Import your modal file
import 'change_profilepic_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  String gender = "Male"; // default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/setting'),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cover Photo
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/cover_photo.jpg", 
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Cover Photo Edit Icon
                Positioned(
                  right: 12,
                  top: 12,
                  child: GestureDetector(
                    onTap: () {
                      showChangeProfilePicModal(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Profile Picture
                      GestureDetector(
                        // onTap functionality is typically linked to the edit icon
                        onTap: () {
                          // No action taken here, the edit icon handles the change.
                        },
                        child: const CircleAvatar(
                          radius: 40,
                          // *** CHANGED FROM NetworkImage to AssetImage ***
                          backgroundImage: AssetImage(
                            "assets/images/profile_photo.png", // Use your asset path here
                          ),
                        ),
                      ),
                      // Profile Picture Edit Icon
                      GestureDetector(
                        onTap: () {
                          showChangeProfilePicModal(context);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                          child: Icon(Icons.edit, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),

            // Form Fields (rest of the code remains the same)
            buildTextField("First Name", "Andy"),
            buildTextField("Last Name", "Lexsian"),
            buildTextField("E-mail", "Andylexian22@gmail.com"),
            buildTextField("Date of Birth", "24 February 1996",
                suffixIcon: Icons.calendar_today_outlined),

            // Gender Selection
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            Row(
              children: [
                genderButton("Male"),
                const SizedBox(width: 12),
                genderButton("Female"),
              ],
            ),

            buildTextField("Location", "New York"),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {IconData? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon:
              suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        style: const TextStyle(color: Colors.black), // Added to make text visible
      ),
    );
  }

  Widget genderButton(String value) {
    bool selected = gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            gender = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(30),
            color: selected ? Colors.green : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected)
                const Icon(Icons.check, color: Colors.white, size: 18),
              if (selected) const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}