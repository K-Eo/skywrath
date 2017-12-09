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

  onChange (e) {
    const state = $(e.currentTarget).data('state')
    Turbolinks.visit(this.buildURL(state))
  }

  start () {
    $(`${el} .dropdown-item`).on('click', this.onChange.bind(this))
  }
}

const filter = new Filter()

$(document).on('turbolinks:load', () => {
  if ($('.alerts.index').length <= 0) {
    return
  }

  filter.start()
})
