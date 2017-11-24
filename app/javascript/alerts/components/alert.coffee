import React, { Component } from "react"
import TimeAgo from "react-timeago"

import utils from "../../utils"

Alert = (props) ->
  <div className="ui card alert">
    <div className="content">
      <div className="right floated meta">#{props.id}</div>
      <p>
        <span className="ui green horizontal label">
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
    <div className="extra content">
      <div className="author">
        <img className="ui avatar image" src={props.author.avatar}/>
        &nbsp;
        <button className="ui tiny green button">Asistir</button>
      </div>
    </div>
  </div>

export { Alert }
