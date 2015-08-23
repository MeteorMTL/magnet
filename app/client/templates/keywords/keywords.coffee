Template.Keywords.events {
  'submit form': (event, template) ->
    event.preventDefault()
    name = event.target.name
    Keywords.insert
      name: name.value
      authorId: Meteor.userId()
    name.value = ""
}

Template.Keywords.helpers {
  keywords: ->
    Keywords.find({},
      sort:
        name: -1
    )
}

# Keywords: Lifecycle Hooks
Template.Keywords.created = ->

Template.Keywords.rendered = ->

Template.Keywords.destroyed = ->
