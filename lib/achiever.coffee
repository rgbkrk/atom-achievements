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

    atom.on "achievement:unlock", @process_unlock
    

  #
  # Public: Process an achievement unlock event
  #
  # This method accepts the events passed by `achievement-unlock`.
  # Handles migrations from older specifications with sane defaults.
  #
  # event - The {Object} event to process.
  #   :name        - The {String} message to display to the user
  #   :requirement - The {String} that says how the user achieved this
  #   :category    - The {String} category where it belongs with other
  #                  achievements (e.g. linting, git, ruby)
  #   :package     - The {String} package this event was emitted from
  #   :points      - The {Integer} number of points
  #
  # Returns `undefined`.
  #
  process_unlock: (event) =>

    # Legacy handling
    if "msg" of event
      event.name = event.msg

    if not event.requirement?
      event.requirement = event.name

    if not event.category?
      event.category = "undefined"

    if not event.package?
      event.package = "undefined"

    if not event.points?
      event.points = 0 # :(

    @achieve(event.name, event.requirement, event.category, event.package,
             event.points)

  #
  # Public: Handle achievement
  #
  # name        - The {String} message to display to the user
  # requirement - The {String} that says how the user achieved this
  # category    - The {String} category where it belongs with other achievements
  #               (e.g. linting, git, ruby)
  # package     - The {String} package this event was emitted from
  # points      - The {Integer} number of points
  #
  # Returns `undefined`.
  #
  achieve: (name, requirement, category, package_name, points) ->
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
