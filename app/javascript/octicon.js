import React from 'react'
import octicons from 'octicons'

const createMarkup = (props = {}) => {
  const icon = props.icon || 'heart'
  const width = props.width || 16

  return {
    __html: octicons[icon].toSVG({ width: width })
  }
}

const Octicon = (props = {}) => {
  let classes = props.class || ''
  return (
    <span
      className={classes}
      dangerouslySetInnerHTML={createMarkup(props)}
    />
  )
}

export default Octicon
