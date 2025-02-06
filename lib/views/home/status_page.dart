import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with 'Status' title
      appBar: AppBar(
        title: const Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF075E54), // WhatsApp green
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Add functionality for more options (e.g., settings)
            },
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
          ),
        ],
      ),

      // Body with list of statuses
      body: Column(
        children: [
          // My Status Section (WhatsApp style)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              onTap: () {
                // Navigate to 'My Status' screen to add/update status
              },
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.add_a_photo, color: Colors.white),
              ),
              title: const Text('My Status', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Tap to update your status'),
            ),
          ),

          const Divider(height: 1),

          // List of other users' statuses
          Expanded(
            child: ListView.separated(
              itemCount: 10, // Example for 10 users
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'), // User profile picture
                  ),
                  title: const Text(
                    'User Name', // Replace with actual user name
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Today, 10:30 AM', // Replace with actual status time
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    // Navigate to view status in full screen
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ),
        ],
      ),

      // Floating Action Button (FAB) to add a new status
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to screen for adding a new status
        },
        backgroundColor: const Color(0xFF075E54), // WhatsApp green
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
