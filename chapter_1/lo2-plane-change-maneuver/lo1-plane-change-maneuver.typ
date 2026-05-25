#import "../../template.typ": *

=== Plane Change Manoeuvre

A plane change manoeuvre is a three dimensional manoeuvre out of the plane of the orbit to alter the plane of the orbit. This follows a similar process to the phase change manoeuvre where the phase change manoeuvre, where the old and new velocity vectors are found and $Delta v$ is the difference between these two vectors. An angle $delta$ is defined as the *plane change angle*, shown in *@3-turning-angle-definition* and in *@3-delta-definition*.

#grid(
  columns: 2,
  column-gutter: -2cm,
  [
    #figure(
      image("images/2-plane-change-schematic.png", width: 70%),
      caption: [Definition of plane change angle $delta$ between an origin and destination orbit in a plane change manoeuvre.],
      supplement: [Figure],
      kind: figure,
    )<3-turning-angle-definition>
  ],
  [#v(4em)$
      cos(delta) = (accent(h, ->)_1 dot accent(h, ->)_2)/(h_1 h_2)
    $<3-delta-definition>],
)

==== Rigid Rotation of the Orbit

A simple plane change manoeuvre is one where the orbit is only rotated and the shape (apogee/perigee) about a rotation line which is a line in the original orbit plane that must intersect the orbit body. This means there are only ever two points `with`in an orbit where a plane change manoeuvre can occur, this is shown in *@3-rigid-plane-change*.

#figure(
  image("images/2-rigid-plane-change-schematic.png", width: 40%),
  caption: [Rigid plane change with the rotation axis shown as the dotted line.],
  supplement: [Figure],
  kind: figure,
)<3-rigid-plane-change>

The velocity vector at the plane change manoeuvre point can be split into its radial and orthogonal components. The radial velocity vector is in the same direction as the rotation axis itself and so the rotation solely acts on the orthogonal component. The $Delta V$ required for this manoeuvre is therefore given by the following equation *@3-rigid-plane-equation* and velocity triangle shown in *@3-rigid_triangle*.

#grid(
  columns: 2,
  column-gutter: -0.5cm,
  [
    #figure(
      image("images/2-rigid-triangle.png", width: 50%),
      caption: [Velocity triangle for a rigid plane change manoeuvre.],
      supplement: [Figure],
      kind: figure,
    )<3-rigid_triangle>
  ],
  [#v(3em)$
      Delta v = |accent(v, ->)^* - accent(v, ->)| = |accent(v, ->)^*_perp - accent(v, ->)_perp| \ therefore Delta v = 2 v_perp sin(delta/2)
    $<3-rigid-plane-equation>],
)

Note that in this case the new orthogonal velocity ($accent(v, ->)^*_perp$) and the old orthogonal velocity ($accent(v, ->)_perp$) are the same as there is no shape change. Note that the $Delta v$ required for this manoeuvre is proportional to the velocity at that point in the orbit, yielding a very high value of $Delta v$.

==== General Plane Change Manoeuvre with Shape Change

For a manoeuvre with a shape change, the cosine rule can be utilized as well as considering a possible change in the radial direction. The resulting equation and velocity triangle are shown in *@3-general-triangle* and in *@3-general-plane-change* respectively. Note that in *@3-general-plane-change*, the second form is achieved by substituting the flight path angles into the first form.


#grid(
  columns: (0.2fr, 0.6fr),
  column-gutter: -0.8cm,
  [
    #figure(
      image("images/2-general-triangle.png", width: 100%),
      caption: [Velocity triangle for a general plane change manoeuvre with a shape change.],
      supplement: [Figure],
      kind: figure,
    )<3-general-triangle>
  ],
  [#v(3em)$
      Delta v = sqrt(
        (v_r^* - v_r)^2 + v_perp^*^2 + v_perp^2
        - 2 v_perp^* v_perp cos(delta)
      )
      \
      Delta v = sqrt(
        v^*^2 + v^2 - 2 v^* v [
          cos(gamma^* - gamma) - cos(gamma^*)cos(gamma)
          (1-cos(delta))
        ]
      )
    $<3-general-plane-change>],
)

