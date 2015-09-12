@PeopleController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Reactions").wait()
    @subscribe("Charts").wait()
  waitOn: -> [
      Meteor.subscribe("UserData")
    ]
  action: ->
    @render "People", {}
)
