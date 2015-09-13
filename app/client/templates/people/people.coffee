# People: Event Handlers
Template.People.events {}

# People: Helpers
Template.People.helpers people: ->
  Meteor.users.find {},
    sort:
      lastAnnounced: -1
    limit: 100
