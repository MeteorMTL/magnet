/*****************************************************************************/
/* Teams: Event Handlers */
/*****************************************************************************/
Template.Teams.events({
  "submit form": function(event, template) {
    event.preventDefault();
    var name = event.target.name;
    var purpose = event.target.purpose;
    teamId = Teams.insert({name: name.value, purpose: purpose.value, "created": new Date(), createdBy: Meteor.userId()});
    Commitments.insert({teamId: teamId, userId: Meteor.userId()});
    name.value = '';
    purpose.value = '';
  }
});

/*****************************************************************************/
/* Teams: Helpers */
/*****************************************************************************/
Template.Teams.helpers({
});

Template.Players.helpers({
  players: function () {
    var commitments = Commitments.find({teamId: this._id}).fetch();
    var userIds = _.pluck(commitments, "userId");
    var players = Meteor.users.find({_id: {$in: userIds}});
    return players;
  }
});

Template.Team.events({
  "click .join": function(event, template) {
    Commitments.insert({teamId: this._id, userId: Meteor.userId()});
  },
  "click .leave": function(event, template) {
    var commitment = Commitments.findOne({teamId: this._id, userId: Meteor.userId()});
    Commitments.remove({_id: commitment._id});
    var wasntLastPlayer = Commitments.findOne({teamId: this._id});
    if (!wasntLastPlayer) {
      Teams.remove({_id: this._id});
    }
  }
});

Template.Team.helpers({
  participating: function () {
    if (Commitments.findOne({teamId: this._id, userId: Meteor.userId()})) {
      return true;
    } else {
      return false;
    }
  }
});

Template.Player.events({
  "click .cancel": function () {
    Session.set('reacting', false);
  }
});

Template.Player.helper({
  reacting: function () {
    Session.set('reacting', true);
  },
  hasReaction: function () {
  }
});

/*****************************************************************************/
/* Teams: Lifecycle Hooks */
/*****************************************************************************/
Template.Teams.created = function () {
};

Template.Teams.rendered = function () {
};

Template.Teams.destroyed = function () {
};
