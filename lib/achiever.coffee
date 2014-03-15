AchievementsView = require './achievements-view'

module.exports =
class Achiever

  @version: 2

  @deserialize: (achieverState) ->
    #
    # TODO: In the future, we'll want to have a migration plan
    #       for @version changes
    #
    # Example:
    #
    # if(achieverState.version <= @version)
    #   # Do something different with this lesser versioned state

    achiever = new Achiever(achieverState.unlocked_achievements)

  constructor: (@unlocked_achievements) ->
    @achievementsView = new AchievementsView() #(state.achievementsViewState)

    atom.on "achievement:unlock", (event) =>
      @achieve(event.msg)

  achieve: (message) ->
    # TODO: Queue these up in case there are more than one achievement to
    #       display in a short period of time
    if(not @unlocked_achievements[message])
      @unlocked_achievements[message] = true
      @achievementsView.achieve(message)
    else
      # Already achieved it

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      unlocked_achievements: @unlocked_achievements

  destroy: ->
    @achievementsView.destroy()
