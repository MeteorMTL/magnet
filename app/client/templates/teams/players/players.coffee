# Players: Event Handlers
Template.Players.events {}

# Players: Helpers
Template.Players.helpers players: ->
  commitments = Commitments.find(teamId: @_id).fetch()
  userIds = _.pluck(commitments, "userId")
  players = Meteor.users.find(_id:
    $in: userIds
  )
  players

# Players: Lifecycle Hooks
Template.Players.created = ->

Template.Players.rendered = ->

Template.Players.destroyed = ->
