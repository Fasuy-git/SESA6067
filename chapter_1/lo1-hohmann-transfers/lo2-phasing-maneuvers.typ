#import "../../template.typ": *

== Phasing Manuevers

The goal of a phasing maneuver is to *change the true anomaly* of a satellite *without changing the orbit* itself. This is useful for *rendezvous missions* or *repositioning* two satellites in the same orbit. The complexity of this problem is that changing the velocity of the orbit changes the orbit itself. The goal for such a maneuver is shown in *@2-phasing-manuever-goal*

#figure(
  grid(
    columns: 2,
    column-gutter: 1cm,
    [#cetz.canvas({
      import cetz.draw: *

      // Define constants
      let r_p = 1.25
      let r_a = 4
      let e = (r_a - r_p) / (r_a + r_p)

      //Plot orbit
      orbit(0, 0, r_p, e)

      // Plot Satellite

      // Earth
      cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")
      satellite(0, 0, r_p, e, 75deg, connecting_line: true, color: aqua)
      satellite(0, 0, r_p, e, -75deg, connecting_line: true, color: green)
    })],
    [#cetz.canvas({
      import cetz.draw: *

      // Define constants
      let r_p = 1.25
      let r_a = 4
      let e = (r_a - r_p) / (r_a + r_p)

      //Plot orbit
      orbit(0, 0, r_p, e)

      // Plot Satellite

      // Earth
      cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")
      satellite(0, 0, r_p, e, 75deg, connecting_line: true, color: aqua)
      satellite(0, 0, r_p, e, 50deg, connecting_line: true, color: green)
    })],
  ),
  caption: [Schematic diagram showing the orbit of two satellites before [Left] and after [Right] a phasing maneuver.],
  supplement: [Figure],
  kind: figure,
) <2-phasing-manuever-goal>

One possible solution for this problem is using a *Lambert Solver* which will give a valid orbit between two points. However, this will often yield an orbit which will be expensive in terms of $Delta v$.

Instead a *Hohmann Transfer* is used. If the orbit is rased relative to the original orbit then this introduces a lag and vice versa for lowering the orbit. Such a manuever is shown in *@2-phasing-manuever-hohmann*.

#figure(
  cetz.canvas({
    import cetz.draw: *

    // Define constants
    let r_p = 1.25
    let r_a = 4
    let r_a_1 = r_a * 1.5
    let r_a_2 = r_a * 0.5
    let e = (r_a - r_p) / (r_a + r_p)
    let e_1 = (r_a_1 - r_p) / (r_a_1 + r_p)
    let e_2 = (r_a_2 - r_p) / (r_a_2 + r_p)

    // Earth
    cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

    //Plot orbits
    orbit(0, 0, r_p, e)
    orbit(0, 0, r_p, e_1, dash_type: "dotted")
    orbit(0, 0, r_p, e_2, dash_type: "dotted")

    // Add notes
    content((-7.5, 0), [Increasing $a$ \ shifts back $theta$])
    content((3, 0), [Decreasing $a$ \ shifts forward $theta$.])
  }),
  caption: [Schematic diagram showing the effect of increasing and decreasing the semi major axis.],
  supplement: [Figure],
  kind: figure,
) <2-phasing-manuever-hohmann>

To calculate the $Delta v$ of such a maneuver the following steps can be used:

