@KeywordsController = RouteController.extend(
  layoutTemplate: "SimpleLayout"
  waitOn: -> [
    Meteor.subscribe("Keywords")
  ]
  data: ->
    keywords: Keywords.find({}, {sort: {name: -1}})
  list: ->
    @render "Keywords"
)
