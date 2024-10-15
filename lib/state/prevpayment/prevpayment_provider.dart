import 'package:the_bhm_app_bloc/models/prev_payment.dart';

class PrevpaymentProvider {
  Future<List<PrevPaymentModel>> getPrevPayments() async {
    try {
      List<Map<String, dynamic>> jsonData = [
        {
          'title': 'Extra Mess',
          'description': 'LUNCH',
          'amount': '28.10',
          'date': '12/12/21',
        },
        {
          'title': 'Extra Mess',
          'description': 'SNACK',
          'amount': '28.10',
          'date': '13/10/21',
        },
        {
          'title': 'Extra Mess',
          'description': 'LUNCH',
          'amount': '18.00',
          'date': '09/08/21',
        },
        {
          'title': 'Extra Mess',
          'description': 'SNACK',
          'amount': '20.00',
          'date': '07/07/21',
        },
        {
          'title': 'Extra Mess',
          'description': 'LUNCH',
          'amount': '28.10',
          'date': '12/12/21',
        },
        {
          'title': 'Extra Mess',
          'description': 'LUNCH',
          'amount': '28.10',
          'date': '13/10/21',
        },
      ];

      List<PrevPaymentModel> transactions =
          jsonData.map((json) => PrevPaymentModel.fromJson(json)).toList();
      return transactions;
    } catch (e) {
      throw Exception(e);
    }
  }
}
