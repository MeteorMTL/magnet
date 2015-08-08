@TeamsController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Reactions").wait()
    @subscribe("Charts").wait()
    @subscribe("Votes").wait()
  waitOn: -> [
      Meteor.subscribe("Topics"),
      Meteor.subscribe("Teams"),
      Meteor.subscribe("UserData"),
      Meteor.subscribe("Commitments"),
      Meteor.subscribe("Reactions"),
      Meteor.subscribe("LatestMessages")
    ]
  data: ->
    teams: ->
      Teams.find {}
    partPlayers: (teamId) ->
      commitments = Commitments.find(teamId: teamId).fetch()
      userIds = _.pluck(votes, "userId")
      Meteor.users.find _id:
        $in: userIds
  list: ->
    @render "Teams", {}
  new: ->
    @render "TeamNew", {}
  edit: ->
    @render "TeamEdit", {}
  show: ->
    @render "TeamShow", {}
)
