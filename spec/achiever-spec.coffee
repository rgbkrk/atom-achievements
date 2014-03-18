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

  describe "when process_unlock is called", ->

    beforeEach ->
      spyOn(achiever, 'achieve')

    it "passes a v2 event on directly to achieve", ->
      event =
        name: "MYNAME"
        requirement: "Did stuff"
        category: "testing"
        package: "achievements"
        points: 9001

      theEvent = clone(event)

      achiever.process_unlock(theEvent)
      expect(achiever.achieve).toHaveBeenCalled()

      expect(achiever.achieve).
        toHaveBeenCalledWith(event.name, event.requirement, event.category,
                             event.package, event.points)

    it "gracefully handles a v1 message spec", ->
      old_event =
        msg: "THEEVENT"

      event =
        name: old_event.msg
        requirement: old_event.msg
        category: "undefined"
        package: "undefined"
        points: 0

      achiever.process_unlock(old_event)
      expect(achiever.achieve).toHaveBeenCalled()

      expect(achiever.achieve).
        toHaveBeenCalledWith(event.name, event.requirement, event.category,
                             event.package, event.points)
