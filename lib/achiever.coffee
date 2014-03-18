AchievementsView = require './achievements-view'

module.exports =
class Achiever

  @version: 2

  @deserialize: (achieverState) ->
    #
    # TODO: In the future, we'll want to have a migration plan
    #       for @version changes
    #
    # Example:
    #
    # if(achieverState.version <= @version)
    #   # Do something different with this lesser versioned state
    #   # Could start over

    if(achieverState.unlockedAchievements?)
      achiever = new Achiever(achieverState.unlockedAchievements)
    else
      achiever = new Achiever()

    return achiever

  constructor: (@unlockedAchievements={}) ->
    @achievementsView = new AchievementsView() #(state.achievementsViewState)

    atom.on "achievement:unlock", process_unlock

  # Public: Process an achievement unlock event
  #
  # This method accepts the events passed by `achievement-unlock`.
  # Handles migrations from older specifications with sane defaults.
  #
  # event - The event to process.
  #   :name - Message to display to the user
  #   :requirement - How the user achieved this
  #   :category - Where to list it among other achievements (linting, git, ruby)
  #   :package - The package this event was emitted from
  #   :points - Number of points
  #
  # Returns `undefined`.
  process_unlock: (event) =>

    # Legacy handling
    if "msg" of event
      event.name = event.msg

    if not event.requirement?
      event.requirement = event.name

    if not event.category?
      event.category = "Undefined"

    if not event.package?
      event.package = "Undefined"

    if not event.points?
      event.points = 0 # :(

    achieve(event.name, event.requirement, event.category, event.package,
            event.points)

  achieve: (name, requirement, category, package, points) ->
    # TODO: Queue these up in case there are more than one achievement to
    #       display in a short period of time
    if(not @unlockedAchievements[name])
      @unlockedAchievements[name] = true
      @achievementsView.achieve(name)
    else
      # Already achieved it

  serialize: ->
    obj =
      deserializer: 'Achiever'
      version: Achiever.version
      unlockedAchievements: @unlockedAchievements

  destroy: ->
    # Pass on to destroy the view
    @achievementsView.destroy()
