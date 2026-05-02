import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const appColor = Color.fromARGB(255, 50, 83, 99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),

      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        titleSpacing: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Device Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              "Control your LED Notice Board",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),

      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.draft == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final s = state.draft!;

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [
              // Brightness
              _card(
                child: Column(
                  children: [
                    _title(Icons.wb_sunny, "Brightness", "${s.brightness}%"),

                    Slider(
                      value: s.brightness.toDouble(),

                      min: 0,
                      max: 100,

                      activeColor: appColor,

                      onChanged: (v) {
                        context.read<SettingsCubit>().updateBrightness(v);
                      },
                    ),
                  ],
                ),
              ),

              // speed
              _card(
                child: Column(
                  children: [
                    _title(Icons.speed, "Scroll Speed", ""),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _speed(context, "Slow", 1, s.scrollSpeed),

                        _speed(context, "Medium", 2, s.scrollSpeed),

                        _speed(context, "Fast", 3, s.scrollSpeed),
                      ],
                    ),
                  ],
                ),
              ),

              _selector(
                context,
                icon: Icons.text_fields,
                title: "Display Mode",
                value: s.displayMode,
                onTap: () {
                  _showOptions(
                    context,
                    "Display Mode",
                    ["scroll", "static", "blink"],
                    (v) {
                      context.read<SettingsCubit>().updateDisplayMode(v);
                    },
                  );
                },
              ),

              // text colors
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(Icons.title, "Heading Text Color", ""),

                    const SizedBox(height: 12),

                    _wrapColors(context, true),

                    const Divider(height: 32),

                    _title(Icons.notes, "Body Text Color", ""),

                    const SizedBox(height: 12),

                    _wrapColors(context, false),
                  ],
                ),
              ),

              // border settings
              _card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.crop_square, color: appColor),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            "Border Settings",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Switch(
                          activeColor: appColor,
                          activeTrackColor: appColor.withOpacity(.4),
                          value: s.borderEnabled,
                          onChanged: (v) {
                            context.read<SettingsCubit>().toggleBorder(v);
                          },
                        ),
                      ],
                    ),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),

                      child: s.borderEnabled
                          ? Column(
                              children: [
                                const SizedBox(height: 18),

                                Wrap(
                                  spacing: 10,
                                  children: [
                                    _borderChip(context, "none"),

                                    _borderChip(context, "single"),

                                    _borderChip(context, "double"),

                                    _borderChip(context, "rounded"),

                                    _borderChip(context, "blinking"),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                _borderColors(context),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    const Text("Thickness"),

                                    const Spacer(),

                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<SettingsCubit>()
                                            .decreaseThickness();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),

                                    Text("${s.borderThickness}px"),

                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<SettingsCubit>()
                                            .increaseThickness();
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Device Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _action(
                    icon: Icons.refresh,
                    title: "Reset",
                    subtitle: "Clear notice",
                    onTap: () {
                      _showResetDialog(context);
                    },
                  ),

                  _action(
                    icon: Icons.restart_alt,
                    title: "Restart",
                    subtitle: "Reboot device",
                    onTap: () {
                      _showRestartDialog(context);
                    },
                  ),

                  _action(
                    icon: Icons.wifi,
                    title: "WiFi",
                    subtitle: "Configure",
                    onTap: () {
                      _showWifiSheet(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 120),
            ],
          );
        },
      ),

      // apply bar
      bottomNavigationBar: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.draft == null) {
            return const SizedBox();
          }

          return Container(
            padding: const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),

            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom( foregroundColor: appColor, padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: state.hasChanges
                        ? () {
                            context.read<SettingsCubit>().discardChanges();
                          }
                        : null,
                    child: const Text("Cancel"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),

                    onPressed: state.hasChanges
                        ? () async {
                            await context.read<SettingsCubit>().applyChanges();

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Settings Applied"),
                                ),
                              );
                            }
                          }
                        : null,

                    child: state.saving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Apply Changes"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // helpers

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),

      child: child,
    );
  }

  Widget _title(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: appColor),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        if (value.isNotEmpty)
          Text(
            value,
            style: const TextStyle(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _speed(BuildContext context, String label, int value, int selected) {
    final active = value == selected;

    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<SettingsCubit>().updateScrollSpeed(value);
        },

        child: AnimatedScale(
          scale: active ? 1.04 : 1,

          duration: const Duration(milliseconds: 220),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),

            margin: const EdgeInsets.symmetric(horizontal: 4),

            padding: const EdgeInsets.symmetric(vertical: 10),

            decoration: BoxDecoration(
              color: active ? appColor : Colors.grey[200],

              borderRadius: BorderRadius.circular(10),
            ),

            child: Center(
              child: Text(
                label,
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selector(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return _card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: appColor),

            const SizedBox(width: 12),

            Expanded(child: Text(title)),

            Text(value, style: const TextStyle(color: appColor)),

            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _wrapColors(BuildContext context, bool heading) {
    final colors = {
      "red": Colors.red,
      "green": Colors.green,
      "blue": Colors.blue,
      "yellow": Colors.amber,
      "white": Colors.white,
    };

    final s = context.watch<SettingsCubit>().state.draft!;

    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: colors.entries.map((e) {
        final selected = heading
            ? s.headerTextColor == e.key
            : s.bodyTextColor == e.key;

        return ChoiceChip(
          label: Text(
            e.key,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : const Color.fromARGB(255, 50, 83, 99),
              fontWeight: FontWeight.w500,
            ),
          ),

          selected: selected,

          selectedColor: const Color.fromARGB(255, 50, 83, 99),

          backgroundColor: Colors.white,

          side: BorderSide(
            color: selected ? appColor : Colors.grey.shade400,
            width: 1,
          ),

          avatar: CircleAvatar(radius: 10, backgroundColor: e.value),

          onSelected: (_) {
            if (heading) {
              context.read<SettingsCubit>().updateHeaderColor(e.key);
            } else {
              context.read<SettingsCubit>().updateBodyColor(e.key);
            }
          },
        );
      }).toList(),
    );
  }

  Widget _borderChip(BuildContext context, String style) {
    final selected =
        context.watch<SettingsCubit>().state.draft!.borderStyle == style;

    return ChoiceChip(
      label: Text(
        style,
        style: TextStyle(color: selected ? Colors.white : appColor),
      ),

      selected: selected,

      selectedColor: appColor,

      backgroundColor: Colors.white,

      side: BorderSide(color: appColor),

      onSelected: (_) {
        context.read<SettingsCubit>().updateBorderStyle(style);
      },
    );
  }

  Widget _borderColors(BuildContext context) {
    final colors = {
      "red": Colors.red,
      "green": Colors.green,
      "blue": Colors.blue,
      "yellow": Colors.amber,
      "white": Colors.white,
    };

    final selectedColor = context
        .watch<SettingsCubit>()
        .state
        .draft!
        .borderColor;

    return Wrap(
      spacing: 14,
      children: colors.entries.map((e) {
        final selected = selectedColor == e.key;

        return GestureDetector(
          onTap: () {
            context.read<SettingsCubit>().updateBorderColor(e.key);
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            width: 42,
            height: 42,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: e.value,

              border: Border.all(
                color: selected ? appColor : Colors.grey,
                width: selected ? 4 : 2,
              ),

              boxShadow: selected
                  ? [BoxShadow(blurRadius: 8, color: Colors.black12)]
                  : [],
            ),

            child: selected
                ? const Icon(Icons.check, size: 18, color: Colors.black)
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _action({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            children: [
              Icon(icon, color: appColor),

              const SizedBox(height: 8),

              Text(title),

              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset Display?"),
        content: const Text("Clear current notice?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsCubit>().reset();

              Navigator.pop(context);
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }

  void _showRestartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Restart Device?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsCubit>().restart();

              Navigator.pop(context);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void _showWifiSheet(BuildContext context) {
    final ssid = TextEditingController();

    final pass = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("WiFi Configuration"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: ssid,
                  decoration: const InputDecoration(
                    labelText: "WiFi Name (SSID)",
                  ),
                ),

                const SizedBox(height: 14),

                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    context.read<SettingsCubit>().resetWifi();

                    Navigator.pop(context);
                  },
                  child: const Text("Clear Saved WiFi"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<SettingsCubit>().sendWifiCredentials(
                  ssid.text.trim(),
                  pass.text.trim(),
                );

                Navigator.pop(context);
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

  void _showOptions(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            ...options.map(
              (e) => ListTile(
                title: Text(e.toUpperCase()),
                onTap: () {
                  onSelect(e);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
