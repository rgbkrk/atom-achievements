AchievementsView = require './achievements-view'

module.exports =

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)

    atom.on "achievement:unlock", (event) =>
      @achievementsView.achieve(event.msg)

    # Bronze trophy!
    atom.emit "achievement:unlock", msg: "Achievements Activated!"

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()

  configDefaults:
    'NoticeDelay': 2500
