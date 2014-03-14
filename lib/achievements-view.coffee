{View} = require 'atom'

module.exports =
class AchievementsView extends View
  @content: ->
    @div class: 'achievements overlay from-top', =>
      @div "The Achievements package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "achievements:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "AchievementsView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
