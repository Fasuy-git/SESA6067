#import "template.typ": *

= Introduction

Geostationary Earth Orbit (GEO) is a circular equatorial orbit favored for its unique property of allowing satellites to remain in a fixed, permanent position in the sky relative to a ground observer. This orbit is commonly used for communication satellites as terrestrial antennas can maintain a continuous link without the need for constant tracking or repositioning.

These satellites are typically launched from, or close to the equator in order to reduce the fuel burnt in repositioning them. This report however, will investigate the feasibility of using a high latitude launch site for launching geostationary satellites.

This report contains a detailed analytical comparison of the fuel required to transfer a satellite to geostationary orbit (GEO) from two initial conditions: a highly inclined parking orbit and an equatorial parking orbit. In addition, this report also investigates the benefits of utilizing a three burn bi-elliptic transfer to insert a highly inclined satellite into GEO, using computational tools such as GMAT. The results of both analyses are presented and discussed and a conclusion is reached on the feasibility of high latitude launch sites for geostationary satellites.

= Analytical Analysis

This section of the report will analyze the following four cases: the minimum inclination from the specified launch site; the performance of a Hohmann transfer from an equatorial parking orbit to GEO; and transfers from an inclined orbit to GEO with the inclination change combined with either the first or second burn. For each case, key performance parameters including $Delta V$, transfer time, and propellant mass fraction are evaluated and compared.

== Minimum Inclination Angle

Minimizing the inclination of the orbit is crucial in order to $Delta v$ required for subsequent inclination change maneuvers. The minimum inclination is governed by the launch azimuth ($beta$) and the effect that the Earth's rotation has on the launch vehicle $Delta v$. An expression for the $Delta v$ of the launch vehicle is shown in *@1-launch-vehicle-deltaV*.

$
  Delta v_"launch" = v_"orbit" + Delta v_"gravity" + Delta v_"drag" + Delta v_"steering" - v_"Earth Rotation" \
  Delta v_"launch" = v_"orbit" + Delta v_"losses" - omega_E R_E cos(phi.alt) sin(A)
$<1-launch-vehicle-deltaV>

Where $phi.alt$ is the launch site latitude and $A$ is the launch site azimuth. As $omega_E$, $R_E$ and $phi.alt$ are fixed for the specified launch site, to maximize the $Delta v$ boost due to Earth's rotation, $A = 90 degree$. Utilizing equations for spherical trigonometry, an expression linking the orbital inclination ($i$) and the launch site latitude can be formed, this is shown in *@1-spherical-trig*.

$
  cos(i) = cos(phi.alt)sin(A)
$<1-spherical-trig>

As $A = 90 degree$, *@1-spherical-trig* reduced to $i=phi.alt$. Therefore the minimum inclination achievable is equvelant to the launch site latitude, which is $i=phi.alt=58.5107 degree$ as outlined in the scenario brief.


The scenario brief outlines the following longitude and latitude of the launch site to be $58.5107 degree "N" 4.5121 degree "W"$ respectively. The minimum

== Equatorial Hohmann Transfer

For this analysis, the satallite is assumed to initially be in an equatorial circular parking orbit then via a 2 burn Hohmann transfer the satallite is raised into a geostationary orbit. This maneuver is shown in *@2-circular-hohmann* with key orbital constants shown in *@2-constants*.

#let compression_perc_1 = 70%

