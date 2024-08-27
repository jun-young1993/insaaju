import 'package:flutter/material.dart';

class NameScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  if (name.isNotEmpty) {
                    // 이름이 입력되었을 경우 다음 화면으로 이동
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NextScreen(name: name)),
                    // );
                  } else {
                    // 이름이 입력되지 않은 경우 경고 메시지
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Input Required'),
                          content: Text('Please enter your name before proceeding.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}