class AppStrings {
  static const String appName = "Ashutosh Portfolio";
  static const String logoText = "ASHUTOSH";
  static const String devNameWithRole = "Ashutosh | Flutter Developer";
  static const String linkedinUrl =
      "https://www.linkedin.com/in/ashutosh-garge-3037a5240";
  static const String githubUrl = "https://github.com/Ashutoshpawar1";
  static const String emailAddress = "ashutoshgarge123@gmail.com";
  static const String emailUrl = "mailto:ashutoshgarge123@gmail.com";
  static const String resumeWebPath = "resume/ashutosh_resume.pdf";
  static const String heroIdentityTitle =
      "Ashutosh Garge\nCrafting seamless digital experiences with Flutter.";
  static const String devSubtitle =
      "State Management (Riverpod/GetX)\n\nReal-time Systems (Socket.io)\n\nPerformance Optimization\n\nClean Architecture (SOLID)";
  static const String devDescriptionLong =
      "I build high-performance, scalable mobile and web applications that combine clean architecture with fluid animations.";
  static const String heroSpecialtiesTitle = "Specialties:";

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
  static const String projectSection = "PROJECT SECTION";
  static const String playground = "PLAYGROUND";
  static const String tools = "TOOLS";

  static const String aboutTitle = "ABOUT ME";
  static const String aboutContent =
      "I'm a Flutter Developer with 2+ years of experience building scalable mobile and web applications. I specialize in responsive UI design, API integration, Firebase, state management, and real-time features. I focus on creating smooth user experiences with clean, maintainable, and efficient code architecture.\n\nI'm passionate about building modern, pixel-perfect applications that are both functional and user-friendly. Over the years, I've worked on projects ranging from simple applications to complex enterprise-level solutions, with experience in real-time communication, multilingual support (English, Arabic, and Urdu), and scalable backend integration using Firebase and MongoDB.";

  static const String projectsTitle = "PROJECTS";

  static const String contactTitle = "CONTACT";
  static const String email = emailAddress;
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
