@ReactionsController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Charts").wait()
  waitOn: -> [
      Meteor.subscribe("Teams")
      Meteor.subscribe("UserData")
      Meteor.subscribe("Commitments")
      Meteor.subscribe("Reactions")
    ]
  data: ->
    reactions: ->
      Reactions.find userId: Meteor.userId()
  action: ->
    @render "Reactions", {}
)
