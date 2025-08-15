class ApiPath{
  static const baseUrl ='https://46812a1d3e42.ngrok-free.app';
  static const submit='/video_process/submit';
  static const summarize='/summary';
  static const transcript='/transcript';
  static const authLogin ='/auth/login';
  static const me ='/auth/me';
  static const authRegister ='/auth/register';
  static const logout ='/auth/logout';
  static const refreshToken ='/auth/refresh';
  static const getPlans ='/plans';
  static  getSinglePlan(String planId) =>'/plans/$planId';
  static const subscribe ='/subscriptions/subscribe';
  static  getActiveSubs(String userId) =>'/subscriptions/subscribe/user/$userId';
  static const unsubscribe ='/subscriptions/unsubscribe';
  static  getSubsHistory(String userId) =>'/subscriptions/subscribe/history/$userId';
}