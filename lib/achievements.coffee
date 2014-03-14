AchievementsView = require './achievements-view'
Achiever = require './achiever'

module.exports =

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)
    @achiever =
      if state
        deserialize(state)
      else
        new Achiever({})

    atom.on "achievement:unlock", (event) =>
      @achievementsView.achieve(event.msg)

    # Bronze trophy!
    atom.emit "achievement:unlock", msg: "You're an achiever!"

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()

  configDefaults:
    'NoticeDelay': 2500
