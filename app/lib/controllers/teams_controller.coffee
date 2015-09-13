@TeamsController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
  waitOn: -> [
      Meteor.subscribe("Teams")
      Meteor.subscribe("UserData")
      Meteor.subscribe("Commitments")
      Meteor.subscribe("TeamKeywords")
      Meteor.subscribe("Keywords")
    ]
  data: ->
    Teams.findOne _id: @params._id
  list: ->
    @render "Teams", {}
  new: ->
    @render "TeamNew", {}
  edit: ->
    @render "TeamEdit", {}
  show: ->
    @render "TeamShow", {}
)
