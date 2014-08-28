# setup google analystic
((win, g, arg) ->
  win['GoogleAnalyticsObject'] = g
  win[g] = {q: arg, l: 1*new Date}
)(window, 'ga', [['create','UA-53043721-1','auto'], ['send','pageview']])

# setup google web font 
WebFontConfig = {
  google: 
    families: ['Open+Sans:400,400italic,700,700italic:latin']
}

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
  '/css/main.css',
  '/js/all.min.js',
  '//www.google-analytics.com/analytics.js'
#  '//ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js'
  'http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700,700italic&subset=latin'
])

