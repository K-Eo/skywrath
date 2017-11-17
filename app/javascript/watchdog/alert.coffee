import React, { Component } from "react"
import TimeAgo from "react-timeago"

import utils from "./utils"

Alert = (props) ->
  <div className="ui card alert">
    <div className="content">
      <img src={props.author.avatar} className="ui right floated avatar image" />
      <div className="header">
        {props.author.name}
      </div>
      <div className="meta">
        #{props.id} &bull;&nbsp;
        <TimeAgo date={props.created_at} formatter={utils.formatter} />
      </div>
    </div>
  </div>

export default Alert
