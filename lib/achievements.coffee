AchievementsView = require './achievements-view'

module.exports =
  achievementsView: null

  activate: (state) ->
    @achievementsView = new AchievementsView(state.achievementsViewState)

  deactivate: ->
    @achievementsView.destroy()

  serialize: ->
    achievementsViewState: @achievementsView.serialize()

  configDefaults:
    'NoticeDelay': 3000


  #createProgressView: ->
#    $$ ->
#      @div tabindex: -1, class: 'overlay from-top', =>
#        @span class: 'loading loading-spinner-small inline-block'
#        @span "Updating package dependencies\u2026"
