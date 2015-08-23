@KeywordsController = RouteController.extend(
  layoutTemplate: "SimpleLayout"
  waitOn: -> [
    Meteor.subscribe("Keywords")
    Meteor.subscribe("UserKeywords")
    Meteor.subscribe("TeamKeywords")
  ]
  data: ->
    Keywords.findOne _id: @params._id
  list: ->
    @render "Keywords"
  edit: ->
    @render "KeywordEdit"
)
