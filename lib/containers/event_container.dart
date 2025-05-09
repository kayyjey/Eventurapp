import 'package:appwrite/models.dart';
import 'package:eventurapp/constants/colors.dart';
import 'package:eventurapp/containers/format_datetime.dart';
import 'package:eventurapp/views/event_details.dart';
import 'package:eventurapp/containers/format_datetime.dart';
import 'package:eventurapp/views/event_details.dart';

import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  final Document data;
  const EventContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => EventDetails(data: data))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: kLightGreen,
                    blurRadius: 0,
                    offset: Offset(1, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    "https://cloud.appwrite.io/v1/storage/buckets/67a0ea89003df90b8242/files/${data.data["image"]}/view?project=679780d900000280dfd0",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 35,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  data.data["name"],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(data.data["datetime"]),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.access_time_rounded, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatTime(data.data["datetime"]),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                left: 16,
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      data.data["location"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}