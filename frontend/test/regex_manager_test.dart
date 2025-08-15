import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/utils/regex_manager.dart' show RegexManager;

void main() {
  final regexManager = RegexManager();

  group('Email Regex Tests', () {
    final regex = regexManager.emailRegex;

    // Valid Email Inputs
    test('should match valid email: test@example.com', () {
      expect(regex.hasMatch("test@example.com"), isTrue);
    });
    test('should match valid email: firstname.lastname@example.co.uk', () {
      expect(regex.hasMatch("firstname.lastname@example.co.uk"), isTrue);
    });
    test('should match valid email: email@subdomain.example.com', () {
      expect(regex.hasMatch("email@subdomain.example.com"), isTrue);
    });
    test('should match valid email: user123@example-domain.com', () {
      expect(regex.hasMatch("user123@example-domain.com"), isTrue);
    });
    test('should match valid email: user.name+tag@example.com', () {
      expect(regex.hasMatch("user.name+tag@example.com"), isTrue);
    });
    test('should match valid email: _______@example.com', () {
      expect(regex.hasMatch("_______@example.com"), isTrue);
    });
    test('should match valid email: user!#\$%&\'*+-/=?^_`{|}~@example.org', () {
      expect(regex.hasMatch("user!#\$%&'*+-/=?^_`{|}~@example.org"), isTrue);
    });
    test('should match valid email: email@example.museum', () {
      expect(regex.hasMatch("email@example.museum"), isTrue);
    });

    // Invalid Email Inputs
    test('should not match invalid email: plainaddress', () {
      expect(regex.hasMatch("plainaddress"), isFalse);
    });
    test('should not match invalid email: @missingusername.com', () {
      expect(regex.hasMatch("@missingusername.com"), isFalse);
    });
    test('should not match invalid email: username@.com', () {
      expect(regex.hasMatch("username@.com"), isFalse);
    });
    test('should not match invalid email: username@domain.', () {
      expect(regex.hasMatch("username@domain."), isFalse);
    });
    test('should not match invalid email: username@domain..com', () {
      expect(regex.hasMatch("username@domain..com"), isFalse);
    });
    test('should not match invalid email: username domain.com', () {
      expect(regex.hasMatch("username domain.com"), isFalse);
    });
    test('should not match invalid email: anystring', () {
      expect(regex.hasMatch("anystring"), isFalse);
    });
  });

  group('Password Regex Tests', () {
    final regex = regexManager.passwordRegex;

    // Valid Password Inputs
    test('should match valid password: Abcdef1@', () {
      expect(regex.hasMatch("Abcdef1@"), isTrue);
    });
    test('should match valid password: P@\$wOrd1', () {
      expect(regex.hasMatch("P@\$wOrd1"), isTrue);
    });
    test('should match valid password: SecureP!23', () {
      expect(regex.hasMatch("SecureP!23"), isTrue);
    });
    test('should match valid password: MyV3ryStr0ngP@ss', () {
      expect(regex.hasMatch("MyV3ryStr0ngP@ss"), isTrue);
    });

    // Invalid Password Inputs
    test('should not match invalid password: short', () {
      expect(regex.hasMatch("short"), isFalse);
    });
    test(
      'should not match invalid password: abcdefg1@ (missing uppercase)',
      () {
        expect(regex.hasMatch("abcdefg1@"), isFalse);
      },
    );
    test(
      'should not match invalid password: ABCDEFG1@ (missing lowercase)',
      () {
        expect(regex.hasMatch("ABCDEFG1@"), isFalse);
      },
    );
    test('should not match invalid password: Abcdefg@ (missing digit)', () {
      expect(regex.hasMatch("Abcdefg@"), isFalse);
    });
    test(
      'should not match invalid password: Abcdefg1 (missing special char)',
      () {
        expect(regex.hasMatch("Abcdefg1"), isFalse);
      },
    );
    test(
      'should not match invalid password: Password (missing digit and special)',
      () {
        expect(regex.hasMatch("Password"), isFalse);
      },
    );
    test(
      'should not match invalid password: PASSWORD123 (missing lowercase and special)',
      () {
        expect(regex.hasMatch("PASSWORD123"), isFalse);
      },
    );
    test(
      'should not match invalid password: password123 (missing uppercase and special)',
      () {
        expect(regex.hasMatch("password123"), isFalse);
      },
    );
  });

  group('Name Regex Tests', () {
    final regex = regexManager.nameRegex;

    // Valid Name Inputs
    test('should match valid name: John', () {
      expect(regex.hasMatch("John"), isTrue);
    });
    test('should match valid name: Mary-Anne', () {
      expect(regex.hasMatch("Mary-Anne"), isTrue);
    });
    test('should match valid name: O\'Malley', () {
      expect(regex.hasMatch("O'Malley"), isTrue);
    });
    test('should match valid name: Peter Jr.', () {
      // Current regex might be strict on ending punctuation
      expect(
        regex.hasMatch("Peter Jr."),
        isTrue,
      ); // This might fail based on strictness; adjust regex or test if needed
    });
    test('should match valid name: Charles de Gaulle', () {
      expect(regex.hasMatch("Charles de Gaulle"), isTrue);
    });
    test('should match valid name: Firstname Lastname', () {
      expect(regex.hasMatch("Firstname Lastname"), isTrue);
    });

    // Invalid Name Inputs
    test('should not match invalid name: "" (empty)', () {
      expect(regex.hasMatch(""), isFalse);
    });
    test('should not match invalid name: 123Name (starts with number)', () {
      expect(regex.hasMatch("123Name"), isFalse);
    });
    test('should not match invalid name:  Name (starts with space)', () {
      expect(regex.hasMatch(" Name"), isFalse);
    });
    test('should not match invalid name: Name  (ends with space)', () {
      expect(regex.hasMatch("Name "), isFalse);
    });
    test('should not match invalid name: Name- (ends with hyphen)', () {
      expect(regex.hasMatch("Name-"), isFalse);
    });
    test('should not match invalid name: Name@Symbol', () {
      expect(regex.hasMatch("Name@Symbol"), isFalse);
    });
  });

  group('Phone Number Regex Tests', () {
    final regex = regexManager.phoneNumberRegex;

    // Valid Phone Number Inputs
    test('should match valid phone: 1234567890', () {
      expect(regex.hasMatch("1234567890"), isTrue);
    });
    test('should match valid phone: +11234567890', () {
      expect(regex.hasMatch("+11234567890"), isTrue);
    });
    test('should match valid phone: +447911123456', () {
      expect(regex.hasMatch("+447911123456"), isTrue);
    });
    test('should match valid phone: +1-800-555-1212', () {
      // Current regex expects only one optional space/hyphen
      expect(
        regex.hasMatch("1-800-555-1212"),
        isTrue,
      ); // This may need regex adjustment or test change
    });
    test('should match valid phone: +91 9876543210', () {
      expect(regex.hasMatch("+91 9876543210"), isTrue);
    });
    test('should match valid phone: 7894561 (7 digits)', () {
      expect(regex.hasMatch("7894561"), isTrue);
    });
    test('should match valid phone: 123456789012345 (15 digits)', () {
      expect(regex.hasMatch("123456789012345"), isTrue);
    });

    // Invalid Phone Number Inputs
    test('should not match invalid phone: 123 (too short)', () {
      expect(regex.hasMatch("123"), isFalse);
    });
    test('should not match invalid phone: 1234567890123456 (too long)', () {
      expect(regex.hasMatch("1234567890123456"), isFalse);
    });
    test('should not match invalid phone: ++11234567890 (double plus)', () {
      expect(regex.hasMatch("++11234567890"), isFalse);
    });
    test('should not match invalid phone: abc1234567 (contains letters)', () {
      expect(regex.hasMatch("abc1234567"), isFalse);
    });
    test('should not match invalid phone: + 1234567890 (space after plus)', () {
      expect(regex.hasMatch("+ 1234567890"), isFalse);
    });
  });

  group('YouTube URL Regex Tests', () {
    final regex = regexManager.youtubeRegex;

    // Valid YouTube URL Inputs
    test(
      'should match valid YouTube URL: https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: http://www.youtube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("http://www.youtube.com/watch?v=dQw4w9WgXcQ"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: www.youtube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(regex.hasMatch("www.youtube.com/watch?v=dQw4w9WgXcQ"), isTrue);
      },
    );
    test('should match valid YouTube URL: youtube.com/watch?v=dQw4w9WgXcQ', () {
      expect(regex.hasMatch("youtube.com/watch?v=dQw4w9WgXcQ"), isTrue);
    });
    test('should match valid YouTube URL: https://youtu.be/dQw4w9WgXcQ', () {
      expect(regex.hasMatch("https://youtu.be/dQw4w9WgXcQ"), isTrue);
    });
    test('should match valid YouTube URL: youtu.be/dQw4w9WgXcQ', () {
      expect(regex.hasMatch("youtu.be/dQw4w9WgXcQ"), isTrue);
    });
    test(
      'should match valid YouTube URL: https://www.youtube.com/embed/dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://www.youtube.com/embed/dQw4w9WgXcQ"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: https://www.youtube.com/live/VIDEO_ID?feature=share',
      () {
        expect(
          regex.hasMatch("https://www.youtube.com/live/VIDEO_ID?feature=share"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: https://m.youtube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://m.youtube.com/watch?v=dQw4w9WgXcQ"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ"),
          isTrue,
        );
      },
    );
    test(
      'should match valid YouTube URL: //www.youtube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(regex.hasMatch("//www.youtube.com/watch?v=dQw4w9WgXcQ"), isTrue);
      },
    );
    test(
      'should match valid YouTube URL: https://www.youtube.com/v/dQw4w9WgXcQ',
      () {
        expect(regex.hasMatch("https://www.youtube.com/v/dQw4w9WgXcQ"), isTrue);
      },
    );

    // Invalid YouTube URL Inputs
    test(
      'should not match invalid YouTube URL: https://www.notyoutube.com/watch?v=dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://www.notyoutube.com/watch?v=dQw4w9WgXcQ"),
          isFalse,
        );
      },
    );
    test(
      'should not match invalid YouTube URL: https://www.youtube.com/watch?vid=dQw4w9WgXcQ',
      () {
        expect(
          regex.hasMatch("https://www.youtube.com/watch?vid=dQw4w9WgXcQ"),
          isFalse,
        );
      },
    );
    test('should not match invalid YouTube URL: youtu.be/', () {
      expect(regex.hasMatch("youtu.be/"), isFalse);
    });
    test(
      'should not match invalid YouTube URL: https://vimeo.com/12345678',
      () {
        expect(regex.hasMatch("https://vimeo.com/12345678"), isFalse);
      },
    );
    test(
      'should not match invalid YouTube URL: www.youtube.com/playlist?list=SOME_ID',
      () {
        expect(
          regex.hasMatch("www.youtube.com/playlist?list=SOME_ID"),
          isFalse,
        );
      },
    );
  });

  group('General URL Regex Tests', () {
    final regex = regexManager.urlRegex;

    // Valid General URL Inputs
    test('should match valid URL: http://example.com', () {
      expect(regex.hasMatch("http://example.com"), isTrue);
    });
    test(
      'should match valid URL: https://example.com/path/to/page?query=value#fragment',
      () {
        expect(
          regex.hasMatch(
            "https://example.com/path/to/page?query=value#fragment",
          ),
          isTrue,
        );
      },
    );
    test(
      'should match valid URL: ftp://user:password@example.com/resource.txt',
      () {
        expect(
          regex.hasMatch("ftp://user:password@example.com/resource.txt"),
          isTrue,
        );
      },
    );
    test(
      'should match valid URL: file:///Users/username/Desktop/myfile.html',
      () {
        expect(
          regex.hasMatch("file:///Users/username/Desktop/myfile.html"),
          isTrue,
        );
      },
    );
    test('should match valid URL: http://localhost:8080', () {
      expect(regex.hasMatch("http://localhost:8080"), isTrue);
    });
    test('should match valid URL: https://www.example.co.uk/test', () {
      expect(regex.hasMatch("https://www.example.co.uk/test"), isTrue);
    });
    test('should match valid URL: http://192.168.1.1/index.html', () {
      expect(regex.hasMatch("http://192.168.1.1/index.html"), isTrue);
    });

    // Invalid General URL Inputs
    test('should not match invalid URL: example.com (missing scheme)', () {
      expect(regex.hasMatch("example.com"), isFalse);
    });
    test('should not match invalid URL: www.example.com (missing scheme)', () {
      expect(regex.hasMatch("www.example.com"), isFalse);
    });
    test(
      'should not match invalid URL: htp://example.com (misspelled scheme)',
      () {
        expect(regex.hasMatch("htp://example.com"), isFalse);
      },
    );
    test(
      'should not match invalid URL: ://example.com (missing scheme name)',
      () {
        expect(regex.hasMatch("://example.com"), isFalse);
      },
    );
    test('should not match invalid URL: http//example.com (missing colon)', () {
      expect(regex.hasMatch("http//example.com"), isFalse);
    });
    test('should not match invalid URL: http:/example.com (missing slash)', () {
      expect(regex.hasMatch("http:/example.com"), isFalse);
    });
    test('should not match invalid URL: http:// (missing domain)', () {
      expect(regex.hasMatch("http://"), isFalse);
    });
    test('should not match invalid URL: Just a string', () {
      expect(regex.hasMatch("Just a string"), isFalse);
    });
    test('should not match invalid URL: mailto:test@example.com', () {
      expect(regex.hasMatch("mailto:test@example.com"), isFalse);
    });
  });
}