Note that as this is effectively an equation for a general manoeuvre, applying certain conditions should reduce the equation to the known cases. Firstly if $v_r = v_r^* =0$ and $delta = 0$ the orbit plane rotation equation about a common apse line is generated.

==== Restricted Three Impulse Circular Plane Change

Plane change manoeuvres are expensive due to them being proportional to $v_perp$, which is typically the largest component of $v$. Minimizing the $v_perp$ can therefore minimize the $Delta v$ cost of the plane change manoeuvre, one way of doing this is doing the plane change manoeuvre at apogee. Thus arises the three impulse plane change manoeuvre, making use of a Hohmann transfer to raise the apogee, a plane change manoeuvre at apogee and then a burn at perigee to recircularize the orbit, a Schematic of this manoeuvre is shown in *@3-impulse-plane*.

#figure(
  image("images/2-three-impulse-plane-change.png", width: 50%),
  caption: [Diagram of a three impulse plane change manoeuvre.],
  supplement: [Figure],
  kind: figure,
)<3-impulse-plane>

To calculate the total $Delta v$ cost of this manoeuvre, the Vis-Viva equation can be used, shown in *@3-general-vis-viva*, rearranged for $v$.

$
  epsilon = v^2 / 2 - mu/r = - mu/(2a)
  quad --> quad
  v = sqrt((2 mu) /r - mu/a)
$<3-general-vis-viva>

This equation can then be applied to each point to work out the $Delta v$. One important distinction in this manoeuvre is that $Delta v_1$ is the same as $Delta v_3$ as the plane change manoeuvre ($Delta v_2$) doesn't change the orthogonal velocity just rotates it. $Delta v_1$ and $Delta v_3$ are thusly derived in *@3-three-plane-change-delta-v-13*, where $v_c$ is the orbital velocity in the circular origin (and destination orbit).

$
  Delta v_1 = Delta v_3 = v_1 - v_c = sqrt((2 mu) /r_1 - mu/(r_1 + r_2)) - sqrt(mu/r_1) = sqrt(mu/r_1) [
    sqrt((2 r_2 / r_1)/(1 + r_2 / r_1)) - 1
  ]
$<3-three-plane-change-delta-v-13>

$Delta v_2$ can be calculated by utilizing the rigid plane change equation as well as observing that at apogee the radial velocity is zero. This is shown in *@3-three-plane-change-delta-v-2*.

$
  Delta v_2 = 2 v_"Apogee" sin(delta/2) = 2 sqrt((2 mu) /r_2 - mu/(r_1 + r_2)) sin(delta/2) = 2 sqrt(mu/r_1) sqrt(
    2/(r_2 / r_1 (1 + r_2 / r_1))
  ) sin(delta/2)
$<3-three-plane-change-delta-v-2>

The total $Delta v$ is therefore the sum of two lots of *@3-three-plane-change-delta-v-13* and one lot of *@3-three-plane-change-delta-v-2*, the final result being shown in *@3-three-plane-change-delta-v-total*.

$
  Delta v = 2 sqrt(mu/r_1) [
    sqrt((2 rho)/(1+rho)) - 1 + sqrt(2/(rho(1+rho))) sin(delta/2)
  ] quad "Where" quad rho = r_2/r_1
$<3-three-plane-change-delta-v-total>

Plotting various values of $rho$ and $delta$ yield the plot shown in *@3-three-impulse-plane-change-plot*. This plot shows that the three impulse plane change manoeuvre is only more efficient than a single burn when $delta > 38.94 degree$ and that for $delta > 60degree$, $r_2$ should be as large as possible.

#figure(
  image("images/2-three-impulse-plane-change-plot.png", width: 100%),
  caption: [Plot of three impulse plane change manoeuvres for various $rho$s and $delta$s],
  supplement: [Figure],
  kind: figure,
)<3-three-impulse-plane-change-plot>

