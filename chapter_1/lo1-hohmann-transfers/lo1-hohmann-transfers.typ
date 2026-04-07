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
    let r_a = 4
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
    cetz.draw.content((r_a * 1.12, 0), [*$r_a$*])

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


#figure(
  cetz.canvas({
    import cetz.draw: *

    // Define constants for orbits
    let r_p_1 = 1.1 // Perigee of Lower Orbit
    let r_a_1 = 2 // Apogee of Upper Orbit
    let r_p_2 = 2.5 // Perigee of Lower Orbit
    let r_a_2 = 7 // Apogee of Upper Orbit

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
    cetz.draw.content((4, -0.4), [*Apse Line*])
  }),
  caption: [Schematic diagram of elliptical Hohmann transfers.],
  supplement: [Figure],
  kind: figure,
) <1-elliptical-hohmann>

#pagebreak()



#cetz.canvas({
  import cetz.draw: *
  // Circular
  cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")
  orbit(0, 0, 1.5, 0)
})

#cetz.canvas({
  import cetz.draw: *

  // Elliptical
  cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

  orbit(0, 0, 1.2, 0.5, mark_number: 8, initial_angle: -120, final_angle: 120)
})

#cetz.canvas({
  import cetz.draw: *

  // Parabolic Plot
  cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")
  orbit(0, 0, 1.1, 1, initial_angle: -120, final_angle: 120, mark_number: 3)
})

#cetz.canvas({
  import cetz.draw: *

  // hyperbolic Plot
  cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")
  let foo = 100
  orbit(0, 0, 1.1, 1.5, initial_angle: -foo, final_angle: foo, mark_number: 9)
})
