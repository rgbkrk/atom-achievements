AchievementsView = require '../lib/achievements-view'
{WorkspaceView} = require 'atom-space-pen-views'

describe "AchievementsView", ->
  activationPromise = null
  workspaceElement = null

  beforeEach ->
    # atom.views.getView(atom.workspace) = new WorkspaceView()
    workspaceElement = atom.views.getView(atom.workspace)

  describe "when achieve is called", ->
    it "should show the achievement"
    achievementsView = new AchievementsView()

    #expect(atom.workspaceView.find('.achievements')).not.toExist()
    #achievementsView.achieve("something")
    #expect(atom.workspaceView.find('.achievements')).toExist()
