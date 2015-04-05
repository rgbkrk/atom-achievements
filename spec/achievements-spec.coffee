Achievements = require '../lib/achievements'
{WorkspaceView} = require 'atom-space-pen-views'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Achievements", ->
  activationPromise = null
  workspaceElement = null

  beforeEach ->
    # atom.workspaceView = new WorkspaceView
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('achievements')

  describe "when achievements is activated for the first time", ->
    it "has an achievement", ->

      waitsForPromise ->
        activationPromise

      checkIfAchivementsExists = () ->
        return workspaceElement.getElementsByClassName('achievements').length > 0

      runs ->
        expect(checkIfAchivementsExists()).toBe(true)
        window.setTimeout ->
          expect(checkIfAchivementsExists()).toBe(false)
        , atom.config.get('achievements.NoticeDelay')


  describe "when achievements is activated", ->
    it "should have configuration set up with defaults"

    waitsForPromise ->
      activationPromise

    runs ->
      expect(atom.config.get('achievements.NoticeDelay')).toBe(2500)
