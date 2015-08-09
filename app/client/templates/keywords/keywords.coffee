Template.Keywords.events {
  'submit form': (event, template) ->
    event.preventDefault()
    name = event.target.name
    Keywords.insert
      name: name.value
      authorId: Meteor.userId()
    name.value = ""
}

Template.Keywords.helpers {}

# Keywords: Lifecycle Hooks
Template.Keywords.created = ->

Template.Keywords.rendered = ->

Template.Keywords.destroyed = ->
