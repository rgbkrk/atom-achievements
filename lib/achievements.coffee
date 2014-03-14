AchievementsView = require './achievements-view'

module.exports =

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)

    @achievementsView.achieve("Achievements Activated!")

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()

  configDefaults:
    'NoticeDelay': 2500
