import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/contants/api.dart';
import '../../../core/widgets/image_picker.dart';

class ServiceClass{
  File? categoryImage;

  Future pickClientImage(String title) async {
    try {
      categoryImage = await PickImage().pickImage();
      if (categoryImage != null) {
        print('image path ${categoryImage!.path}');
        await submitSubscription(categoryImage!,'hassan');
      }
    } catch (error) {
      print(error.toString());
    }
  }
  Future<int> submitSubscription(File file,String name)async{

    var request = http.MultipartRequest(
      'POST',  Uri.parse('http://192.168.1.122:8000/dashboard/category'),

    );
    Map<String,String> headers={
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZjA1OWJlMzA0MGU3ZDc4YmRlOTE3NSIsImlhdCI6MTY5Mzc1ODE0NiwiZXhwIjoxNjkzODQ0NTQ2fQ.Hp96Ic6DbBPtZYjFBdPJUZ-JjRAIvg0EtPbZl8qvVAU",
      "Content-type": "multipart/form-data"
    };


    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: 'image.jpg',
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name":name,
    });
    print("request: "+request.toString());
    var res = await request.send();

    if(res.statusCode==200){
      print('done');
    }
else{
  print('errrrrrrrrrrrrro');
    }
    print("This is response:"+res.toString());
    return res.statusCode;
  }
}