# Navigation: Event Handlers
Template.Navigation.events "click #at-nav-button": (event) ->
  if Meteor.user()
    AccountsTemplates.logout()
  else
    Router.go "login"

# Navigation: Helpers
Template.Navigation.helpers
  myName: ->
    # if a user exists use the profile name, if that is no good use the email if all fails use 'My'
    # linkedin sometimes the service data is absent...
    (if Meteor.user() then (if typeof (Meteor.user().profile.name) isnt "undefined" and Meteor.user().profile.name isnt null and Meteor.user().profile.name.length > 0 then Meteor.user().profile.name else (if typeof (Meteor.user().profile.firstName) isnt "undefined" and Meteor.user().profile.firstName isnt null and Meteor.user().profile.firstName.length > 0 then Meteor.user().profile.firstName else (if typeof (Meteor.user().emails) isnt "undefined" and Meteor.user().emails[0].address isnt null and Meteor.user().emails[0].address.length > 1 then Meteor.user().emails[0].address else (if typeof (Meteor.user().services.github) isnt "undefined" then "github" else (if typeof (Meteor.user().services.facebook) isnt "undefined" then "facebook" else (if typeof (Meteor.user().services.linkedin) isnt "undefined" then "linkedin" else (if typeof (Meteor.user().services.google) isnt "undefined" then "google" else (if typeof (Meteor.user().services.twitter) isnt "undefined" then "twitter" else "My Profile")))))))) else "My Profile")

# Navigation: Lifecycle Hooks
Template.Navigation.created = ->

Template.Navigation.rendered = ->
  $(".button-collapse").sideNav
    menuWidth: 300
    edge: "left"
    closeOnClick: true

Template.Navigation.destroyed = ->
