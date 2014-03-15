Achiever = require './achiever'

module.exports =

  activate: (state) ->
    @achiever =
      if state? and state.achieverState?
        Achiever.deserialize(state.achieverState)
      else
        new Achiever()

    # Bronze trophy!
    atom.emit "achievement:unlock", msg: "You're an achiever!"

  deactivate: ->
    @achiever.destroy()

  serialize: ->
    achieverState: @achiever.serialize()

  configDefaults:
    # How long the achievement message is kept up for
    'NoticeDelay': 2500
