module.exports =
class Achiever
  @version: 1

  registerDeserializer(this)

  @deserialize: ({unlocked_achievements}) -> new Achiever(unlocked_achievements)

  constructor: (@unlocked_achievements) ->

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      data: @unlocked_achievements
