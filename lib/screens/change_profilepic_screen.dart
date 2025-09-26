import 'package:flutter/material.dart';

class ChangeProfilePic extends StatelessWidget {
  const ChangeProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // Apply rounded corners only to the top, typical for a bottom sheet
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keep content height minimal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Change your picture",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          
          // Action 1: Take a photo
          _buildActionItem(
            context,
            icon: Icons.photo_camera_outlined,
            text: "Take a photo",
            textColor: Colors.black,
            onTap: () {
              // TODO: Implement logic to open the camera
              Navigator.pop(context); 
            },
          ),
          
          // Action 2: Choose from your file
          _buildActionItem(
            context,
            icon: Icons.folder_open_outlined,
            text: "Choose from your file",
            textColor: Colors.black,
            onTap: () {
              // TODO: Implement logic to open file picker/gallery
              Navigator.pop(context); 
            },
          ),

          // Action 3: Delete Photo (Styled in red)
          _buildActionItem(
            context,
            icon: Icons.delete_outline,
            text: "Delete Photo",
            textColor: Colors.red,
            onTap: () {
              // TODO: Implement logic to delete the current photo
              Navigator.pop(context); 
            },
          ),
        ],
      ),
    );
  }

  // Helper method to create the styled buttons
  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.grey.shade50, // Light background for button
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 24),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500,
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

// Helper function to show the modal as a bottom sheet
void showChangeProfilePicModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow for custom height control
    backgroundColor: Colors.transparent, // Use transparent background to show custom Container shape
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const ChangeProfilePic();
    },
  );
}