#import "october.typ": calendar
#set page(flipped: true, margin: 1cm)
#set text(font: "Jost", weight: "light")
// #set text(font: "Jost")
#show: calendar.with(year: datetime.today().year() + 1)
