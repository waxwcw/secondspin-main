import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import 'dart:io';

import 'package:SecondSpin/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
  }

  Future _submitForm(File image) async {
    final imageExtension = image.path.split('.').last.toLowerCase();
    final imageBytes = await image.readAsBytes();
    final userId = supabase.auth.currentUser!.id;
    final imagePath = '/$userId/${_nameController.text}.$imageExtension';
    await supabase.storage.from('profiles').uploadBinary(
          imagePath,
          imageBytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$imageExtension',
          ),
        );
    String imageUrl = supabase.storage.from('profiles').getPublicUrl(imagePath);

    await supabase.from('product').insert({
      'profile_id': supabase.auth.currentUser!.id,
      'title': _nameController.text,
      'price': double.parse(_priceController.text),
      'description': _descriptionController.text,
      'category': _categoryController.text,
      'image_url': imageUrl,
    });
    print('商品名称: ${_nameController.text}');
    print('商品价格: ${_priceController.text}');
    print('商品描述: ${_descriptionController.text}');
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product name',
                  labelStyle: TextStyle(color: Colors.black), // 标签样式
                  hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0), // 内容内边距
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Product price',
                  labelStyle: TextStyle(color: Colors.black), // 标签样式
                  hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0), // 内容内边距
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price of the product';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Product category',
                  labelStyle: TextStyle(color: Colors.black), // 标签样式
                  hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0), // 内容内边距
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Product name',
                  labelStyle: TextStyle(color: Colors.black), // 标签样式
                  hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                    borderRadius: BorderRadius.circular(10.0), // 边框圆角
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0), // 内容内边距
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              if (_image != null) ...[
                Stack(
                  children: [
                    Image.file(_image!),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: _removeImage,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
              // ProductImage(
              //   imageUrl: _imageUrl,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kprimaryColor),
                onPressed: _getImage,
                child: Text(
                  'Select image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kprimaryColor),
                onPressed: () async {
                  await _submitForm(_image!);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
