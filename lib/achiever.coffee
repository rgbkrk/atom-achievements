AchievementsView = require './achievements-view'

module.exports =
class Achiever

  @version: 3

  @deserialize: (achieverState) -> new Achiever(achieverState.unlocked_achievements)

  constructor: (@unlocked_achievements) ->
    @achievementsView = new AchievementsView() #(state.achievementsViewState)

    atom.on "achievement:unlock", (event) =>
      @achieve(event.msg)

  achieve: (message) ->
    if(not @unlocked_achievements[message])
      @unlocked_achievements[message] = true
      console.log("Achieved " + message)
      @achievementsView.achieve(message)
    else
      console.log("Already got the achievement '" + message + "'")

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      unlocked_achievements: @unlocked_achievements

  destroy: ->
    @achievementsView.destroy()
