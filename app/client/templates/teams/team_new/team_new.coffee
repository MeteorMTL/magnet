Template.TeamNew.events {
  "submit #new-team-form": (event, template) ->
    event.preventDefault()
    name = event.target.name
    purpose = event.target.purpose
    teamId = Teams.insert(
      name: name.value
      purpose: purpose.value
      created: new Date()
      createdBy: Meteor.userId()
    )
    Commitments.insert
      teamId: teamId
      userId: Meteor.userId()
    name.value = ""
    purpose.value = ""
}

Template.TeamNew.helpers {}

# TeamNew: Lifecycle Hooks
Template.TeamNew.created = ->

Template.TeamNew.rendered = ->

Template.TeamNew.destroyed = ->
