import React, { Component } from 'react'
import { connect } from 'react-redux'

import Alert from './alert'
import { defaultSelector } from '../selectors'
import * as actions from '../actions'

class AlertListComponent extends Component {
  componentDidMount () {
    this.props.fetch()
  }

  renderContent () {
    const { alerts, fetching } = this.props

    if (fetching.status === 'fetching') {
      return (
        <div className='ui segment js-loader-space'>
          <div className='ui active centered loader' />
        </div>
      )
    }

    if (fetching.status === 'success' && alerts.length === 0) {
      return (
        <div className='ui segment'>
          <h5>No hay alertas</h5>
        </div>
      )
    }

    return alerts.map(alert => (
      <Alert key={alert.id} {...alert} />
    ))
  }

  render () {
    return (
      <div className='col'>
        <ul className='list-group'>
          { this.renderContent() }
        </ul>
      </div>
    )
  }
}

const mapStateToProps = (state) => ({
  alerts: defaultSelector(state),
  fetching: state.control.alerts.fetching
})

export const AlertList = connect(mapStateToProps, actions)(AlertListComponent)
