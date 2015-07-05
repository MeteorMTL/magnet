/*****************************************************************************/
/* Team: Event Handlers */
/*****************************************************************************/
Template.Team.events({
  "click .join": function (event, template) {
   if (!Template.Team.helpers.participating)
    Commitments.insert({teamId: this._id, userId: Meteor.userId()});
   else alert ("you are already on the team");
  },
  "click .leave": function (event, template) {
    var commitment = Commitments.findOne({teamId: this._id, userId: Meteor.userId()});
    Commitments.remove({_id: commitment._id});
    var wasntLastPlayer = Commitments.findOne({teamId: this._id});
    if (!wasntLastPlayer) {
      Teams.remove({_id: this._id});
    }
  }
});

/*****************************************************************************/
/* Team: Helpers */
/*****************************************************************************/
Template.Team.helpers({
  participating: function () {
    if (Commitments.findOne({teamId: this._id, userId: Meteor.userId()})) {
      return true;
    } else {
      return false;
    }
  },
  topics: function () {
    var teamId = this._id;
    var commitments = Commitments.find({teamId: teamId}).fetch();
    var userIds = _.pluck(commitments, "userId");
    var topicIds = _.pluck(Votes.find({userId: {$in: userIds}}, {sort: {points: -1}}).fetch(), 'topicId');
    return Topics.find({_id: {$in: topicIds}});
  }
});

/*****************************************************************************/
/* Team: Lifecycle Hooks */
/*****************************************************************************/
Template.Team.created = function () {
};

Template.Team.rendered = function () {
};

Template.Team.destroyed = function () {
};
