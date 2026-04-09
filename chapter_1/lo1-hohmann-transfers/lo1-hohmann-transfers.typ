#import "../../template.typ": *

== Hohmann Transfers

A Hohmann transfer is a form of co-planar manuever that can be used to raise or lower an orbit. These types of manuevers are typically used during launch to increase the height of an orbit to the desired altitude.

=== Circular Hohmann Transfer

A circular Hohmann transfer is used to move between two circular orbits via one intermediate elliptical orbit. The derivation for the orbital velocities of each obit can be done via the angular momenta of each orbit. To start with a diagram of a circular Hohmann transfer is shown in *@1-circular-hohmann*.


#figure(
  cetz.canvas({
    import cetz.draw: *

    // Define constants
    let r_p = 1.5
    let r_a = 2.5
    let r_p_angle = 180deg
    let r_a_angle = 0deg

    // Earth
    cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

    // Lower Orbit and Arrow
    orbit(0, 0, r_p, 0)
    cetz.draw.line((0.1, 0), (-r_p, 0), mark: (
      start: "o",
      end: ">",
      fill: black,
    ))
    cetz.draw.content((-r_p * 1.25, 0), [*$r_p$*])

    // Higher Orbit
    orbit(0, 0, r_a, 0)
    cetz.draw.line((-0.1, 0), (r_a, 0), mark: (
      start: "o",
      end: ">",
      fill: black,
    ))
    cetz.draw.content((r_a * 1.15, 0), [*$r_a$*])

    // Elliptical Orbit
    let e = (r_a - r_p) / (r_a + r_p)
    orbit(0, 0, r_p, e, dash_type: "dashed", initial_angle: 180, final_angle: 360)
  }),
  caption: [Schematic diagram of a circular Hohmann Transfer.],
  supplement: [Figure],
  kind: figure,
) <1-circular-hohmann>

In order to calculate the $Delta V$ required for the two burns in this manuever the polar orbit equation can be used, shown in *@1-hohmann-derivation-1*, note that at perigee for the elliptical transfer orbit $theta = 0 degree$

$
  r =p/(1 + e cos(theta)) =(a(1-e^2))/(1 + e cos(theta))=(h^2"/"mu)/(1 + e cos(theta))
  quad --> quad
  r_p = (h^2"/"mu)/(1 + e)
$<1-hohmann-derivation-1>

The expression in *@1-hohmann-derivation-1* can be combined with the eccentricity equation shown in *@1-hohmann-derivation-2*.

$
  e = (r_a - r_p)/(r_a + r_p)
$<1-hohmann-derivation-2>

Combining both expressions *@1-hohmann-derivation-1* and *@1-hohmann-derivation-2* yield the following expression shown in *@1-hohmann-derivation-3*.

$
  r_p = (a(1-e^2))/(1 + e) quad e = (r_a - r_p)/(r_a + r_p) quad --> quad h = sqrt(2 mu (r_a r_p)/(r_a + r_p))
$<1-hohmann-derivation-3>

Where $h$ is the specific angular momentum ($m^2 s^(-1)$)  of the orbit and $r_p$ and $r_a$ are the radius at perigee and apogee shown in *@1-circular-hohmann*. Now consider the general expression for specific angular momentum shown in *@1-hohmann-derivation-4*.

$
  h = accent(r, ->) times accent(v, ->) = r v sin(phi.alt)
$<1-hohmann-derivation-4>

Where $accent(r, ->)$ and $accent(v, ->)$ are the position and velocity vectors and the angle $phi.alt$ is the angle between these two vectors. Importantly, $phi.alt = 0 degree$ *at the apogee and perigee points in the elliptical transfer orbit*. Combining *@1-hohmann-derivation-3* and *@1-hohmann-derivation-4* the velocities at $r_p$ and $r_a$ can be written in the form shown in *@1-hohmann-derivation-5*.

$
  v_a = h/r_a quad v_p = h/r_p quad "Where" h = sqrt(2 mu (r_a r_p)/(r_a + r_p))
$<1-hohmann-derivation-5>

Note that if $r_p = r_a$, meaning the transfer orbit is circular, then the expression simplifies to the following known expressions for circular orbits, shown in *@1-hohmann-derivation-6*.

