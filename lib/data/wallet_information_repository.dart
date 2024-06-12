import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moralis_web3_flutter/data/model/nft.dart';
import 'package:web3dart/web3dart.dart';

abstract class MoralisWalletRepository {
  Future<double> getBalanceByToken(String address, String chain);
  Future<List<NFT>> getNFTsList(String address, String chain);
}

class WalletRepository implements MoralisWalletRepository {
  @override
  Future<double> getBalanceByToken(String address, String chain) async {
    final queryParams = {
      'address': address,
      'chain': chain,
    };
    final url = Uri.http('localhost:5050', '/get_token_balance', queryParams);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return data['balance'] ?? 0.0;
      }
      return 0.0000;
    } catch (e) {
      throw Exception('Error getting Balance! $e');
    }
  }

  String convertBalanceToEthereum(double balance) {
    final ethBalance =
        EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(balance.toString()));
    return ethBalance.getValueInUnit(EtherUnit.ether).toString();
  }

  @override
  Future<List<NFT>> getNFTsList(String address, String chain) async {
    final response = await http.get(
        Uri.parse(
            'http://localhost:5050/get_user_nfts?address=$address&chain=$chain'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      final nftsList = jsonData
          .map((json) => NFT.fromJson(json as Map<String, dynamic>))
          .toList();
      return nftsList;
    } else {
      throw Exception('Failed to load NFT list');
    }
  }
}
