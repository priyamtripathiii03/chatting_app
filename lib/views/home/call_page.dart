import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calls',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: const Color(0xFF075E54), // WhatsApp green
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
          ),
        ],

      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  title: const Text(
                    'User Name', // user name
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.call_made,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '12:30 PM',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: const Text(
                    '1:23',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {

                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ),
        ],
      ),

      // Floating Action Button to make a new call
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: const Color(0xFF075E54), // WhatsApp green
        child: const Icon(Icons.call,color: Colors.white,),
      ),
    );
  }
}
