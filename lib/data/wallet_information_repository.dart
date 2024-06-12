import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moralis_web3_flutter/data/model/nft.dart';
import 'package:web3dart/web3dart.dart';

abstract class MoralisWalletRepository {
  Future<double> getBalanceByToken(String address, String chain);
  Future<List<NFT>?> getNFTsList(String address, String chain);
  Future<String> sendTransaction(
      String privateKey, String receiver, EtherAmount txValue);
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
  Future<List<NFT>?> getNFTsList(String address, String chain) async {
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(
          Uri.parse(
              'http://localhost:5050/get_user_nfts?address=$address&chain=$chain'),
          headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        final nftsList = jsonData
            .map((json) => NFT.fromJson(json as Map<String, dynamic>))
            .toList();
        return nftsList;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load NFT list $e');
    }
  }

  @override
  Future<String> sendTransaction(
      String privateKey, String receiver, EtherAmount txValue) async {
    const apiUrl = "Your RPC Url"; // Replace with your API
    // Replace with your API
    final httpClient = http.Client();
    final ethClient = Web3Client(apiUrl, httpClient);
    try {
      EthPrivateKey credentials = EthPrivateKey.fromHex('0x$privateKey');

      EtherAmount etherAmount = await ethClient.getBalance(credentials.address);
      EtherAmount gasPrice = await ethClient.getGasPrice();

      print(etherAmount);

      final transactionId = await ethClient.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 11155111,
      );
      return transactionId;
    } catch (e) {
      throw Exception('Failed to send transaction: $e');
    }
  }
}
