# Spinner
An activity indicator view. There are many like it, but this one is mine.

Usage is very simple. Check out the example project, or do something like this:

    import Spinner

    VISpinnerView.show(text: "Some text", in: self.view)

or

    VIToastView.show(text: "Some text", in: self.view)

The label will show, then fade after some time.

# Screenshot

![Screenshot](screenshot.png?raw=true "screenshot")

# Wish list
Some things are still missing:

* When calling repeatedly, the width of the background changes with the label
  length. This happens instantly, and it should be updated in an animated way.
* When the label is updated on an existing (visible) spinner/toastview, the
  label change should be animated.
