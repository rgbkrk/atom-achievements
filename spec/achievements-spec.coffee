Achievements = require '../lib/achievements'
{WorkspaceView} = require 'atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Achievements", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('achievements')

  describe "when achievements is activated for the first time", ->
    it "has an achievement", ->

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.achievements')).toExist()
        #jasmine.clock().tick(atom.config.get('achievements.NoticeDelay'))
        #expect(atom.workspaceView.find('.achievements')).not.toExist()

  describe "when achievements is activated", ->
    it "should have configuration set up with defaults"

    waitsForPromise ->
      activationPromise

    runs ->
      expect(atom.config.get('achievements.NoticeDelay')).toBe(2500)
