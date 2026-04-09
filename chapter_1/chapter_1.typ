= Chapter 1: Orbital Manuevers

== Manuevers

A manuever is defined as *`A controlled change in the velocity (magnitude and/or direction) of a spacecraft to alter its orbit.`* Each mission contains multiple manuevers and those manuevers can be made of the following building blocks:

- Change orbit shape.
- Change orbit orientation (plane).
- Change of orbit phasing (anomaly).

There can be multiple reasrons for manuevers within a mission,  including orbital transfers, maintenance and disposal. The goal of mission design is to *`minimize `$Delta V$` within mission constraints`*, these constraints being:

- Transfer time.
- Forbidden regions (e.g. radiation belts).
- Pointing requirements (panels, instruments).

== Types of Manuevers

This module will cover various types of coplanar transfers and plane change maneuvers, these are:

#grid(
  columns: 2,
  column-gutter: 1cm,
  [
    - Coplanar transfers
      - (Bi-elliptic) Hohmann transfer
      - Phasing maneuvers
      - Non-Hohmann transfers
      - Apse line rotation
  ],
  [
    - Plane change maneuvers
      - Inclination change
      - RAAN change
  ],
)

== Impulsive Manuever Assumption

For this module, each manuever is assumed to be impulsive (kick manuever). This assumes that the burn time is negligible in comparison to the orbital time. It is important to note that *$Delta V$ cost of a mission is the sum of all manuevers*. Further note that for this topic *$Delta V$ is a vector and so must be added correctly*.

#pagebreak()

#include "lo1-hohmann-transfers/lo1-hohmann-transfers.typ"
