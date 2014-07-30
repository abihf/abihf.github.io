((document, files) ->
  head = document.getElementsByTagName('head')[0]
  for file in files
    if file.match /\.js$/
      elm = document.createElement 'script'
      elm.async = true
      elm.src = file
    else
      elm = document.createElement 'link'
      elm.rel = 'stylesheet'
      elm.href = file
    head.appendChild elm
)(document, [
  'css/main.css',
  'js/all.min.js',
  '//www.google-analytics.com/analytics.js'
])

((win, g, arg) ->
  win['GoogleAnalyticsObject'] = g
  win[g] = {q: arg, l: 1*new Date}
)(window, 'ga', [['create','UA-53043721-1','auto'], ['send','pageview']])