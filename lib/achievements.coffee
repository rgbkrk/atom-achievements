AchievementsView = require './achievements-view'

module.exports =

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)

    atom.on "achievement:unlock", (event) =>
      @achievementsView.achieve(event.name)

    # Bronze trophy!
    atom.emit "achievement:unlock", name: "Achievements Activated!"

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()

  configDefaults:
    'NoticeDelay': 2500