#grid(
  column-gutter: 1cm,
  columns: 2,
  [#v(1.5cm)$
      R_E = 6378.1363 k m \
      h_"orbit" = 500 k m \
      mu_E = 398600 k m^3 s^(-2) \
      r_"GEO" = 42164 k m
    $<2-constants>],
  [#figure(
    cetz.canvas({
      import cetz.draw: *
      scale(y: compression_perc_1, x: compression_perc_1)

      // Define constants
      let r_p = 1.25
      let r_a = 3
      let r_p_angle = 180deg
      let r_a_angle = 0deg

      // Earth
      cetz.draw.circle((0, 0), radius: 1, fill: blue, stroke: (thickness: 2pt), name: "Planet")

      // Lower Orbit and Arrow
      orbit(0, 0, r_p, 0)

      // Higher Orbit
      orbit(0, 0, r_a, 0)

      // Elliptical Orbit
      let e = (r_a - r_p) / (r_a + r_p)
      orbit(0, 0, r_p, e, dash_type: "dashed", initial_angle: 0, final_angle: 180)

      // Measurement Line for r_1
      let y_1 = -3.5
      let r_c = -r_p

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
      cetz.draw.content((0.7, -3.8), [*$r_1$*])


      // Measurement Line for r_1
      let y_1 = -3.5
      let r_c = r_a

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
      cetz.draw.content((-1.5, -3.8), [*$r_2$*])
    }),
    caption: [Schematic diagram of a circular Hohmann transfer.],
    supplement: [Figure],
    kind: figure,
  ) <2-circular-hohmann>],
)

To determine the orbital velocities in the parking orbit ($v_1$) and in the GEO ($v_2$), the angular momenta in each orbit can be used, this calculation is shown in *@2-derivation-1* for the constants in *@2-constants*.

$
  r_1 = R_E + h_"orbit" quad r_2 = r_"GEO" \
  h_1 = sqrt(mu_E r_1) = 52360.53 k m^2 s^(-1) quad v_1 = h_1/r_1 =7.61 k m s^(-1)\
  h_2 = sqrt(mu_E r_2) = 129640.16 k m^2 s^(-1) quad v_2 = h_2/r_2 = 3.08 k m s^(-1)
$<2-derivation-1>

Utilizing the definitions for $r_1$ and $r_2$, the velocities at apogee and perigee of the transfer orbit can also be determined, as shown in *@2-derivation-2*.

$
  h_"Transfer" = sqrt(2 mu_E (r_1 r_2)/(r_1 + r_2)) = 68660.23 k m s^(-1) \
  v_(1t) = h_"Transfer"/r_1 = 9.98 k m s^(-1) quad v_(2t) = h_"Transfer"/r_2 = 1.63 k m s^(-1)
$<2-derivation-2>

Using $v_1,v_2,v_(1t),v_(2t)$ the $Delta v$ required at each burn can be calculated as well as the total $Delta v$, this is shown in *@2-derivation-3*.

$
  Delta v_1 = v_(1t) - v_1 = 2.37 k m s^(-1)
  quad
  Delta v_2 = v_2 - v_(2t) = 1.45 k m s^(-1)
  \
  Delta v_"tot" = Delta v_1 + Delta v_2 = 3.82 k m s^(-1)
$<2-derivation-3>

Using $Delta v_"tot"$ as well as the $I_"sp"$ and $m_0$ from the brief the payload fraction and propellent fraction can be determined, this is shown in *@2-derivation-4*.

$
  m_0 = 1700 k g quad I_"sp" = 230 s \
  m_f = m_0 / (exp((Delta v_"tot")/(I_"sp" g_0))) = 313.1 k g quad m_"fuel" = m_0 - m_f = 1386.9 k g \ zeta = m_"fuel"/m_0 = 0.82 quad lambda = m_f/m_0 = 0.18
$<2-derivation-4>

In this maneuver, burn 1 can occur at any point within the parking orbit given that it is done tangentially to the velocity vector. Burn 2 is performed at the apogee of the transfer orbit, also tangentially along the velocity vector. The transfer time is the time between these two burns  and is calculated in *@2-derivation-5*.

$
  e = (r_2 - r_1)/(r_2 + r_1) = 0.72 quad a = r_1 / (1 - e) = 24521.07 k m quad theta = 180 degree \
  E = 2 arctan(sqrt((1 - e)/(1 + e)) tan(theta/2)) = 180 degree quad M_e = E - e sin (E) = pi "rad" \ t = sqrt(a^3 / mu_E)M_e = 19106.90s
