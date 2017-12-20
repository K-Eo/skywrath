import React, { Component } from 'react'
import TimeAgo from 'react-timeago'
import classNames from 'classnames'

import utils from '../../utils'
import Octicon from '../../octicon'

const Block = ({ children, avatar, actor, datetime }) => (
  <div className='d-flex'>
    <img
      className='rounded mr-3'
      width="32"
      height="32"
      src={avatar}
    />
    <div>
      <BlockAction>
        <strong>{actor}</strong>
        {
          datetime && (
            <span className='text-muted'>
              <span className='mx-2'>&bull;</span>
              <TimeAgo
                className='text-secondary'
                date={datetime}
                formatter={utils.timeFormatter}
              />
            </span>
          )
        }
      </BlockAction>
      {children}
    </div>
  </div>
)

const BlockAction = ({ children }) => (
  <div className='mb-2'>
   {children}
  </div>
)

export class Alert extends Component {
  renderAuthor () {
    const { assignee, author, control, created_at: createdAt, id, state } = this.props
    const alertURL = `/dashboard/alerts/${id}`
    const iconClass = classNames('mr-2', {
      'text-success': state === 'opened' && assignee === null,
      'text-warning': state === 'opened' && assignee !== null,
      'text-red': state === 'closed'
    })

    return (
      <Block avatar={author.avatar} actor={author.name} datetime={createdAt}>
        <BlockAction>
          <Octicon icon='issue-opened' className={iconClass} />
          <span className='align-middle'>
            Envío una alerta <a href={alertURL}>#{id}</a>
          </span>
          <a
            href="#"
            className="ml-3"
            onClick={this.handleSelect.bind(this)}>
              <Octicon icon='location' />
          </a>
        </BlockAction>
        {
          (state === 'opened' && assignee === null) && (
            <BlockAction>
              <button
                className='btn btn-outline-primary btn-sm'
                disabled={control.assign.status === 'requesting'}
                onClick={this.handleAssignee.bind(this)}
              >
                Asignarme
              </button>
            </BlockAction>
          )
        }
      </Block>
    )
  }

  handleSelect (e) {
    if (e && e.preventDefault) {
      e.preventDefault()
    }

    const { id } = this.props

    this.props.select(id)
  }

  handleAssignee () {
    const { id } = this.props

    this.props.assign(id)
  }

  renderAssignee () {
    const { assignee } = this.props

    if (!assignee) {
      return null
    }

    return (
      <Block
        avatar={assignee.avatar}
        actor={assignee.name}
      >
        <BlockAction>
          <Octicon icon='organization' className='mr-2 text-muted' />
          <span className='align-middle'>
            Fue asignado a esta alerta
          </span>
        </BlockAction>
      </Block>
    )
  }

  render () {
    return (
      <li className='list-group-item js-alert mr-1'>
        {this.renderAuthor()}
        {this.renderAssignee()}
      </li>
    )
  }
}

export default Alert
