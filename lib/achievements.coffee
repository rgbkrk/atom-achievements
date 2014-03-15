Achiever = require './achiever'

module.exports =

  activate: (state) ->
    @achiever =
      if state?
        Achiever.deserialize(state.achieverState)
      else
        new Achiever({})

    # Bronze trophy!
    atom.emit "achievement:unlock", msg: "You're an achiever!"

  deactivate: ->
    @achiever.destroy()

  serialize: ->
    achieverState: @achiever.serialize()

  configDefaults:
    'NoticeDelay': 2500
