AchievementsView = require './achievements-view'
Achiever = require './achiever'

module.exports =

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)
    @achiever =
      if state?
        console.log(state)
        #new AchievementsView(state)
        new Achiever(state.achieverState.unlocked_achievements)
      else
        new Achiever({})

    atom.on "achievement:unlock", (event) =>
      @achievementsView.achieve(event.msg)

    @achiever.achieve("test3")
    @achiever.achieve("test4")

    # Bronze trophy!
    atom.emit "achievement:unlock", msg: "You're an achiever!"

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()
    achieverState: @achiever.serialize()

  configDefaults:
    'NoticeDelay': 2500
