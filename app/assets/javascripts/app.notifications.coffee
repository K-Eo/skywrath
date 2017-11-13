class App.Notifications
  constructor: ->
    console.log "Connecting to Pusher"
    @pusher = new Pusher @getKey(), @getOptions()

  getOptions: ->
    {
      encrypted: true
      cluster: 'us2'
    }

  getKey: ->
    App.config["pusher-key"]
