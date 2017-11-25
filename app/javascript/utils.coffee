import buildFormatter from "react-timeago/lib/formatters/buildFormatter"

# Spanish
spanishStrings =
  prefixAgo: "",
  prefixFromNow: "dentro de",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "menos de un minuto",
  minute: "1 minuto",
  minutes: "%d minutos",
  hour: "1 hora",
  hours: "%d horas",
  day: "1 día",
  days: "%d días",
  month: "1 mes",
  months: "%d meses",
  year: "1 año",
  years: "%d años"

to_state = (state) ->
  unless state?
    return "unknown"

  switch state
    when "opened"
      "Activo"
    when "assisting"
      "Asistiendo"
    when "closed"
      "Cerrado"
    else
      "unknown"

sleep = (ms) ->
  new Promise (resolve) ->
    window.setTimeout resolve, ms

utils =
  formatter: buildFormatter(spanishStrings)
  to_state: to_state
  sleep: sleep

export default utils
