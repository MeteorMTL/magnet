@TopicShowController = RouteController.extend(
  subscriptions: ->
    @subscribe("Photos").wait()
    @subscribe("Reactions").wait()
    @subscribe("Charts").wait()
    @subscribe("Votes").wait()
  waitOn: -> [
      Meteor.subscribe("Topics")
      Meteor.subscribe("TopicTeams", Router.current().params._id)
      Meteor.subscribe("UserData")
      Meteor.subscribe("Commitments")
      Meteor.subscribe("Reactions")
    ]
  data: ->
    topic: ->
      Topics.findOne _id: Router.current().params._id
    voters: ->
      votes = Votes.find(topicId: Router.current().params._id).fetch()
      userIds = _.pluck(votes, "userId")
      Meteor.users.find _id:
        $in: userIds
    teams: ->
      Teams.find {}
    partPlayers: (teamId) ->
      commitments = Commitments.find(teamId: teamId).fetch()
      userIds = _.pluck(votes, "userId")
      Meteor.users.find _id:
        $in: userIds
  action: ->
    @render "TopicShow"
)