==== Hohmann Transfer with Split Change Manoeuvre

In a combination of both of these manoeuvres, it is not immediately clear for a combination of $r_1$ and $r_2$ where the plane change manoeuvre should be. In reality the plane change manoeuvre can be done at each burn by a certain angle. This manoeuvre is shown in *@3-split-plane-change*.

#figure(
  image("images/2-split-change-manouver.png", width: 40%),
  caption: [Schematic view of a split plane change manoeuvre combined with a Hohmann transfer.],
  supplement: [Figure],
  kind: figure,
)<3-split-plane-change>

The angular momentum and orbital velocities of each point of interest in each orbit are shown in *@3-split-change-eq-1*.

$
  h_0 = sqrt(mu r_1)
  quad quad h_1 = sqrt(2 mu (r_1 r_2)/(r_1 + r_2))
  quad quad h_2 = sqrt(mu r_2)
  \
  quad quad v_0 = h_0/r_1
  quad quad v_(0,t) = h_1/r_1
  quad quad v_(2,t) = h_1/r_2
  quad quad v_2 = h_2/r_2
$<3-split-change-eq-1>

The proportion of the plane change that would be done at each manoeuvre is given by the $alpha$ parameter. Using this the $Delta v$ for the entire manoeuvre can be determined, this is shown in *@3-split-change-eq-2*.

$
  delta_0 = alpha delta quad quad delta_2 = (1-alpha) delta \
  Delta v_0 = sqrt(
    v_0^2 + v_(0,t)^2
    - 2 v_0 v_(0,t) cos(delta_0)
  )
  quad quad
  Delta v_2 = sqrt(
    v_2^2 + v_(2,t)^2
    - 2 v_2 v_(2,t) cos(delta_2)
  ) \
  Delta v = Delta v_0 + Delta v_2 = sqrt(
    v_0^2 + v_(0,t)^2
    - 2 v_0 v_(0,t) cos(delta_0)
  ) + sqrt(
    v_2^2 + v_(2,t)^2
    - 2 v_2 v_(2,t) cos(delta_2)
  )
$<3-split-change-eq-2>

The value of $Delta v$ can be minimized by altering the value  of $alpha$, the resulting minimization equation is shown in *@3-split-change-eq-3*. Note that the equation itself would need some numerical analysis to solve for the $alpha$ value that yields the minimum value of $Delta v$.

$
  d / (d alpha) (Delta v) =
  (v_0 v_(0,t) delta sin(delta_0))/(sqrt(
    v_0^2 + v_(0,t)^2
    - 2 v_0 v_(0,t) cos(delta_0)
  ))
  -
  (v_2 v_(2,t) delta sin(delta_2))/(sqrt(
    v_2^2 + v_(2,t)^2
    - 2 v_2 v_(2,t) cos(delta_2)
  )) = 0
$<3-split-change-eq-3>

== When and How to do Manoeuvres

Doing energy gain manoeuvres at perigee results in more energy gain, this is called the Oberth effect. This occurs as kinetic energy is proportional to the square of the velocity not the velocity on its own. An example derivation is shown in *@3-oberth*.

$
  Delta E = 1/2 m (v + Delta v)^2 - 1/2 m v^2
  = 1/2 m (v^2 + 2 v Delta v + Delta v^2) - 1/2 m v^2
  \
  = 1/2 m (v^2 + 2 v Delta v + Delta v^2 - v^2) = 1/2m(2 v Delta v + Delta v^2 )
$<3-oberth>

The last equation in *@3-oberth* has $v$ within it meaning a higher velocity results in a higher energy gain. Combining manoeuvres together in a single point is often advantageous for both the Oberth effect as well as for reducing vector addition losses. However this is not always the case, for example plane change manoeuvres are more efficient at high apogees as their $Delta v$ cost is proportional to the velocity.

#pagebreak()
