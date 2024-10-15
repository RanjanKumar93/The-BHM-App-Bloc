import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bhm_app_bloc/models/prev_payment.dart';
import 'package:the_bhm_app_bloc/state/prevpayment/prevpayment_bloc.dart';

class PrevPaymentScreen extends StatelessWidget {
  const PrevPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                GoRouter.of(context).pop();
              },
              tooltip: 'Back',
            ),
            const Text(
              'Payments',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<PrevPaymentBloc, PrevPaymentState>(
            builder: (context, state) {
              if (state is PrevPaymentStateInitial ||
                  state is PrevPaymentStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PrevPaymentStateLoaded) {
                final List<PrevPaymentModel> prevPaymentData =
                    state.prevPayments;
                if (prevPaymentData.isEmpty) {
                  return const Center(child: Text("No payments found."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: prevPaymentData.length,
                  itemBuilder: (context, index) {
                    final payment = prevPaymentData[index];
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(66.0, 6.0, 6.0, 6.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        payment.title ?? "--",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        payment.description ?? "--",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        payment.amount ?? "--",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        payment.date ?? "--",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 28,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.bolt,
                              color: Colors.amber,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(child: Text("Failed to load payments."));
              }
            },
          ),
        ),
      ],
    );
  }
}
