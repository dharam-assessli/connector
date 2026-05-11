// ignore_for_file: lines_longer_than_80_chars

class QuickStartModelOuter {
  QuickStartModelOuter({required this.title, required this.innerList});

  final String title;
  final List<QuickStartModelInner> innerList;
}

class QuickStartModelInner {
  QuickStartModelInner({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.timestamp,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final String timestamp;
}

final List<QuickStartModelOuter> quickStartData = <QuickStartModelOuter>[
  QuickStartModelOuter(
    title: "Getting Started",
    innerList: <QuickStartModelInner>[
      QuickStartModelInner(
        title: "Welcome to Dots",
        subtitle: "Let's get you started with a quick tour of the app.",
        buttonText: "Take a Tour",
        timestamp: "Just now",
      ),
      QuickStartModelInner(
        title: "Set Up Your Profile",
        subtitle:
            "Add your personal details and preferences to get personalized insights.",
        buttonText: "Set Up Profile",
        timestamp: "2 hours ago",
      ),
    ],
  ),
  QuickStartModelOuter(
    title: "Next Steps",
    innerList: <QuickStartModelInner>[
      QuickStartModelInner(
        title: "Explore Features",
        subtitle:
            "Discover the various features of Dots to make the most out of it.",
        buttonText: "Explore Now",
        timestamp: "1 day ago",
      ),
      QuickStartModelInner(
        title: "Connect with Community",
        subtitle:
            "Join our community to share your experiences and learn from others.",
        buttonText: "Join Community",
        timestamp: "3 days ago",
      ),
    ],
  ),
  QuickStartModelOuter(
    title: "Getting Started",
    innerList: <QuickStartModelInner>[
      QuickStartModelInner(
        title: "Welcome to Dots",
        subtitle: "Let's get you started with a quick tour of the app.",
        buttonText: "Take a Tour",
        timestamp: "Just now",
      ),
      QuickStartModelInner(
        title: "Set Up Your Profile",
        subtitle:
            "Add your personal details and preferences to get personalized insights.",
        buttonText: "Set Up Profile",
        timestamp: "2 hours ago",
      ),
    ],
  ),
  QuickStartModelOuter(
    title: "Next Steps",
    innerList: <QuickStartModelInner>[
      QuickStartModelInner(
        title: "Explore Features",
        subtitle:
            "Discover the various features of Dots to make the most out of it.",
        buttonText: "Explore Now",
        timestamp: "1 day ago",
      ),
      QuickStartModelInner(
        title: "Connect with Community",
        subtitle:
            "Join our community to share your experiences and learn from others.",
        buttonText: "Join Community",
        timestamp: "3 days ago",
      ),
    ],
  ),
];
