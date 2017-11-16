class App.Notifications
  constructor: ->
    console.log "Connecting to Pusher"
    @pusher = new Pusher @getKey(), @getOptions()
    @pusher.subscribe("alerts")
    @pusher.bind "new", (data) ->
      console.log data

  getOptions: ->
    {
      encrypted: true
      cluster: 'us2'
    }

  getKey: ->
    App.config["pusher-key"]
