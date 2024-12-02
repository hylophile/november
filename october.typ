
#let calendar(year: "", body) = {

  set document(title: str(year) + " calendar")

  for month in range(1, 13) [

    #let month_date = datetime(
      year: year,
      month: month,
      day: 1,
    )

    #let monthly_days = ()

    #for day in range(0, 31) [
      #let month_accumulator = (month_date + duration(days: day))
      #if month_accumulator.month() != month {
        break
      }
      #monthly_days.push(month_accumulator)
    ]

    #align(center)[
      #heading(level: 1)[
        #text(size: 15pt)[#month_date.display("[month repr:long] [year]")
        ]
      ]
    ]


    #let first_monday = {
      int(monthly_days.first().display("[weekday repr:monday]"))
    }

    #let content_without_weeks = (
      ..range(1, first_monday).map(empty_day => []),
      ..monthly_days.map(day => [#day.display("[day padding:none]")]),
    )

    #let content_chunks = content_without_weeks.chunks(7)

    #let first_week_number = int(month_date.display("[week_number]"))
    #let week_numbers = range(
      first_week_number,
      first_week_number + content_chunks.len(),
    ).map(it => [#it])

    #let content_with_weeks = week_numbers.zip(content_chunks).flatten()

    #show table.cell.where(y: 0): strong
    #show table.cell.where(y: 0): it => align(horizon + center)[#it]
    #show table.cell.where(x: 0): it => strong(align(horizon + right)[#it])
    #block(
      height: 1fr,
      table(
        columns: (1em, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
        rows: (2em, 1fr, 1fr, 1fr, 1fr, 1fr),
        // inset: 12pt,
        stroke: (x, y) => if y > 0 and x > 0 {
          .5pt
        },
        table.header(
          [],
          [Monday],
          [Tuesday],
          [Wednesday],
          [Thursday],
          [Friday],
          [Saturday],
          [Sunday],
        ),

        ..content_with_weeks,
      ),
    )

    #pagebreak(weak: true)
  ]
}
