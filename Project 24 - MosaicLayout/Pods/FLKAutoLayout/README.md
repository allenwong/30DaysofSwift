FLKAutoLayout
=============

FLKAutoLayout is a category on UIView which makes it easy to setup layout constraints in code.

FLKAutoLayout creates simple constraints with a readable syntax and provides many convenience methods to setup more complex constraints between multiple views at once. It automatically adds the constraints to the nearest common superview of the views involved and sets the translatesAutoresizingMaskIntoConstraints property on those views to NO.

FLKAutoLayout provides methods on UIView *instances* for simple layout constraints like width and height or constraining an edge of one view to another. Furthermore it provides methods on the UIView *class* for more complex layout constraints where more than two views are involved.

For some examples of how to setup constraints please check the [example project](./Example/).

## Example

Let's assume we have a bunch of labels and an equal amount of textFields and we want to align them nicely in a grid like manner:

``` objective-c
// align the first label with its superview
[labels[0] alignTop:@"20" leading:@"20" toView:labels[0].superview];
// give it a minimum width of 200 and a maximum width of 300
[labels[0] constrainWidth:@">=200,<=300"];
// now constrain all labels to this size
[UIView alignLeadingAndTrailingEdgesOfViews:labels];
// space the labels out vertically with 10 points in between
[UIView spaceOutViewsVertically:labels predicate:@"10"];

// now let's take care of the text fields. 
// the first one has a fixed space of 20 to its label
[textFields[0] constrainLeadingSpaceToView:labels[0] predicate:@"20"];
// constrain the right edge to its superview with 20 points padding
[textFields[0] alignTrailingEdgeWithView:textFields[0].superview predicate:@"20"];
// constrain all other text fields to the same width
[UIView alignLeadingAndTrailingEdgesOfViews:textFields];
// and finally let's align the baseline of each label with the baseline of each text field
[UIView alignAttribute:NSLayoutAttributeBaseline ofViews:labels toViews:textFields predicate:nil];
```


## FLKAutoLayout instance methods

FLKAutoLayout extends UIView instances with methods to setup simple constraints in a readable form.

Aligning edges of one view to another:

``` objective-c
 // constrain the leading edge of the view to the leading edge of another
[view alignLeadingEdgeWithView:otherView predicate:nil];

 // same as before but use a 20 point offset
[view alignLeadingEdgeWithView:otherView predicate:@"20"];

 // same as before but give this constraint a priority of 750
[view alignLeadingEdgeWithView:otherView predicate:@"20@750"];

// aligning some other edge types
[view alignTopEdgeWithView:otherView predicate:nil];
[view alignBottomEdgeWithView:otherView predicate:nil];
[view alignTrailingEdgeWithView:otherView predicate:nil];
[view alignBaselineWithView:otherView predicate:nil];
[view alignCenterXWithView:otherView predicate:nil];
[view alignCenterYWithView:otherView predicate:nil];

// centering two views
[view alignCenterWithView:otherView];
```

Constraining view to another:
``` objective-c
// constrain leading edge of the view to the trailing edge of the other
 [view constrainLeadingSpaceToView:otherView predicate:@"0"];

 // constrain trailing edge of the view to the leading edge of the other
 [view constrainTrailingSpaceToView:otherView predicate:@"0"];

 // constrain top edge of the view to the bottom edge of the other
 [view constrainTopSpaceToView:otherView predicate:@"0"];

 // constrain bottom edge of the view to the top edge of the other
 [view constrainBottomSpaceToView:otherView predicate:@"0"];
```

Constraining width & height:

``` objective-c
[view constrainWidth:@"400"];
[view constrainHeight:@"300"];
// or combined:
[view constrainWidth:@"400" height:@"300"];
// or relative to another view
[view constrainWidthToView:otherView predicate:@"*.3"]; // 30% of otherView's width
[view constrainHeightToView:otherView predicate:@">=*.5"]; // at least 50% of otherView's height
```

Spacing out two views:

``` objective-c
// creating a >=20 points space between the top edge of one view to the bottom edge of the other
[view constrainTopSpaceToView:otherView predicate:@">=20"];
// creating a >=20 points space between the leading edge of one view to the trailing edge of the other
[view constrainLeadingSpaceToView:otherView predicate:@">=20"];
```

If you need more control over which layout attribute of one view should be constrained to which layout attribute of another view,
you can use a generic helper method:

``` objective-c
[view alignAttribute:NSLayoutAttributeCenterX to Attribute:NSLayoutAttributeTrailing ofView:otherView predicate:@"20"];
```

## FLKAutoLayout class methods

For laying out more than two views at once FLKAutoLayout provides extends UIView with some class methods.

Align multiple views at once:

``` objective-c
// align all views in the views array along their leading edge
[UIView alignLeadingEdgesOfViews:views];
// align all views in the views array along their bottom edge
[UIView alignBottomEdgesOfViews:views];
// see UIView+FLKAutoLayout.h for more...
```

Constrain width and height of multiple views:

``` objective-c
// constrain all views to the same height
[UIView equalHeightForViews:views];
// constrain all views to the same width
[UIView equalWidthForViews:views];
```

Spacing out multiple views:

``` objective-c
// space out views horizontally with 20 points in between
[UIView spaceOutViewsHorizontally:views predicate:@"20"];
// space out views vertically with no space in between
[UIView spaceOutViewsVertically:views predicate:nil];

// Distribute views according to their horizontal center
[UIView distributeCenterXOfViews:views inView:containerView];
// Distribute views according to their vertical center
[UIView distributeCenterYOfViews:views inView:containerView];
```

Please note that distributing views at their centers will line up the center of the first view at the edge of the container view.


### The predicate argument

Many of the methods take a predicate string which resembles the syntax Apple uses in their visual format language,
extended by the possibiliy to also specify a multiplier. A nil predicate is the same as @"0".

[ == | >= | <= ] [ *multipler ] [ constant ] [ @priority ], ...

For example:

``` objective-c
// greater than or equal to 300points, small then 500 points
[view constrainWidth:@">=300,<=500"];
// equal to 300 points
[view constrainWidth:@"300"];
// greater than or equal to 300 points with priority of 250
[view constrainWidth:@">=300@250"];

// greater than or equal to 1/2 of the otherView width
[view constrainWidthToView:otherView predicate:@">=*.5"];
// greater than or equal to 1/2 of the otherView width, smaller than or equal to 600 points with a priority of 100
[view constrainWidthToView:otherView predicate:@">=*.5,<=600@100"];
```


## Creator

[Florian Kugler](http://floriankugler.de) ([@floriankugler](https://twitter.com/floriankugler)).

## License

FLKAutoLayout is available under the MIT license. See the LICENSE file for more info.
