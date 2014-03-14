# Achievements!

Unlock Achievements in your Editor

![](https://f.cloud.github.com/assets/836375/2418108/0a402398-ab37-11e3-8111-e0f374079515.gif)

## Configuration

Set how long the achievements banner lasts by changing the notice delay (in milliseconds).

![](https://f.cloud.github.com/assets/836375/2424719/6a9ca422-abab-11e3-925c-3a85f87b3bb1.png)

## Adding achievements

Achievements can be triggered using the `achievement:unlock` event:

```
atom.emit "achievement:unlock", msg: "Used a tutorial!"
```

Emit events from your own packages to grant achievements to your users!

## ROADMAP

* Use the swirling octocat icon :white_check_mark:
* Populate achievement bar using a message :white_check_mark:
* Time achievements display out :white_check_mark:
* Add configuration for timer :white_check_mark:
* Create an event spec for triggering achievements :white_check_mark:
* Create some default achievements :soon:
* Store achievements so they're only earned once. (per user, per project?)
