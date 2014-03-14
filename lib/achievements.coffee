AchievementsView = require './achievements-view'

module.exports =
  achievementsView: null

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()
