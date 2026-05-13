class AppStrings {
  static const String appName = "Ashutosh Portfolio";
  static const String logoText = "ASHUTOSH";
  static const String devNameWithRole = "Ashutosh | Flutter Developer";
  static const String linkedinUrl =
      "https://www.linkedin.com/in/ashutosh-garge-3037a5240";
  static const String githubUrl = "https://github.com/Ashutoshpawar1";
  static const String emailAddress = "ashutoshgarge123@gmail.com";
  static const String emailUrl = "mailto:ashutoshgarge123@gmail.com";
  static const String twitterUrl = "";
  static const String resumeWebPath = "resume/ashutosh_resume.pdf";
  static const String heroAvailability =
      "Available for Freelance & Full-Time Projects";
  static const String heroIdentityTitle = "ASHUTOSH\nGARGE";
  static const String heroRoleSubtitle =
      "Flutter Developer &\nAI-focused App Engineer";
  static const String devSubtitle =
      "State Management (GetX / Riverpod / Bloc)\n\nReal-time Systems (Socket.io)\n\nScalable Flutter Architecture\n\nPerformance Optimization\n\nResponsive UI Engineering\n\nClean Architecture (SOLID)";
  static const String devDescriptionLong =
      "Flutter Developer with 2+ years of experience building production-level mobile and web applications.\n\nFocused on responsive UI systems, API integrations, real-time communication, scalable architecture, and AI-powered application experiences.";
  static const String heroSpecialtiesTitle =
      "Beyond Visuals.\nBuilt with\nVision.";

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
      "I'm a Flutter Developer with 2+ years of practical experience building scalable mobile and web applications.\n\nI specialize in responsive UI systems, API integration, Firebase services, state management, and real-time features. My development approach focuses on creating smooth user experiences with clean, maintainable, and production-ready architecture.\n\nOver the years, I've worked on real-world applications including e-commerce systems, meeting platforms, health & wellness apps, employee management systems, and wildlife shelter management solutions.\n\nCurrently, I'm exploring AI-integrated applications, local LLM systems, voice AI, and intelligent automation workflows.";

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
  final String playStoreUrl;
  final String appStoreUrl;

  ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.imageUrl,
    required this.githubUrl,
    this.playStoreUrl = '',
    this.appStoreUrl = '',
  });
}

final List<ProjectModel> appProjects = [
  ProjectModel(
    title: "JayHyzmat",
    description:
        "Industrial e-commerce platform for procurement workflows with product listings, authentication, and responsive ordering journeys.",
    tech: ["Flutter", "REST APIs", "Firebase", "Responsive UI"],
    imageUrl: "https://images.unsplash.com/photo-1494412651409-8963ce7935a7",
    githubUrl: "#",
    playStoreUrl:
        "https://play.google.com/store/apps/details?id=com.jayhyzmat.app&pcampaignid=web_share&utm_source=chatgpt.com",
    appStoreUrl: "https://apps.apple.com/in/app/jayhyzmat/id6743439907",
  ),
  ProjectModel(
    title: "Intercessory Army",
    description:
        "Faith-based community platform enabling prayer meetings and real-time engagement systems.",
    tech: ["Flutter", "Firebase", "Jitsi Meet", "Notifications"],
    imageUrl: "https://images.unsplash.com/photo-1504052434569-70ad5836ab65",
    githubUrl: "#",
    playStoreUrl:
        "https://play.google.com/store/apps/details?id=com.intercessory.army",
    appStoreUrl:
        "https://apps.apple.com/in/app/intercessory-army/id6760646458",
  ),
  ProjectModel(
    title: "LifeVibe",
    description:
        "AI-powered wellness application focused on nutrition tracking, habit monitoring, and analytics visualization.",
    tech: ["Flutter", "AI Concepts", "Charts", "Firebase"],
    imageUrl: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
    githubUrl: "#",
    playStoreUrl:
        "https://play.google.com/store/apps/details?id=com.laon.laon_app&pcampaignid=web_share",
    appStoreUrl: "https://apps.apple.com/us/app/lifevibe/id6756407133",
  ),
  ProjectModel(
    title: "MakeItHappn",
    description:
        "Smart event scheduling platform using availability voting and automated date coordination.",
    tech: ["Flutter", "Scheduling Systems", "REST APIs"],
    imageUrl: "https://images.unsplash.com/photo-1511578314322-379afb476865",
    githubUrl: "#",
  ),
  ProjectModel(
    title: "Wildlife Shelter Management System",
    description:
        "Large-scale wildlife shelter management system with multi-role workflows, analytics, geolocation, and medical tracking.",
    tech: ["Flutter", "GetX", "REST APIs", "Firebase", "Geolocation"],
    imageUrl: "https://images.unsplash.com/photo-1501706362039-c6e80948f11f",
    githubUrl: "#",
  ),
];
