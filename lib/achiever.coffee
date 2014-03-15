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
    #   # Could start over

    if(achieverState.unlockedAchievements?)
      achiever = new Achiever(achieverState.unlockedAchievements)
    else
      achiever = new Achiever()

    return achiever

  constructor: (@unlockedAchievements={}) ->
    @achievementsView = new AchievementsView() #(state.achievementsViewState)

    atom.on "achievement:unlock", (event) =>
      @achieve(event.msg)

  achieve: (message) ->
    # TODO: Queue these up in case there are more than one achievement to
    #       display in a short period of time
    if(not @unlockedAchievements[message])
      @unlockedAchievements[message] = true
      @achievementsView.achieve(message)
    else
      # Already achieved it

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      unlockedAchievements: @unlockedAchievements

  destroy: ->
    # Pass on to destroy the view
    @achievementsView.destroy()
