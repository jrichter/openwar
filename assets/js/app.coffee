window.app =
  models: {}
  views: {}

$ ->
  map = new app.views.MapView
    el: $('#map')
    ui_url: "/maps/usa.svg"
    meta_url: "/maps/usa.json"
  map.on 'ready', map.render
  window.app.map = map

$ ->
  status = new app.views.StatusView
    el: $('#status')
  status.listenTo window.app.map, 'ready', status.render
  window.app.status = status

sock = new SockJS('/echo')
sock.onopen = ->
  console.log('open')
  sock.send('hello wurld')
sock.onmessage = (e) -> console.log('message', e.data)
sock.onclose = -> console.log('close')
