class RegexManager {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  // Password requires:
  // - At least 8 characters
  // - At least one uppercase letter
  // - At least one lowercase letter
  // - At least one digit
  // - At least one special character (from the set @$!%*?&)
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  // Name allows letters, spaces, hyphens, and apostrophes.
  // It must start and end with a letter.
  final nameRegex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  // Phone number regex:
  // - Optional + at the beginning
  // - Followed by 1 to 3 digits (country code)
  // - Optional space or hyphen
  // - Followed by 7 to 15 digits (the main number part)
  // This is a general example and might need to be adjusted for specific country formats.
  final phoneNumberRegex = RegExp(r'^\+?[0-9]{1,3}?[ -]?[0-9]{7,15}$');

  // YouTube video URL regex:
  // Supports various YouTube URL formats (standard, short, embed, with www or without, http/https)
  final youtubeRegex = RegExp(
    r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube(-nocookie)?\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|live\/|v\/)?)([\w\-]+)(\S+)?$',
  );

  // General URL regex:
  // Matches most common URL patterns, including http, https, ftp, and file protocols.
  final urlRegex = RegExp(
    r"^(?:http|ftp|https?|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]",
  );
}

extension RegexExt on String {
  bool get isNotEmail => !RegexManager().emailRegex.hasMatch(this);

  bool get isNotPassword => !RegexManager().passwordRegex.hasMatch(this);

  bool get isNotName => !RegexManager().nameRegex.hasMatch(this);

  bool get isNotPhoneNumber => !RegexManager().phoneNumberRegex.hasMatch(this);

  bool get isNotYoutube => !RegexManager().youtubeRegex.hasMatch(this);

  bool get isNotUrl => !RegexManager().urlRegex.hasMatch(this);
}
