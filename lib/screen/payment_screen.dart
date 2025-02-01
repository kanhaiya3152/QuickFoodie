import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/screen/wallet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final TextEditingController _amountController = TextEditingController();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> openCheckout(int amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_jfRGEmmQAOFqac',
      'amount': amount,
      'name': 'Food Delivery App',
      'prefill': {'contact': '2342342427', 'email': 'venom00240@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  // Future<void> updateWalletBalance(String userId, int amount) async {
  //   final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

  //   try {
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       final snapshot = await transaction.get(userDoc);

  //       if (!snapshot.exists) {
  //         throw Exception("User does not exist!");
  //       }

  //       final currentBalance = snapshot.data()!['walletBalance'];
  //       final newBalance = currentBalance + amount;
  //       transaction.update(userDoc, {'walletBalance': newBalance});
  //     });
  //   } catch (error) {
  //     debugPrint("Failed to update wallet balance: $error");
  //     throw Exception("Failed to update wallet balance: $error");
  //   }
  // }

  Future<void> updateWalletBalance(String userId, int amount) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);

      // ✅ Debugging: Check if the document exists
      if (!snapshot.exists) {
        debugPrint("❌ User document does not exist: $userId");
        throw Exception("User does not exist!");
      } else {
        debugPrint("✅ User document found: ${snapshot.data()}");
      }

      final currentBalance = snapshot.data()?['walletBalance'] ?? 0;
      final newBalance = currentBalance + amount;

      debugPrint("💰 Updating wallet balance: Old=$currentBalance, New=$newBalance");

      transaction.update(userDoc, {'walletBalance': newBalance});
    });

    debugPrint("✅ Wallet balance updated successfully");
  } catch (error) {
    debugPrint("❌ Failed to update wallet balance: $error");
  }
}


  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "Payment Successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    // int amount = int.parse(_amountController.text);
    int? amount = int.tryParse(_amountController.text);
      if (amount == null || amount <= 0) {
        Fluttertoast.showToast(msg: "Please enter a valid amount");
        return;
      }

    try {
      await updateWalletBalance(userId, amount);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => Wallet()));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to update wallet balance: $e",
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Payments",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            const Text(
              'Welcome to Razorpay Payment',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: _amountController,
                cursorColor: Colors.white,
                autofocus: false,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Enter amount to be paid',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter amount to be paid";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.toString().isNotEmpty) {
                  int amount = int.parse(_amountController.text.toString());
                  openCheckout(amount);
                }
              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Make Payment",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  )),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}