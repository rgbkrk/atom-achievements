AchievementsView = require './achievements-view'

module.exports =
class Achiever

  @version: 3

  #
  # Public: Turn a serialized achieverState into an {Achiever}.
  #
  # This method turns an achieverState into an {Achiever} instance, making sure
  # to migrate the object to the current version spec.
  #
  # achieverState - The {Object} state of an {Achiever} as created by the
  #                 serialize {Function}.
  #
  # Returns an {Achiever}.
  #
  @deserialize: (achieverState) ->

    if(achieverState.unlockedAchievements?)
      unlockedAchievements = null
      if(achieverState.version < @version)
        console.log("Migrating achievements to latest version...")
        unlockedAchievements = @migrateTov3(achieverState.unlockedAchievements)
        console.log("...Done. Achievements fully migrated.")
      else
        unlockedAchievements = achieverState.unlockedAchievements

      achiever = new Achiever(unlockedAchievements)

    else
      achiever = new Achiever()

    return achiever

  @migrateTov3: (unlockedAchievements) ->
    newUnlockedAchievements = {}
    for msg, val of unlockedAchievements
      newUnlockedAchievements[msg] =
        requirement: msg
        category: "undefined"
        package: "undefined"
        points: 0 # :(

    return newUnlockedAchievements

  constructor: (@unlockedAchievements={}) ->
    @achievementsView = new AchievementsView() #(state.achievementsViewState)

    atom.on "achievement:unlock", @processUnlock


  #
  # Public: Process an achievement unlock event
  #
  # This method accepts the events passed by `achievement-unlock`.
  # Handles migrations from older specifications with sane defaults.
  #
  # event - The {Object} event to process.
  #   :name        - The {String} message to display to the user.  Uniquely identifies the achievement.
  #   :requirement - The {String} that says how the user achieved this.
  #   :category    - The {String} category where it belongs with other
  #                  achievements (e.g. linting, git, ruby).
  #   :package     - The {String} package this event was emitted from.
  #   :points      - The {Integer} number of points.
  #   :iconURL     - The {String} URL of an icon to display for the user, which
  #                  can be base64 encoded but must have a valid data prefix
  #                  such as "data:image/png;base64,". Optional, defaults to
  #                  spinning octocat.
  #
  # Returns `undefined`.
  #
  processUnlock: (event) =>

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

    if not event.iconURL?
      event.iconURL = "images/octocat-spinner-128.gif"

    @achieve(event.name, event.requirement, event.category, event.package,
             event.points, event.iconURL)

  #
  # Public: Handle achievement
  #
  # name        - The {String} message to display to the user.  Uniquely identifies the achievement.
  # requirement - The {String} that says how the user achieved this.
  # category    - The {String} category where it belongs with other achievements.
  #               (e.g. linting, git, ruby)
  # package     - The {String} package this event was emitted from.
  # points      - The {Integer} number of points.
  # iconURL     - The {String} URL of an image to show next to the achievement.
  #
  # Returns `undefined`.
  #
  achieve: (name, requirement, category, package_name, points, iconURL) ->
    # TODO: Queue these up in case there are more than one achievement to
    #       display in a short period of time
    if(not @unlockedAchievements[name])
      @unlockedAchievements[name] =
        requirement: requirement
        category: category
        package: package_name
        points: points
        iconURL: iconURL

      @achievementsView.achieve(name, iconURL)
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
