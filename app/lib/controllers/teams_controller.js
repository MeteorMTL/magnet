TeamsController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Teams'),
      Meteor.subscribe('UserData'),
      Meteor.subscribe('Commitments'),
    ];
  },
  data: function () {
    return {
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
    // You can create as many action functions as you'd like.
    // This is the primary function for running your route.
    // Usually it just renders a template to a page. But it
    // might also perform some conditional logic. Override
    // the data context by providing it as an option in the
    // last parameter.
    this.render('Teams', { /* data: {} */});
  }
});
