# Team: Event Handlers
Template.Team.events
  "click .changeOwner": (event, template) ->
    _changeOwner @_id
  "submit #addPlayersForm": (event, template) ->
    event.preventDefault()
    newPlayer = event.target.selectPlayer.value
    unless Commitments.findOne(
      teamId: @_id
      userId: newPlayer
    )
      Commitments.insert
        teamId: @_id
        userId: newPlayer
    else
      alert "already exists"
  "submit #changeOwnerForm": (event, template) ->
    event.preventDefault()
    newOwner = event.target.select.value
    if Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
      Teams.update
        _id: @_id
      ,
        $set:
          authorId: newOwner
    else
      alert "you are not on the team"
  "click .join": (event, template) ->
    unless Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
      Commitments.insert
        teamId: @_id
        userId: Meteor.userId()
    else
      alert "You are already on the team"
  "click .leave": (event, template) ->
    _changeOwner @_id  if _players(@_id).length > 1 and Meteor.userId() is @authorId
    commitment = Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
    Commitments.remove _id: commitment._id
    Teams.remove _id: @_id unless Commitments.findOne(teamId: @_id)

# Team: Helpers
# a little helper function helpers
_players = (teamId) ->
  # get all the players on the team
  commitments = Commitments.find(teamId: teamId).fetch()
  userIds = _.pluck(commitments, "userId")

  # remove current player
  userIds = _.reject(userIds, (id) ->
    id is Meteor.userId()
  )
  players = Meteor.users.find(_id:
    $in: userIds
  ).fetch()
  players

_changeOwner = (teamId) ->
  players = _players(teamId)

  # choose first player from team
  newOwner = players[0]._id
  if Commitments.findOne(
    teamId: teamId
    userId: Meteor.userId()
  )
    Teams.update
      _id: teamId
    ,
      $set:
        authorId: newOwner

  else
    alert "you are not on the team"

_creator = (authorId) ->
  (if Meteor.userId() is authorId then "organizer" else "")

Template.Team.helpers
  participating: ->
    #alert("teamID " + this._id);
    if Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
      true
    else
      false
  creator: ->
    _creator @authorId
  playersNotOnTeam: ->
    commitments = Commitments.find(teamId: @_id).fetch()
    userIds = _.pluck(commitments, "userId")
    players = Meteor.users.find(_id:
      $nin: userIds
    ).fetch()
    players
  players: ->
    _players @_id
  playersLengthGreaterThanOne: ->
    _players(@_id).length > 1
  playersLengthEqualsOne: ->
    _players(@_id).length is 1
  latestMessage: ->
    teamId = @_id
    messages = Messages.find(
      teamId: teamId
    ,
      sort:
        createdAt: -1
    ).fetch()
    return messages[0].message  if messages.length
    ""
  activePlayfieldClass: ->
    if Session.get("activePlayfield") is @.playfieldId
      "activePlayfield"
    else
      ""
# Team: Lifecycle Hooks
Template.Team.created = ->

Template.Team.rendered = ->

Template.Team.destroyed = ->
