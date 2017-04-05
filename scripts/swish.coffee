# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

reply_invalid = (res, text) ->
  res.send "Error: Invalid #{text}"

module.exports = (robot) ->
  robot.hear /!swish (.*)/i, (res) ->
    args = res.match[1].split " "
    number = args[0].replace /[^\d]/g, ''
    value = args[1]
    has_value = args.length > 1 && value.match /\d+/

    swishObj = {
      version: 1,
      payee: {
        value: number,
        editable: false
      }
    }
    swishObj.amount = { value: parseInt(value, 10), editable: true } if has_value
    jsonstring = JSON.stringify swishObj

    if has_value
      res.send "Swisha #{value}kr till #{number}"
    else
      res.send "Swisha till #{number}"

    res.send "swish://payment?data=#{encodeURIComponent(jsonstring)}"
