import 'package:http/http.dart' as http;

class WalletInformationRepository {
  Future<String> getBalance(String address, String chain) async {
    final url = Uri.http('someEndpoint', '/get_token_balance', {
      'address': address,
      'chain': chain,
    });
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      return 'Unknown Balance';
    } catch (e) {
      throw Exception('Error getting Balance! $e');
    }
  }
}
