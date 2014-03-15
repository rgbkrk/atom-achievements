Achiever = require '../lib/achiever'
{WorkspaceView} = require 'atom'

describe "Achiever", ->
  it "should handle creating an empty achiever", ->
    achiever = new Achiever()
    expect(achiever.unlockedAchievements).toBeDefined()