+ Calculate time period $T$ of phasing orbit:
  - Determine the change in time needed to get the object from its current $theta$ to the desired theta. *@2-phasing-manuever-eq-1* can be used.

  $
    Delta t = T markhl(plus.minus, tag: #<1>) t(theta = theta_0 -> theta = theta_1)
    #annot((<1>), pos: bottom, dy: 0.5em, dx: 1em, leader-connect: "elbow")[$+$ to increase $theta$ \ $-$ to decrease $theta$]
  $<2-phasing-manuever-eq-1>
  - Set the time period of the phasing orbit ($T_"Phasing"$) as multiples of $Delta t$ depending on the required number of phasing orbits ($arrow.t n -> arrow.b Delta v_"Phasing"$).
  $
    T_"phasing" = n Delta t
  $
+ Compute the semi major axis of the phasing orbit:
  - This can be done by using a modified form of the orbital period equation, shown in *@2-phasing-manuever-eq-2*.
  $
    T = 2 pi sqrt(a^3 /mu) quad -> quad a = ((T sqrt(mu))/(2 pi))^(3/2)
  $<2-phasing-manuever-eq-2>
+ Compute the radius perigee or radius apogee using the semi major axis:
  - The phasing burn must take place at $r_p$ or $r_a$ of the original orbit so *@2-phasing-manuever-eq-3* can be used to calculate the other orbital parameter of the phasing orbit.
  $
    2a = r_p + r_a
  $<2-phasing-manuever-eq-3>

+ Use the Hohmann transfer equation to calculate $Delta v_"Phasing"$ (Note that burn is symmetric so $Delta v_"Total" = 2 Delta v_"Phasing"$).

== Non-Hohmann Transfers

Whilst being *less efficient* Non-Hohmann transfers allow for more complex manuevers such as moving between any two points on an orbit and moving between any two orbits. These maneuvers are more costly as the $Delta v$ vector is not only scaled but also rotated.

If two orbits are intersect at least once then *only one burn* is needed to move between them. Non intersecting orbits require multiple burns as well as optimizations of starting points, end points and flight times.

=== Apse Line Rotation

The apse line is a straight line which connects together the apogee and perigee of an orbit. Rotating the Apse line of an orbit is an example of a non-Hohmann transfer. The derivation for the *required $Delta v$* for this manuever (including an optional shape change of the destination orbit) is shown below, starting with *@2-apse-line-rot-figure*.

#let compression_perc_3 = 94%

#figure(
  cetz.canvas({
    import cetz.draw: *

    scale(y: compression_perc_3, x: compression_perc_3)

    // Define constants
    let r_p = 1.25
    let r_a = 5
    let e = (r_a - r_p) / (r_a + r_p)

    // Earth
    cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

    //Plot origin orbit
    orbit(0, 0, r_p, e)

    //Plot destination orbit
    orbit(0, 0, r_p, e, inclination: -135deg)

    // Plot Apse Lines
    cetz.draw.line((-6, 0), (5, 0), stroke: (dash: "dashed"), name: "Apse_Line_1")
    cetz.draw.rotate(z: 90deg + 135deg)
    cetz.draw.line((-5.5, 0), (4, 0), stroke: (dash: "dashed"), name: "Apse_Line_2")
    cetz.draw.rotate(z: -90deg - 135deg)

    // Plot intersection line
    let thetatt = 22deg
    cetz.draw.rotate(z: 90deg + thetatt)
    cetz.draw.line((-1.7, 0), (2.7, 0), stroke: (dash: "dotted"), name: "intersection_line")
    cetz.draw.rotate(z: -90deg - thetatt)

    // Plot Eta Arc Line
    cetz.draw.arc(
      (0, 0),
      start: 0deg,
      stop: -135deg,
      radius: 2.5,
      anchor: "origin",
      mark: (
        end: ">",
        fill: green,
        stroke: (paint: green),
      ),
      stroke: (paint: green, thickness: 1.5pt),
    )

    // Plot Theta 1 line
    cetz.draw.arc(
      (0, 0),
      start: 112deg,
      stop: 0deg,
      radius: 1.5,
      anchor: "origin",
      mark: (
        start: ">",
        fill: red,
        stroke: (paint: red),
      ),
      stroke: (paint: red, thickness: 1.5pt),
    )

    // Plot Theta 2 line
    cetz.draw.arc(
      (0, 0),
      start: 112deg,
      stop: -135deg,
      radius: 2,
      anchor: "origin",
      mark: (
        start: ">",
        fill: blue,
        stroke: (paint: blue),
      ),
      stroke: (paint: blue, thickness: 1.5pt),
    )

    //Plot velocity vector #1, #2 and Delta v
    let r = orbit_radius(r_p, e, 112.5deg)
    let thetat = 112.5deg

    cetz.draw.line(
      (thetat, r),
      (-2.5, 2.8),
      mark: (
        end: ">",
        fill: orange,
        stroke: (paint: orange),
      ),
      stroke: (paint: orange, thickness: 1.5pt),
    )

    cetz.draw.line(
      (thetat, r),
      (-1.7, 1),
      mark: (
        end: ">",
        fill: yellow,
        stroke: (paint: yellow),
      ),
      stroke: (paint: yellow, thickness: 1.5pt),
    )

    cetz.draw.line(
      (-2.5, 2.8),
      (-1.7, 1),
      mark: (
        end: ">",
        fill: purple,
        stroke: (paint: purple),
      ),
      stroke: (paint: purple, thickness: 1.5pt),
    )

    // Plot Location of intersection points
    satellite(0, 0, r_p, e, 112.5deg, sat_radius: 0.1, color: white) // Intersection #1
    satellite(0, 0, r_p, e, -68deg, sat_radius: 0.1, color: white) // Intersection #2

    // Apse Line Notes
    cetz.draw.content((4.5, -0.75), [*Apse Line \ Orbit 1*])
    cetz.draw.content((5, 3.5), [*Apse Line \ Orbit 2*])

    // Angle Notes
    cetz.draw.content((2, -2), text(green)[*$eta$*])
    cetz.draw.content((0.3, 1.2), text(red)[*$theta_1$*])
    cetz.draw.content((2.2, 1), text(blue)[*$theta_2$*])

    // Velocity Notes
    cetz.draw.content((-1.6, 3), text(orange)[*$V_1$*])
    cetz.draw.content((-0.9, 1.5), text(yellow)[*$V_2$*])
    cetz.draw.content((-2.75, 1.6), text(purple)[*$Delta v$*])
  }),
  caption: [Schematic diagram showing an apse line rotation.],
  supplement: [Figure],
  kind: figure,
) <2-apse-line-rot-figure>

