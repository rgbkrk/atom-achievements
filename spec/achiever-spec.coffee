Achiever = require '../lib/achiever'
{WorkspaceView} = require 'atom'


class MockAchievementView
  constructor: () ->
    @messages = []

  achieve: (msg) ->
    # Hokey pokey just save the message
    @messages.push msg

  destroy: () ->



describe "Achievements with Mock View", ->
  achiever = null

  beforeEach ->
    #achiever = new Achiever()
    #mockAchievementView = new MockAchievementView
    #achiever.achievementsView = mockAchievementView

  describe "when a fresh achiever is created", ->
    it "unlockedAchievements should be empty"
    achiever = new Achiever()
    mockAchievementView = new MockAchievementView
    achiever.achievementsView = mockAchievementView

    expect(achiever.unlockedAchievements).toBeDefined()

  describe "when achieve is called repeated times", ->
    it "should only register the message once"
    achiever = new Achiever()
    mockAchievementView = new MockAchievementView
    achiever.achievementsView = mockAchievementView

    achiever.achieve("Ran a test!")

    expect(mockAchievementView.messages[0]).toBe "Ran a test!"
    # Reset
    mockAchievementView.messages = []

    achiever.achieve("Ran a test!")
    expect(mockAchievementView.messages[0]).not.toBeDefined()

  describe "when achievement:unlock is emitted", ->
    it "should trigger achieve on the achiever"

    achiever = new Achiever()
    mockAchievementView = new MockAchievementView
    achiever.achievementsView = mockAchievementView

    atom.emit "achievement:unlock", msg: "EMITTED"

    expect(mockAchievementView.messages[0]).toBe "EMITTED"
