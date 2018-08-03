App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      $('#alarm').append "<li>" + "새로운 메세지 입니다 : " + data.content + '<a href="#"> | 삭제</a>' + "</li>"
