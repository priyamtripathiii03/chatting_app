import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: const Color(0xFF075E54), // WhatsApp green colour
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert,color: Colors.white,),
            tooltip: 'More options',
          ),
        ],

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              onTap: () {},
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.add_a_photo, color: Colors.white),
              ),
              title: const Text('My Status',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Tap to update your status'),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  title: const Text(
                    'User Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Today, 10:30 AM',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF075E54),
        child: const Icon(Icons.camera_alt,color: Colors.white,),
      ),
    );
  }
}
