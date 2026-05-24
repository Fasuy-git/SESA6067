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

A simple plane change manoeuvre is one where the orbit is only rotated and the shape (apogee/perigee) about a rotation line which is a line in the original orbit plane that must intersect the orbit body. This means there are only ever two points within an orbit where a plane change manoeuvre can occur, this is shown in *@3-rigid-plane-change*.

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
