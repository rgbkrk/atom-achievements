{View} = require 'atom'

module.exports =
class AchievementsView extends View
  @content: ->
      @div tabindex: -1, class: 'achievements overlay from-top', =>
        @span class: 'loading loading-spinner-small inline-block'
        @span "ACHIEVEMENT UNLOCKED: "
        @span outlet: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "achievements:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  cleanup: =>
    @destroy()

  achieve: (msg) ->
    @message.text(msg)
    atom.workspaceView.append(this)
    setTimeout(@cleanup, atom.config.get('achievements.NoticeDelay'))

  toggle: ->
    @achieve("How Toggling")
