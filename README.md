# Achievements!

Unlock Achievements in your Editor

![](https://f.cloud.github.com/assets/836375/2445108/65747512-ae6a-11e3-9f65-61b31c68d73d.png)

Install this *now* to opt-in to achievements from various packages. Earn EditorPoints,

**Package Developers**: Achievements can be submitted by any package using the `achievement:unlock` event.
This package takes care of storing the user's state of achievement so you don't have to.
Read on for more details!

## Grant Achievements to Your Users!

Achievements can be triggered using the `achievement:unlock` event:

```CoffeeScript
atom.emit "achievement:unlock",
  name: "So many scripts, so little time!"
  requirement: "Run a script while another is still running"
  category: "runners"
  package: "script"
  points: 200
  iconURL: "http://i.imgur.com/qRXoLmE.png"
```

:tada:

![](https://f.cloud.github.com/assets/836375/2444882/5a0fcf74-ae64-11e3-8b36-3307d7182014.png)

The name is what uniquely identifies the achievement.

### Message Spec v2

```
event - The {Object} event to process.
  :name        - The {String} message to display to the user.
                 Part of the key that uniquely identifies the achievement.
  :requirement - The {String} that says how the user achieved this
  :category    - The {String} category where it belongs with other
                 achievements (e.g. linting, git, ruby)
  :package     - The {String} package this event was emitted from.
                 Part of the key that uniquely identifies the achievement.
  :points      - The {Integer} number of points
  :iconURL     - The {String} URL of an icon to display for the user, which
                 can be base64 encoded but must have a valid data prefix
                 such as "data:image/png;base64,". Optional, defaults to
                 spinning octocat.
```

Achievements are stored under key `{package}:{name}` within an associative array
of unlocked achievements.

## Configuration

Set how long the achievements banner lasts by changing the notice delay (in milliseconds).

![](https://f.cloud.github.com/assets/836375/2424719/6a9ca422-abab-11e3-925c-3a85f87b3bb1.png)

Emit events from your own packages to grant achievements to your users!

## ROADMAP

* Use the swirling octocat icon :white_check_mark:
* Populate achievement bar using a message :white_check_mark:
* Time achievements display out :white_check_mark:
* Add configuration for timer :white_check_mark:
* Create an event spec for triggering achievements :white_check_mark:
* Create some default achievements :white_check_mark:
* Store achievements so they're only earned once. (per user, per project?) :white_check_mark:
* Allow for a custom icon :white_check_mark:
