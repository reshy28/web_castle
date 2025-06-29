import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_castle/homescreen/model/home_datas_model.dart';
import 'dart:convert';

import 'package:web_castle/services/app_urls.dart';

class HomescreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initHome();
  }

  Future<void> initHome() async {
    await login();
    await fetchHomeDatas();
  }

  final token = ''.obs;
  final isLoading = false.obs;

  final RxList<HomeField> homeFields = <HomeField>[].obs;

  Future<void> fetchHomeDatas() async {
    try {
      isLoading(true);
      final url = Uri.parse(ApiUrl.homeData);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token.value}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final homeData = HomeDatasModel.fromJson(data);
        homeFields.value = homeData.data?.homeFields ?? [];
        print(homeFields.first.carouselItems?.first.id);
      } else {
        throw Exception('Failed to load home data');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> login() async {
    final url = Uri.parse(
      '${ApiUrl.login}?device_token=test_token&device_type=1',
    );

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final accessToken = data['data']?['access_token'];

        if (accessToken != null) {
          token.value = accessToken;
          print("Token value: $accessToken");
        } else {
          throw Exception("Access token not found in response");
        }
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print("Login Error: $e");
      rethrow;
    }
  }
}
