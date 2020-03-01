How to choose a projection
================

I am: 1. a sea captain without access to GPS 2. a researcher 3. a
cartographer

If you chose (1): You should use a conventional mercator\! This
projection might distort everything close to the poles (really beyond
about 70 degrees north or south), but there’s so much ice you’d never
take your ship there anyways. This projection is conformal, which means
that no matter where you are, the horizontal and vertical scales will be
the same as each other (though not the same as the scales at other
latitudes). Additionally, straight lines on this map correspond to a
constant bearing.

If you chose (2) or (3): Think about the area you’re trying to map or
study. Is it: A. The whole world\! B. A continent, country, or state. C.
Something smaller than that.

If you said (A), you could do a lot worse than looking at [this XKCD
comic](https://xkcd.com/977/), which is to say you probably want
Robinson, Winkel-Tripel, or the one that looks like a peeled orange.

If you said (B), use the standard projection is for your selected
continent, country, state/province. Google should be pretty helpful
here. For California, I generally go with the [California
Albers](https://epsg.io/3310).

If you said (C), you should use a
[UTM](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system)
or State Plane zone for your study area. At this scale, the specific
choice doesn’t matter that much, as long as you choose something that
works’s appropriate for the area you’re working in.
