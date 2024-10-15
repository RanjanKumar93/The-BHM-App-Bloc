import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_bhm_app_bloc/state/complaint/complaint_bloc.dart';

const categories = {
  Categories.c1: Category('c1'),
  Categories.c2: Category('c2'),
  Categories.c3: Category('c3'),
  Categories.other: Category('Other'),
};

class ComplainScreen extends StatelessWidget {
  const ComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain here'),
        actions: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go("/complain/status");
            },
            child: const Text('Complain Status'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
        child: BlocListener<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state.submissionStatus == SubmissionStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Complaint submitted successfully')),
              );
            } else if (state.submissionStatus == SubmissionStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      state.errorMessage ?? 'Submission failed',
                      style: const TextStyle(color: Colors.red),
                    )),
              );
            }
          },
          child: BlocBuilder<ComplaintBloc, ComplaintState>(
            builder: (context, state) {
              final complaintBloc = BlocProvider.of<ComplaintBloc>(context);

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _showTitleInputDialog(context, complaintBloc),
                          child: _buildField(
                              'Title',
                              state.title.isEmpty
                                  ? 'Title of Complaint'
                                  : state.title,
                              false),
                        ),
                        GestureDetector(
                          onTap: () => _showDescriptionInputDialog(
                              context, complaintBloc),
                          child: _buildField(
                              'Description',
                              state.description.isEmpty
                                  ? 'Enter Description of Complaint'
                                  : state.description,
                              false),
                        ),
                        GestureDetector(
                          onTap: () => _showCategorySelectionDialog(
                              context, complaintBloc),
                          child: _buildField('Category',
                              categories[state.category]!.title, false),
                        ),
                        GestureDetector(
                          onTap: () => _pickImage(context, complaintBloc),
                          child: _buildField(
                              'Additional Information', 'Attach Image', true),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Anonymity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: state.isAnonymous,
                              onChanged: (value) => complaintBloc
                                  .add(ComplaintEventUpdateAnonymity(value)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  state.submissionStatus != SubmissionStatus.loading
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          onPressed: () => complaintBloc
                              .add(ComplaintEventSubmitComplaint()),
                          child: const Text('Submit Your Complaint'),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField(String title, String value, bool isAttachImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        isAttachImage
            ? const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 40.0,
              )
            : Row(
                children: [
                  Container(
                    width: 200,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
      ],
    );
  }

  void _showTitleInputDialog(
      BuildContext context, ComplaintBloc complaintBloc) {
    // String input = '';
    String input = complaintBloc.state.title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Title'),
          content: TextField(
            controller:
                TextEditingController(text: input.isEmpty ? null : input),
            onChanged: (value) => input = value,
            decoration: const InputDecoration(hintText: 'Enter Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                complaintBloc.add(ComplaintEventUpdateTitle(input));
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDescriptionInputDialog(
      BuildContext context, ComplaintBloc complaintBloc) {
    // String input = '';
    String input = complaintBloc.state.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Description'),
          content: TextField(
            controller:
                TextEditingController(text: input.isEmpty ? null : input),
            onChanged: (value) => input = value,
            decoration: const InputDecoration(hintText: 'Enter Description'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                complaintBloc.add(ComplaintEventUpdateDescription(input));
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCategorySelectionDialog(
      BuildContext context, ComplaintBloc complaintBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Category'),
          children: Categories.values.map((category) {
            return SimpleDialogOption(
              onPressed: () {
                complaintBloc.add(ComplaintEventUpdateCategory(category));
                Navigator.pop(context);
              },
              child: Text(categories[category]!.title),
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _pickImage(
      BuildContext context, ComplaintBloc complaintBloc) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      complaintBloc.add(ComplaintEventUpdateImage(File(pickedFile.path)));
    }
  }
}
