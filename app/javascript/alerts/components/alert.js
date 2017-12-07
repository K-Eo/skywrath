import React, { Component } from "react"

export class Alert extends Component {
  render () {
    return (
      <div className="ui segment js-alert">
        <div className="js-alert-block">
          <p>
            <img
              className="ui mini avatar image"
              src="https://placehold.it/200"
            />
            <span className="text-gray">
              Mia Volkova
            </span>
          </p>

          <p>
            <i className="ui small green circle icon" title="Activo"></i>
            Envío una alerta <a href="#">#1</a>
          </p>

          <time className="text-gray text-small">hace 1 hora</time>

          <p>
            <button className="ui small basic button">Asignarme</button>
          </p>
        </div>

        <div className="js-alert-block">
          <p>
            <img
              className="ui mini avatar image"
              src="https://placehold.it/200"
            />
            <span className="text-gray">
              Mia Volkova &bull;
            </span> fue asignado a esta alerta
          </p>
        </div>
      </div>
    )
  }
}

export default Alert
