class EndPoints {
  static const String baseUrl = 'https://elmazone.topbusiness.io/api/';
  static const String userUrl = '${baseUrl}auth/login';
  static const String onBoardingUrl = '${baseUrl}on-boarding';
  static const String homePageUrl = '${baseUrl}auth/home-page';
  static const String communicationUrl = '${baseUrl}auth/communication';
  static const String adsUrl = '${baseUrl}ads';
  static const String notificationUrl = '${baseUrl}auth/all-notifications';
  static const String explanationUrl =
      '${baseUrl}auth/home-page/start-your-journey';
  static const String examsOflesson = '/ExamEntry/all-of-questions/';
  static const String finalReviewUrl =
      '${baseUrl}auth/home-page/videos-resources';
  static const String examClassesUrl = '${baseUrl}auth/home-page/all-classes';
  static const String allExamClassesUrl = '${baseUrl}auth/home-page/all-exams';
  static const String examsClassByIdUrl =
      '${baseUrl}auth/home-page/start-your-journey/findExamByClassById/';
  static const String monthPlanUrl = '${baseUrl}plans/all';
  static const String notesUrl = '${baseUrl}notes/note-all-by-date';
  static const String datesOfNotesUrl = '${baseUrl}notes/dates-of-notes';

  static const String lessonsByClassUrl = '${baseUrl}classes/lessonsByClassId/';
  static const String VideoByLessonUrl =
      '${baseUrl}lesson/all-video-by-lessonId/';
  static const String ExamByLessonUrl =
      '${baseUrl}lesson/all-exams-by-lessonId/';

  static const String AudioOfLesson = '${baseUrl}lesson/all-audios-by-videoId/';
  static const String PdfOfLesson = '${baseUrl}lesson/all-pdf-by-videoId/';
  static const String homeworkOfLesson =
      '${baseUrl}lesson/all-exams-by-videoId/';

  static const String registerExamUrl = '${baseUrl}auth/papel-sheet-exam/user/';
  static const String deleteregisterExamUrl =
      '${baseUrl}auth/paper-sheet-exam/latest-paper-exam-delete';
  static const String paperExamDetialsUrl =
      '${baseUrl}auth/paper-sheet-exam/register-with-student-check-before';
  static const String timesUrl = '${baseUrl}auth/papel-sheet-exam/show';
  static const String sourcesReferencesUrl =
      '${baseUrl}guide/sources_references/all';
  static const String sourcesReferencesByIdUrl =
      '${baseUrl}guide/sources_references/by-lesson/';
  static const String examInstructionsUrl = '${baseUrl}instruction/exam/';
  static const String videoDetailsUrl = '${baseUrl}lesson/video/details/';
  static const String commentsUrl = '${baseUrl}lesson/video/comments/';
  static const String addremovefavUrl = '${baseUrl}favorite/video-add-favorite';
  static const String addcommentsUrl = '${baseUrl}lesson/video/add-comment';
  static const String addreplayUrl = '${baseUrl}lesson/comment/add-replay/';
  static const String deletecommentUrl = '${baseUrl}video/comment/delete/';
  static const String deletereplayUrl = '${baseUrl}video/replay/delete/';
  static const String editcommentUrl = '${baseUrl}video/comment/update/';
  static const String editReplayUrl = '${baseUrl}video/replay/update/';
  static const String reportUrl = '${baseUrl}report/student-add-report';
  static const String updateVideoTimeUrl = '${baseUrl}video-update-time/';

  static const String applyLessonExam = '${baseUrl}ExamEntry/exam/';
}
