TopicShowController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
    this.subscribe('Reactions').wait();
    this.subscribe('Charts').wait();
    this.subscribe('Votes').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Topics'),
      Meteor.subscribe('TopicTeams', Router.current().params._id),
      Meteor.subscribe('UserData'),
      Meteor.subscribe('Commitments'),
      Meteor.subscribe('Reactions')
    ];
  },
  data: function () {
    return {
      topic: function () {
        return Topics.findOne({_id: Router.current().params._id});
      },
      voters: function () {
        var votes = Votes.find({topicId: Router.current().params._id}).fetch();
        var userIds = _.pluck(votes, "userId");
        return Meteor.users.find({_id: {$in: userIds}});
      },
      teams: function () {
        return Teams.find({});
      },
      partPlayers: function (teamId) {
        var commitments = Commitments.find({teamId: teamId}).fetch();
        var userIds = _.pluck(votes, "userId");
        return Meteor.users.find({_id: {$in: userIds}});
      }
    };
  },
  action: function () {
    this.render('TopicShow');
  }
});
