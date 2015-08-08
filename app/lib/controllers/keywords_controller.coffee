@KeywordsController = RouteController.extend(
  layoutTemplate: "MasterLayout"
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Reactions").wait()
    @subscribe("Charts").wait()
    @subscribe("Votes").wait()
  waitOn: -> [
      Meteor.subscribe("Votes")
      Meteor.subscribe("Topics")
      Meteor.subscribe("UserData")
    ]
  action: ->
    @render "Keywords"
)
