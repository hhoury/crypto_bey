// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NewOrderScreen extends StatelessWidget {
  static const routeName = '/new-order';

  Widget _buildUploadedScreenshot() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: const [
              Text('Uploaded Screenshot'),
              SizedBox(
                height: 10,
              ),
              //    Image.network(imageUrl)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place a New Order'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text('Upload Screenshot'),
              const Text('Please upload a screenshot of the item that you want'),
              const ElevatedButton(
                onPressed: null,
                child: Icon(Icons.cloud_upload_outlined),
              ),
              Row(
                children: const [
                  ElevatedButton(onPressed: null, child: Text('PREVIOUS')),
                  ElevatedButton(onPressed: null, child: Text('NEXT')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
