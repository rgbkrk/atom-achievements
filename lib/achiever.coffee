Serializable = require 'serializable'

module.exports =
class Achiever extends Serializable
  @registerDeserializers(Achiever)
  
  @version: 1

  @deserialize: ({unlocked_achievements}) -> new Achiever(unlocked_achievements)

  constructor: (@unlocked_achievements) ->

  achieve: (message) ->
    if(not unlocked_achievements[message])
      unlocked_achievements[message] = true
      console.log("Achieved " + message)
    else
      console.log("Already did that")

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      data: @unlocked_achievements
