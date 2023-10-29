import '../contants/api.dart';

String checkImage(String image) {
  String newImage;
  try {
    newImage = "$baseUri$image";
  } catch (error) {
    newImage = 'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
  }
  return newImage;
}
