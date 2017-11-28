import React, { Component } from "react"
import TimeAgo from "react-timeago"
import classNames from "classnames"

import utils from "../../utils"

Alert = (props) ->
  state_label_class = classNames {
    circular: true
    green: props.state == "opened"
    label: true
    mini: true
    red: props.state == "closed"
    ui: true
  }

  <div className="ui segment" style={{ display: "flex" }}>
    <div style={{ marginRight: "1em" }}>
      <span className={state_label_class}>
        <i className="warning icon" style={{ margin: 0 }}></i>
      </span>
    </div>
    <div style={{ flex: 1 }}>
      <strong>
        {props.author.name}
      </strong>
      &nbsp;envío esta alerta hace&nbsp;
      <TimeAgo
        date={props.created_at}
        formatter={utils.formatter}
        className="strong"/>
      <p style={{ fontSize: "13px" }}>
        <span className="right floated meta" style={{ color: "#999" }}>
          #{props.id}
        </span>
      </p>
    </div>
    <div style={{ alignSelf: "center", margin: "0 1em", textAlign: "center", minWidth: 70 }}>
      {
        if props.assignee
          <img
            src={props.assignee.avatar}
            className="ui avatar image"
            title="Asignado a #{props.assignee.name}"
          />
        else
          if props.assignee_control.status == "requesting"
            <div className="ui mini active inline loader"></div>
          else
            <a
              href="#"
              onClick={ (e) -> e.preventDefault(); props.assign(props.id) }
            >
              asignarme
            </a>
      }
    </div>
    <div style={{ alignSelf: "center", minWidth: 60, textAlign: "center", margin: "0 0 0 1em" }}>
      {
        if props.assignee? and props.state == "opened"
          <button
            className="ui tiny negative button"
            onClick={ -> props.close(props.id) }
          >
            Cerrar
          </button>
      }
    </div>
  </div>

export { Alert }
