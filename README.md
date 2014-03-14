# Achievements!

Unlock Achievements in your Editor

<!-- ![](https://f.cloud.github.com/assets/836375/2418076/1d50f6ca-ab36-11e3-98e7-539f18eba22a.gif) -->

![](https://f.cloud.github.com/assets/836375/2418108/0a402398-ab37-11e3-8111-e0f374079515.gif)

# Adding achievements

Achievements can be triggered using the `achievement:unlock` event:

```
atom.emit "achievement:unlock", msg: "Used a tutorial!"
```

## ROADMAP

* Use the swirling octocat icon :white_check_mark:
* Populate achievement bar using a message :white_check_mark:
* Time achievements display out :white_check_mark:
* Add configuration for timer :white_check_mark:
* Create an event spec for triggering achievements :white_check_mark:
* Create some default achievements :soon:
* Store achievements so they're only earned once. (per user, per project?)
