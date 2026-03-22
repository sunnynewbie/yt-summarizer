export function notFoundHandler(req, res) {
  return res.status(404).json({
    success: false,
    error: 'Route not found',
  });
}

export function errorHandler(err, req, res, next) {
  console.error('Unhandled API error:', err);

  const statusCode = err.statusCode || 500;
  const message = statusCode >= 500 ? 'Internal server error' : err.message;

  return res.status(statusCode).json({
    success: false,
    error: message,
  });
}
