@PeopleController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
  waitOn: -> [
      Meteor.subscribe("UserData")
    ]
  action: ->
    @render "People", {}
)
