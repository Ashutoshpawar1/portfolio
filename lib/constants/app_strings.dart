class AppStrings {
  static const String appName = "Ashutosh Portfolio";
  static const String logoText = "ASHUTOSH";
  static const String devNameWithRole = "Ashutosh | Flutter Developer";
  static const String devSubtitle =
      "Building Scalable Mobile & Web Applications";
  static const String devDescriptionLong =
      "I am a Flutter Developer with experience in building scalable mobile and web applications with REST APIs, real-time sockets, and clean architecture.";

  static const String skills = "SKILLS";
  static const String experience = "EXPERIENCE";
  static const String about = "ABOUT ME";

  static const String viewProjects = "View Projects";
  static const String downloadResume = "Download Resume";
  static const String contactMe = "LET'S TALK";

  static const String menu = "MENU";
  static const String close = "CLOSE";
  static const String contact = "CONTACT";
  static const String home = "HOME";
  static const String aboutMe = "ABOUT ME";
  static const String projects = "PROJECTS";
  static const String playground = "PLAYGROUND";

  static const String aboutTitle = "ABOUT ME";
  static const String aboutContent =
      "I am a Flutter Developer with experience in building scalable mobile and web applications with REST APIs, real-time sockets, and clean architecture.";

  static const String projectsTitle = "PROJECTS";

  static const String contactTitle = "CONTACT";
  static const String email = "ashutosh@example.com";
  static const String whatsapp = "WhatsApp";
}

class ProjectModel {
  final String title;
  final String description;
  final List<String> tech;
  final String imageUrl;
  final String githubUrl;

  ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.imageUrl,
    required this.githubUrl,
  });
}

final List<ProjectModel> appProjects = [
  ProjectModel(
    title: "Meeting App",
    description:
        "VC application with Jitsi integration, high-quality streaming and real-time chat.",
    tech: ["Flutter", "Jitsi SDK", "Firebase"],
    imageUrl: "https://images.unsplash.com/photo-1611605698335-8b1569810432",
    githubUrl: "#",
  ),
  ProjectModel(
    title: "Employee Service App",
    description:
        "Internal management tool for attendance, leaves, and payroll tracking.",
    tech: ["Flutter", "REST API", "State Management"],
    imageUrl: "https://images.unsplash.com/photo-1454165833767-027ffea9e77b",
    githubUrl: "#",
  ),
  ProjectModel(
    title: "Animal Management App",
    description:
        "Tracking livestock health, nutrition, and genealogy records with real-time sync.",
    tech: ["Flutter", "SQLite", "Firebase"],
    imageUrl: "https://images.unsplash.com/photo-1516733725897-1aa38917d3d7",
    githubUrl: "#",
  ),
  ProjectModel(
    title: "Marketplace App",
    description:
        "Full e-commerce experience with advanced filtering and seamless checkout flow.",
    tech: ["Flutter", "Stripe", "PostgreSQL"],
    imageUrl: "https://images.unsplash.com/photo-1472851294608-062f824d29cc",
    githubUrl: "#",
  ),
];
