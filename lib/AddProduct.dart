import 'package:boutique/Dashboard.dart';
import 'package:boutique/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  File? _selectedImage;

  _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  _addProduct() async {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty ||
        priceController.text.isEmpty || categoryIdController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('All fields are required.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

   // var uri = Uri.parse('http://10.0.2.2/flutter and laravel project/example-app/api/addproduct');
     var uri = Uri.parse('https://pageofcode99.000webhostapp.com/api/addproduct');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = nameController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['price'] = priceController.text;
    request.fields['category_id'] = categoryIdController.text;

    if (_selectedImage != null) {
      var imageFile = await http.MultipartFile.fromPath('image', _selectedImage!.path);
      request.files.add(imageFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      // Product added successfully, navigate back to the DashboardPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      // Show an error dialog if something went wrong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('We apologize for the inconvenience, but  '
              ' this page is not functioning properly. '
              'We kindly request you to utilize our website to add'
              ' products .'
              'https://pageofcode99.000webhostapp.com/admin/login'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                ),
                maxLines: 4,
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  height: 100,
                  width: 100,
                ),
              TextFormField(
                controller: categoryIdController,
                decoration: const InputDecoration(
                  labelText: 'Category ID',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  _addProduct();
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
