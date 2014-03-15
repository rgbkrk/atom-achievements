AchievementsView = require '../lib/achievements-view'
{WorkspaceView} = require 'atom'

describe "AchievementsView", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView

  describe "when achieve is called", ->
    it "should show the achievement"
    achievementsView = new AchievementsView()

    #expect(atom.workspaceView.find('.achievements')).not.toExist()
    #achievementsView.achieve("something")
    #expect(atom.workspaceView.find('.achievements')).toExist()