The first step in calculating the $Delta v$ of such a maneuver is to find the location of the intersection points, this is done in *@2-apse-line-rot-der-1*

$
  eta = theta_1 - theta_2 quad therefore quad theta_1 = eta + theta_2 quad theta_2 = theta_1 - eta \
  r_"intersection" = (h_1^2 "/" mu)/(1 + e_1cos(theta_1)) = (h_2^2 "/" mu)/(1 + e_2cos(theta_2))
$<2-apse-line-rot-der-1>

After rewriting $theta_2$ in terms of $theta_1$ and $eta$, cross multiplying and simplifying, *@2-apse-line-rot-der-1* can be simplified into *@2-apse-line-rot-der-2*.

$
  h_1^2 - h_2^2 = -h_1^2 e_2 cos(theta_1 - eta) + h_2^2 e_1 cos(theta_1)
$<2-apse-line-rot-der-2>

*@2-apse-line-rot-der-2* can be further simplified by separating out $cos(theta_1 - eta)$ using the angle difference equation and then rewriting the equation, grouping together terms in terms of $theta_1$, this is shown in *@2-apse-line-rot-der-3*.

$
  cos(theta_1 - eta) = cos(theta_1)cos(eta) + sin(theta_1)sin(eta)
  \
  therefore quad h_1^2 - h_2^2 = [e_1 h_2^2 - e_2 h_1^2 cos(eta)]cos(theta_1) + [-e_2 h_1^2 sin(eta)] sin(theta_1)
  \
  therefore quad a cos(theta_1) + b sin(theta_1) = c quad cases(
    a = e_1 h_2^2 - e_2 h_1^2 cos(eta),
    b = -e_2 h_1^2 sin(eta),
    c = h_1^2 - h_2^2
  )
$<2-apse-line-rot-der-3>

The equation shown at the end of *@2-apse-line-rot-der-3* has a general solution for $theta_1$, this is shown in *@2-apse-line-rot-der-4*

$
  theta_1 = phi.alt plus.minus arccos(c/a cos(phi.alt)) quad cases(
    a = e_1 h_2^2 - e_2 h_1^2 cos(eta),
    b = -e_2 h_1^2 sin(eta),
    c = h_1^2 - h_2^2,
    phi.alt = arctan(b/a)
  )
$<2-apse-line-rot-der-4>

Note that the *@2-apse-line-rot-der-4* generates two solutions as there are two intersections points and the equations themselves are general. Now that a general expression for the intersection points of the two obits has been determined, the velocity vector at this point in each orbit must be determined, this is done using the *flight path angle* (the angle between the velocity and the local horizon), shown in *@2-flight-path-angle-figure*.

