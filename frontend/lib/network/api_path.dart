class ApiPath {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000',
  );

  static const submit = '/video-process/submit';
  static getVideoProcessStatus(String id) => '/video-process/status/$id';

  static const transcript = '/transcript';
  static const summarize = '/summary';
  static getSummaryById(String id) => '/summary/$id';

  static const jobs = '/jobs';
  static getJobStatus(String jobId) => '/jobs/$jobId';
  static getJobEvents(String jobId) => '/jobs/$jobId/events';
  static getJobResult(String jobId) => '/jobs/$jobId/result';

  static const authLogin = '/auth/login';
  static const authRegister = '/auth/register';
  static const logout = '/auth/logout';
  static const refreshToken = '/auth/refresh';
  static const me = '/auth/me';

  static const getPlans = '/plans';
  static getSinglePlan(String planId) => '/plans/$planId';

  static const subscribe = '/subscriptions/subscribe';
  static const unsubscribe = '/subscriptions/unsubscribe';
  static const activeSubscription = '/subscriptions/me';
  static const subscriptionHistory = '/subscriptions/history';

  static const auditLogs = '/audit-logs';
  static getAuditLog(String auditId) => '/audit-logs/$auditId';
}
