/**
 * type validation helpers
 */

'use strict'

module.exports = {

  isInt: function (value) {
    return !isNaN(value) && parseInt(Number(value)) === value && !isNaN(parseInt(value, 10))
  }

}
