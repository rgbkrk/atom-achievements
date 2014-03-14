module.exports =
class Achiever

  @version: 3

  @deserialize: ({unlocked_achievements}) -> new Achiever(unlocked_achievements)

  constructor: (@unlocked_achievements) ->

  achieve: (message) ->
    if(not @unlocked_achievements[message])
      @unlocked_achievements[message] = true
      console.log("Achieved " + message)
    else
      console.log("Already got that achievement")

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      unlocked_achievements: @unlocked_achievements
