import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:SecondSpin/utils/color_constants.dart';
import '/models/product.dart';

class CheckOutPage extends StatelessWidget {
  final Product product;

  CheckOutPage({required this.product});

  final TextEditingController countryController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _submitDeclaration(BuildContext context) async {
    String country = countryController.text;
    String unit = unitController.text;
    String info = infoController.text;
    String address = addressController.text;
    String phone = phoneController.text;

    Map<String, dynamic> declarationData = {
      "app_key": "mh_cb78572913a4ae31",
      "timestamp": "${DateTime.now().millisecondsSinceEpoch ~/ 1000}",
      "v": 1.0,
      "sign_method": "MD5",
      "sign": "123456",
      "data": {
        "service_info": {
          "o_business_no": "",
          "type": 1,
          "o_business_type": "9610",
          "o_business_name": "2024062802批次零售出口",
          "o_ebc_name": "广州市顶真科技有限公司",
          "o_trading_mall_link": "https://cbec-mall.gzport.net/",
          "o_ebp_name": "CHEEHON CO.,LTD",
          "o_platform_buyer": "CHEEHON CO.,LTD",
          "o_supply_name": "东莞顶真服装厂",
          "o_declare_name": "广州顶真电子商务有限公司",
          "o_logistics_name": "广州顶真运输有限公司",
          "o_transport_name": "深圳市顶真运输有限公司",
          "o_transport_abroad_name": "深圳顶真国际货运代理有限公司",
          "o_pay_name": "招商银行股份有限公司"
        },
        "service_base_info": {
          "o_export_contract": "ECK202405280002",
          "o_deal_curr": "人民币",
          "o_price_term": "FOB",
          "o_freight_fee": "0",
          "o_insurance_fee": "0",
          "o_settle_date": "2024-06-31",
          "o_ebc_name": "广州没啥用科技有限公司",
          "o_ebc_ename": "HUIHUANG",
          "o_ebc_contact": "HUIHUANG Zhang",
          "o_ebc_contact_tell": "+86-13267725312",
          "o_ebc_address": "广州市海珠区",
          "o_ebc_eaddress": "21 Luntou Road, Haizhu District, Guangzhou City",
          "o_plat_name": "CHEEHON CO.,LTD",
          "o_plat_ename": "CHEEHON CO.,LTD",
          "o_plat_contact": "SUSAN",
          "o_plat_contact_tell": "001-202-495-2266",
          "o_plat_address": "",
          "o_plat_eaddress":
              "3505 International Place,N.W. Washington,D.C.20008 U.S.A.",
          "o_special": "0",
          "o_ship_date": "2024-05-27",
          "o_pack_way": "4",
          "o_ship_way": "4",
          "o_ship_port": "广州",
          "o_country": "美国",
          "o_country_port": "华盛顿",
          "o_export_note": ""
        },
        "order_info": [
          {
            "o_order_no": "20240528000002",
            "o_pay_no": "P20240528000002",
            "o_waybill_no": "SF20240528000002",
            "o_charge": "100",
            "o_goods_value": "100",
            "o_currency": "502",
            "o_accounting_date": "20240528121312",
            "o_traf_mode": 5,
            "o_country": "502",
            "o_order_note": "",
            "order_goods_info": [
              {
                "o_classification": "衣服",
                "o_goods_ename": product.title,
                "o_goods_cname": product.title,
                "o_goods_sku": "SP00001",
                "o_goods_num": "1",
                "o_goods_price": product.price,
                "o_goods_total": 100,
                "o_goods_link": "http:// xxxx.com/....",
                "o_goods_enterprice": "广州市顶真科技有限公司",
                "o_goods_ingrediant": "棉100%",
                "o_goods_note": ""
              }
            ]
          }
        ]
      }
    };

    declarationData['data']['service_info']['o_country'] = country;
    declarationData['data']['service_base_info']['o_unit'] = unit;
    declarationData['data']['service_base_info']['o_info'] = info;
    declarationData['data']['service_base_info']['o_address'] = address;
    declarationData['data']['service_base_info']['o_phone'] = phone;

    // try {
    //   Map<String, dynamic> response =
    //       await ApiService().applyService(declarationData);

    //   print('Service application successful: $response');

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Service application successful!'),
    //       duration: Duration(seconds: 2),
    //     ),
    //   );
    // } catch (e) {
    //   print('Service application failed: $e');

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Service application failed, please try again!'),
    //       duration: Duration(seconds: 2),
    //     ),
    //   );
    // }
    try {
      Map<String, dynamic> response =
          await ApiService().applyService(declarationData);

      print('Service application successful: $response');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service application successful!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Service application failed: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service application failed, please try again!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    // 提示用户申报成功
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Declaration Successful'),
          content: Text('Customs declaration submitted successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name: ${product.title}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Image.network(
              product.image,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Product Price: \$${product.price}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: countryController,
              decoration: InputDecoration(
                labelText: 'Shipping Country/Region',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: unitController,
              decoration: InputDecoration(
                labelText: 'Declaration Unit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: infoController,
              decoration: InputDecoration(
                labelText: 'Declaration Information',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Shipping Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Contact Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kprimaryColor),
                onPressed: () {
                  _submitDeclaration(context);
                },
                child: const Text(
                  'Submit Declaration',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ApiService {
//   static const String baseUrl = 'https://cbec-studapi.gzport.net';

//   Future<Map<String, dynamic>> applyService(Map<String, dynamic> data) async {
//     final String apiUrl = '$baseUrl/api/access_service/apply_service';

//     try {
//       final http.Response response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonResponse = json.decode(response.body);
//         return jsonResponse;
//       } else {
//         throw Exception('Failed to apply service: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to apply service: $e');
//     }
//   }
// }
class ApiService {
  static const String baseUrl = 'https://cbec-studapi.gzport.net';
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> applyService(Map<String, dynamic> data) async {
    final String apiUrl = '$baseUrl/api/access_service/apply_service';

    try {
      final Response response = await _dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        return jsonResponse;
      } else {
        throw Exception('Failed to apply service: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to apply service: $e');
    }
  }
}
