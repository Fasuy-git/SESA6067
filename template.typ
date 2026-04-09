// Place imported functions here

#import "@preview/wordometer:0.1.5": total-words, word-count

#import "@preview/equate:0.3.2": equate

#import "@preview/cetz:0.4.2"
#import "@preview/cetz:0.4.2": canvas, draw

#import "@preview/numty:0.1.0" as nt

#import "@preview/mannot:0.3.2": *

// Place custom functions here

#let lecture(title, level, week-num) = {
  // Define week tag box
  let week-tag = box(
    fill: luma(90%),
    inset: 4pt,
    radius: 4pt,
    stroke: none,
    text(0.9em, weight: 600)[START OF WEEK #week-num],
  )

  // Return the grid layout: heading left, tag right
  grid(
    columns: (1fr, auto),
    gutter: 1em,
    [#heading(level: level, title)],
    [
      #figure(
        week-tag,
        supplement: [Week],
        kind: "week",
      )
    ],
  )
}


#let orbit(
  x_center,
  y_center,
  r_p,
  e,
  initial_angle: 0,
  final_angle: 360,
  points: 100,
  color: black,
  dash_type: "solid",
  width: 1pt,
  inclination: 90deg,
  mark_number: 4,
  mark_color: black,
  mark_symbol: "<",
  mark_scale: 1,
) = {
  // Rotate Frame
  cetz.draw.rotate(z: 90deg - inclination)

  // Define Constants
  let rs
  let thetas = nt.mult(nt.linspace(initial_angle, final_angle, points), 1deg)

  // Conditional statements based on eccentricity
  if e == 0 {
    // Circular Orbits
    rs = thetas.map(p => r_p)

    // Plot marks
    let mark_separation_angle
    if (final_angle - initial_angle) == 360 {
      mark_separation_angle = (final_angle - initial_angle) / mark_number * 1deg
    } else { mark_separation_angle = (final_angle - initial_angle) / (mark_number - 1) * 1deg }


    for mark_index in range(0, mark_number) {
      let mark_characteristic_angle = mark_index * mark_separation_angle + initial_angle * 1deg

      cetz.draw.mark(
        (mark_characteristic_angle, r_p),
        90deg + mark_characteristic_angle,
        symbol: mark_symbol,
        stroke: mark_color,
        fill: mark_color,
        scale: mark_scale,
        anchor: "center",
      )
    }
  } else if (e > 0 and e < 1) {
    // Elliptical Orbits
    rs = thetas.map(p => ((r_p / (1 - e)) * (1 - calc.pow(e, 2))) / (1 + e * calc.cos(p)))

    // Plot marks
    let mark_separation_angle
    if (final_angle - initial_angle) == 360 {
      mark_separation_angle = (final_angle - initial_angle) / mark_number * 1deg
    } else { mark_separation_angle = (final_angle - initial_angle) / (mark_number - 1) * 1deg }


    for mark_index in range(0, mark_number) {
      let mark_characteristic_angle = mark_index * mark_separation_angle + initial_angle * 1deg

      // Compute flight path angle
      let gamma = calc.atan((e * calc.sin(mark_characteristic_angle)) / (1 + e * calc.cos(mark_characteristic_angle)))

      let r_mark = ((r_p / (1 - e)) * (1 - calc.pow(e, 2))) / (1 + e * calc.cos(mark_characteristic_angle))
      cetz.draw.mark(
        (mark_characteristic_angle, r_mark),
        90deg + mark_characteristic_angle - gamma,
        symbol: mark_symbol,
        stroke: mark_color,
        fill: mark_color,
        scale: mark_scale,
        anchor: "center",
      )
    }
  } else if e == 1 {
    // Parabolic Orbits
    rs = thetas.map(p => (2 * r_p) / (1 + e * calc.cos(p)))

    // Plot marks
    let mark_separation_angle
    if (final_angle - initial_angle) == 360 {
      mark_separation_angle = (final_angle - initial_angle) / mark_number * 1deg
    } else { mark_separation_angle = (final_angle - initial_angle) / (mark_number - 1) * 1deg }


    for mark_index in range(0, mark_number) {
      let mark_characteristic_angle = mark_index * mark_separation_angle + initial_angle * 1deg

      // Compute flight path angle
      let gamma = calc.atan((e * calc.sin(mark_characteristic_angle)) / (1 + e * calc.cos(mark_characteristic_angle)))

      let r_mark = (2 * r_p) / (1 + e * calc.cos(mark_characteristic_angle))
      cetz.draw.mark(
        (mark_characteristic_angle, r_mark),
        90deg + mark_characteristic_angle - gamma,
        symbol: mark_symbol,
        stroke: mark_color,
        fill: mark_color,
        scale: mark_scale,
        anchor: "center",
      )
    }
  } else if e > 1 {
    // Hyperbolic Orbits
    rs = thetas.map(p => (r_p * (1 + e)) / (1 + e * calc.cos(p)))

    // Plot marks
    let mark_separation_angle
    if (final_angle - initial_angle) == 360 {
      mark_separation_angle = (final_angle - initial_angle) / mark_number * 1deg
    } else { mark_separation_angle = (final_angle - initial_angle) / (mark_number - 1) * 1deg }


    for mark_index in range(0, mark_number) {
      let mark_characteristic_angle = mark_index * mark_separation_angle + initial_angle * 1deg

      // Compute flight path angle
      let gamma = calc.atan((e * calc.sin(mark_characteristic_angle)) / (1 + e * calc.cos(mark_characteristic_angle)))

      let r_mark = (r_p * (1 + e)) / (1 + e * calc.cos(mark_characteristic_angle))
      cetz.draw.mark(
        (mark_characteristic_angle, r_mark),
        90deg + mark_characteristic_angle - gamma,
        symbol: mark_symbol,
        stroke: mark_color,
        fill: mark_color,
        scale: mark_scale,
        anchor: "center",
      )
    }
  }

  //Define x y and plot line
  let xs = nt.mult(rs, nt.cos(thetas))
  let ys = nt.mult(rs, nt.sin(thetas))
  cetz.draw.line(..xs.zip(ys).map(p => (p.at(0), p.at(1))), stroke: (
    thickness: width,
    paint: color,
    dash: dash_type,
  ))

  cetz.draw.rotate(z: -90deg + inclination)
}
