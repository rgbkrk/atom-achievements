Achiever = require '../lib/achiever'
{WorkspaceView} = require 'atom'

clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = clone obj[key]

  return newInstance

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
    expect(achiever.unlockedAchievements).toEqual({})

  it "should track all the fields from the v2 message spec", ->
    event =
      name: "MYNAME"
      requirement: "Did stuff"
      category: "testing"
      package: "achievements"
      points: 9001
      iconURL: "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"

    achiever.achieve(event.name, event.requirement, event.category,
                     event.package, event.points, event.iconURL)

    expected_key = (event.package + ":" + event.name).trim().toLowerCase()

    expect(achiever.unlockedAchievements[expected_key]).toEqual(
      name: event.name
      requirement: event.requirement
      category: event.category
      package: event.package
      points: event.points
      iconURL: event.iconURL
    )

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

    it "passes the message on to the view", ->
      atom.emit "achievement:unlock", name: "EMITTED"
      expect(mockAchievementsView.messages[0]).toBe "EMITTED"

    it "handles the v1 message spec", ->
      atom.emit "achievement:unlock", msg: "old specdonald"
      expect(mockAchievementsView.messages[0]).toBe "old specdonald"

  describe "when processUnlock is called", ->

    beforeEach ->
      spyOn(achiever, 'achieve')

    it "passes a v2 event on directly to achieve", ->
      event =
        name: "MYNAME"
        requirement: "Did stuff"
        category: "testing"
        package: "achievements"
        points: 9001
        iconURL: "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"

      theEvent = clone(event)

      achiever.processUnlock(theEvent)
      expect(achiever.achieve).toHaveBeenCalled()

      expect(achiever.achieve).
        toHaveBeenCalledWith(event.name, event.requirement, event.category,
                             event.package, event.points, event.iconURL)

    it "gracefully handles a v1 message spec", ->
      old_event =
        msg: "THEEVENT"

      event =
        name: old_event.msg
        requirement: old_event.msg
        category: "undefined"
        package: "undefined"
        points: 0
        iconURL: "images/octocat-spinner-128.gif"

      achiever.processUnlock(old_event)
      expect(achiever.achieve).toHaveBeenCalled()

      expect(achiever.achieve).
        toHaveBeenCalledWith(event.name, event.requirement, event.category,
                             event.package, event.points, event.iconURL)
