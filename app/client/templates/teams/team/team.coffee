# Team: Event Handlers
Template.Team.events
  "click .join": (event, template) ->
    unless Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
      Commitments.insert
        teamId: @_id
        userId: Meteor.userId()
        authorId: Meteor.userId()
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

_creator = (authorId) ->
  (if Meteor.userId() is authorId then "organizer" else "")

Template.Team.helpers
  participating: ->
    if Commitments.findOne(
      teamId: @_id
      userId: Meteor.userId()
    )
      true
    else
      false
  teamKeywordSchema: ->
    schemas.teamKeyword
  teamKeywordDoc: ->
    {
      name: ""
      teamId: Template.currentData()._id
    }
  newTeamKeywordFormId: ->
    "newTeamKeyword-" + Template.currentData()._id
  creator: ->
    _creator @authorId
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
    return messages[0].message if messages.length
    ""
