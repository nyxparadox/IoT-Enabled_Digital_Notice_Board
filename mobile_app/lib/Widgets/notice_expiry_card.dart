import 'package:flutter/material.dart';

class NoticeExpiryCard extends StatelessWidget {
  final bool enableExpiry;
  final DateTime? expiryDate;
  final TimeOfDay? expiryTime;
  final VoidCallback onToggle;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;

  const NoticeExpiryCard({
    super.key,
    required this.enableExpiry,
    required this.expiryDate,
    required this.expiryTime,
    required this.onToggle,
    required this.onSelectDate,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_calendar_outlined,
                color: Colors.red,
                size: 32,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Auto Delete ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "After expiry, the notice will be removed automatically.",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ],
                ),
              ),

              // TOGGLE SWITCH
              Switch(
                value: enableExpiry,
                onChanged: (_) => onToggle(),
                activeColor: Colors.white,
                activeTrackColor: const Color.fromARGB(255, 50, 83, 99),
                inactiveThumbColor: const Color.fromARGB(255, 50, 83, 99),
                inactiveTrackColor: const Color.fromARGB(66, 50, 83, 99),
                trackOutlineColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color.fromARGB(255, 50, 83, 99);
                  }

                  return const Color.fromARGB(177, 50, 83, 99);
                }),
              ),
            ],
          ),

          if (enableExpiry) ...[
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onSelectDate,
                    borderRadius: BorderRadius.circular(18),

                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Expiry Date",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),

                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              expiryDate == null
                                  ? "Select Date"
                                  : "${expiryDate!.day}/${expiryDate!.month}/${expiryDate!.year}",

                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: InkWell(
                    onTap: onSelectTime,
                    borderRadius: BorderRadius.circular(18),

                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Expiry Time",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),

                      child: Row(
                        children: [
                          const Icon(Icons.access_time_outlined),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              expiryTime == null
                                  ? "Select Time"
                                  : expiryTime!.format(context),

                              style: const TextStyle(fontSize: 16),
                            ),
                          ),

                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(
                  color: const Color.fromARGB(125, 76, 175, 79),
                ),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: const Color.fromARGB(255, 76, 157, 80),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "After the selected time, the board will automatically return to clock mode.",

                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 10,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