$<2-derivation-5>

== Inclined Hohmann Transfer with Inclination Change at Perigee of GTO

In this scenario, the satellite is inclined at an angle of $58.5107 degree$ necessitating an inclination burn to achieve a $0 degree$ inclination at GEO. Combing the inclination burn with burn 1 (insertion burn) or burn 2 (circularization burn) will decrease $Delta v_"tot"$ and so both scenarios will be analyzed to determine which configuration is more efficient. Many of the previous calculations for the zero inclination case can be applied to this scenario with the exception of $Delta v_1$ which is calculated in *@3-derivation-1*. Note that *@3-derivation-1* is a reduced form of the equation as both orbits have the same apse line and have zero radial velocity at the burn point.

$
  Delta v_1 = sqrt(v_(1t)^2 + v_1^2 - 2 v_(1t) v_1 cos (delta))= 8.84 k m s^(-1) quad Delta v_"tot" = Delta v_1 + Delta v_2 = 10.29 k m s^(-1)
$<3-derivation-1>

Using $v_"tot"$, the mass of fuel needed, the payload and propellent fractions can be determined for this maneuver and this is shown in *@3-derivation-2*.

$
  m_f = m_0 / (exp((Delta v_"tot")/(I_"sp" g_0))) = 17.75 k g quad m_"fuel" = m_0 - m_f = 1682.25k g \ zeta = m_"fuel"/m_0 = 0.99 quad lambda = m_f/m_0 = 0.01
$<3-derivation-2>

== Inclined Hohmann Transfer with Inclination Change at Apogee of GTO

This case is similair to the previous one, however the inclination burn is combined with the circularization burn at the apogee of of the geostationary transfer orbit. In this case $Delta v_1$ is the same as the equatorial case and $Delta v_2$ is changed. The altered $Delta v_2$ is calculated in *@4-derivation-1*.

$
  Delta v_2 = sqrt(v_(2)^2 + v_(2t)^2 - 2 v_(2) v_(2t) cos (delta))= 2.62 k m s^(-1) quad Delta v_"tot" = Delta v_1 + Delta v_2 = 4.99 k m s^(-1)
$<4-derivation-1>


$
  m_f = m_0 / (exp((Delta v_"tot")/(I_"sp" g_0))) = 185.91 k g quad m_"fuel" = m_0 - m_f = 1514.09k g \ zeta = m_"fuel"/m_0 = 0.89 quad lambda = m_f/m_0 = 0.11
$<4-derivation-2>

= Computational Analysis

This section of the report will utilize NASA's General Mission Analysis Tool (GMAT) to validate the best case analytical calculation as well as investigate a bi-elliptic transfer.

== Validation of Best Case Analytical Result

From the analysis section, the best case was performing the inclination burn in combination with the circularization burn with a $Delta v_"tot" = 4.99 k m s^(-1)$. To replicate this result in GMAT, first thing was to define a Spacecraft object with the quantities shown in *@2-constants*, this is shown in *@5-spacecraft-init*.

#grid(
  column-gutter: 1cm,
  columns: 2,
  [#figure(
    image("images/satallite_object.png", width: 120%),
    caption: [Definition of key parameters for the spacecraft object in GMAT.],
    supplement: [Figure],
    kind: figure,
  ) <5-spacecraft-init>],
  [#figure(
    image("images/resource_tree.png", width: 45%),
    caption: [Resource tree objects for the mission in GMAT.],
    supplement: [Figure],
    kind: figure,
  ) <5-resource_tree>],
)

As well as the parking orbit conditions defined in *@5-spacecraft-init*, a default propagator object, two burns and a default boundary value solver were also created in the resource tab, this is shown in *@5-resource_tree*.

