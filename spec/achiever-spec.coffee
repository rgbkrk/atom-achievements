Achiever = require '../lib/achiever'
{WorkspaceView} = require 'atom'


class MockAchievementsView
  constructor: () ->
    @messages = []

  achieve: (msg) ->
    # Hokey pokey just save the message
    @messages.push msg

  destroy: () ->

window.yar = []

describe "Achievements with Mock View", ->
  [achiever, mockAchievementsView] = []

  beforeEach ->
    achiever = new Achiever()
    mockAchievementsView = new MockAchievementsView
    achiever.achievementsView = mockAchievementsView

  it "has empty unlockedAchievements", ->
    expect(achiever.unlockedAchievements).toBeDefined()

  it "should only register an event once", ->
    achiever.achieve("Ran a test!")
    expect(mockAchievementsView.messages[0]).toBe "Ran a test!"
    # Reset
    mockAchievementsView.messages = []

    achiever.achieve("Ran a test!")
    expect(mockAchievementsView.messages[0]).not.toBeDefined()

  describe "when achievement:unlock is emitted", ->

    beforeEach ->
      atom.workspaceView = new WorkspaceView

    it "should trigger achieve on the achiever", ->
      atom.emit "achievement:unlock", name: "EMITTED"
      expect(mockAchievementsView.messages[0]).toBe "EMITTED"
