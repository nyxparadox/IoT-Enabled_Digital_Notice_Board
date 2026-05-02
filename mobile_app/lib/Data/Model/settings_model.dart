class SettingsModel {
  final int brightness;
  final int scrollSpeed;

  final String displayMode;

  final String headerTextColor;
  final String bodyTextColor;

  final bool borderEnabled;
  final String borderStyle;
  final String borderColor;
  final int borderThickness;

  const SettingsModel({
    required this.brightness,
    required this.scrollSpeed,
    required this.displayMode,      
    required this.headerTextColor,
    required this.bodyTextColor,
    required this.borderEnabled,
    required this.borderStyle,
    required this.borderColor,
    required this.borderThickness,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      brightness: map["brightness"] ?? 50,

      scrollSpeed: map["scrollSpeed"] ?? 2,

      displayMode: map["displayMode"] ?? "scroll",
    

      headerTextColor: map["headerTextColor"] ?? "red",

      bodyTextColor: map["bodyTextColor"] ?? "green",

      borderEnabled: map["borderEnabled"] ?? false,

      borderStyle: map["borderStyle"] ?? "single",

      borderColor: map["borderColor"] ?? "yellow",

      borderThickness: map["borderThickness"] ?? 2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "brightness": brightness,
      "scrollSpeed": scrollSpeed,
      "displayMode": displayMode,   

      "headerTextColor": headerTextColor,
      "bodyTextColor": bodyTextColor,

      "borderEnabled": borderEnabled,
      "borderStyle": borderStyle,
      "borderColor": borderColor,
      "borderThickness": borderThickness,
    };
  }

  SettingsModel copyWith({
    int? brightness,
    int? scrollSpeed,
    String? displayMode,           
    String? headerTextColor,
    String? bodyTextColor,
    bool? borderEnabled,
    String? borderStyle,
    String? borderColor,
    int? borderThickness,
  }) {
    return SettingsModel(
      brightness: brightness ?? this.brightness,

      scrollSpeed: scrollSpeed ?? this.scrollSpeed,

      displayMode: displayMode ?? this.displayMode,
          

      headerTextColor: headerTextColor ?? this.headerTextColor,

      bodyTextColor: bodyTextColor ?? this.bodyTextColor,

      borderEnabled: borderEnabled ?? this.borderEnabled,

      borderStyle: borderStyle ?? this.borderStyle,

      borderColor: borderColor ?? this.borderColor,

      borderThickness: borderThickness ?? this.borderThickness,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SettingsModel &&
            brightness == other.brightness &&
            scrollSpeed == other.scrollSpeed &&
            displayMode == other.displayMode &&    
            headerTextColor == other.headerTextColor &&
            bodyTextColor == other.bodyTextColor &&
            borderEnabled == other.borderEnabled &&
            borderStyle == other.borderStyle &&
            borderColor == other.borderColor &&
            borderThickness == other.borderThickness;
  }

  @override
  int get hashCode => Object.hash(
    brightness,
    scrollSpeed,
    displayMode,      
    headerTextColor,
    bodyTextColor,
    borderEnabled,
    borderStyle,
    borderColor,
    borderThickness,
  );
}
