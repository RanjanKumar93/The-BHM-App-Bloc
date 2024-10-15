import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/qr.dart';
import 'package:the_bhm_app_bloc/state/qr/qr_bloc.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'QR CODE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<QRBloc, QRState>(
          builder: (context, state) {
            if (state is QRStateInitial || state is QRStateLoading) {
              return const Center(
                heightFactor: 10,
                child: CircularProgressIndicator(),
              );
            } else if (state is QRStateLoaded) {
              final QRModel qrData = state.qrData;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<QRBloc>().add(QREventFetch());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // QR Code Image
                        qrData.imgUrl.isNotEmpty
                            ? Image.network(
                                qrData.imgUrl,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 300),
                              )
                            : const Icon(Icons.image, size: 300),
                        const SizedBox(height: 16),

                        // Name Text
                        Text(
                          qrData.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Hostel Text
                        Text(
                          qrData.hostel,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Time/Date Text
                        Text(
                          _formatDateTime(qrData.time),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is QRStateError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<QRBloc>().add(QREventFetch());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            // Fallback for unexpected states
            return const Center(child: Text("Unexpected error occurred."));
          },
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Format the DateTime as per your requirements
    // Example: "Oct 14, 2024 at 3:45 PM"
    return "${_monthName(dateTime.month)} ${dateTime.day}, ${dateTime.year} at ${_formatTime(dateTime)}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }
}
