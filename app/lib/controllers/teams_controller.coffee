@TeamsController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Reactions").wait()
    @subscribe("Charts").wait()
  waitOn: -> [
      Meteor.subscribe("Teams")
      Meteor.subscribe("UserData")
      Meteor.subscribe("Commitments")
      Meteor.subscribe("Reactions")
      Meteor.subscribe("LatestMessages")
      Meteor.subscribe("TeamKeywords")
      Meteor.subscribe("Keywords")
    ]
  data: ->
    teams: ->
      Teams.find(
        playfieldId: Session.get("activePlayfield")
      ,
        sort:
          updated: -1
      )
  list: ->
    @render "Teams", {}
  new: ->
    @render "TeamNew", {}
  edit: ->
    @render "TeamEdit", {}
  show: ->
    @render "TeamShow", {}
)
