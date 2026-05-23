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


#let orbit_radius(r_p, e, theta) = {
  if e == 0 {
    r_p
  } else if (e > 0 and e < 1) {
    ((r_p / (1 - e)) * (1 - calc.pow(e, 2))) / (1 + e * calc.cos(theta))
  } else if e == 1 {
    (2 * r_p) / (1 + e * calc.cos(theta))
  } else if e > 1 {
    (r_p * (1 + e)) / (1 + e * calc.cos(theta))
  }
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
  mark_symbol: ">",
  mark_scale: 1,
) = {
  cetz.draw.rotate(z: 90deg - inclination)

  let thetas = nt.mult(nt.linspace(initial_angle, final_angle, points), 1deg)
  let rs = thetas.map(p => orbit_radius(r_p, e, p))

  let mark_separation_angle
  if (final_angle - initial_angle) == 360 {
    mark_separation_angle = (final_angle - initial_angle) / mark_number * 1deg
  } else {
    mark_separation_angle = (final_angle - initial_angle) / (mark_number - 1) * 1deg
  }

  for mark_index in range(0, mark_number) {
    let mark_characteristic_angle = mark_index * mark_separation_angle + initial_angle * 1deg
    let r_mark = orbit_radius(r_p, e, mark_characteristic_angle)

    let gamma = if e == 0 {
      0deg
    } else {
      calc.atan((e * calc.sin(mark_characteristic_angle)) / (1 + e * calc.cos(mark_characteristic_angle)))
    }

    cetz.draw.mark(
      (
        x_center + r_mark * calc.cos(mark_characteristic_angle),
        y_center + r_mark * calc.sin(mark_characteristic_angle),
      ),
      90deg + mark_characteristic_angle - gamma,
      symbol: mark_symbol,
      stroke: mark_color,
      fill: mark_color,
      scale: mark_scale,
      anchor: "center",
    )
  }

  let xs = nt.mult(rs, nt.cos(thetas)).map(x => x + x_center)
  let ys = nt.mult(rs, nt.sin(thetas)).map(y => y + y_center)
  cetz.draw.line(..xs.zip(ys).map(p => (p.at(0), p.at(1))), stroke: (
    thickness: width,
    paint: color,
    dash: dash_type,
  ))

  cetz.draw.rotate(z: -90deg + inclination)
}

#let satellite(
  x_center,
  y_center,
  r_p,
  e,
  sat_angle,
  color: black,
  sat_radius: 0.15,
  connecting_line: false,
  line_type: "solid",
  line_width: 1pt,
  inclination: 90deg,
  line_start_mark: "o",
  line_color: black,
  mark_scale: 1,
) = {
  cetz.draw.rotate(z: 90deg - inclination)
  let r = orbit_radius(r_p, e, sat_angle)
  if connecting_line {
    cetz.draw.line(
      (x_center, y_center),
      (sat_angle, r),
      stroke: (
        dash: "dashed",
        thickness: line_width,
        paint: line_color,
      ),
    )
    cetz.draw.mark(
      (
        x_center,
        y_center,
      ),
      (sat_angle, r),
      symbol: line_start_mark,
      stroke: line_color,
      fill: line_color,
      scale: mark_scale,
      anchor: "center",
    )
  }
  cetz.draw.circle((sat_angle, r), radius: sat_radius, fill: color)
  cetz.draw.rotate(z: -90deg + inclination)
}
