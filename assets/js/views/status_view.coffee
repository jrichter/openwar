class app.views.StatusView extends Backbone.View

  initialize: (options)=>
    @options = options || {}
    # Fetch the game state and update status
    @game_info = "<p>Some Info Here</p>"
    @trigger 'status:ready'

  render: =>
    @$el.append(@game_info) if @$el.html() == ''

    @
