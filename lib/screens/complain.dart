import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ComplainStatusScreen()),
              // );
            },
            child: const Text('Complain Status'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    content: Text(state.errorMessage ?? 'Submission failed')),
              );
            }
          },
          child: BlocBuilder<ComplaintBloc, ComplaintState>(
            builder: (context, state) {
              final complaintBloc = BlocProvider.of<ComplaintBloc>(context);

              return Column(
                children: [
                  GestureDetector(
                    onTap: () => _showTitleInputDialog(context, complaintBloc),
                    child: _buildField('Title',
                        state.title.isEmpty ? 'Enter Title' : state.title),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _showDescriptionInputDialog(context, complaintBloc),
                    child: _buildField(
                        'Description',
                        state.description.isEmpty
                            ? 'Enter Description'
                            : state.description),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _showCategorySelectionDialog(context, complaintBloc),
                    child: _buildField(
                        'Category', categories[state.category]!.title),
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(context, complaintBloc),
                    child:
                        _buildField('Additional Information', 'Attach Image'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Anonymity'),
                      Switch(
                        value: state.isAnonymous,
                        onChanged: (value) =>
                            complaintBloc.add(UpdateAnonymity(value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => complaintBloc.add(SubmitComplaint()),
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showTitleInputDialog(
      BuildContext context, ComplaintBloc complaintBloc) {
    String input = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Title'),
          content: TextField(
            onChanged: (value) => input = value,
            decoration: const InputDecoration(hintText: 'Enter Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                complaintBloc.add(UpdateTitle(input));
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
    String input = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Description'),
          content: TextField(
            onChanged: (value) => input = value,
            decoration: const InputDecoration(hintText: 'Enter Description'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                complaintBloc.add(UpdateDescription(input));
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
                complaintBloc.add(UpdateCategory(category));
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
      complaintBloc.add(UpdateImage(File(pickedFile.path)));
    }
  }
}
