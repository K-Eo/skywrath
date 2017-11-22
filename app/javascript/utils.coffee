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

utils =
  formatter: buildFormatter(spanishStrings)

export default utils