After creating these objects in the resource tree, a list of propagations, manuevers, targets and achievements was defined within the mission tab, this tab is shown in *@5-mission-tree*.

#grid(
  column-gutter: 0.2cm,
  columns: (0.33fr, 0.67fr),
  [#figure(
    image("images/mission_tree.png", width: 140%),
    caption: [Mission tree objects for the mission in GMAT.],
    supplement: [Figure],
    kind: figure,
  ) <5-mission-tree>],
  [
    + *`One_Orbit`*: Propagates one LEO orbit by setting elapsed time as $5767s$.

    + *`To_AN`*: Propagates the orbit until $theta = 180 degree$ at which point the satellite is at the ascending node.

    + *`Target`*: Defines the beginning of the iteration loop.

    + *`Burn_1_V`*: Varies the tangential velocity of the GTO insertion burn between $-3k m s^(-1)$ to $3k m s^(-1)$ with an initial guess of $2k m s^(-1)$.

    + *`Insertion_burn`*: Performs the `GTO_insertion` burn defined in *@5-resource_tree*.

    + *`Coast_to_apogee`*: Propagates transfer orbit until the apogee of the orbit is reached.

    + *`Burn_2_V`*: Varies the tangential velocity of the combined circularization and inclination burn between $-3k m s^(-1)$ to $3k m s^(-1)$ with an initial guess of $2k m s^(-1)$.
  ],
)

#set enum(start: 8)

+ *`Burn_2_N`*: Varies the normal velocity of the combined circularization and inclination burn between $-3k m s^(-1)$ to $3k m s^(-1)$ with an initial guess of $2k m s^(-1)$.

+ *`Burn_2_B`*:  Varies the bi-normal velocity of the combined circularization and inclination burn between $-1k m s^(-1)$ to $1k m s^(-1)$ with an initial guess of $0.5k m s^(-1)$.

+ *`Circular_Inclination_burn`*: Performs the `GTO_circular_inclination` burn defined in *@5-resource_tree*.

+ *`Desired_inclination`*: Defines the achievement criteria of $i approx 0$ with a tolerance of 0.2.

+ *`Desired_eccentricity`*: Defines the achievement criteria of $e approx 0$ with a tolerance of 0.2.

+ *`Desired_SMA`*: Defines the achievement criteria of $a approx 42164$ with a tolerance of 0.2.

+ *`End_Target1`*: Defines the end of the iteration loop.

+ *`One_orbit`*: Propagates one orbit at GEO by setting elapsed time as $90,000s$.

Running the solver until it converges to a solution yields the velocity values detailed in *@5-gmat-simulation-output* and a image of the orbits are shown in *@5-gmat-simulation*.

#grid(
  columns: 2,
  column-gutter: 0.5cm,
  [#figure(
    table(
      columns: 3,
      inset: 5pt,
      fill: (col, row) => if row == 0 { gray } else { white },
      align: center + horizon,
      table.header[*Name*][*Quantity*][*Unit*],

      [Burn 1 $v_V$], [2.373], [$k m s^(-1)$],
      [Burn 2 $v_V$], [-0.023], [$k m s^(-1)$],
      [Burn 2 $v_N$], [2.622], [$k m s^(-1)$],
      [Burn 2 $v_B$], [-0.001], [$k m s^(-1)$],
    ),
    caption: [Velocity outputs from GMAT simulation.],
    supplement: [Figure],
    kind: figure,
  )<5-gmat-simulation-output>],
  [#figure(
    image("images/gmat-simulation-1.png", width: 100%),
    caption: [Mission tree objects for the mission in GMAT.],
    supplement: [Figure],
    kind: figure,
  ) <5-gmat-simulation>],
)

Adding together the velocities within *@5-gmat-simulation-output* yields a $Delta v_"tot" approx 5 k m s^(-1)$ which is consistent with the analytical result previously calculated.

== Bi-elliptic Transfer

