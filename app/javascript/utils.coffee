import buildFormatter from "react-timeago/lib/formatters/buildFormatter"

# Spanish
spanishStrings =
  prefixAgo: "",
  prefixFromNow: "dentro de",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "ahora",
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

toState = (state, assignee) ->
  if state == "opened" and not assignee?
    "Activo"
  else if state == "opened" and assignee?
    "Asistiendo"
  else if "closed"
    "Cerrado"
  else
    "Desconocido"

utils =
  timeFormatter: buildFormatter(spanishStrings)
  humanizeState: toState

export default utils
