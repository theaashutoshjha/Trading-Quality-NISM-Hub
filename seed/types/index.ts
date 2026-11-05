export type UserRole = 'employee' | 'trainer' | 'admin';

export type AccountStatus = 'active' | 'pending' | 'suspended';

export interface UserProfile {
  uid: string;
  fullName: string;
  email: string;
  employeeId?: string;
  role: UserRole;
  department?: string;
  team?: string;
  accountStatus: AccountStatus;
  emailVerified: boolean;
  avatarUrl?: string;
  createdAt?: string;
  lastLoginAt?: string;
}

export type CourseCategory =
  | 'nism'
  | 'product'
  | 'call_excellence'
  | 'objection_handling'
  | 'customer_support';

export interface SyllabusTopic {
  id: string; // e.g., 'VA-CH01-T01'
  chapterId: string;
  courseCode: string;
  topicCode: string;
  title: string;
  durationMinutes: number;
  learningObjectives: string[];
  explanation: {
    what: string;
    why: string;
    how: string;
    definitions: { term: string; definition: string }[];
    rulesAndRegulations: string[];
    formulas?: { name: string; formula: string; explanation?: string; workedExample?: string }[];
    practicalScenario: string;
    keyDistinctions?: string[];
    commonMistakes: string[];
  };
  instructorScript: string;
  slides: {
    slideNumber: number;
    title: string;
    bulletPoints: string[];
    narration: string;
    visualNotes?: string;
  }[];
  practiceQuestions: {
    id: string;
    question: string;
    options: string[];
    correctIndex: number;
    explanation: string;
    examTip: string;
  }[];
  // Video & Production Tracking Metadata
  videoUrl?: string;
  videoStatus?:
    | 'script_in_progress'
    | 'awaiting_narration'
    | 'rendering'
    | 'awaiting_review'
    | 'approved_and_published'
    | 'failed_retry';
  videoDurationSeconds?: number;
  scriptStatus?: 'draft' | 'reviewed' | 'approved';
  narrationStatus?: 'pending' | 'generated' | 'reviewed';
  captionsUrl?: string;
  transcript?: { timestampSeconds: number; speaker: string; text: string }[];
  sourceReferences?: string[];
  accuracyReviewStatus?: 'pending' | 'approved' | 'flagged_sme';
  lastReviewDate?: string;
  contentVersion?: string;
  isLongVideo?: boolean;
  videoChapters?: {
    title: string;
    startSeconds: number;
    endSeconds: number;
    summary?: string;
  }[];
}

export interface SyllabusChapter {
  id: string;
  chapterNumber: number;
  title: string;
  weightagePercent: number;
  targetDurationMinutes: number;
  learningObjectives: string[];
  topics: SyllabusTopic[];
}

export interface Course {
  id: string;
  code: string;
  title: string;
  subtitle: string;
  category: CourseCategory;
  certification?: string;
  chaptersCount: number;
  totalTopics: number;
  totalModules?: number;
  durationHours: number;
  isPopular?: boolean;
  description: string;
  published: boolean;
  bannerColor?: string;
  illustrationType?: 'coins' | 'barchart' | 'magnifier' | 'piechart';
  chapters?: SyllabusChapter[];
}

export interface UserProgress {
  id?: string;
  uid: string;
  courseId: string;
  completedTopicIds: string[];
  completedCount: number;
  totalTopics: number;
  percentComplete: number;
  status: 'not_started' | 'in_progress' | 'completed';
  lastStudiedTopicId?: string;
  lastStudiedTopicTitle?: string;
  updatedAt?: string;
  // legacy compatibility
  currentModule?: number;
  currentModuleTitle?: string;
  totalModules?: number;
}

export interface AssessmentQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: number;
  explanation: string;
  topicCode?: string;
}

export interface Assessment {
  id: string;
  courseCode: string;
  title: string;
  description: string;
  category: CourseCategory;
  durationMinutes: number;
  totalQuestions: number;
  passPercentage: number;
  negativeMarkingPercent: number;
  questions: AssessmentQuestion[];
  published: boolean;
}

export interface AssessmentAttempt {
  id: string;
  uid: string;
  assessmentId: string;
  assessmentTitle: string;
  courseCode: string;
  totalQuestions: number;
  correctAnswers: number;
  incorrectAnswers: number;
  unattempted: number;
  score: number;
  maxScore: number;
  percentage: number;
  passed: boolean;
  timeSpentSeconds: number;
  completedAt: string;
}

export interface Certificate {
  id: string;
  uid: string;
  recipientName: string;
  courseId: string;
  courseCode: string;
  courseName: string;
  courseSubtitle?: string;
  description?: string;
  certificateNumber: string;
  scoreAchieved: number;
  learningHours?: string;
  issueDate: string;
  expiryDate?: string;
  status: 'active' | 'revoked' | 'expired';
  verificationUrl?: string;
  qrCodeDataUrl?: string;
  tamperProofHash?: string;
  revokedReason?: string;
  revokedAt?: string;
  revokedBy?: string;
  issuedBy?: string;
}

export interface Activity {
  id: string;
  title: string;
  type: 'mock_test' | 'call_observation' | 'objection_practice' | 'product_quiz';
  scheduledTime: string;
  date: string;
  category: string;
  published: boolean;
}

export interface LearningCategory {
  id: string;
  title: string;
  description: string;
  categoryKey: CourseCategory;
  bgClass: string;
  borderClass: string;
  iconBgClass: string;
  iconColorClass: string;
  buttonClass: string;
  route: string;
}

export interface SystemSettings {
  allowSelfRegistration: boolean;
  maintenanceMode: boolean;
  updatedAt?: string;
  updatedBy?: string;
}

export type ActiveNavTab =
  | 'home'
  | 'my_learning'
  | 'nism_academy'
  | 'sales_watchlist'
  | 'zoho_crm'
  | 'tatatele_guide'
  | 'product_school'
  | 'call_excellence'
  | 'objection_handling'
  | 'customer_support'
  | 'assessments'
  | 'certificates'
  | 'help_support'
  | 'feedback'
  | 'admin_users'
  | 'admin_users_2026'
  | 'profile';

