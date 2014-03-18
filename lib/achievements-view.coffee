{View} = require 'atom'

module.exports =
class AchievementsView extends View
  @content: ->
      @div tabindex: -1, class: 'achievements overlay from-top', =>
        @img class: "inline-block", src: "images/octocat-spinner-128.gif", width: '32px', height: '32px', outlet: "icon"
        @div class: "achievements-message-body inline-block", =>
          @div class: "block-tight text-smaller text-highlight", "Achievement Unlocked"
          @div class: "block-tight text-smaller", outlet: "message"

  initialize: (serializeState) ->

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  # destroy + this
  cleanup: =>
    @destroy()

  achieve: (msg, iconURL) ->
    if not iconURL?
      iconURL = "images/octocat-spinner-128.gif"

    @icon.attr('src', iconURL)

    @message.text(msg)
    atom.workspaceView.append(this)
    setTimeout(@cleanup, atom.config.get('achievements.NoticeDelay'))
