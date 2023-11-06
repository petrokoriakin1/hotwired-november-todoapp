### Welcome to Petro Koriakin's ALKO worklog

```bash

alko init
# asks local git for the user.name
# asks local git for the user.email
# creates a file structure
# sends a welcome email and supstack subscription note


alko start
# creates a file structure if needed
# creates a commit

alko finish
# creates a file structure for tomorrow if needed
# creates a commit, pushes things
```

#### Boring Box Practice

The idea is to set the goal and trust the flow. Shallow activities are welcomed. Cook if you want, drink, eat. The boring box should be either `DONE` or `FAILED`. Key habit here is to remember the goal, and additional habits are starting box and finishing box. Possible outcomes: stats for better estimates.

```
git add . ;git commit -am "boringbox goal: "
git commit -am "finish boringbox: DONE"
git commit -am "finish boringbox: FAILED"
```

#### Pomodoro Slots Practice

Nothing special here - just regular pomodorro by Francesco Cirillo

```
Pomodoro #0
=======


Result
-------


Plan
-------


Details
-------




git log --format="%an (%ad): %h %s" --reverse -n 50

git commit --allow-empty -m "pause progress"

git add .; git commit -am "pause progress"; git push

```
