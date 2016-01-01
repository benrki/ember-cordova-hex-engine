module.exports = {
  'default-src': "'self' data: gap: https://ssl.gstatic.com",
  'script-src': "'self' 'unsafe-inline' 'unsafe-eval' http://10.0.2.2:* http://localhost:*",
  'font-src': "'self' https://fonts.gstatic.com",
  'connect-src': "'self' ws://localhost:* http://localhost:* ws://0.0.0.0:* http://10.0.2.2:* ws://10.0.2.2:*",
  'img-src': "'self'",
  'style-src': "'self' 'unsafe-inline'",
  'media-src': "*",
  'frame-src': "gap:"
}