$
  "If" r_a = r_p = r quad "Then" quad h = sqrt(mu r) quad v = sqrt(mu/r)
$<1-hohmann-derivation-6>

=== Elliptical Hohmann Transfer

The derivation on the previous page is *not specific to circular orbits* as all of the equations used are general orbital equations. For this reason the equations can also be used for *transferring between two elliptical orbits* given they are coaxial (the Apse line of both orbits is the same).

However, there is a caveat in that it is not initially clear which transfer orbit is the most efficient. This is exacerbated if the two orbits are not in the same direction. This scenario would require calculating the deltaV of all 4 possible orbits (2 transfer orbits in each direction). The two possible orbits are shown in *@1-elliptical-hohmann*.

#let compression_perc_1 = 80%
#figure(
  cetz.canvas({
    import cetz.draw: *
    scale(y: compression_perc_1, x: compression_perc_1)

    // Define constants for orbits
    let r_p_1 = 1.1 // Perigee of Lower Orbit
    let r_a_1 = 2 // Apogee of Upper Orbit
    let r_p_2 = 2.3 // Perigee of Lower Orbit
    let r_a_2 = 3 // Apogee of Upper Orbit

    // Calculate key parameters
    let e_1 = (r_a_1 - r_p_1) / (r_a_1 + r_p_1)
    let e_2 = (r_a_2 - r_p_2) / (r_a_2 + r_p_2)
    let e_3 = (r_a_2 - r_a_1) / (r_a_2 + r_a_1)
    let e_4 = (r_p_2 - r_p_1) / (r_p_2 + r_p_1)

    // Earth
    cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

    // Transfer Orbit #1
    orbit(
      0,
      0,
      r_a_1,
      e_3,
      inclination: 270deg,
      dash_type: "dashed",
      color: orange,
      mark_color: orange,
      width: 2pt,
      initial_angle: 180,
      final_angle: 360,
    )

    // Transfer Orbit #2
    orbit(
      0,
      0,
      r_p_1,
      e_4,
      dash_type: "dashed",
      color: green,
      mark_color: green,
      width: 2pt,
      initial_angle: 180,
      final_angle: 360,
    )

    // Lower and Higher Orbits
    orbit(0, 0, r_p_1, e_1)
    orbit(0, 0, r_p_2, e_2, inclination: 270deg)

    // Apse Line
    cetz.draw.line((-3.5, 0), (8, 0), stroke: (dash: "dashed"))
    cetz.draw.content((5, -0.4), [*Apse Line*])
  }),
  caption: [Schematic diagram of elliptical Hohmann transfers.],
  supplement: [Figure],
  kind: figure,
) <1-elliptical-hohmann>

=== Parabolic and Hyperbolic Hohmann Transfer

The same equations can also be used for transferring between an elliptical/circular orbit to a hyperbolic or parabolic orbit. Note that both of the orbits must lie on the same apse line as one another, examples of these types of orbit are shown in *@1-parabolic-hyperbolic-hohmann*.

#let compression_perc_2 = 67%
#figure(
  grid(
    columns: 2,
    column-gutter: 1cm,
    [#cetz.canvas({
      import cetz.draw: *

      scale(y: compression_perc_2, x: compression_perc_2)

      // Define constants
      let r = 1.5
      let r_parabolic = 2
      let parabolic_theta = 80

      // Calculations
      let e_1 = (r_parabolic - r) / (r_parabolic + r)

      // Earth
      cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

      // Transfer Orbit
      orbit(
        0,
        0,
        r,
        e_1,
        inclination: 180deg,
        initial_angle: 180,
        final_angle: 360,
        dash_type: "dashed",
        color: blue,
        mark_color: blue,
        width: 2pt,
      )

      // Circular lower orbit
      orbit(0, 0, r, 0)

      // Parabolic Orbit
      orbit(0, 0, r_parabolic, 1, initial_angle: -parabolic_theta, final_angle: parabolic_theta, inclination: 0deg)

      // Apse Line
      cetz.draw.line((0, -2), (0, 3), stroke: (dash: "dashed"))
    })],
    [#cetz.canvas({
      import cetz.draw: *

      scale(y: compression_perc_2, x: compression_perc_2)

      // Define constants
      let r = 1.5
      let r_hyperbolic = 2
      let hyperbolic_theta = 80

      // Calculations
      let e_1 = (r_hyperbolic - r) / (r_hyperbolic + r)

      // Earth
      cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

      // Transfer Orbit
      orbit(
        0,
        0,
        r,
        e_1,
        inclination: 180deg,
        initial_angle: 180,
        final_angle: 360,
        dash_type: "dashed",
        color: blue,
        mark_color: blue,
        width: 2pt,
      )

      // Circular lower orbit
      orbit(0, 0, r, 0)

      // Parabolic Orbit
      orbit(0, 0, r_hyperbolic, 2, initial_angle: -hyperbolic_theta, final_angle: hyperbolic_theta, inclination: 0deg)

      // Apse Line
      cetz.draw.line((0, -2), (0, 3), stroke: (dash: "dashed"))
    })],
  ),

  caption: [Schematic diagram of parabolic Hohmann transfer [Left] and hyperbolic Hohmann transfer [Right].],
  supplement: [Figure],
  kind: figure,
) <1-parabolic-hyperbolic-hohmann>

