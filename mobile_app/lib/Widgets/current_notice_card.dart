import 'package:flutter/material.dart';

class CurrentNoticeCard extends StatelessWidget {
  final String category;
  final String message;
  final String? symbol;
  final String activeSince;
  final String expiryTime;

  const CurrentNoticeCard({
    super.key,
    required this.category,
    required this.message,
    required this.symbol,
    required this.activeSince,
    required this.expiryTime,
  });

  String getIconPath() {
    switch (symbol) {
      case "anouncement":
        return "assets/images/icons/advertising.png";

      case "calender":
        return "assets/images/icons/calendar.png";

      case "exam":
        return "assets/images/icons/exam.png";

      case "trophy":
        return "assets/images/icons/trophy.png";

      default:
        return "assets/images/notice.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool noActiveNotice =
        message.trim().isEmpty || message == "No active notice";

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        // color:  const Color.fromARGB(255, 244, 245, 244),
        borderRadius: BorderRadius.circular(25),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                const CircleAvatar(radius: 6, backgroundColor: Color.fromARGB(255, 58, 128, 60),),

                const SizedBox(width: 10),

                const Text(
                  "Currently Displaying",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(width: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 233, 222),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: Color.fromARGB(255, 58, 128, 60),
                      ),

                      const SizedBox(width: 5),

                      const Text(
                        "LIVE",
                        style: TextStyle(
                          color: Color.fromARGB(255, 60, 138, 63),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // WHEN THEIR IS NO ACTIVE MESSAGE OR CONTENT 
            
            if (noActiveNotice) ...[
              const SizedBox(height: 15),

              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.dvr_outlined,
                      size: 70,
                      color: Colors.grey[400],
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "No Active Notice",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Board is showing default clock screen.",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ]
            
            // ACTIVE NOTICE UI
            else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                
                  // ICON
                  Container(
                    height: 135,
                    width: 90,

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Image.asset(getIconPath()),
                  ),

                  const SizedBox(width: 18),

                  // DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1,
                          ),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 242, 247, 252),
                            border: BoxBorder.all(color: Color.fromARGB(166, 22, 101, 165))
                          ),

                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 22, 101, 165),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 18),

                            const SizedBox(width: 8),

                            Text(
                              "Active since: $activeSince",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 18),

                            const SizedBox(width: 8),

                            Text(
                              "Expires at: $expiryTime",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // INFO BANNER
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(3),

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 244, 250),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Sending a new notice will replace the current notice.",
                        style: TextStyle(color:Color.fromARGB(255, 22, 101, 165), fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
