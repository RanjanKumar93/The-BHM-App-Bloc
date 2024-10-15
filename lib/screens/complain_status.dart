import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/complain_status.dart';
import 'package:the_bhm_app_bloc/state/complain_status/complain_status_bloc.dart';

class ComplainStatusScreen extends StatelessWidget {
  const ComplainStatusScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Complaint Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ComplainStatusBloc, ComplainStatusState>(
              builder: (context, state) {
                if (state is ComplainStatusStateInitial ||
                    state is ComplainStatusStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ComplainStatusStateLoaded) {
                  final complaints = state.complainStatusData;
                  if (complaints.isEmpty) {
                    return Center(
                      child: Text(
                        'No complaints found.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final ComplainStatusModel complaint = complaints[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              title: Text(
                                complaint.id,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Title: ${complaint.title}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              trailing: Text(
                                complaint.status,
                                style: TextStyle(
                                  color: _getStatusColor(complaint.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ComplainStatusStateError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red[600]),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ComplainStatusBloc>()
                                .add(ComplainStatusEventFetch());
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