#pagebreak()

=== Bi-elliptic Hohmann Transfer

If the maximum number of burns is increased to three, then in some cases the *bi-elliptic Hohmann transfer* may be more efficient than a basic Hohmann transfer. This type of manuever is shown in *@1-bielliptic-hohmann*

#figure(
  cetz.canvas({
    import cetz.draw: *

    // Define constants for orbits
    let r_a = 1.5 // Radius of Lower Orbit
    let r_b = 3 // Radius of Higher Orbit
    let r_c = 5 // Radius of Intermediate Orbit

    // Calculate key parameters
    let e_1 = (r_c - r_a) / (r_c + r_a)
    let e_2 = (r_c - r_b) / (r_c + r_b)

    // Earth
    cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

    // Letter Identifiers
    cetz.draw.content((r_a * 1.2, -0.3), [*A*])
    cetz.draw.content((r_c * -1.05, -0.3), [*B*])
    cetz.draw.content((r_b * 1.1, -0.3), [*C*])


    // Lower Orbit
    orbit(
      0,
      0,
      r_a,
      0,
    )

    // Higher Orbit
    orbit(
      0,
      0,
      r_b,
      0,
    )


    // Transfer Orbit #1
    orbit(
      0,
      0,
      r_a,
      e_1,
      dash_type: "dashed",
      color: green,
      mark_color: green,
      width: 2pt,
      initial_angle: 180,
      final_angle: 360,
    )

    // Transfer Orbit #2
    orbit(
      0,
      0,
      r_b,
      e_2,
      dash_type: "dashed",
      color: blue,
      mark_color: blue,
      width: 2pt,
      initial_angle: 0,
      final_angle: 180,
      inclination: 90deg,
    )

    // Apse Line
    cetz.draw.line((-6, 0), (4, 0), stroke: (dash: "dashed"))
    cetz.draw.content((4.7, 0.3), [*Apse Line*])

    //  Measurement Line r_a
    let y_1 = -3.5

    cetz.draw.line((0, y_1), (r_a, y_1), mark: (start: ">", end: ">", scale: 1, fill: black))
    cetz.draw.line(
      (0, 0),
      (0, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )
    cetz.draw.line(
      (r_a, 0),
      (r_a, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )

    cetz.draw.content((0.75, -3.8), [*$r_A$*])

    //  Measurement Line r_b
    let y_1 = -4.5

    cetz.draw.line((0, y_1), (r_b, y_1), mark: (start: ">", end: ">", scale: 1, fill: black))
    cetz.draw.line(
      (0, 0),
      (0, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )
    cetz.draw.line(
      (r_b, 0),
      (r_b, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )

    cetz.draw.content((1.5, -4.8), [*$r_C$*])

    //  Measurement Line r_c
    let y_1 = -4.5

    cetz.draw.line((0, y_1), (-r_c, y_1), mark: (start: ">", end: ">", scale: 1, fill: black))
    cetz.draw.line(
      (0, 0),
      (0, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )
    cetz.draw.line(
      (-r_c, 0),
      (-r_c, y_1 - 0.2),
      mark: (start: "o", scale: 1, fill: black, anchor: "center"),
      dash_type: "dashed",
      stroke: (
        dash: "loosely-dotted",
      ),
    )

    cetz.draw.content((-2.5, -4.8), [*$r_B$*])
  }),
  caption: [Schematic diagram of bi-elliptic Hohmann transfer.],
  supplement: [Figure],
  kind: figure,
) <1-bielliptic-hohmann>

As $r_b$ goes to infinity, the $Delta V$ required at *B* goes to zero, allowing for a cheaper burn.  However, a bi-elliptic Hohmann transfer is not always more efficient and so a derivation is required.

To start with, it is observed there are two transfer orbits $T_1$ from $A -> B$ and $T_2$ from $B -> C$, the perigee and apogee radii of these two transfer orbits is shown in *@1-bielliptic-derivation-1*.

$
  T_1 cases(r_a = r_B, r_p = r_A) quad quad T_2 cases(r_a = r_C, r_p = r_B)
$<1-bielliptic-derivation-1>

From these definitions the change in velocity at point *A* ($Delta V_A$) can be calculated and is shown in *@1-bielliptic-derivation-2* (Note, $V_0$ = velocity in origin orbit, $V_1$ = perigee velocity in $T_1$).

$
  V_0 = sqrt(mu/ r_A) quad quad V_1 = h/r_p = 1/r_p sqrt(2 mu (r_a r_p)/(r_a + r_p)) = sqrt(2 mu/r_p^2 (r_a r_p)/(r_a + r_p)) = sqrt(2 mu/r_A (r_B)/(r_A + r_B))
  \
  Delta V_A = V_1 - V_0 = sqrt(2 mu/r_A (r_B)/(r_A + r_B)) - sqrt(mu/ r_A) = sqrt(mu/ r_A) [sqrt(2 (r_B)/(r_A + r_B)) - 1]
  \
  therefore Delta V_A = V_0 [sqrt(2 (r_B)/(r_A + r_B)) - 1] quad "Where" V_0 = sqrt(mu/ r_A)
$<1-bielliptic-derivation-2>

The derivation for the change in velocity at point *B* ($Delta V_B$) can be determined similarly, and is shown in *@1-bielliptic-derivation-3* (Note, $V_1$ = apogee velocity in $T_1$, $V_2$ = apogee velocity in $T_2$).

$
  V_1 = h/r_a = sqrt(2 mu/r_B (r_A)/(r_A + r_B)) quad quad
  V_2 = h/r_a = sqrt(2 mu/r_B (r_C)/(r_C + r_B)) \
  Delta V_B = V_2 - V_1 = sqrt(2 mu/r_B (r_C)/(r_C + r_B)) - sqrt(2 mu/r_B (r_A)/(r_A + r_B))\
  therefore Delta V_B = sqrt(2 mu/r_B) [sqrt((r_C)/(r_C + r_B)) - sqrt((r_A)/(r_A + r_B))]
$<1-bielliptic-derivation-3>

The derivation for the change in velocity at point *C* ($Delta V_C$) can be determined similarly, and is shown in *@1-bielliptic-derivation-4* (Note, $V_2$ = perigee velocity in $T_2$, $V_3$ = velocity in destination orbit (further note that $V_C = V_2 - V_3$ to keep $Delta V$ +ve)).

$
  V_2 = h/r_p = sqrt(2 mu/r_C (r_B)/(r_C + r_B)) quad quad
  V_3 = sqrt(2 mu/r_C) \
  Delta V_C = V_2 - V_3 = sqrt(mu/ r_C) [sqrt(2 (r_B)/(r_C + r_B)) - 1]
$<1-bielliptic-derivation-4>

The total $Delta V$ of this manuever would be the sum of *@1-bielliptic-derivation-2*, *@1-bielliptic-derivation-3* & *@1-bielliptic-derivation-4*, however some substitutions are made to make the resulting equations simpler, these substitutions are shown in *@1-bielliptic-derivation-5*.

$
  "Let" quad beta = r_B / r_A quad quad alpha = r_C /r_A quad quad V_0 = sqrt(mu/ r_A) quad therefore \
  Delta V_A = V_0 [sqrt(2 (beta)/(beta + 1)) - 1] \
  Delta V_B = V_0 sqrt(2 /(beta))[sqrt((alpha)/(beta + alpha)) - sqrt((1)/(beta + 1))] \
  Delta V_C = V_0 sqrt(1/alpha) [sqrt(2 (beta)/(beta + alpha)) - 1]
$<1-bielliptic-derivation-5>

Note that in *@1-bielliptic-derivation-5* a common term of $V_0$ can be extracted. Adding these expressions whilst multiplying $V_B$ by $sqrt(2 /(beta))$ and $V_C$ by $sqrt(1/alpha)$ yields *@1-bielliptic-derivation-6*.

$
  Delta V = Delta V_A + Delta V_B + Delta V_C \
  #v(5em)
  = V_0 [
    markhl(sqrt((2beta)/(beta + 1)), color: #aqua, tag: #<5>)
    -markhl(1, color: #purple, tag: #<3>)
    + markhl(sqrt((2alpha)/(beta(beta + alpha))), tag: #<1>)
    -markhl(sqrt((2)/(beta(beta + 1))), color: #aqua, tag: #<6>)
    + markhl(sqrt((2beta)/(alpha(beta + alpha))), color: #red, tag: #<2>)
    - markhl(sqrt(1/alpha), color: #purple, tag: #<4>)
  ]
  #annot((<1>), pos: bottom, dy: 0.5em, dx: 1em, leader-connect: "elbow")[Multiply by $alpha"/"alpha$]
  #annot((<2>), pos: bottom, dy: 0.5em, dx: 1em, leader-connect: "elbow")[Multiply by $beta"/"beta$]
  #annot((<3>, <4>), pos: top, dy: -1.5em, dx: 8em, leader-connect: "elbow")[Combine together]
  #annot((<5>), pos: bottom, dy: 0.5em, dx: 1.5em, leader-connect: "elbow")[Multiply by $beta"/"beta$]
  #annot((<6>), pos: bottom, dy: 0.5em, dx: 1em, leader-connect: "elbow")[Combine Aqua]
  \
  #v(5em)
  therefore
  markhl(sqrt((2alpha^2)/(alpha beta(beta + alpha))))
  +
  markhl(sqrt((2beta^2)/(alpha beta(beta + alpha))), color: #red, tag: #<2>) = sqrt((2(alpha + beta))/(alpha beta))
  quad quad
  markhl(-1 - sqrt(1/alpha), color: #purple) = - (1 + sqrt(alpha))/sqrt(alpha)
  \
  therefore markhl(sqrt((2beta^2)/(beta(beta + 1))) - sqrt((2)/(beta(beta + 1))), color: #aqua) = sqrt(2/(beta(beta + 1))) (beta - 1)
$<1-bielliptic-derivation-6>

Combining together the simplified expressions in *@1-bielliptic-derivation-6* yield the final expression for the $Delta V$ cost for a bi-elliptic Hohmann transfer shown in *@1-bielliptic-derivation-7*

$
  Delta V = V_0 [sqrt((2(alpha + beta))/(alpha beta)) - (1 + sqrt(alpha))/sqrt(alpha) +sqrt(2/(beta(beta + 1))) (beta - 1)]
  \ "Where" : quad quad
  V_0 = sqrt(mu/ r_A) quad quad beta = r_B / r_A quad quad alpha = r_C /r_A
$<1-bielliptic-derivation-7>

By plotting $beta$ against $alpha$, it is possible to see when the bi-elliptic Hohmann transfer is more efficient than a normal Hohmann transfer, this plot is shown in *@1-bielliptic-hohmann-plot*.

#figure(
  image("images/1-bielliptic-hohmann.png"),
  caption: [Plot of $beta$ against $alpha$ for a bi-elliptic Hohmann transfer.],
  supplement: [Figure],
  kind: figure,
) <1-bielliptic-hohmann-plot>

In *@1-bielliptic-hohmann-plot* the straight line labelled $r_B = r_C$ is a normal Hohmann transfer. Specifically if $alpha > 11.94$ then a *bi-elliptic Hohmann transfer is more efficient than a normal Hohmann transfer*.

#pagebreak()
