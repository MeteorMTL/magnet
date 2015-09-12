Template.Player.events
  "submit #reaction-form": (event, template) ->
    event.preventDefault()
    userId = template.data._id
    teamId = Template.parentData(1)._id
    feedback = event.target.feedback
    chartName = event.target.select
    chart = Charts.find(name: chartName.value)
    if feedback.value
      existingReaction = Reactions.findOne(
        userId: userId
        teamId: teamId
        evaluator: Meteor.userId()
      )
      if existingReaction
        Reactions.update
          _id: existingReaction._id
        ,
          $set:
            feedback: feedback.value
            chartId: chart._id

      else
        Reactions.insert
          userId: userId
          teamId: teamId
          feedbackId: feedback._id
          evaluator: Meteor.userId()
          feedback: feedback.value

    Session.set "target" + userId + teamId, false

  "click .cancel": (event, template) ->
    userId = template.data._id
    teamId = Template.parentData(1)._id
    Session.set "target" + userId + teamId, false

  "click #edit": (event, template) ->
    userId = template.data._id
    teamId = Template.parentData(1)._id
    Session.set "target" + userId + teamId, true

  "keypress input": (event, template) ->
    if event.keyCode is 13
      reaction = Reactions.findOne({})
      Reactions.update
        _id: reaction._id
      ,
        $set:
          feedback: event.currentTarget.value

      userId = template.data._id
      teamId = Template.parentData(1)._id
      Session.set "target" + userId + teamId, false

  "click #delete": (event, template) ->
    reaction = Reactions.findOne(
      userId: template.data._id
      teamId: Template.parentData(1)._id
    )
    Reactions.remove _id: reaction._id

# Player: Helpers
Template.Player.helpers
  photoBackgroundStyle: ->
    userPhoto = Photos.findOne(userId: @_id)
    "background-image: url('" + userPhoto?.data + "')" if userPhoto

  profile: ->
    user = Meteor.users.findOne(_id: @_id)
    user.profile.email = (if user.emails then user.emails[0].address else "")  if user and user.profile
    user.profile

  reacting: ->
    Session.set "reacting", true

  editing: ->
    Session.get "target" + @_id + Template.parentData(1)._id

  feedback: ->
    userId = @_id
    teamId = Template.parentData(1)._id
    reaction = Reactions.findOne(
      userId: userId
      teamId: teamId
      evaluator: Meteor.userId()
    )
    return reaction.feedback  if reaction
    null

  charts: ->
    Charts.find {}

  creator: ->
    (if @_id is Template.parentData(1).authorId then "organizer" else "")

  inTeamCanFeedback: ->
    commitments = Commitments.find(userId: Meteor.userId()).fetch()
    userId = @_id
    teamId = Template.parentData(1)._id
    if commitments and (Meteor.userId() isnt userId)
      currentUserTeamIds = _.pluck(commitments, "teamId")
      _.contains currentUserTeamIds, teamId
    else
      false

# Player: Lifecycle Hooks
Template.Player.created = ->

Template.Player.rendered = ->

Template.Player.destroyed = ->
