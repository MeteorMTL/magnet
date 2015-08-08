@TeamShowController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Messages").wait()
    @subscribe("Likes").wait()
  waitOn: -> [
    Meteor.subscribe("Teams")
    Meteor.subscribe("UserData")
    Meteor.subscribe("Messages", Router.current().params._id)
    Meteor.subscribe("Likes", Router.current().params._id)
  ]
  data: ->
    team: ->
      Teams.findOne _id: Router.current().params._id
    messages: ->
      teamId = Router.current().params._id
      Messages.find(teamId: teamId).fetch()
  action: ->
    @render "TeamShow"
)
