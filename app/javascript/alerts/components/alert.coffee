import React, { Component } from "react"
import TimeAgo from "react-timeago"
import classNames from "classnames"

import utils from "../../utils"

Alert = (props) ->
  basic_button_class = {
    ui: true
    tiny: true
    button: true
    loading: props.control.status == "requesting"
  }

  assist_button_class = classNames basic_button_class, {
    green: true
  }

  close_button_class = classNames basic_button_class, {
    red: true
  }

  state_label_class = classNames {
    ui: true
    horizontal: true
    label: true
    green: props.state == "opened"
    violet: props.state == "assisting"
    red: props.state == "closed"
  }

  <div className="ui card alert">
    <div className="content">
      <div className="right floated meta">#{props.id}</div>
      <p>
        <span className={state_label_class}>
          <i className="warning circle icon"></i>
          {utils.to_state(props.state)}
        </span>
      </p>
      <strong>
        {props.author.name}
      </strong>
      &nbsp;envío esta alerta hace&nbsp;
      <TimeAgo
        date={props.created_at}
        formatter={utils.formatter}
        className="strong"/>
    </div>
    { if props.events.length > 0
      <div className="content">
        <div className="ui feed">
          {
            for event in props.events
              <div className="event" key={event.date}>
                <div className="label">
                  <img src={event.avatar}/>
                </div>
                <div className="content">
                  <div className="summary" style={{ fontWeight: "normal" }}>
                    <span className="user">
                      {event.actor}
                    </span> {event.action}
                    <div className="date">
                      <TimeAgo
                        date={event.date}
                        formatter={utils.formatter}
                        className="strong"/>
                    </div>
                  </div>
                </div>
              </div>
          }
        </div>
      </div>
    }
    <div className="extra content">
      <div className="author">
        <img className="ui avatar image" src={props.author.avatar}/>
        &nbsp;
        { if props.state == "opened"
            <button
              className={assist_button_class}
              onClick={ -> props.assist(props.id) }
            >
              Asistir
            </button>
          else if props.state == "assisting"
            <button
              className={close_button_class}
              onClick={ -> props.close(props.id) }
            >
              Cerrar
            </button>
          else
            <span>Cerrado</span>
          }
      </div>
    </div>
  </div>

export { Alert }
