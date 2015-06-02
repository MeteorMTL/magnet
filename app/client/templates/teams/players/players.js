/*****************************************************************************/
/* Players: Event Handlers */
/*****************************************************************************/
Template.Players.events({
});

/*****************************************************************************/
/* Players: Helpers */
/*****************************************************************************/
Template.Players.helpers({
  players: function () {
    var commitments = Commitments.find({teamId: this._id}).fetch();
    var userIds = _.pluck(commitments, "userId");
    var players = Meteor.users.find({_id: {$in: userIds}});
    return players;
  }
});

/*****************************************************************************/
/* Players: Lifecycle Hooks */
/*****************************************************************************/
Template.Players.created = function () {
};

Template.Players.rendered = function () {
};

Template.Players.destroyed = function () {
};
