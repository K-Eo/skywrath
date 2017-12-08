import queryString from 'query-string'

const $ = window.$
const Turbolinks = window.Turbolinks
const el = '#js-alerts-filter'

class Filter {
  getQuery () {
    const { search } = window.location
    return queryString.parse(search)
  }

  buildURL (state) {
    const { origin, pathname } = window.location
    const query = this.getQuery()
    query.state = state

    const nextQuery = queryString.stringify(query)
    return `${origin}${pathname}?${nextQuery}`
  }

  onChange (value, text, $selectedItem) {
    const state = $selectedItem.data('state')
    Turbolinks.visit(this.buildURL(state))
  }

  postVisit () {
    const query = this.getQuery()
    let filter = ''

    switch (query.state) {
      case 'opened':
        filter = 'Activo'
        break
      case 'closed':
        filter = 'Cerrado'
        break
      default:
        return
    }
  }

  start () {
    this.postVisit()
  }
}

const filter = new Filter()

$(document).on('turbolinks:load', () => {
  if ($('.alerts.index').length <= 0) {
    return
  }

  filter.start()
})