Instead of utilizing two burns as has been considered for the previous analyses, utilizing three burns may be offer a lower $Delta v_"tot"$ by allowing the inclination maneuver to be done at a lower orthogonal velocity. The mission tree for this maneuver is shown in *@6-mission-tree*.

#grid(
  columns: (0.4fr, 0.6fr),
  column-gutter: 0.5cm,
  [#figure(
    image("images/mission_tree_.png", width: 80%),
    caption: [Mission tree objects for the bi-elliptic maneuver in GMAT.],
    supplement: [Figure],
    kind: figure,
  ) <6-mission-tree>],
  [The majority of the elements within *@6-mission-tree* are the same as *@5-mission-tree*, with the exception of *`Post Burn1 SMA`*. This achievement criteria allows for the explicit definition of the semi major axis for the initial transfer orbit and is nessicary to analyze this maneuver. It was found that without this achievement criteria the solution would converge to the previous two burn case.

    By varying the value set in this achievement criteria, the values of $Delta v_"tot"$ shown in *@5-gmat-simulation-output-2* can be achieved.

    #figure(
      table(
        columns: 2,
        inset: 5pt,
        fill: (col, row) => if row == 0 { gray } else { white },
        align: center + horizon,
        table.header[*Apogee (km)*][*$Delta v_"tot"$ ($k m s^(-1)$)*],

        [24521.068], [6.00],
        [33439.068], [4.54],
        [43439.068], [4.32],
        [48439.068], [4.24],
      ),
      caption: [Velocity outputs from GMAT simulation of bi-elliptic transfer.],
      supplement: [Figure],
      kind: figure,
    )<5-gmat-simulation-output-2>],
)

#pagebreak()

= Results and Discussion

A summary of the $Delta v_"tot"$, propellent mass, propellant mass fraction and payload mass fraction are shown in *@7-summary-table*.

#figure(
  table(
    columns: 5,
    inset: 5pt,
    fill: (col, row) => if row == 0 { gray } else { white },
    align: center + horizon,
    table.header[*Manuever*][*$Delta v_"tot"$ ($k m s^(-1)$)*][*Propellent Mass (kg)*][*Propellent Frac ($zeta$)*][*Payload Frac ($lambda$)*],
    [Zero Inclination Hohmann.], [3.82], [1386.9], [0.82], [0.18],
    [Inclined Hohmann, Inclination burn at perigee.], [10.29], [1682], [0.99], [0.01],
    [Inclined Hohmann, Inclination burn at apogee.], [4.99], [1514], [0.89], [0.11],
    [GMAT Inclined Hohmann, Inclination burn at apogee.], [5.01], [1515.587], [0.892], [0.12],
    [GMAT bi-elliptic Hohmann], [4.24], [1440.551], [0.847], [0.153],
  ),
)<7-summary-table>

As the $Delta v$ required to change the inclination is proportional to the orthogonal velocity, maneuvers which have the inclination change at the apogee of the transfer orbit have a lower $Delta v_"tot"$. Furthermore, the three burn Hohmann transfer is able to approach a $Delta v_"tot"$ similar to the zero inclination scenario by performing the inclination change at a high apogee radius.

= Conclusion

In conclusion utilizing high inclination launch sites for geostationary satellites has been shown to be significantly less efficient than equatorial launches. Through analytical analyses and computational simulations, the $Delta v$ required for the inclination burn has been seen to be significant and a limiting factor on the use of these launch sites for such missions.

To mitigate the effect of the inclination burn, a bi-elliptic transfer was investigated which approached the $Delta V$ of the zero inclination case however, this maneuver has its draw backs. Though not investigated in this report, the transit time for such a maneuver would be much longer than the equivalent circular Hohmann maneuver. This could increase the time satellites spend within radiation belts, possibly damaging electrical equipment. Another manuever which was not investigated but that could mitigate these effects would be a split change angle maneuver where the inclination burn is split over both Hohmann transfer burns.
