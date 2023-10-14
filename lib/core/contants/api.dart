import 'package:selivery_controlle_panal/main.dart';

const baseUri = 'http://192.168.1.122:8000/';
const authBaseUri = 'http://192.168.1.122:8000/auth/';
String token = sharedPreferences.getString('token') ?? '';
final allCategory =
    Uri.parse('${baseUri}dashboard/category'); // Replace with your API URL
final topPassengers = Uri.parse("${baseUri}dashboard/trip/top_passengers");
final topVehicles = Uri.parse("${baseUri}dashboard/trip/top_vehicles");
final topDrivers = Uri.parse("${baseUri}dashboard/driver");
final uploadCategoryUri = Uri.parse('${baseUri}dashboard/category');
final addAdsUri = Uri.parse('${baseUri}dashboard/advertisement');
final getAllAdsUri = Uri.parse('${baseUri}dashboard/advertisement');


Uri deleteCategoryUri(String? id) =>
    Uri.parse('${baseUri}dashboard/category/$id');
Uri updateCategoryUri(String? id) =>
    Uri.parse('${baseUri}dashboard/category/$id');

final authHeaders = {
  'Keep-Alive': 'timeout=5',
  'Connection': 'keep-alive',
  'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
  'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
  'Content-Type': 'application/json; charset=utf-8',
  'X-Powered-By': 'Express',
  'Access-Control-Allow-Origin': '*',
};
authHeadersWithToken(String token) => {
      'Keep-Alive': 'timeout=5',
      'Connection': 'keep-alive',
      'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
      'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
      'Content-Type': 'application/json; charset=utf-8',
      'X-Powered-By': 'Express',
      'Access-Control-Allow-Origin': '*',
      'AUTHORIZATION': 'Bearer $token',
    };