#figure(
  image("images/1-flight-path-angle.png", width: 25%),
  caption: [Schematic diagram showing how the flight path angle ($gamma$), transverse velocity ($v_perp$) and radial velocity ($v_r$).],
  supplement: [Figure],
  kind: figure,
)<2-flight-path-angle-figure>

The equations for the flight path angle, transverse velocity and radial velocity are shown below in *@2-apse-line-rot-der-5*.

$
  gamma = arctan(v_r/ v_perp) quad quad v_perp = h/r quad quad v_r = mu/h e sin(theta) quad quad v = sqrt(v_r^2 + v_perp^2)
$<2-apse-line-rot-der-5>

The $Delta v$ of the manuever can then be determined by looking at teh triangle formed by the three velocity vectors, this section of the derivation is shown in *@2-apse-line-rot-der-6* and *@2-velocity-triangle-figure*.

#grid(
  columns: (0.4fr, 0.6fr),
  column-gutter: 1cm,
  [
    #figure(
      image("images/1-norm-delta_v.png", width: 80%),
      caption: [Schematic diagram showing how the velocity triangle formed by the $Delta v$, $v_1$ and $v_2$.],
      supplement: [Figure],
      kind: figure,
    )<2-velocity-triangle-figure>
  ],
  [#v(4em)
    $
      |Delta accent(v, ->)|^2 = |accent(v_2, ->) - accent(v_1, ->)|^2 = (accent(v_2, ->) - accent(v_1, ->)) dot (accent(v_2, ->) - accent(v_1, ->))\
      = |accent(v_1, ->)|^2 + |accent(v_2, ->)|^2 - 2 accent(v_1, ->) accent(v_2, ->) \
      = |accent(v_1, ->)|^2 + |accent(v_2, ->)|^2 - 2 |accent(v_1, ->)| |accent(v_2, ->)| cos(Delta gamma) \
      therefore Delta v = sqrt(v_2^2 + v_1^2 - 2 v_1 v_2 cos(gamma_2 - gamma_1))
    $<2-apse-line-rot-der-6>
  ],
)

Note that the final equation in *@2-apse-line-rot-der-6* for the $Delta v$ is the same as the cosine rule which is illustrated further by *@2-velocity-triangle-figure*. The key equations for an Apse line rotation maneuver are shown in *@2-apse-line-rot-der-7*.

$
  theta_1 = phi.alt plus.minus arccos(c/a cos(phi.alt)) quad cases(
    a = e_1 h_2^2 - e_2 h_1^2 cos(eta),
    b = -e_2 h_1^2 sin(eta),
    c = h_1^2 - h_2^2,
    phi.alt = arctan(b/a)
  ) \
  gamma = arctan(v_r/ v_perp) cases(
    v_perp = h/r,
    v_r = mu/h e sin(theta),
    v = sqrt(v_r^2 + v_perp^2)
  )
  quad quad
  Delta v = sqrt(v_2^2 + v_1^2 - 2 v_1 v_2 cos(gamma_2 - gamma_1))
$<2-apse-line-rot-der-7>

=== Special Case for the Apse Line Rotation

If the second orbit has an $eta$ angle of $0 degree$, $phi.alt$ = 0 and the equation reduce to the ones shown in  *@2-apse-line-case*.

$
  theta_1 = plus.minus arccos(c/a) = plus.minus arccos(( h_1^2 - h_2^2)/(e_1 h_2^2 - e_2 h_1^2))
$<2-apse-line-case>

This maneuver is shown visually in *@2-apse-line-case-fig*  where the second orbit is different. Note the orange line would be an equivalent Hohmann manuever. Despite the *Hohmann manuever being more efficient*, there may be cases where this apse line maneuver is nessicary (only one burn possible, restricted zones, time constraints).

#figure(
  image("images/1-apse-line-case.png", width: 40%),
  caption: [Schematic diagram showing an apse line manuever where $eta = 0 degree$ and the orbits are different.],
  supplement: [Figure],
  kind: figure,
)<2-apse-line-case-fig>

