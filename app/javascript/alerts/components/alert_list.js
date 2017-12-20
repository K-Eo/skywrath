import React, { Component } from 'react'
import { connect } from 'react-redux'

import Alert from './alert'
import { defaultSelector } from '../selectors'
import { fetch, assign } from '../actions'
import maps from '../../maps'

const styles = {
  position: 'absolute',
  top: 0,
  left: 0,
  overflowY: 'scroll',
  width: 320,
  height: 'calc(100vh - 72px)'
}

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
      <Alert
        assign={this.props.assign}
        key={alert.id}
        select={this.props.select}
        {...alert}
      />
    ))
  }

  render () {
    return (
      <div className='alerts-scroll' style={styles}>
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

const mapDispatchToProps = {
  fetch,
  assign,
  select: maps.actions.select
}

export const AlertList = connect(
  mapStateToProps,
  mapDispatchToProps
)(AlertListComponent)
