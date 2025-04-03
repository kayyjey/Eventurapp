import 'package:eventurapp/views/homepage.dart';
import "package:flutter/material.dart";
import 'package:eventurapp/containers/custom_headtext.dart';
import 'package:eventurapp/constants/colors.dart';

class SeatingPage extends StatefulWidget {
  const SeatingPage({super.key});

  @override
  State<SeatingPage> createState() => _SeatingPageState();
}

class _SeatingPageState extends State<SeatingPage> {

  //enlarged image
  void showEnlargedImage(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Tap outside to close
      barrierLabel: "Image",
      pageBuilder: (_, __, ___) {
        return GestureDetector(
          onTap: () => Navigator.pop(context), // Tap anywhere to close
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.9), // Dark overlay
            body: Center(
              child: InteractiveViewer(
                panEnabled: true, // Enable panning
                boundaryMargin: EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4.0,
                child: ClipRect( // Prevents rendering issues
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Display a placeholder or error message
                      return Center(child: Text("Image failed to load"));
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Use a fixed URL for the image
  String seatingImageUrl = "https://cloud.appwrite.io/v1/storage/buckets/67eea33600285deee567/files/hallimage/view?project=679780d900000280dfd0&mode=admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 28,
                    color: kLightGreen,
                  ),
                ),
                SizedBox(width: 10),
                CustomHeadtext(text: "Hall Mapping"),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .7,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: seatingImageUrl.isNotEmpty
                      ? GestureDetector(
                    onTap: () => showEnlargedImage(context, seatingImageUrl),
                    child: Image.network(
                      seatingImageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        // Display a placeholder or error message
                        return Text("No hall mapping available");
                      },
                    ),
                  )
                      : Text("No hall mapping available"),
                ),
              ),
            ), //event image
          ],
        ),
      ),
    );
  }
}